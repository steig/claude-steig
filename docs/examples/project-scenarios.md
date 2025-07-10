# Simone Framework Project Scenarios

---
title: "Project Scenarios and Examples"
type: "examples"
category: "project_management"
complexity: "beginner_to_advanced"
audience: ["project_managers", "team_leads", "architects"]
created_date: "2025-07-10"
updated_date: "2025-07-10"
version: "1.0.0"
tags: ["examples", "scenarios", "best_practices", "templates"]
related_docs: ["template-catalog.md", "project-structure.md", "getting-started/quick-start.md"]
---

## Overview

The Simone Framework is designed to work across diverse project types, team sizes, and organizational contexts. This document showcases real-world scenarios demonstrating how Simone adapts to different project management needs while maintaining consistency and structure.

## Scenario Categories

### 1. Startup Project (Lean & Agile)
**Context**: Small team, tight budget, rapid iteration  
**Example**: [SaaS Analytics Platform MVP](../examples/startup-project/.simone/00_PROJECT_MANIFEST.md)

### 2. Enterprise Project (Scaled & Governed)
**Context**: Large organization, compliance requirements, complex stakeholder management  
**Example**: [Global Customer Portal Modernization](../examples/enterprise-project/.simone/00_PROJECT_MANIFEST.md)

### 3. Migration Project (Risk-Focused)
**Context**: Legacy system replacement, zero-downtime requirements, high technical risk  
**Example**: [Legacy Mainframe to Cloud Migration](../examples/migration-project/.simone/00_PROJECT_MANIFEST.md)

### 4. Multi-Team Project (Coordination-Heavy)
**Context**: Multiple teams, cross-department collaboration, shared platform development  
**Example**: [Unified Development Platform Initiative](../examples/multi-team-project/.simone/00_PROJECT_MANIFEST.md)

---

## Scenario Comparison Matrix

| Aspect | Startup | Enterprise | Migration | Multi-Team |
|--------|---------|------------|-----------|------------|
| **Team Size** | 3 people | 45 people | 25 people | 75 people |
| **Duration** | 3 months | 18 months | 24 months | 15 months |
| **Budget** | $50K | $12M | $8M | $6M |
| **Risk Level** | High | High | Critical | Medium |
| **Complexity** | Moderate | Very Complex | Very Complex | Very Complex |
| **Compliance** | Minimal | SOX, GDPR, SOC2 | SOX | Internal Standards |
| **Methodology** | Lean Startup | SAFe + Simone | Waterfall + Agile | Federated Agile |

## Key Adaptations by Scenario

### Startup Project Adaptations

**Simplified Quality Standards**
- Manual testing vs. automated test suites
- Basic code review vs. formal architecture review
- Essential documentation vs. comprehensive documentation

**Lean Metrics Focus**
- Build-Measure-Learn cycle integration
- Hypothesis tracking in project metadata
- Customer validation metrics over technical metrics

**Resource Optimization**
- Single person wearing multiple hats (PM/PO/TL)
- Shared responsibilities across small team
- Cost-conscious tool selection

### Enterprise Project Adaptations

**Enhanced Governance**
- Multiple approval layers and review boards
- Comprehensive audit trails and documentation
- Formal change management processes

**Compliance Integration**
- Regulatory requirements in YAML frontmatter
- Automated compliance checking and reporting
- Security reviews for all changes

**Stakeholder Management**
- Executive steering committee structure
- Regular stakeholder communication plans
- Multi-level reporting and dashboards

### Migration Project Adaptations

**Risk-Centric Planning**
- Zero-downtime requirements as core constraint
- Parallel system operation strategy
- Comprehensive rollback procedures

**Legacy System Integration**
- Strangler fig pattern implementation
- Data integrity validation frameworks
- Business continuity planning

**Specialized Team Structure**
- Legacy system experts and modern architects
- Data migration specialists
- Business continuity coordinators

### Multi-Team Project Adaptations

**Coordination Mechanisms**
- Federated agile with shared ceremonies
- Cross-team dependency tracking
- Shared platform and standards

**Distributed Decision Making**
- Team autonomy within global constraints
- Architecture board for technical decisions
- Platform council for strategic alignment

**Shared Resource Management**
- Platform team for common services
- Cross-team on-call rotation
- Shared budget allocation models

---

## Common Patterns Across Scenarios

### Universal Simone Elements

**Project Manifest Structure**
All scenarios use the same basic YAML frontmatter structure:
```yaml
id: "unique-project-identifier"
title: "Human-readable project name"
type: "project_category"
status: "current_phase"
priority: "business_priority"
business_value: "value_assessment"
technical_complexity: "complexity_level"
```

**Milestone-Sprint-Task Hierarchy**
All projects follow the same structural pattern:
- Milestones: Major business deliverables
- Sprints: Time-boxed development cycles
- Tasks: Individual work items

**Quality Standards Framework**
All scenarios include:
- Definition of Done criteria
- Quality gates appropriate to context
- Review and approval processes

### Scaling Patterns

**Team Size Scaling**
- **Small (3-10)**: Direct communication, shared responsibilities
- **Medium (10-30)**: Specialized roles, formal ceremonies
- **Large (30+)**: Multiple teams, governance structures

