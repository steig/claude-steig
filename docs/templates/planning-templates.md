# Planning Templates

**Last Updated**: 2025-07-10  
**Version**: 2.1.0  
**Framework**: Simone Framework

## Overview

Planning templates in the Simone Framework facilitate structured project planning at multiple levels - from high-level roadmaps to detailed sprint planning. These templates ensure comprehensive planning while maintaining flexibility for different project types and methodologies.

## Planning Template Categories

### Strategic Planning Templates

#### 1. Product Roadmap Template

**Template**: `roadmap.yml`  
**Purpose**: Long-term product vision and planning

```yaml
metadata:
  template: "roadmap"
  version: "2.0"
  planning_horizon: "12 months"
  
roadmap:
  vision: |
    Become the leading platform for small business automation
    by providing intuitive, AI-powered workflow tools
    
  strategic_themes:
    - title: "AI-Powered Automation"
      description: "Integrate AI to automate repetitive tasks"
      timeframe: "Q1-Q2 2025"
      
    - title: "Enterprise Scalability"
      description: "Support for large-scale deployments"
      timeframe: "Q3-Q4 2025"
      
  quarters:
    Q1_2025:
      theme: "Foundation"
      objectives:
        - Launch MVP with core features
        - Achieve 1000 active users
        - Establish support infrastructure
      key_features:
        - User authentication system
        - Basic workflow builder
        - Integration marketplace
        
    Q2_2025:
      theme: "Growth"
      objectives:
        - Scale to 10,000 users
        - Launch mobile application
        - Implement AI recommendations
      key_features:
        - AI-powered suggestions
        - Mobile apps (iOS/Android)
        - Advanced analytics
        
  success_metrics:
    - Monthly Active Users (MAU)
    - Customer Satisfaction Score (CSAT)
    - Revenue growth rate
    - Feature adoption rate
    
  risks_and_mitigations:
    - risk: "Competitive pressure"
      mitigation: "Focus on unique AI capabilities"
    - risk: "Technical scalability"
      mitigation: "Invest in infrastructure early"
```

#### 2. Release Planning Template

**Template**: `release-plan.yml`  
**Purpose**: Planning for specific product releases

```yaml
metadata:
  template: "release-plan"
  version: "2.0"
  
release:
  version: "2.1.0"
  codename: "Neptune"
  target_date: "2025-03-15"
  
  release_goals:
    - Improve system performance by 40%
    - Add enterprise SSO capabilities
    - Enhanced mobile experience
    
  feature_set:
    must_have:
      - feature: "Single Sign-On (SSO)"
        owner: "@security-team"
        status: "in-progress"
      - feature: "Performance optimizations"
        owner: "@platform-team"
        status: "completed"
        
    nice_to_have:
      - feature: "Advanced reporting"
        owner: "@analytics-team"
        status: "at-risk"
        
  dependencies:
    external:
      - "Auth0 integration approval"
      - "App store review process"
    internal:
      - "Database migration completion"
      - "Security audit sign-off"
      
  release_criteria:
    - All must-have features completed
    - Performance benchmarks met
    - Security audit passed
    - Zero critical bugs
    
  rollout_plan:
    - phase: "Internal testing"
      duration: "1 week"
      participants: "QA team"
    - phase: "Beta release"
      duration: "2 weeks"
      participants: "100 selected customers"
    - phase: "General availability"
      duration: "ongoing"
      participants: "All users"
```

### Milestone Planning Templates

#### 3. Milestone Definition Template

**Template**: `milestone.yml`  
**Purpose**: Define and track major project milestones

