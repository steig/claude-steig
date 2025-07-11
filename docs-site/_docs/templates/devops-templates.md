# DevOps Templates

**Last Updated**: 2025-07-10  
**Version**: 2.0.3  
**Framework**: Simone Framework

## Overview

DevOps templates in the Simone Framework streamline infrastructure management, deployment processes, monitoring, and operational excellence. These templates ensure consistent, reliable, and scalable software delivery through automated and well-documented operational practices.

## DevOps Template Categories

### Infrastructure Templates

#### 1. Infrastructure as Code Template

**Template**: `infrastructure.yml`  
**Purpose**: Define and manage infrastructure resources

```yaml
metadata:
  template: "infrastructure"
  version: "2.0"
  provider: "aws"
  
infrastructure:
  project: "simone-platform"
  environment: "production"
  region: "us-east-1"
  
  networking:
    vpc:
      cidr: "10.0.0.0/16"
      availability_zones: 3
      
    subnets:
      public:
        - cidr: "10.0.1.0/24"
          az: "us-east-1a"
        - cidr: "10.0.2.0/24"
          az: "us-east-1b"
        - cidr: "10.0.3.0/24"
          az: "us-east-1c"
          
      private:
        - cidr: "10.0.11.0/24"
          az: "us-east-1a"
        - cidr: "10.0.12.0/24"
          az: "us-east-1b"
        - cidr: "10.0.13.0/24"
          az: "us-east-1c"
          
  compute:
    ecs_cluster:
      name: "simone-cluster"
      capacity_providers: ["FARGATE", "FARGATE_SPOT"]
      
    services:
      api:
        task_definition: "simone-api"
        desired_count: 3
        cpu: 512
        memory: 1024
        autoscaling:
          min: 3
          max: 10
          target_cpu: 70
          
      worker:
        task_definition: "simone-worker"
        desired_count: 2
        cpu: 1024
        memory: 2048
        autoscaling:
          min: 2
          max: 20
          target_memory: 80
          
  storage:
    rds:
      engine: "postgres"
      version: "15.2"
      instance_class: "db.r6g.xlarge"
      storage: 500
      multi_az: true
      backup_retention: 30
      
    s3_buckets:
      - name: "simone-assets"
        versioning: true
        lifecycle:
          archive_after_days: 90
          delete_after_days: 365
          
      - name: "simone-backups"
        versioning: true
        lifecycle:
          glacier_after_days: 30
          
    elasticache:
      engine: "redis"
      version: "7.0"
      node_type: "cache.r6g.large"
      num_nodes: 3
      
  security:
    security_groups:
      web:
        ingress:
          - port: 443
            protocol: "tcp"
            source: "0.0.0.0/0"
          - port: 80
            protocol: "tcp"
            source: "0.0.0.0/0"
            
      api:
        ingress:
          - port: 8080
            protocol: "tcp"
            source: "sg-web"
            
      database:
        ingress:
          - port: 5432
            protocol: "tcp"
            source: "sg-api"
            
  monitoring:
    cloudwatch:
      dashboards:
        - "infrastructure-overview"
        - "application-metrics"
        - "cost-optimization"
        
      alarms:
        - metric: "cpu_utilization"
          threshold: 80
          action: "scale_up"
          
        - metric: "error_rate"
          threshold: 5
          action: "page_oncall"
          
  cost_optimization:
    spot_instances: true
    reserved_instances:
      database: "3_year_all_upfront"
      compute: "1_year_partial_upfront"
      
    auto_shutdown:
      dev_environments: "8pm-8am"
      staging: "weekends"
      
  tags:
    Environment: "production"
    Project: "simone"
    ManagedBy: "terraform"
    CostCenter: "engineering"
```

#### 2. Kubernetes Deployment Template

**Template**: `k8s-deployment.yml`  
**Purpose**: Kubernetes application deployment

