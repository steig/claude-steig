# State of Project Directory

This directory contains timestamped snapshots of project health and progress, created by the `project_review` command.

## Purpose

- **Historical Tracking**: Maintain a record of project evolution over time
- **Health Monitoring**: Track technical debt, architecture decisions, and project health
- **Progress Documentation**: Record milestone achievements and sprint completions
- **Decision Context**: Provide context for future architectural and project decisions

## File Naming Convention

```
YYYY-MM-DD_HH-MM_Project_Review.md
```

**Examples:**
- `2024-01-15_14-30_Project_Review.md`
- `2024-02-01_09-15_Project_Review.md`
- `2024-02-15_16-45_Project_Review.md`

## Content Structure

Each project review file should contain:

1. **Executive Summary**
   - Overall project health status
   - Key achievements since last review
   - Critical issues requiring attention

2. **Technical Assessment**
   - Architecture alignment and evolution
   - Code quality metrics and trends
   - Technical debt assessment
   - Performance and scalability status

3. **Progress Analysis**
   - Milestone completion status
   - Sprint velocity and effectiveness
   - Task completion patterns
   - Bottlenecks and blockers

4. **Quality Metrics**
   - Test coverage and quality
   - Documentation completeness
   - Code review effectiveness
   - Bug trends and resolution

5. **Recommendations**
   - Immediate actions required
   - Process improvements needed
   - Architectural adjustments
   - Resource allocation suggestions

6. **Future Outlook**
   - Upcoming milestones and challenges
   - Predicted bottlenecks
   - Capacity planning considerations
   - Strategic recommendations

## Usage by Commands

### project_review.md
- Primary creator of project review files
- Uses template from `99_TEMPLATES/project_review_template.md`
- Automatically generates comprehensive project assessments

### initialize.md
- References previous project reviews when setting up existing projects
- Uses historical context to inform initialization decisions

### create_sprints_from_milestone.md
- Reviews recent project state to inform sprint planning
- Identifies capacity and velocity patterns

### yolo.md
- Checks recent project reviews to understand current project health
- Uses context to make autonomous decisions about task prioritization

## Best Practices

### Review Frequency
- **Weekly**: During active development phases
- **Bi-weekly**: During stable development periods
- **Monthly**: During maintenance phases
- **Ad-hoc**: After major milestones or critical incidents

### Review Quality
- **Objective Metrics**: Include quantifiable data where possible
- **Honest Assessment**: Document real issues and challenges
- **Actionable Insights**: Provide clear, implementable recommendations
- **Historical Context**: Reference previous reviews and trends

### Team Usage
- **Stakeholder Updates**: Use reviews for progress reporting
- **Team Retrospectives**: Reference during sprint retrospectives
- **Architectural Planning**: Inform major technical decisions
- **Process Improvement**: Identify and address workflow issues

## Integration with MCP Servers

### GitHub
- Track project review creation and outcomes via repository history
- Maintain history of review recommendations and their implementation through issues and PRs

### Sequential Thinking
- Structure comprehensive project analysis systematically
- Ensure consistent review methodology across time

### Context7
- Maintain context about project evolution and health trends
- Preserve insights about project patterns and decision outcomes

### Serena
- Enhance technical analysis and code quality assessment
- Provide deeper insights into architecture and implementation quality

## Example Review Triggers

### Scheduled Reviews
- End of sprint or milestone
- Monthly project health checks
- Quarterly strategic reviews
- Annual architecture assessments

### Event-Driven Reviews
- After major feature releases
- Following critical incidents or outages
- When technical debt reaches concerning levels
- Before major architectural changes

### Quality-Driven Reviews
- When test coverage drops below thresholds
- After significant performance regressions
- When bug rates exceed acceptable levels
- During team scaling or restructuring

## Archive Management

### Retention Policy
- **Active Reviews**: Last 6 months readily accessible
- **Historical Reviews**: Older reviews archived but retrievable
- **Critical Reviews**: Milestone and incident reviews permanently retained

### Organization
- Reviews organized chronologically
- Critical reviews tagged for easy retrieval
- Trends and patterns documented in summary reports

---

**Note**: This directory is automatically managed by Simone commands. Manual file creation should follow the established templates and naming conventions for consistency.