**Complexity Scaling**
- **Simple**: Basic templates, minimal process
- **Moderate**: Standard templates, regular ceremonies
- **Complex**: Extended templates, formal governance

**Risk Scaling**
- **Low**: Simplified approvals, basic testing
- **Medium**: Standard reviews, automated testing
- **High/Critical**: Multiple approvals, comprehensive testing

---

## Implementation Guidance by Scenario

### When to Use Each Scenario Template

**Choose Startup Template When:**
- Small team (3-10 people)
- Limited budget and timeline
- High uncertainty and need for rapid iteration
- Minimal compliance requirements
- Focus on product-market fit validation

**Choose Enterprise Template When:**
- Large organization with formal processes
- Significant compliance and audit requirements
- Multiple stakeholder groups and approval layers
- High-stakes project with substantial budget
- Need for comprehensive documentation and governance

**Choose Migration Template When:**
- Replacing or modernizing legacy systems
- Zero-downtime requirements
- High technical risk and complexity
- Need for parallel system operation
- Business continuity is critical

**Choose Multi-Team Template When:**
- Multiple development teams
- Cross-functional collaboration required
- Shared platform or infrastructure development
- Need for team autonomy with alignment
- Complex dependency management

### Customization Guidelines

**Adapting Templates for Your Context**

1. **Start with closest scenario template**
2. **Modify YAML frontmatter** to match your metadata needs
3. **Adjust quality standards** to match your risk tolerance
4. **Scale communication plans** to match your organization
5. **Customize governance** to match your approval processes

**Common Customizations**
- Adding industry-specific compliance requirements
- Modifying team structure for matrix organizations
- Adjusting sprint durations for different cadences
- Including organization-specific quality metrics

---

## Best Practices by Scenario

### Startup Best Practices

**Speed and Agility**
- Keep documentation lightweight but sufficient
- Focus on customer validation over internal process
- Use hypothesis-driven development approach
- Prioritize features that validate core assumptions

**Resource Efficiency**
- Leverage existing tools and platforms when possible
- Focus on MVP scope and avoid feature creep
- Cross-train team members for flexibility
- Plan for scaling processes as team grows

### Enterprise Best Practices

**Governance and Compliance**
- Establish clear approval processes early
- Automate compliance checking where possible
- Maintain comprehensive audit trails
- Regular stakeholder communication and alignment

**Risk Management**
- Identify and mitigate risks proactively
- Plan for multiple approval layers and reviews
- Build in buffer time for governance processes
- Establish clear escalation procedures

### Migration Best Practices

**Business Continuity**
- Plan for zero-downtime operation
- Test rollback procedures regularly
- Maintain parallel systems during transition
- Validate data integrity continuously

**Technical Excellence**
- Invest in comprehensive testing strategies
- Use proven migration patterns (Strangler Fig, etc.)
- Plan for incremental migration approach
- Monitor performance throughout transition

### Multi-Team Best Practices

**Coordination and Alignment**
- Establish shared standards and platforms
- Plan for cross-team dependencies
- Regular synchronization and communication
- Balance team autonomy with alignment needs

**Shared Ownership**
- Distribute platform responsibilities across teams
- Share on-call and support responsibilities
- Cross-team knowledge sharing and learning
- Collaborative decision-making processes

---

## Example Project Files

Each scenario includes complete example project structures:

### File Structure Examples
```
examples/
├── startup-project/
│   └── .simone/
│       ├── 00_PROJECT_MANIFEST.md
│       ├── 01_PROJECT_DOCS/
│       ├── 02_REQUIREMENTS/
│       └── 03_SPRINTS/
├── enterprise-project/
├── migration-project/
└── multi-team-project/
```

### Key Documents Included
- **Project Manifest**: Complete with scenario-specific metadata
- **Requirements Documentation**: Tailored to project complexity
- **Sprint Planning**: Examples of planning for each scenario
- **Quality Standards**: Adapted for each context

---

## Getting Started with Scenarios

### Step 1: Identify Your Scenario
Review the scenario descriptions and choose the one that best matches your project characteristics.

### Step 2: Copy Example Structure
```bash
# Copy the relevant example to your project location
cp -r examples/startup-project/.simone /path/to/your/project/
```

### Step 3: Customize for Your Context
- Update project manifest with your details
- Modify quality standards for your requirements
- Adjust team structure and communication plans
- Customize templates for your domain

### Step 4: Begin Project Execution
- Start with project initialization using Simone commands
- Follow the adapted workflow for your scenario
- Use scenario-specific best practices
- Iterate and improve based on your experience

---

## Related Resources

### Documentation
- [Template Catalog](template-catalog.md) - All available templates
- [Project Structure](../core-components/project-structure.md) - Simone directory organization
- [Command Reference](../core-components/command-reference.md) - Available commands

### Tools and Integration
- [Installation Guide](../getting-started/installation.md) - Setting up Simone
- [Quick Start](../getting-started/quick-start.md) - First project setup
- [Best Practices](../best-practices/) - Detailed best practices guides

---

**Document Status**: Active  
**Maintenance**: Update scenarios based on user feedback and new use cases  
**Contact**: Simone Framework Team for scenario-specific questions