```yaml
metadata:
  template: "k8s-deployment"
  version: "2.0"
  
deployment:
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: simone-api
    namespace: production
    labels:
      app: simone
      component: api
      version: "2.1.0"
      
  spec:
    replicas: 3
    strategy:
      type: RollingUpdate
      rollingUpdate:
        maxSurge: 1
        maxUnavailable: 0
        
    selector:
      matchLabels:
        app: simone
        component: api
        
    template:
      metadata:
        labels:
          app: simone
          component: api
          version: "2.1.0"
          
      spec:
        serviceAccountName: simone-api
        
        containers:
        - name: api
          image: simone/api:2.1.0
          imagePullPolicy: Always
          
          ports:
          - containerPort: 8080
            name: http
            protocol: TCP
            
          env:
          - name: DATABASE_URL
            valueFrom:
              secretKeyRef:
                name: simone-secrets
                key: database-url
                
          - name: REDIS_URL
            valueFrom:
              secretKeyRef:
                name: simone-secrets
                key: redis-url
                
          - name: LOG_LEVEL
            value: "info"
            
          resources:
            requests:
              cpu: 500m
              memory: 1Gi
            limits:
              cpu: 1000m
              memory: 2Gi
              
          livenessProbe:
            httpGet:
              path: /health
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 10
            
          readinessProbe:
            httpGet:
              path: /ready
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 5
            
          volumeMounts:
          - name: config
            mountPath: /app/config
            readOnly: true
            
        volumes:
        - name: config
          configMap:
            name: simone-api-config
            
        affinity:
          podAntiAffinity:
            preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchExpressions:
                  - key: app
                    operator: In
                    values:
                    - simone
                topologyKey: kubernetes.io/hostname
                
---
apiVersion: v1
kind: Service
metadata:
  name: simone-api
  namespace: production
  
spec:
  type: ClusterIP
  selector:
    app: simone
    component: api
    
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
    name: http
    
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: simone-api-hpa
  namespace: production
  
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: simone-api
    
  minReplicas: 3
  maxReplicas: 10
  
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
        
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

### CI/CD Templates

#### 3. CI/CD Pipeline Template

**Template**: `cicd-pipeline.yml`  
**Purpose**: Comprehensive CI/CD pipeline definition

```yaml
metadata:
  template: "cicd-pipeline"
  version: "2.0"
  platform: "github-actions"
  
