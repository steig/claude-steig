# Multi-Team Project Example - Unified Development Platform Initiative

This example demonstrates how to use the Simone Framework for **large-scale platform projects** with multiple autonomous teams working in federated agile coordination.

## 📋 Project Overview

**Project Type**: Platform Development  
**Team Size**: 75 people across 8 teams and 4 departments  
**Duration**: 15 months  
**Coordination Model**: Federated Agile  
**Technology**: Kubernetes, microservices, shared platform services  

## 🎯 What This Example Demonstrates

### Multi-Team Coordination Features
- **Federated Agile Model**: Team autonomy within shared standards
- **Cross-Team Dependencies**: Sophisticated dependency management
- **Shared Platform Services**: Common infrastructure and services
- **Team Autonomy**: Technology choices within platform constraints
- **Unified Standards**: API governance, security, and monitoring standards

### Simone Framework for Platform Teams
- **Team Structure Management**: 8 teams with clear responsibilities
- **Dependency Tracking**: Cross-team integration planning
- **Shared Sprint Alignment**: Coordinated sprint cycles across teams
- **Platform Governance**: Architecture board and product owner council

## 📁 Key Structure Highlights

```
multi-team-project/
├── README.md                          # This file
└── .simone/
    ├── 00_PROJECT_MANIFEST.md         # Platform program dashboard
    ├── 01_PROJECT_DOCS/
    │   ├── PLATFORM_ARCHITECTURE.md   # Shared platform design
    │   ├── API_STANDARDS.md           # Cross-team API governance
    │   ├── TEAM_CHARTER.md            # Team responsibilities
    │   ├── DEPENDENCY_MANAGEMENT.md   # Cross-team coordination
    │   └── FEDERATED_AGILE_PLAYBOOK.md # Coordination methodology
    ├── 02_REQUIREMENTS/
    │   ├── PLATFORM_CORE/             # Shared platform requirements
    │   ├── TEAM_ALPHA/                # Product team requirements
    │   ├── TEAM_BETA/                 # Business logic requirements
    │   └── INFRASTRUCTURE/             # DevOps requirements
    ├── 03_SPRINTS/                    # Cross-team sprint coordination
    └── 05_ARCHITECTURAL_DECISIONS/     # Platform architecture decisions
```

## 🏗 Platform Characteristics

### Team Structure
- **Platform Team**: Core infrastructure and shared services (8 members)
- **Product Teams**: Customer features and business logic (4 teams, 36 members)
- **Infrastructure Team**: DevOps and site reliability (12 members)
- **Data Team**: Data engineering and ML platform (10 members)
- **Quality Team**: Testing automation and QA (9 members)

### Governance Structure
- **Platform Council**: Strategic decisions and cross-team prioritization
- **Architecture Board**: Technical standards and architectural decisions
- **Product Owners Council**: Feature alignment and customer value
- **Engineering Managers Circle**: Resource allocation and coordination

### Shared Platform Services
- **Identity & Access**: Keycloak with OIDC/OAuth2
- **API Gateway**: Kong with rate limiting and analytics
- **Service Mesh**: Istio for inter-service communication
- **Configuration**: Consul for distributed configuration
- **Monitoring**: Prometheus + Grafana + DataDog
- **Logging**: ELK Stack (Elasticsearch, Logstash, Kibana)

### Team Autonomy Balance
- **Technology Choices**: Teams choose within platform standards
- **Shared Standards**: Common APIs, security, monitoring, deployment
- **Federated Decisions**: Teams make local decisions within global constraints
- **Regular Sync**: Weekly cross-team demos and monthly alignment

This example showcases how Simone Framework coordinates multiple autonomous teams while maintaining shared standards and platform coherence.