---
project_name: "{PROJECT_NAME}"
project_version: "{PROJECT_VERSION}"
created_date: "{CREATED_DATE}"
last_updated: "{LAST_UPDATED}"
current_milestone: "{CURRENT_MILESTONE}"
current_sprint: "{CURRENT_SPRINT}"
project_status: "{PROJECT_STATUS}" # planning, active, maintenance, completed, paused
architecture_version: "{ARCHITECTURE_VERSION}"
team_size: {TEAM_SIZE}
tech_stack:
  language: "{PRIMARY_LANGUAGE}"
  framework: "{PRIMARY_FRAMEWORK}"
  database: "{DATABASE_TYPE}"
  testing: "{TEST_FRAMEWORK}"
  deployment: "{DEPLOYMENT_PLATFORM}"
health_metrics:
  test_coverage: {TEST_COVERAGE}
  documentation_complete: {DOCUMENTATION_PERCENTAGE}
  technical_debt_level: "{TECH_DEBT_LEVEL}" # low, medium, high
  performance_status: "{PERFORMANCE_STATUS}" # excellent, good, needs_attention, critical
  security_status: "{SECURITY_STATUS}" # secure, needs_review, vulnerabilities_present
active_tasks:
  in_progress: {TASKS_IN_PROGRESS}
  pending: {TASKS_PENDING}
  blocked: {TASKS_BLOCKED}
sprint_velocity:
  current_sprint_progress: {CURRENT_SPRINT_PROGRESS}
  average_completion_rate: {AVERAGE_COMPLETION_RATE}
  estimated_sprint_capacity: {ESTIMATED_SPRINT_CAPACITY}
quality_gates:
  code_review_required: true
  automated_testing_required: true
  documentation_required: true
  security_scan_required: {SECURITY_SCAN_REQUIRED}
  performance_testing_required: {PERFORMANCE_TESTING_REQUIRED}
risk_assessment:
  technical_risks: {TECHNICAL_RISKS_COUNT}
  schedule_risks: {SCHEDULE_RISKS_COUNT}
  resource_risks: {RESOURCE_RISKS_COUNT}
  overall_risk_level: "{OVERALL_RISK_LEVEL}" # low, medium, high, critical
---

# {PROJECT_NAME} - Project Manifest

**Status**: {PROJECT_STATUS} | **Version**: {PROJECT_VERSION} | **Last Updated**: {LAST_UPDATED}

## Executive Summary

### Project Vision
{PROJECT_VISION}

### Current State
- **Milestone**: {CURRENT_MILESTONE}
- **Sprint**: {CURRENT_SPRINT}  
- **Health**: {OVERALL_HEALTH_STATUS}
- **Team**: {TEAM_SIZE} developers
- **Progress**: {OVERALL_PROGRESS_PERCENTAGE}% complete

### Key Metrics
- **Test Coverage**: {TEST_COVERAGE}%
- **Documentation**: {DOCUMENTATION_PERCENTAGE}% complete
- **Technical Debt**: {TECH_DEBT_LEVEL}
- **Sprint Velocity**: {AVERAGE_COMPLETION_RATE} tasks/sprint

## Current Focus

### Active Milestone: {CURRENT_MILESTONE}
{CURRENT_MILESTONE_DESCRIPTION}

**Progress**: {MILESTONE_PROGRESS}% | **Target Completion**: {MILESTONE_TARGET_DATE}

### Active Sprint: {CURRENT_SPRINT}
{CURRENT_SPRINT_DESCRIPTION}

**Progress**: {CURRENT_SPRINT_PROGRESS}% | **Sprint End**: {SPRINT_END_DATE}

### Immediate Priorities
1. {PRIORITY_1}
2. {PRIORITY_2}
3. {PRIORITY_3}

## Project Structure

### Technical Architecture
- **Language**: {PRIMARY_LANGUAGE}
- **Framework**: {PRIMARY_FRAMEWORK}
- **Database**: {DATABASE_TYPE}
- **Testing**: {TEST_FRAMEWORK}
- **Deployment**: {DEPLOYMENT_PLATFORM}
- **Architecture Version**: {ARCHITECTURE_VERSION}

### Documentation Status
- [x] Project Manifest (this document)
- [x] [Architecture Documentation](01_PROJECT_DOCS/ARCHITECTURE.md)
- [ ] [API Documentation](01_PROJECT_DOCS/API_DOCUMENTATION.md)
- [ ] [Deployment Guide](01_PROJECT_DOCS/DEPLOYMENT_GUIDE.md)
- [ ] [Setup Guide](01_PROJECT_DOCS/SETUP_GUIDE.md)

### Current Milestones & Sprints

#### Completed Milestones
{COMPLETED_MILESTONES_LIST}

#### Active Milestone: {CURRENT_MILESTONE}
- **Sprint {CURRENT_SPRINT_NUMBER}**: {CURRENT_SPRINT_NAME} (Active)
- **Planned Sprints**: {PLANNED_SPRINTS_LIST}