pipeline:
  name: "Simone Platform CI/CD"
  
  triggers:
    push:
      branches: ["main", "develop"]
    pull_request:
      branches: ["main"]
    schedule:
      - cron: "0 0 * * *"  # Daily builds
      
  environment_variables:
    NODE_ENV: "production"
    DOCKER_REGISTRY: "docker.io/simone"
    AWS_REGION: "us-east-1"
    
  stages:
    build:
      name: "Build and Test"
      runs_on: "ubuntu-latest"
      
      steps:
        - name: "Checkout code"
          uses: "actions/checkout@v3"
          
        - name: "Setup Node.js"
          uses: "actions/setup-node@v3"
          with:
            node_version: "18"
            cache: "npm"
            
        - name: "Install dependencies"
          run: |
            npm ci
            npm run build
            
        - name: "Run linters"
          run: |
            npm run lint
            npm run prettier:check
            
        - name: "Run unit tests"
          run: |
            npm run test:unit
            npm run test:coverage
            
        - name: "Upload coverage"
          uses: "codecov/codecov-action@v3"
          with:
            token: "${{ secrets.CODECOV_TOKEN }}"
            
        - name: "Build Docker image"
          run: |
            docker build -t simone-api:${{ github.sha }} .
            
        - name: "Security scan"
          uses: "aquasecurity/trivy-action@master"
          with:
            image_ref: "simone-api:${{ github.sha }}"
            
      artifacts:
        - path: "dist/"
          name: "build-artifacts"
        - path: "coverage/"
          name: "coverage-report"
          
    integration_test:
      name: "Integration Tests"
      needs: ["build"]
      runs_on: "ubuntu-latest"
      
      services:
        postgres:
          image: "postgres:15"
          env:
            POSTGRES_PASSWORD: "test"
          options: >-
            --health-cmd pg_isready
            --health-interval 10s
            --health-timeout 5s
            --health-retries 5
            
        redis:
          image: "redis:7"
          options: >-
            --health-cmd "redis-cli ping"
            --health-interval 10s
            --health-timeout 5s
            --health-retries 5
            
      steps:
        - name: "Run integration tests"
          run: |
            npm run test:integration
            
        - name: "Run E2E tests"
          run: |
            npm run test:e2e
            
    deploy_staging:
      name: "Deploy to Staging"
      needs: ["integration_test"]
      if: github.ref == 'refs/heads/develop'
      environment: "staging"
      
      steps:
        - name: "Configure AWS credentials"
          uses: "aws-actions/configure-aws-credentials@v2"
          with:
            aws_access_key_id: "${{ secrets.AWS_ACCESS_KEY_ID }}"
            aws_secret_access_key: "${{ secrets.AWS_SECRET_ACCESS_KEY }}"
            
        - name: "Deploy to ECS"
          run: |
            aws ecs update-service \
              --cluster simone-staging \
              --service simone-api \
              --force-new-deployment
              
        - name: "Run smoke tests"
          run: |
            npm run test:smoke -- --env=staging
            
        - name: "Notify team"
          uses: "8398a7/action-slack@v3"
          with:
            status: "${{ job.status }}"
            webhook_url: "${{ secrets.SLACK_WEBHOOK }}"
            
    deploy_production:
      name: "Deploy to Production"
      needs: ["integration_test"]
      if: github.ref == 'refs/heads/main'
      environment: "production"
      
      steps:
        - name: "Create deployment"
          uses: "chrnorm/deployment-action@v2"
          with:
            token: "${{ github.token }}"
            environment: "production"
            
        - name: "Blue/Green deployment"
          run: |
            ./scripts/deploy-blue-green.sh production
            
        - name: "Verify deployment"
          run: |
            ./scripts/verify-deployment.sh production
            
        - name: "Update documentation"
          run: |
            ./scripts/update-api-docs.sh ${{ github.sha }}
            
  rollback:
    on_failure:
      - name: "Automatic rollback"
        run: |
          ./scripts/rollback.sh ${{ env.PREVIOUS_VERSION }}
          
      - name: "Alert on-call"
        run: |
          ./scripts/page-oncall.sh "Deployment failed and rolled back"
```

#### 4. Deployment Checklist Template

**Template**: `deployment-checklist.yml`  
**Purpose**: Pre and post deployment verification

```yaml
metadata:
  template: "deployment-checklist"
  version: "2.0"
  
