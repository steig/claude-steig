# Architecture Initialization Checklist

> ⚠️ **DEPRECATED**: This checklist has been integrated into `architecture_template.md` for a unified architecture documentation approach. This file will be removed in v3.0.0.
>
> **Migration**: Use `architecture_template.md` which now includes the complete initialization checklist.

Use this checklist during project initialization to ensure comprehensive architecture documentation.

## 1. Codebase Analysis (Auto-Detection)

### Tech Stack Detection
- [ ] **Primary Language**: Detected from file extensions and package files
- [ ] **Framework**: Identified from dependencies and project structure
- [ ] **Database**: Found in configuration files and dependencies
- [ ] **Testing Framework**: Detected from test directories and dependencies
- [ ] **Build Tools**: Identified from build configuration files
- [ ] **Package Manager**: Detected from lock files and configurations

### Project Structure Analysis
- [ ] **Folder Organization**: Mapped directory structure and patterns
- [ ] **Module Patterns**: Identified how code is organized into modules
- [ ] **Configuration Management**: Located and analyzed config files
- [ ] **Environment Setup**: Detected development environment requirements
- [ ] **Script Analysis**: Identified build, test, and deployment scripts

### Code Pattern Detection
- [ ] **Architectural Patterns**: MVC, microservices, monolithic, etc.
- [ ] **Design Patterns**: Singleton, Factory, Observer, etc.
- [ ] **Data Access Patterns**: ORM, Repository, DAO, etc.
- [ ] **API Patterns**: REST, GraphQL, RPC, etc.
- [ ] **Authentication Patterns**: JWT, OAuth, Session-based, etc.

## 2. Interactive Architecture Gathering

### Business Context
- [ ] **Project Purpose**: Clear statement of what the project does
- [ ] **Business Goals**: Key objectives and success metrics
- [ ] **Target Users**: Primary and secondary user groups
- [ ] **Success Metrics**: How success will be measured
- [ ] **Timeline Constraints**: Any critical deadlines or milestones

### Technical Decisions
- [ ] **Technology Choices**: Why specific technologies were chosen
- [ ] **Architectural Decisions**: Key structural decisions made
- [ ] **Performance Requirements**: Speed, throughput, scalability needs
- [ ] **Security Requirements**: Authentication, authorization, data protection
- [ ] **Compliance Requirements**: Industry standards, regulations, policies

### Development Workflow
- [ ] **Branching Strategy**: Git workflow and branch management
- [ ] **Testing Strategy**: Unit, integration, E2E testing approach
- [ ] **Code Review Process**: How code reviews are conducted
- [ ] **Deployment Process**: How code gets to production
- [ ] **Monitoring Strategy**: How system health is monitored

## 3. Architecture Document Creation

### Core Sections
- [ ] **Quick Reference**: Tech stack summary and key decisions
- [ ] **Project Context**: Purpose, goals, and success metrics
- [ ] **System Architecture**: High-level overview and components
- [ ] **Development Architecture**: Code organization and patterns
- [ ] **Technical Standards**: Coding standards and quality gates
- [ ] **Testing Architecture**: Test strategy and approaches
- [ ] **Deployment & Infrastructure**: Environments and deployment strategy
- [ ] **Security & Compliance**: Security measures and compliance requirements
- [ ] **Performance & Scalability**: Performance requirements and scaling strategy
- [ ] **Development Workflow Integration**: How architecture supports Simone workflow
- [ ] **Evolution Strategy**: How architecture will evolve over time
- [ ] **Decision Context**: Links to ADRs and key decisions

### Integration Points
- [ ] **Simone Integration**: How architecture supports task-based development
- [ ] **Sprint Planning**: How architecture influences sprint organization
- [ ] **Code Reviews**: Architecture compliance in review process
- [ ] **Testing Integration**: Architecture-driven testing approach
- [ ] **ADR References**: Links to relevant Architectural Decision Records

## 4. Quality Validation

### Completeness Check
- [ ] **All sections filled**: No template placeholders remaining
- [ ] **Consistent information**: No contradictions between sections
- [ ] **Actionable guidance**: Clear instructions for developers
- [ ] **Decision rationale**: Explanations for key architectural choices
- [ ] **Integration clarity**: Clear connection to Simone workflow

### Usability Validation
- [ ] **Quick Start Guide**: New developers can get started quickly
- [ ] **Code Review Checklist**: Reviewers have clear architectural guidelines
- [ ] **Sprint Planning Support**: Architecture supports milestone planning
- [ ] **Testing Guidance**: Clear testing approach and standards
- [ ] **Development Patterns**: Clear patterns for common development tasks

## 5. Continuous Improvement

### Evolution Strategy
- [ ] **Version Control**: Architecture document versioning approach
- [ ] **Change Management**: How architectural changes are managed
- [ ] **Regular Reviews**: Schedule for architecture review and updates
- [ ] **Feedback Loop**: How architecture feedback is collected and acted upon
- [ ] **ADR Process**: How architectural decisions are documented

### Integration Optimization
- [ ] **Command Integration**: How architecture supports all Simone commands
- [ ] **Template Updates**: How architecture insights improve other templates
- [ ] **Workflow Optimization**: How architecture enables faster development
- [ ] **Quality Improvement**: How architecture supports better code quality
- [ ] **Team Alignment**: How architecture keeps team aligned on technical direction

## Usage Notes

### For Initialize Command
- Use this checklist to ensure comprehensive architecture documentation
- Leverage MCP servers for enhanced analysis and detection
- Focus on creating actionable, developer-friendly documentation
- Ensure strong integration with Simone workflow patterns

### For Project Evolution
- Review and update architecture documentation regularly
- Use this checklist when onboarding new team members
- Reference during major architectural decisions
- Update as project requirements and constraints evolve

### For Quality Assurance
- Use during code reviews to ensure architectural compliance
- Reference during sprint planning to identify architectural considerations
- Use for project health assessments and technical debt identification
- Guide for maintaining architectural consistency across development team