```yaml
metadata:
  template: "milestone"
  version: "2.0"
  
milestone:
  id: "M-2025-Q1-01"
  title: "Platform Launch Readiness"
  description: |
    Complete all requirements for public platform launch
    including features, infrastructure, and go-to-market
    
  timeline:
    start_date: "2025-01-01"
    target_date: "2025-03-31"
    critical_path: true
    
  deliverables:
    technical:
      - name: "Core platform features"
        criteria: "All P0 features implemented and tested"
        owner: "@engineering"
        status: "on-track"
        
      - name: "Infrastructure setup"
        criteria: "Production environment ready for 10k users"
        owner: "@devops"
        status: "at-risk"
        
    business:
      - name: "Go-to-market strategy"
        criteria: "Marketing campaign ready to launch"
        owner: "@marketing"
        status: "completed"
        
      - name: "Support documentation"
        criteria: "User guides and API docs published"
        owner: "@documentation"
        status: "in-progress"
        
  success_criteria:
    - System handles 1000 concurrent users
    - 99.9% uptime SLA achievable
    - Complete feature parity with competitors
    - Support team trained and ready
    
  risks:
    - description: "Infrastructure scaling issues"
      probability: "medium"
      impact: "high"
      mitigation: "Load testing and capacity planning"
      
  stakeholders:
    sponsor: "@ceo"
    leads:
      - "@cto"
      - "@vp-product"
    teams:
      - "engineering"
      - "marketing"
      - "support"
```

#### 4. Quarterly Planning Template

**Template**: `quarterly-plan.yml`  
**Purpose**: Detailed planning for quarterly objectives

```yaml
metadata:
  template: "quarterly-plan"
  version: "2.0"
  
quarter:
  period: "Q1 2025"
  theme: "Scale and Stability"
  
  objectives:
    - objective: "Achieve 99.9% platform uptime"
      key_results:
        - "Implement automated failover"
        - "Reduce incident response time to < 5 minutes"
        - "Zero data loss incidents"
      owner: "@platform-team"
      
    - objective: "Grow user base by 300%"
      key_results:
        - "Launch referral program"
        - "Implement freemium tier"
        - "Achieve 50% month-over-month growth"
      owner: "@growth-team"
      
  initiatives:
    - name: "Infrastructure Resilience"
      description: "Improve system reliability and recovery"
      milestones:
        - "Multi-region deployment"
        - "Automated backup system"
        - "Disaster recovery plan"
      budget: "$150,000"
      
    - name: "User Acquisition"
      description: "Accelerate user growth through various channels"
      milestones:
        - "Launch affiliate program"
        - "Content marketing strategy"
        - "Paid acquisition campaigns"
      budget: "$200,000"
      
  resource_allocation:
    engineering: "60%"
    marketing: "25%"
    support: "10%"
    operations: "5%"
    
  review_schedule:
    - "Week 4: Initial progress check"
    - "Week 8: Mid-quarter review"
    - "Week 12: Final assessment"
```

### Sprint Planning Templates

#### 5. Sprint Planning Template

**Template**: `sprint-plan.yml`  
**Purpose**: Detailed sprint planning and tracking

```yaml
metadata:
  template: "sprint-plan"
  version: "2.0"
  
sprint:
  number: 42
  name: "Authentication Improvements"
  duration: "2 weeks"
  dates:
    start: "2025-01-15"
    end: "2025-01-29"
    
  goals:
    - "Complete SSO integration"
    - "Fix critical authentication bugs"
    - "Improve login performance by 50%"
    
  capacity:
    total_hours: 320  # 4 developers × 80 hours
    planned_hours: 256  # 80% allocation
    buffer_hours: 64   # 20% for unplanned work
    
  commitments:
    - task_id: "TASK-101"
      title: "Implement SAML SSO"
      points: 8
      assignee: "@alice"
      
    - task_id: "TASK-102"
      title: "Fix password reset flow"
      points: 3
      assignee: "@bob"
      
    - task_id: "TASK-103"
      title: "Optimize JWT validation"
      points: 5
      assignee: "@charlie"
      
  velocity:
    historical_average: 45
    last_sprint: 42
    target: 48
    
  risks:
    - "External dependency on Auth0 API changes"
    - "Limited QA availability"
    
  ceremonies:
    planning:
      date: "2025-01-15 10:00"
      duration: "2 hours"
      
    daily_standup:
      time: "09:30"
      duration: "15 minutes"
      
    review:
      date: "2025-01-29 14:00"
      duration: "1 hour"
      
    retrospective:
      date: "2025-01-29 15:30"
      duration: "1 hour"
```