deployment_checklist:
  release: "v2.1.0"
  environment: "production"
  date: "2025-01-15"
  deployer: "@devops-engineer"
  
  pre_deployment:
    code_preparation:
      - task: "Code freeze notification sent"
        status: "✓"
        verified_by: "@release-manager"
        
      - task: "All PRs merged"
        status: "✓"
        link: "https://github.com/simone/pulls"
        
      - task: "Release branch created"
        status: "✓"
        branch: "release/2.1.0"
        
    testing:
      - task: "All tests passing"
        status: "✓"
        coverage: "85%"
        
      - task: "Integration tests completed"
        status: "✓"
        duration: "12 minutes"
        
      - task: "Performance tests passed"
        status: "✓"
        report: "perf-report-2.1.0.html"
        
      - task: "Security scan clean"
        status: "✓"
        vulnerabilities: 0
        
    infrastructure:
      - task: "Database migrations tested"
        status: "✓"
        rollback_tested: true
        
      - task: "Infrastructure changes applied"
        status: "✓"
        terraform_plan: "approved"
        
      - task: "Monitoring alerts configured"
        status: "✓"
        alerts_count: 15
        
      - task: "Backup completed"
        status: "✓"
        backup_id: "backup-2025-01-15-1400"
        
    communications:
      - task: "Stakeholders notified"
        status: "✓"
        method: "email + slack"
        
      - task: "Maintenance window announced"
        status: "✓"
        duration: "30 minutes"
        
      - task: "Support team briefed"
        status: "✓"
        runbook_updated: true
        
  deployment_steps:
    - step: 1
      action: "Enable maintenance mode"
      status: "✓"
      time: "14:00"
      
    - step: 2
      action: "Database migrations"
      status: "✓"
      time: "14:02"
      duration: "3 minutes"
      
    - step: 3
      action: "Deploy blue environment"
      status: "✓"
      time: "14:05"
      instances: 3
      
    - step: 4
      action: "Health checks on blue"
      status: "✓"
      time: "14:10"
      all_healthy: true
      
    - step: 5
      action: "Switch traffic to blue"
      status: "✓"
      time: "14:12"
      traffic_percentage: 100
      
    - step: 6
      action: "Monitor metrics"
      status: "✓"
      time: "14:15"
      duration: "10 minutes"
      
    - step: 7
      action: "Decommission green"
      status: "✓"
      time: "14:25"
      
  post_deployment:
    verification:
      - task: "Application accessible"
        status: "✓"
        response_time: "145ms"
        
      - task: "All services healthy"
        status: "✓"
        services: ["api", "worker", "scheduler"]
        
      - task: "Database connections stable"
        status: "✓"
        connection_pool: "45/100"
        
      - task: "No error spike"
        status: "✓"
        error_rate: "0.01%"
        
    functional_checks:
      - task: "User login working"
        status: "✓"
        test_user: "deployment-test@simone.io"
        
      - task: "Payment processing active"
        status: "✓"
        test_transaction: "successful"
        
      - task: "API endpoints responding"
        status: "✓"
        endpoints_tested: 25
        
    monitoring:
      - task: "Metrics dashboards updated"
        status: "✓"
        dashboard: "prod-overview"
        
      - task: "Alerts active"
        status: "✓"
        test_alert_fired: true
        
      - task: "Logs flowing"
        status: "✓"
        log_volume: "normal"
        
    communication:
      - task: "Deployment success announced"
        status: "✓"
        channels: ["slack", "email"]
        
      - task: "Release notes published"
        status: "✓"
        url: "https://simone.io/releases/2.1.0"
        
      - task: "Support team updated"
        status: "✓"
        known_issues: 0
        
  rollback_plan:
    trigger_conditions:
      - "Error rate > 5%"
      - "Response time > 1s"
      - "Database connection failures"
      - "Payment processing errors"
      
    steps:
      - "Switch traffic back to green"
      - "Rollback database migrations"
      - "Restore configuration"
      - "Notify stakeholders"
      
    tested: true
    estimated_time: "5 minutes"
    
  sign_off:
    technical_lead:
      name: "@tech-lead"
      approved: true
      time: "14:30"
      
    product_owner:
      name: "@product-owner"
      approved: true
      time: "14:35"
      
    operations:
      name: "@ops-manager"
      approved: true
      time: "14:40"
```

### Monitoring Templates

#### 5. Monitoring and Alerting Template

**Template**: `monitoring.yml`  
**Purpose**: Comprehensive monitoring setup

```yaml
metadata:
  template: "monitoring"
  version: "2.0"
  