#### Future Milestones
{FUTURE_MILESTONES_LIST}

## Team & Workflow

### Team Composition
- **Team Size**: {TEAM_SIZE} developers
- **Team Leads**: {TEAM_LEADS}
- **Stakeholders**: {KEY_STAKEHOLDERS}

### Development Workflow
- **Branching Strategy**: {BRANCHING_STRATEGY}
- **Code Review Process**: {CODE_REVIEW_PROCESS}
- **Testing Strategy**: {TESTING_STRATEGY}
- **Deployment Process**: {DEPLOYMENT_PROCESS}

### Quality Standards
- **Code Coverage Minimum**: {MIN_CODE_COVERAGE}%
- **Code Review Required**: {CODE_REVIEW_REQUIRED}
- **Automated Testing Required**: {AUTOMATED_TESTING_REQUIRED}
- **Documentation Required**: {DOCUMENTATION_REQUIRED}

## Health & Metrics

### Current Health Status: {OVERALL_HEALTH_STATUS}

#### Technical Health
- **Code Quality**: {CODE_QUALITY_STATUS}
- **Test Coverage**: {TEST_COVERAGE}% (Target: {TARGET_TEST_COVERAGE}%)
- **Technical Debt**: {TECH_DEBT_LEVEL}
- **Performance**: {PERFORMANCE_STATUS}
- **Security**: {SECURITY_STATUS}

#### Project Health
- **Sprint Velocity**: {AVERAGE_COMPLETION_RATE} tasks/sprint
- **On-time Delivery**: {ONTIME_DELIVERY_RATE}%
- **Stakeholder Satisfaction**: {STAKEHOLDER_SATISFACTION}
- **Team Velocity Trend**: {VELOCITY_TREND}

### Active Tasks Summary
- **In Progress**: {TASKS_IN_PROGRESS} tasks
- **Pending**: {TASKS_PENDING} tasks
- **Blocked**: {TASKS_BLOCKED} tasks
- **Total Active**: {TOTAL_ACTIVE_TASKS} tasks

### Recent Achievements
{RECENT_ACHIEVEMENTS}

### Current Challenges
{CURRENT_CHALLENGES}

## Risk Management

### Overall Risk Level: {OVERALL_RISK_LEVEL}

#### Technical Risks
{TECHNICAL_RISKS_DETAIL}

#### Schedule Risks  
{SCHEDULE_RISKS_DETAIL}

#### Resource Risks
{RESOURCE_RISKS_DETAIL}

### Risk Mitigation Strategies
{RISK_MITIGATION_STRATEGIES}

## Strategic Outlook

### Next 30 Days
{NEXT_30_DAYS_PLAN}

### Next Quarter
{NEXT_QUARTER_PLAN}

### Long-term Vision
{LONG_TERM_VISION}

## Resource Links

### Key Documents
- [Architecture Documentation](01_PROJECT_DOCS/ARCHITECTURE.md)
- [Current Milestone Requirements](02_REQUIREMENTS/{CURRENT_MILESTONE}/)
- [Active Sprint Details](03_SPRINTS/{CURRENT_SPRINT}/)
- [Recent Project Reviews](10_STATE_OF_PROJECT/)

### External Resources
- **Repository**: {REPOSITORY_URL}
- **Documentation**: {DOCUMENTATION_URL}
- **Issue Tracker**: {ISSUE_TRACKER_URL}
- **CI/CD Pipeline**: {CICD_URL}

### Team Communication
- **Chat**: {TEAM_CHAT_URL}
- **Meetings**: {MEETING_SCHEDULE}
- **Status Updates**: {STATUS_UPDATE_FREQUENCY}

## Change Log

### Recent Updates
{RECENT_CHANGE_LOG}

### Version History
{VERSION_HISTORY}

---

## Quick Actions

### For Developers
- **Start Development**: See [Setup Guide](01_PROJECT_DOCS/SETUP_GUIDE.md)
- **Pick Next Task**: Check [Active Sprint](03_SPRINTS/{CURRENT_SPRINT}/)
- **Review Architecture**: Read [Architecture Docs](01_PROJECT_DOCS/ARCHITECTURE.md)
- **Submit Changes**: Follow [Development Workflow](01_PROJECT_DOCS/DEVELOPMENT_WORKFLOW.md)

### For Stakeholders  
- **Project Status**: See Health & Metrics section above
- **Progress Report**: Check [Recent Reviews](10_STATE_OF_PROJECT/)
- **Roadmap**: Review Milestones & Sprints section
- **Escalations**: Contact {ESCALATION_CONTACT}

### For Project Management
- **Update Status**: Run `/project:simone:project_review`
- **Plan Sprint**: Run `/project:simone:create_sprint_tasks`
- **Review Progress**: Check [Project Reviews](10_STATE_OF_PROJECT/)
- **Manage Risks**: Update Risk Management section

---

**Last Updated**: {LAST_UPDATED} | **Next Review**: {NEXT_REVIEW_DATE}