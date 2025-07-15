# Quality Enforcement System

## Overview

Simone's Quality Enforcement System implements a comprehensive "garbage in, garbage out" prevention strategy that ensures all project inputs meet minimum quality standards. The system actively prevents lazy usage patterns and enforces thoughtful, detailed planning at every stage of the development process.

## Key Philosophy

**Garbage In, Garbage Out Prevention**: The system recognizes that poor-quality inputs lead to poor-quality outputs. By enforcing quality standards at all entry points, Simone ensures that projects maintain high standards throughout the development lifecycle.

## Features

### 🔍 Intelligent Input Validation

#### Lazy Pattern Detection
The system automatically detects and blocks common lazy patterns:
- **Placeholder text**: "TBD", "TODO", "fix this", "update this", "change this"
- **Vague language**: "as needed", "if needed", "might need", "probably should"  
- **Non-specific terms**: "stuff", "things", "etc", "and so on"

#### Minimum Word Count Requirements
- **Project descriptions**: 10+ meaningful words
- **Task titles**: 3+ meaningful words  
- **Task descriptions**: 10+ meaningful words
- **Acceptance criteria**: 15+ meaningful words

*Note: The system excludes common filler words (the, a, an, and, or, etc.) when counting meaningful words.*

### 📊 Quality Scoring System

Every input receives a quality score from 0-10 based on:

#### Word Count Scoring (0-4 points)
- **4 points**: 2x minimum word count or more
- **3 points**: 1.5x minimum word count
- **2 points**: Meets minimum word count
- **1 point**: 50% of minimum word count
- **0 points**: Below 50% of minimum

#### Specificity Scoring (0-3 points)
- **Action-oriented language**: "will", "shall", "must", "should" (+1 point)
- **Conditional logic**: "when", "if", "given", "then" (+1 point)
- **Domain-specific terms**: "user", "system", "application", "feature", "requirement" (+1 point)

#### Structure Scoring (0-3 points)
- **Organized format**: Bullet points, numbered lists (+1 point)
- **Shows thinking**: Contains questions (+1 point)
- **Sufficient detail**: More than 100 characters (+1 point)

#### Quality Thresholds
- **7+ points**: High quality, passes validation
- **5-6 points**: Warning issued, user can proceed with confirmation
- **<5 points**: Blocked, requires improvement

### 🚫 Progressive Restrictions

#### Quality History Tracking
The system maintains a log of all input quality scores in `.simone/.cache/quality-history.log`:
```
2024-01-15 10:30:15|task_creation|8|25
2024-01-15 11:15:22|project_init|6|18
```

#### Cooling-Off Periods
- **3+ low-quality inputs** (score <7): Warning displayed about quality patterns
- **5+ low-quality inputs**: Temporary block with 30-minute cooling-off period
- **Alternative**: Improve 3 existing items before creating new ones

#### Historical Analysis
- Tracks average quality scores over time
- Identifies improvement or degradation patterns
- Provides personalized recommendations

### 🔒 Quality Gates

#### Project Initialization
```bash
simone init
```
- Requires detailed project description (10+ meaningful words)
- Blocks initialization with lazy patterns or insufficient detail
- Creates quality-enabled project manifest

#### Task Creation
```bash
simone task create
```
- Validates project manifest quality first
- Requires specific task title, detailed description, and acceptance criteria
- Checks quality history for progressive restrictions

#### Sprint Management
```bash
simone sprint status
```
- Blocks if project manifest quality is insufficient
- Ensures proper planning foundation before sprint operations

#### Blitz Mode (Automated Execution)
```bash
simone blitz
```
- **Enhanced safety validation**:
  - Project manifest quality validation
  - Quality history review
  - Quality report generation
  - Requires typing "EXECUTE" to confirm
- Most restrictive quality gate due to automation risks

## Commands

### Quality Assessment
```bash
# Show comprehensive quality report
simone quality report

# Test the validation system
simone quality check

# Reset quality history (requires confirmation)
simone quality reset
```

### Quality Report Output
```
📊 Project Quality Assessment
==============================

✅ Project manifest: High quality

📊 Project Quality Report
=========================

Total submissions: 15
Average quality score: 7.8/10
High quality (8+): 10 (67%)
Low quality (<7): 2 (13%)

🎉 Excellent quality standards! Keep up the good work.
```

## Configuration

### Quality Thresholds
Located in `.simone/01_UTILS/quality-validation.sh`:

```bash
# Minimum word counts
readonly MIN_DESCRIPTION_WORDS=10
readonly MIN_TITLE_WORDS=3  
readonly MIN_ACCEPTANCE_CRITERIA_WORDS=15

# Quality score threshold (out of 10)
readonly QUALITY_SCORE_THRESHOLD=7
```