monitoring:
  infrastructure:
    servers:
      metrics:
        - name: "cpu_utilization"
          threshold: 80
          duration: "5m"
          severity: "warning"
          
        - name: "memory_utilization"
          threshold: 85
          duration: "5m"
          severity: "warning"
          
        - name: "disk_space"
          threshold: 90
          duration: "1m"
          severity: "critical"
          
        - name: "network_errors"
          threshold: 100
          duration: "5m"
          severity: "warning"
          
    database:
      metrics:
        - name: "connection_pool_usage"
          threshold: 80
          duration: "5m"
          severity: "warning"
          
        - name: "query_duration_p99"
          threshold: "1s"
          duration: "5m"
          severity: "warning"
          
        - name: "replication_lag"
          threshold: "10s"
          duration: "1m"
          severity: "critical"
          
        - name: "deadlocks"
          threshold: 5
          duration: "5m"
          severity: "warning"
          
  application:
    api:
      metrics:
        - name: "request_rate"
          baseline: "dynamic"
          deviation: 50
          severity: "info"
          
        - name: "error_rate"
          threshold: 2
          duration: "5m"
          severity: "warning"
          
        - name: "response_time_p95"
          threshold: "500ms"
          duration: "5m"
          severity: "warning"
          
        - name: "response_time_p99"
          threshold: "1s"
          duration: "5m"
          severity: "critical"
          
    business_metrics:
      - name: "user_registrations"
        baseline: 100
        deviation: -50
        duration: "1h"
        severity: "warning"
        
      - name: "payment_failures"
        threshold: 5
        duration: "15m"
        severity: "critical"
        
      - name: "cart_abandonment_rate"
        threshold: 70
        duration: "1h"
        severity: "info"
        
  synthetic_monitoring:
    user_journeys:
      - name: "user_login"
        frequency: "5m"
        timeout: "10s"
        regions: ["us-east-1", "eu-west-1", "ap-south-1"]
        
      - name: "checkout_flow"
        frequency: "15m"
        timeout: "30s"
        regions: ["us-east-1", "eu-west-1"]
        
    api_endpoints:
      - endpoint: "/api/health"
        frequency: "1m"
        timeout: "5s"
        expected_status: 200
        
      - endpoint: "/api/v1/users"
        frequency: "5m"
        timeout: "10s"
        expected_status: 200
        auth_required: true
        
  logging:
    sources:
      - name: "application"
        format: "json"
        fields: ["timestamp", "level", "message", "trace_id"]
        
      - name: "nginx"
        format: "combined"
        parse_regex: '^(\S+) \S+ \S+ \[([^\]]+)\] "([^"]+)" (\d+) (\d+)'
        
    aggregations:
      - name: "error_logs"
        filter: "level:error"
        group_by: ["service", "error_type"]
        window: "5m"
        
      - name: "slow_queries"
        filter: "duration>1000"
        group_by: ["query_type", "table"]
        window: "15m"
        
    retention:
      hot: "7d"
      warm: "30d"
      cold: "90d"
      
  alerting:
    channels:
      critical:
        - type: "pagerduty"
          key: "$PAGERDUTY_KEY"
          
      warning:
        - type: "slack"
          webhook: "$SLACK_WEBHOOK"
          channel: "#alerts"
          
      info:
        - type: "email"
          to: "devops@simone.io"
          
    escalation:
      - level: 1
        after: "5m"
        notify: ["on-call-primary"]
        
      - level: 2
        after: "15m"
        notify: ["on-call-secondary", "team-lead"]
        
      - level: 3
        after: "30m"
        notify: ["engineering-manager", "cto"]
        
  dashboards:
    - name: "System Overview"
      refresh: "30s"
      panels:
        - "Service Health"
        - "Request Rate"
        - "Error Rate"
        - "Response Time"
        
    - name: "Infrastructure"
      refresh: "1m"
      panels:
        - "CPU Usage"
        - "Memory Usage"
        - "Disk I/O"
        - "Network Traffic"
        
    - name: "Business Metrics"
      refresh: "5m"
      panels:
        - "User Activity"
        - "Revenue"
        - "Conversion Funnel"
        - "Customer Satisfaction"
```

#### 6. Incident Response Template

**Template**: `incident-response.yml`  
**Purpose**: Structured incident management

```yaml
metadata:
  template: "incident-response"
  version: "2.0"
  