#### 6. Sprint Retrospective Template

**Template**: `retrospective.yml`  
**Purpose**: Capture learnings and improvements from sprints

```yaml
metadata:
  template: "retrospective"
  version: "2.0"
  
retrospective:
  sprint: 42
  date: "2025-01-29"
  facilitator: "@scrum-master"
  participants:
    - "@alice"
    - "@bob"
    - "@charlie"
    - "@dana"
    
  metrics:
    committed_points: 48
    completed_points: 45
    velocity_target_met: false
    sprint_goals_achieved: "2 of 3"
    
  what_went_well:
    - item: "Great collaboration on SSO implementation"
      votes: 4
    - item: "Effective pair programming sessions"
      votes: 3
    - item: "Quick resolution of blockers"
      votes: 2
      
  what_needs_improvement:
    - item: "Too many context switches"
      votes: 4
      action: "Limit WIP to 2 items per person"
      owner: "@team"
      
    - item: "Unclear requirements for some tasks"
      votes: 3
      action: "Add requirement review to planning"
      owner: "@product-owner"
      
    - item: "Late integration testing"
      votes: 2
      action: "Start integration tests by day 3"
      owner: "@qa-lead"
      
  action_items:
    - description: "Implement WIP limits in Jira"
      owner: "@scrum-master"
      due_date: "2025-02-05"
      
    - description: "Create requirements checklist"
      owner: "@product-owner"
      due_date: "2025-02-01"
      
  kudos:
    - from: "@alice"
      to: "@bob"
      message: "Thanks for help with SAML debugging!"
      
    - from: "@charlie"
      to: "@team"
      message: "Great teamwork this sprint!"
```

### Project Planning Templates

#### 7. Project Kickoff Template

**Template**: `project-kickoff.yml`  
**Purpose**: Comprehensive project initiation

```yaml
metadata:
  template: "project-kickoff"
  version: "2.0"
  
project:
  name: "Mobile App Development"
  code: "PROJ-MOB-2025"
  type: "new-development"
  
  overview:
    description: |
      Develop native mobile applications for iOS and Android
      to complement our web platform
      
    business_case: |
      60% of users request mobile access
      Competitors have mobile apps
      Mobile usage growing 40% YoY
      
    expected_outcomes:
      - Increase user engagement by 50%
      - Capture mobile-first market segment
      - Improve customer satisfaction scores
      
  scope:
    in_scope:
      - Native iOS application
      - Native Android application
      - Core feature parity with web
      - Push notifications
      - Offline mode
      
    out_of_scope:
      - Tablet-specific interfaces
      - Advanced features beyond web
      - Wearable device support
      
  timeline:
    kickoff: "2025-02-01"
    milestones:
      - name: "Design Complete"
        date: "2025-03-01"
      - name: "Alpha Release"
        date: "2025-05-01"
      - name: "Beta Release"
        date: "2025-06-15"
      - name: "Public Launch"
        date: "2025-07-01"
        
  team:
    project_manager: "@sarah"
    tech_lead: "@mike"
    members:
      - name: "@john"
        role: "iOS Developer"
        allocation: "100%"
      - name: "@emma"
        role: "Android Developer"
        allocation: "100%"
      - name: "@david"
        role: "Backend Developer"
        allocation: "50%"
      - name: "@lisa"
        role: "UI/UX Designer"
        allocation: "75%"
        
  budget:
    total: "$500,000"
    breakdown:
      development: "$350,000"
      design: "$50,000"
      infrastructure: "$30,000"
      marketing: "$50,000"
      contingency: "$20,000"
      
  risks:
    - risk: "App store rejection"
      impact: "high"
      probability: "medium"
      mitigation: "Early app store guideline review"
      
    - risk: "Platform fragmentation"
      impact: "medium"
      probability: "high"
      mitigation: "Focus on latest 2 OS versions"
      
  communication_plan:
    stakeholder_updates: "Bi-weekly"
    team_meetings: "Daily standups"
    status_reports: "Weekly"
    escalation_path: "PM -> Tech Lead -> VP Engineering"
```