### Disabling Quality Enforcement
If the quality validation script is not present, the system operates in legacy mode without quality gates. **This is not recommended** for production use.

## Best Practices

### Writing High-Quality Descriptions
✅ **Good Example**:
```
Implement user authentication system with JWT tokens. The system must validate user credentials against the database, generate secure tokens with 24-hour expiration, and provide refresh token functionality. Users should be able to login, logout, and maintain sessions across browser restarts.
```

❌ **Poor Example**:
```
Add auth stuff to the app. Users need to login somehow.
```

### Writing Effective Acceptance Criteria
✅ **Good Example**:
```
Given a user with valid credentials, when they submit the login form, then they should receive a JWT token and be redirected to the dashboard. Given an invalid credential attempt, then an error message should display and the user should remain on the login page.
```

❌ **Poor Example**:
```
Login should work correctly.
```

### Handling Quality Warnings
When you receive a quality warning:
1. **Read the feedback carefully** - it identifies specific areas for improvement
2. **Add more specific details** about requirements and implementation
3. **Use structured formatting** like bullet points or numbered lists
4. **Include action-oriented language** with clear expectations
5. **Consider the "why"** behind the requirement, not just the "what"

### Recovering from Quality Blocks
If your input is blocked:
1. **Review the specific feedback** provided by the system
2. **Identify lazy patterns** that triggered the block
3. **Rewrite with specific, actionable language**
4. **Add concrete details** about requirements and success criteria
5. **Use the quality check command** to test improvements before resubmitting

## Benefits

### For Individual Developers
- **Better planning habits**: Forces thorough thinking before implementation
- **Reduced rework**: Clear requirements prevent scope creep and confusion
- **Improved documentation**: Creates comprehensive project records
- **Quality awareness**: Real-time feedback improves writing skills

### For Teams
- **Consistent standards**: All team members held to same quality bar
- **Better handoffs**: Detailed documentation enables smooth collaboration
- **Reduced context switching**: Clear requirements reduce back-and-forth communication
- **Historical learning**: Quality trends identify team improvement areas

### For Projects
- **Scope clarity**: Detailed planning prevents feature drift
- **Risk reduction**: Thorough requirements identify potential issues early
- **Better estimates**: Clear scope enables more accurate time planning
- **Quality deliverables**: High input quality leads to high output quality

## Troubleshooting

### Common Issues

#### "Lazy pattern detected"
**Cause**: Using placeholder text like "TBD", "TODO", or vague terms
**Solution**: Replace placeholders with specific, actionable descriptions

#### "Insufficient detail"
**Cause**: Not meeting minimum word count requirements
**Solution**: Add more specific details about requirements, implementation, and success criteria

#### "Low quality score"
**Cause**: Lack of structure, specificity, or action-oriented language
**Solution**: Use bullet points, include conditional logic ("when/then"), and specify concrete actions

#### "Cooling-off period activated"
**Cause**: Multiple recent low-quality inputs
**Solution**: Take time to improve existing project items, or wait 30 minutes before creating new ones

### Getting Help
- Use `simone quality check` to test inputs before submitting
- Review quality reports to understand patterns and improvement areas
- Study high-quality examples in the documentation
- Focus on the "why" behind requirements, not just the "what"

## Implementation Details

### File Locations
- **Quality validation system**: `.simone/01_UTILS/quality-validation.sh`
- **Quality history log**: `.simone/.cache/quality-history.log`
- **Project manifest**: `.simone/00_PROJECT_MANIFEST.md`

### Integration Points
The quality system is integrated into:
- Project initialization (`simone init`)
- Task creation (`simone task create`)
- Sprint management (`simone sprint`)
- Blitz mode automation (`simone blitz`)
- All major workflow entry points

### Logging Format
Quality history entries follow the format:
```
timestamp|action|quality_score|word_count
```

This enables analysis of quality trends over time and identification of improvement opportunities.

## Future Enhancements

### Planned Features
- **Domain-specific validation**: Tailored quality requirements for different project types
- **Team quality analytics**: Aggregate quality metrics across team members
- **Integration with external tools**: Quality gate integration with CI/CD pipelines
- **Machine learning improvements**: Adaptive thresholds based on project success patterns

### Contributing
Quality enforcement improvements should focus on:
- Reducing false positives while maintaining strict standards
- Providing more actionable feedback for improvement
- Integrating with additional workflow entry points
- Enhancing the user experience of quality validation

---

The Quality Enforcement System represents Simone's commitment to preventing lazy usage and ensuring that all project work maintains high standards from conception through completion.