incident:
  id: "INC-2025-0023"
  title: "API Gateway High Latency"
  severity: "SEV-2"
  status: "resolved"
  
  timeline:
    detected: "2025-01-10T14:23:00Z"
    acknowledged: "2025-01-10T14:25:00Z"
    mitigated: "2025-01-10T14:45:00Z"
    resolved: "2025-01-10T15:30:00Z"
    
  impact:
    duration: "67 minutes"
    services_affected:
      - "API Gateway"
      - "User Service"
      - "Payment Service"
      
    users_affected:
      percentage: 35
      regions: ["us-east-1", "eu-west-1"]
      
    business_impact:
      transactions_delayed: 450
      estimated_revenue_impact: "$12,000"
      sla_breached: false
      
  response_team:
    incident_commander: "@sarah-jones"
    technical_lead: "@mike-chen"
    communications: "@alex-smith"
    participants:
      - "@api-team"
      - "@infrastructure-team"
      - "@database-team"
      
  investigation:
    initial_hypothesis:
      - "DDoS attack"
      - "Database connection exhaustion"
      - "Memory leak in API gateway"
      
    findings:
      - finding: "Spike in API requests from single IP"
        time: "14:28"
        evidence: "Access logs show 10k req/s from 192.168.1.100"
        
      - finding: "Database connection pool at 95%"
        time: "14:32"
        evidence: "Metrics show connection saturation"
        
      - finding: "Misconfigured rate limiting"
        time: "14:38"
        evidence: "Rate limiter allowing 10k req/s instead of 100"
        
    root_cause: |
      Rate limiting configuration was incorrectly set during
      last deployment, allowing 100x intended request rate
      
  actions_taken:
    - time: "14:25"
      action: "Acknowledged incident and assembled team"
      owner: "@on-call"
      
    - time: "14:30"
      action: "Blocked suspicious IP address"
      owner: "@security-team"
      
    - time: "14:35"
      action: "Increased database connection pool"
      owner: "@database-team"
      
    - time: "14:40"
      action: "Fixed rate limiting configuration"
      owner: "@api-team"
      
    - time: "14:45"
      action: "Deployed fix to production"
      owner: "@devops-team"
      
    - time: "15:00"
      action: "Monitored system stability"
      owner: "@monitoring-team"
      
    - time: "15:30"
      action: "Declared incident resolved"
      owner: "@incident-commander"
      
  communication:
    internal:
      - time: "14:25"
        channel: "slack #incidents"
        message: "SEV-2 incident detected - API latency"
        
      - time: "14:45"
        channel: "slack #incidents"
        message: "Mitigation deployed, monitoring"
        
    external:
      - time: "14:30"
        channel: "status page"
        message: "Investigating API performance issues"
        
      - time: "15:00"
        channel: "status page"
        message: "Issue resolved, service restored"
        
  follow_up:
    post_mortem:
      scheduled: "2025-01-12T10:00:00Z"
      owner: "@incident-commander"
      
    action_items:
      - description: "Add configuration validation to CI/CD"
        owner: "@devops-team"
        due_date: "2025-01-17"
        
      - description: "Implement rate limit monitoring alerts"
        owner: "@monitoring-team"
        due_date: "2025-01-15"
        
      - description: "Create runbook for rate limit issues"
        owner: "@api-team"
        due_date: "2025-01-20"
        
    preventive_measures:
      - "Automated configuration testing"
      - "Canary deployments for config changes"
      - "Enhanced monitoring for rate limits"
```

### Operational Excellence Templates

#### 7. Runbook Template

**Template**: `runbook.yml`  
**Purpose**: Standardized operational procedures

```yaml
metadata:
  template: "runbook"
  version: "2.0"
  