#### 8. Capacity Planning Template

**Template**: `capacity-plan.yml`  
**Purpose**: Team capacity and resource planning

```yaml
metadata:
  template: "capacity-plan"
  version: "2.0"
  
capacity_planning:
  period: "Q1 2025"
  team: "Platform Engineering"
  
  team_members:
    - name: "@alice"
      role: "Senior Engineer"
      availability:
        january: 0.9  # 10% on support
        february: 1.0
        march: 0.8   # 20% on hiring
      skills:
        - "Backend"
        - "DevOps"
        - "Python"
        
    - name: "@bob"
      role: "Engineer"
      availability:
        january: 1.0
        february: 0.5  # 50% on training
        march: 1.0
      skills:
        - "Frontend"
        - "React"
        - "TypeScript"
        
  planned_work:
    projects:
      - name: "API v2"
        effort_days: 60
        skills_required: ["Backend", "Python"]
        priority: "high"
        
      - name: "Dashboard Redesign"
        effort_days: 40
        skills_required: ["Frontend", "React"]
        priority: "medium"
        
    maintenance:
      percentage: 20
      typical_tasks:
        - "Bug fixes"
        - "Security patches"
        - "Performance tuning"
        
    meetings_overhead:
      percentage: 15
      includes:
        - "Sprint ceremonies"
        - "1:1s"
        - "Team meetings"
        
  capacity_analysis:
    total_available_days: 180
    planned_project_days: 100
    maintenance_days: 36
    meeting_days: 27
    buffer_days: 17
    
    utilization_target: 85%
    actual_utilization: 91%
    
  recommendations:
    - "Reduce meeting overhead by 5%"
    - "Consider hiring additional backend engineer"
    - "Defer low-priority features to Q2"
```

### Strategic Planning Templates

#### 9. Risk Management Plan Template

**Template**: `risk-plan.yml`  
**Purpose**: Comprehensive risk planning and mitigation

```yaml
metadata:
  template: "risk-plan"
  version: "2.0"
  
risk_management:
  project: "Platform Migration"
  assessment_date: "2025-01-10"
  next_review: "2025-02-10"
  
  risk_categories:
    technical:
      - id: "RISK-001"
        description: "Data loss during migration"
        probability: "low"
        impact: "critical"
        score: 8  # probability × impact
        
        mitigation_strategies:
          - "Implement comprehensive backup strategy"
          - "Perform dry runs in staging"
          - "Create rollback procedures"
          
        contingency_plan: |
          1. Stop migration immediately
          2. Restore from backup
          3. Investigate root cause
          4. Implement fixes before retry
          
        owner: "@platform-lead"
        status: "monitoring"
        
    business:
      - id: "RISK-002"
        description: "Customer churn due to downtime"
        probability: "medium"
        impact: "high"
        score: 6
        
        mitigation_strategies:
          - "Implement zero-downtime migration"
          - "Communicate proactively with customers"
          - "Offer service credits for any issues"
          
        owner: "@customer-success"
        status: "mitigated"
        
    resource:
      - id: "RISK-003"
        description: "Key team member unavailable"
        probability: "medium"
        impact: "medium"
        score: 4
        
        mitigation_strategies:
          - "Document all procedures"
          - "Cross-train team members"
          - "Identify external consultants"
          
        owner: "@project-manager"
        status: "accepted"
        
  risk_matrix:
    critical_risks: ["RISK-001"]
    high_risks: ["RISK-002"]
    medium_risks: ["RISK-003"]
    
  monitoring_plan:
    - Weekly risk review meetings
    - Monthly stakeholder updates
    - Automated alerts for risk triggers
    
  escalation_thresholds:
    - score >= 8: "Immediate escalation to VP"
    - score >= 6: "Escalation to Director"
    - score >= 4: "Team lead notification"
```

#### 10. Resource Planning Template

**Template**: `resource-plan.yml`  
**Purpose**: Long-term resource and budget planning