runbook:
  title: "Database Connection Pool Exhaustion"
  category: "Database"
  severity: "High"
  
  description: |
    This runbook provides steps to diagnose and resolve
    database connection pool exhaustion issues
    
  symptoms:
    - "Connection timeout errors in logs"
    - "Application response time degradation"
    - "Database connection pool metrics > 90%"
    - "Increased error rate"
    
  prerequisites:
    access_required:
      - "Production database read access"
      - "Application server SSH access"
      - "Monitoring dashboard access"
      
    tools_needed:
      - "psql client"
      - "kubectl"
      - "AWS CLI"
      
  diagnosis_steps:
    - step: 1
      description: "Check current connection pool usage"
      commands:
        - |
          kubectl exec -it api-pod -- curl localhost:8080/metrics | grep db_connections
        - |
          psql -h $DB_HOST -U $DB_USER -c "SELECT count(*) FROM pg_stat_activity;"
          
    - step: 2
      description: "Identify connection consumers"
      commands:
        - |
          psql -h $DB_HOST -U $DB_USER -c "
            SELECT pid, usename, application_name, client_addr, 
                   state, query_start, state_change
            FROM pg_stat_activity
            WHERE state != 'idle'
            ORDER BY query_start;
          "
          
    - step: 3
      description: "Check for long-running queries"
      commands:
        - |
          psql -h $DB_HOST -U $DB_USER -c "
            SELECT pid, now() - pg_stat_activity.query_start AS duration, 
                   query, state
            FROM pg_stat_activity
            WHERE (now() - pg_stat_activity.query_start) > interval '5 minutes';
          "
          
  resolution_steps:
    immediate_mitigation:
      - step: 1
        description: "Increase connection pool size temporarily"
        command: |
          kubectl set env deployment/api-deployment \
            DB_POOL_SIZE=200
        caution: "Monitor memory usage after increase"
        
      - step: 2
        description: "Terminate idle connections"
        command: |
          psql -h $DB_HOST -U $DB_USER -c "
            SELECT pg_terminate_backend(pid)
            FROM pg_stat_activity
            WHERE state = 'idle'
            AND state_change < current_timestamp - INTERVAL '10 minutes';
          "
        caution: "May cause temporary application errors"
        
    permanent_fix:
      - step: 1
        description: "Optimize connection pool settings"
        config: |
          # application.yml
          database:
            pool:
              size: 100
              timeout: 5s
              idle_timeout: 10m
              max_lifetime: 30m
              
      - step: 2
        description: "Implement connection pooling at database level"
        setup: |
          # Install PgBouncer
          apt-get install pgbouncer
          
          # Configure pgbouncer.ini
          [databases]
          simone_db = host=localhost dbname=simone
          
          [pgbouncer]
          pool_mode = transaction
          max_client_conn = 1000
          default_pool_size = 25
          
  verification:
    - "Connection pool usage < 70%"
    - "No connection timeout errors in logs"
    - "Application response time normal"
    - "Database performance metrics stable"
    
  escalation:
    if_not_resolved:
      after: "30 minutes"
      contact:
        - "@database-team-lead"
        - "@platform-architect"
        
  references:
    - title: "PostgreSQL Connection Management"
      url: "https://wiki.simone.io/database/connections"
      
    - title: "Application Pool Configuration"
      url: "https://wiki.simone.io/api/configuration#pool"
      
  last_updated: "2025-01-10"
  maintained_by: "@database-team"
```

#### 8. Disaster Recovery Template

**Template**: `disaster-recovery.yml`  
**Purpose**: Disaster recovery planning and procedures

```yaml
metadata:
  template: "disaster-recovery"
  version: "2.0"
  
disaster_recovery:
  plan_name: "Simone Platform DR Plan"
  last_tested: "2024-12-15"
  next_test: "2025-03-15"
  
  objectives:
    rto: "4 hours"  # Recovery Time Objective
    rpo: "1 hour"   # Recovery Point Objective
    
  scenarios:
    region_failure:
      description: "Complete AWS region failure"
      probability: "Low"
      impact: "Critical"
      
      recovery_steps:
        - step: 1
          action: "Activate incident response team"
          responsible: "@on-call"
          time_estimate: "5 minutes"
          
        - step: 2
          action: "Verify DR region health"
          responsible: "@infrastructure-team"
          time_estimate: "10 minutes"
          
        - step: 3
          action: "Failover DNS to DR region"
          responsible: "@network-team"
          time_estimate: "15 minutes"
          
        - step: 4
          action: "Restore database from snapshot"
          responsible: "@database-team"
          time_estimate: "60 minutes"
          
        - step: 5
          action: "Deploy application stack"
          responsible: "@platform-team"
          time_estimate: "30 minutes"
          
        - step: 6
          action: "Verify application functionality"
          responsible: "@qa-team"
          time_estimate: "30 minutes"
          
    database_corruption:
      description: "Primary database corruption"
      probability: "Medium"
      impact: "High"
      
      recovery_steps:
        - step: 1
          action: "Failover to read replica"
          responsible: "@database-team"
          time_estimate: "15 minutes"
          
        - step: 2
          action: "Promote replica to primary"
          responsible: "@database-team"
          time_estimate: "10 minutes"
          
        - step: 3
          action: "Verify data integrity"
          responsible: "@data-team"
          time_estimate: "30 minutes"
          
        - step: 4
          action: "Rebuild corrupted instance"
          responsible: "@database-team"
          time_estimate: "120 minutes"
          
  backup_strategy:
    database:
      frequency: "Every 6 hours"
      retention: "30 days"
      location: "S3 cross-region"
      encryption: "AES-256"
      
    application_data:
      frequency: "Daily"
      retention: "7 days"
      location: "S3 with versioning"
      
    configuration:
      frequency: "On change"
      retention: "Indefinite"
      location: "Git + S3"
      
  infrastructure_requirements:
    dr_region:
      location: "us-west-2"
      capacity: "50% of production"
      state: "Warm standby"
      
    data_replication:
      method: "Continuous"
      lag_tolerance: "< 5 minutes"
      
    monitoring:
      health_checks: "Every 5 minutes"
      replication_monitoring: "Continuous"
      
  testing_procedures:
    quarterly_drill:
      participants: ["All teams"]
      duration: "4 hours"
      scenarios: ["Region failover", "Database recovery"]
      
    monthly_validation:
      - "Backup restoration test"
      - "Replication lag verification"
      - "DR infrastructure health check"
      
  communication_plan:
    internal:
      - channel: "Slack #dr-activation"
        update_frequency: "Every 30 minutes"
        
      - channel: "Email to all-staff"
        update_frequency: "Hourly"
        
    external:
      - channel: "Status page"
        update_frequency: "Every 30 minutes"
        
      - channel: "Customer email"
        update_frequency: "As needed"
        
  success_criteria:
    - "All services operational in DR region"
    - "Data loss within RPO limits"
    - "Recovery completed within RTO"
    - "Customer communication completed"
    
  post_recovery:
    - "Document actual recovery time"
    - "Identify improvement areas"
    - "Update DR procedures"
    - "Schedule lessons learned session"