```yaml
metadata:
  template: "resource-plan"
  version: "2.0"
  
resource_planning:
  fiscal_year: "2025"
  department: "Engineering"
  
  headcount_plan:
    current_headcount: 25
    planned_additions:
      Q1:
        - role: "Senior Backend Engineer"
          count: 2
          cost: "$300,000"
        - role: "DevOps Engineer"
          count: 1
          cost: "$140,000"
          
      Q2:
        - role: "Frontend Engineer"
          count: 3
          cost: "$360,000"
        - role: "QA Engineer"
          count: 2
          cost: "$200,000"
          
    total_new_headcount: 8
    total_headcount_cost: "$1,000,000"
    
  budget_allocation:
    salaries: "$4,500,000"
    benefits: "$900,000"
    tools_and_licenses: "$150,000"
    training: "$100,000"
    conferences: "$50,000"
    equipment: "$75,000"
    contingency: "$225,000"
    
    total_budget: "$6,000,000"
    
  tool_investments:
    - name: "APM Solution"
      cost: "$50,000/year"
      justification: "Improve system observability"
      
    - name: "CI/CD Platform Upgrade"
      cost: "$30,000/year"
      justification: "Reduce deployment time by 50%"
      
  training_plan:
    technical_skills:
      - "Kubernetes certification"
      - "AWS advanced training"
      - "Security best practices"
      
    leadership_development:
      - "Engineering management training"
      - "Technical leadership workshop"
      
  efficiency_targets:
    - "Reduce time-to-market by 30%"
    - "Improve deployment frequency to daily"
    - "Achieve 90% automated test coverage"
```

## Using Planning Templates

### Quick Start Commands

```bash
# Create a new roadmap
claude-code "/project:simone:create_plan --type=roadmap --horizon=12months"

# Initialize sprint planning
claude-code "/project:simone:plan_sprint --number=43 --duration=2weeks"

# Generate capacity report
claude-code "/project:simone:analyze_capacity --team=engineering --period=Q1"

# Create project kickoff
claude-code "/project:simone:kickoff_project --name='Mobile App'"
```

### Template Customization

1. **Extend existing templates**:
   ```yaml
   # Add custom fields to any template
   custom_fields:
     compliance_review: "required"
     sustainability_impact: "assessed"
   ```

2. **Create organization-specific templates**:
   ```bash
   cp .claude/templates/simone/planning/sprint-plan.yml \
      .simone/templates/planning/agile-sprint.yml
   ```

3. **Template inheritance**:
   ```yaml
   metadata:
     extends: "sprint-plan"
     custom_version: "1.0"
   ```

## Best Practices

### 1. Regular Updates

- Update plans weekly/bi-weekly
- Track actuals vs. planned
- Adjust based on learnings

### 2. Stakeholder Alignment

- Share plans with all stakeholders
- Get explicit buy-in
- Document assumptions

### 3. Risk Management

- Identify risks early
- Plan mitigations proactively
- Review risks regularly

### 4. Realistic Planning

- Include buffer time
- Account for meetings/overhead
- Consider team velocity

### 5. Measurable Outcomes

- Define clear success criteria
- Set measurable goals
- Track progress objectively

## Integration with Other Tools

### Project Management Tools

```yaml
integrations:
  jira:
    sync_sprints: true
    sync_tasks: true
    
  github:
    link_milestones: true
    track_releases: true
    
  slack:
    planning_notifications: true
    daily_summaries: true
```

### Reporting and Analytics

Generate reports from planning data:

```bash
# Sprint velocity report
claude-code "/project:simone:report --type=velocity --sprints=last-5"

# Capacity utilization
claude-code "/project:simone:report --type=capacity --period=Q1"

# Risk assessment summary
claude-code "/project:simone:report --type=risks --status=active"
```

## Conclusion

Planning templates in the Simone Framework provide comprehensive structures for every level of project planning. From strategic roadmaps to detailed sprint plans, these templates ensure thorough planning while maintaining the flexibility needed for different project types and organizational needs. Regular use of these templates leads to better project outcomes, improved team alignment, and more predictable delivery.