```

## Using DevOps Templates

### Quick Commands

```bash
# Deploy infrastructure
claude-code "/project:simone:deploy_infrastructure --env=production"

# Create CI/CD pipeline
claude-code "/project:simone:setup_pipeline --platform=github"

# Configure monitoring
claude-code "/project:simone:setup_monitoring --provider=datadog"

# Generate runbook
claude-code "/project:simone:create_runbook --issue='high-cpu'"
```

### Template Customization

Adapt templates to your environment:

```yaml
# .simone/devops/custom-deployment.yml
extends: "k8s-deployment"
customizations:
  namespace: "my-app"
  replicas: 5
  resources:
    requests:
      cpu: "1000m"
      memory: "2Gi"
```

## Best Practices

### 1. Infrastructure as Code

- Version control everything
- Use declarative configurations
- Test infrastructure changes
- Implement drift detection

### 2. Automation First

- Automate repetitive tasks
- Self-healing systems
- Automated rollbacks
- ChatOps integration

### 3. Monitoring and Observability

- Monitor everything
- Set meaningful alerts
- Track business metrics
- Distributed tracing

### 4. Security Integration

- Security scanning in CI/CD
- Secrets management
- Compliance automation
- Regular security audits

### 5. Documentation

- Keep runbooks updated
- Document architecture decisions
- Maintain disaster recovery plans
- Share knowledge

## Integration Points

### Cloud Providers

```yaml
providers:
  aws:
    - EC2, ECS, EKS
    - RDS, DynamoDB
    - S3, CloudFront
    - Lambda, API Gateway
    
  gcp:
    - Compute Engine, GKE
    - Cloud SQL, Firestore
    - Cloud Storage, CDN
    - Cloud Functions
    
  azure:
    - Virtual Machines, AKS
    - SQL Database, Cosmos DB
    - Blob Storage, CDN
    - Functions
```

### Monitoring Tools

```yaml
monitoring:
  metrics:
    - Prometheus
    - DataDog
    - New Relic
    - CloudWatch
    
  logging:
    - ELK Stack
    - Splunk
    - Sumo Logic
    - CloudWatch Logs
    
  tracing:
    - Jaeger
    - Zipkin
    - AWS X-Ray
    - DataDog APM
```

## Conclusion

DevOps templates in the Simone Framework provide comprehensive coverage for modern infrastructure and operations needs. By using these templates, teams can ensure consistent, reliable, and scalable deployments while maintaining operational excellence. The key is to start with these templates and customize them to fit your specific environment and requirements.