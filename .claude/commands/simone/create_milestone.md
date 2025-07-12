# Create AI-Powered Milestone - Execute top to bottom

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise enhancement for intelligent milestone creation.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: System design and technical architecture planning
- `--persona-security`: Security requirements and compliance planning
- `--persona-frontend`: User experience and interface planning
- `--persona-backend`: API design and backend architecture planning
- `--persona-analyzer`: Scope analysis and complexity assessment
- `--persona-mentor`: Best practices and team guidance integration
- `--persona-performance`: Performance requirements and optimization planning
- `--persona-qa`: Quality assurance and testing strategy planning

**ADVANCED FLAGS:**
- `--introspect`: Show transparent AI reasoning for milestone planning decisions
- `--consensus`: Multi-model consensus for critical milestone architecture decisions
- `--think-deep`: Extended analysis for complex milestones with assumption challenging

**USAGE EXAMPLES:**
- `/project:simone:create_milestone "Auth system" --persona-security --persona-architect` (Security-focused auth planning)
- `/project:simone:create_milestone "Payment gateway" --persona-security --persona-backend --consensus` (Comprehensive payment system)
- `/project:simone:create_milestone "Dashboard UI" --persona-frontend --persona-performance --introspect` (UX-focused with transparency)

Generate a comprehensive milestone from natural language description using AI-powered template population and intelligent scope analysis.

## Create a TODO with EXACTLY these 10 Items

1. Parse milestone prompt and validate requirements
2. Analyze project context and existing milestones
3. Generate milestone metadata using AI analysis
4. Create milestone scope and feature breakdown
5. Generate sprint planning and timeline
6. Assess risks and dependencies automatically
7. Create milestone directory structure
8. Populate milestone meta file with generated content
9. Update project manifest with new milestone
10. Validate and review generated milestone

Follow step by step and adhere closely to the following instructions for each step.

## DETAILS on every TODO item

### 1. Parse milestone prompt and validate requirements

Check: <$ARGUMENTS>

**REQUIRED:** Natural language milestone description must be provided. If empty, ask user to describe what milestone they want to create.

**Prompt Examples:**
- "Implement user authentication system with JWT tokens, MFA support, and social login integration"
- "Build product catalog with search, filtering, and recommendations" 
- "Create admin dashboard for user management and analytics"

**Parse for key elements:**
- Core features and functionality
- Technical requirements and constraints
- Business objectives and success criteria
- Integration points and dependencies
- Timeline hints or priority indicators

**Validation:**
- Ensure prompt is descriptive enough (minimum 10 words)
- Check that milestone doesn't duplicate existing milestones
- Verify scope is appropriate for a milestone (not too small/large)

### 2. Analyze project context and existing milestones

**MCP INTEGRATION:** Use MCP servers to enhance context understanding:
- **Sequential Thinking**: Structure the project analysis systematically
- **Context7**: Maintain comprehensive context about project state
- **Serena**: Enhance project documentation analysis

**Use PARALLEL SUBAGENTS** to gather project intelligence:

**Project Context Analysis:**
- READ `.simone/00_PROJECT_MANIFEST.md` for current project status
- READ existing milestones in `.simone/02_REQUIREMENTS/` to understand patterns
- READ `.simone/01_PROJECT_DOCS/ARCHITECTURE.md` for technical context
- READ `.simone/01_PROJECT_DOCS/LONG_TERM_VISION.md` for strategic alignment

**Milestone Pattern Analysis:**
- Identify naming conventions from existing milestones
- Analyze typical milestone duration and complexity
- Review team capacity and velocity patterns
- Check for common risk patterns and mitigation strategies

**Dependency Detection:**
- Identify which existing milestones this new one might depend on
- Check for potential conflicts with planned milestones
- Analyze technology stack alignment and integration points

### 3. Generate milestone metadata using AI analysis

**PERSONA-DRIVEN METADATA GENERATION:** Apply domain expertise to enhance milestone planning:

**🏗️ Architecture Persona Analysis (if activated):**
- **Technical Complexity**: Assess system integration complexity, design pattern requirements
- **Architecture Impact**: Evaluate impact on existing system architecture and dependencies
- **Scalability Planning**: Identify performance requirements and scaling considerations
- **Integration Points**: Map service boundaries, API contracts, data flow requirements

**🔒 Security Persona Analysis (if activated):**
- **Security Requirements**: Identify OWASP compliance needs, security standards
- **Risk Assessment**: Security vulnerability analysis, threat modeling requirements
- **Compliance Planning**: Data protection, privacy regulations, audit requirements
- **Security Dependencies**: Authentication, authorization, encryption dependencies

**🎨 Frontend Persona Analysis (if activated):**
- **UX Requirements**: User experience goals, accessibility compliance needs
- **Interface Complexity**: Component design requirements, responsive design scope
- **Performance Goals**: Loading time targets, bundle size optimization requirements
- **Browser Support**: Cross-browser compatibility requirements and testing scope

**⚙️ Backend Persona Analysis (if activated):**
- **API Design**: RESTful service requirements, endpoint specifications
- **Data Management**: Database design requirements, migration planning
- **Performance Targets**: Response time goals, throughput requirements
- **Infrastructure**: Server capacity, deployment, monitoring requirements

**📊 Analyzer Persona Analysis (if activated):**
- **Scope Analysis**: Feature breakdown complexity, effort estimation refinement
- **Quality Metrics**: Testing coverage requirements, quality gate definitions
- **Technical Debt**: Legacy system integration challenges, refactoring needs
- **Success Metrics**: KPI definitions, measurement framework planning

**✅ QA Persona Analysis (if activated):**
- **Testing Strategy**: Test automation requirements, coverage targets
- **Quality Assurance**: Bug prevention strategies, validation frameworks
- **Acceptance Criteria**: Testable requirement definitions, verification plans
- **Quality Gates**: Review processes, approval workflows, compliance checks

**INTROSPECTION MODE** (if `--introspect` flag present):
- Show 🤔 Thinking process for each metadata field generation
- Display 🎯 Decision rationale for effort estimates and complexity assessments
- Provide 🔍 Analysis of risk assessment and dependency identification
- Conclude with ✅ Summary of persona-specific planning insights

**AI-Powered Field Population:**

**Core Identification:**
```yaml
milestone_id: # Auto-generate based on sequence (M03, M04, etc.)
milestone_name: # Extract from prompt and refine for clarity
milestone_version: "1.0.0" # Standard initial version
status: "planning" # New milestones start in planning
```

**Business Analysis from Prompt:**
```yaml
priority: # Infer from prompt context (low/medium/high/critical)
business_value: # Analyze business impact from description
estimated_effort: # Calculate person-weeks based on scope analysis
target_date: # Estimate based on effort and team capacity
```

**Technical Analysis:**
```yaml
technical_complexity: # Assess complexity from feature description
architecture_impact: # Determine impact level (none/minor/moderate/major)
risk_level: # Analyze potential risks from scope and technology
dependencies: # Auto-detect from project context and requirements
```

**Team and Resource Planning:**
```yaml
team_size: # Recommend based on scope and project patterns
stakeholders: # Suggest based on feature area and project structure
milestone_lead: # Recommend based on technical area expertise
```

### 4. Create milestone scope and feature breakdown

**Intelligent Scope Analysis:**

**Feature Categorization:**
- **Must Have (Core Features)**: Essential functionality that defines milestone success
- **Should Have (Important Features)**: Valuable features that enhance the core
- **Could Have (Nice-to-Have)**: Features that add value but aren't critical
- **Won't Have (Excluded)**: Features explicitly out of scope

**AI-Powered Feature Analysis:**
- Parse natural language prompt to identify distinct features
- Categorize features by business value and technical complexity  
- Estimate effort for each feature using domain knowledge
- Generate acceptance criteria for core features
- Identify integration points and API requirements

**Domain-Specific Intelligence:**
- **Authentication Systems**: Include security, compliance, audit logging
- **E-commerce Features**: Include payment integration, inventory considerations
- **API Development**: Include versioning, documentation, rate limiting
- **Data Processing**: Include performance, scalability, monitoring

**Business Context Generation:**
- Generate business rationale from prompt context
- Create market context based on feature type
- Define user impact and competitive advantages
- Establish success metrics and KPIs

### 5. Generate sprint planning and timeline

**AI-Powered Sprint Breakdown:**

**Sprint Planning Logic:**
- Analyze feature dependencies to determine optimal sprint sequence
- Estimate sprint duration based on team capacity and complexity
- Balance sprint workload for consistent team velocity
- Identify critical path items and potential bottlenecks

**Sprint Structure Generation:**
```yaml
sprint_breakdown:
  total_sprints: # Calculate based on effort and team capacity
  sprint_duration: # Standard 2-week sprints or adjust based on project
  sprint_1:
    name: # Generate descriptive name based on core features
    focus: # Primary objective and deliverables
    key_deliverables: # Main outputs and milestones
    success_criteria: # Measurable completion criteria
```

**Timeline Calculation:**
- Factor in team availability and project calendar
- Include buffer time for unknowns and testing (15-20%)
- Consider integration time with other milestones
- Account for review cycles and stakeholder feedback

**Dependency Mapping:**
- Map inter-sprint dependencies within milestone
- Identify external dependencies on other milestones
- Flag potential resource conflicts or bottlenecks
- Generate dependency resolution strategies

### 6. Assess risks and dependencies automatically

**AI-Powered Risk Assessment:**

**Risk Categories Analysis:**
- **Technical Risks**: Complexity, unknown technologies, integration challenges
- **Business Risks**: Changing requirements, market pressures, stakeholder alignment
- **Resource Risks**: Team availability, skill gaps, external dependencies
- **Timeline Risks**: Aggressive deadlines, dependency delays, scope creep

**Domain-Specific Risk Patterns:**
- **Authentication**: Security vulnerabilities, compliance requirements, user adoption
- **Payment Systems**: PCI compliance, fraud prevention, integration complexity
- **Data Migration**: Data integrity, performance impact, rollback procedures
- **Third-party APIs**: Rate limits, service availability, breaking changes

**Risk Mitigation Strategies:**
- Generate specific mitigation approaches for identified risks
- Create contingency plans for high-impact risks
- Suggest early prototyping for technical uncertainties
- Recommend stakeholder alignment activities for business risks

**Dependency Analysis:**
- Auto-detect technical dependencies from architecture context
- Identify business process dependencies from project context
- Map external vendor or service dependencies
- Generate dependency management and monitoring strategies

### 7. Create milestone directory structure

**Directory Creation:**
```bash
# Create milestone directory with proper naming
mkdir -p ".simone/02_REQUIREMENTS/${MILESTONE_ID}_${MILESTONE_NAME}/"
```

**Standard Milestone Structure:**
```
02_REQUIREMENTS/M##_Milestone_Name/
├── M##_milestone_meta.md        # Main milestone file (created in step 8)
├── PRD_${Feature_Name}.md       # Product Requirements Document (optional)
├── SPECS_${Component}.md        # Technical Specifications (optional)
└── README.md                    # Milestone overview and navigation
```

**Template Preparation:**
- Copy milestone template from `.simone/99_TEMPLATES/milestone_meta_template.md`
- Prepare placeholder replacement mapping
- Validate template structure and required fields

**Quality Validation:**
- Verify directory naming follows Simone conventions
- Check for existing milestone conflicts
- Ensure proper permissions and accessibility

### 8. Populate milestone meta file with generated content

**Template Population Process:**

**Systematic Field Replacement:**
- Replace all `{PLACEHOLDER}` fields with AI-generated content
- Ensure YAML frontmatter is properly formatted
- Validate all required fields are populated
- Apply project-specific formatting and style

**Content Quality Assurance:**
- Ensure all sections have meaningful, specific content
- Verify business and technical coherence
- Check that success criteria are measurable
- Validate that timeline and effort estimates are realistic

**AI-Generated Content Examples:**
```yaml
# Executive Summary - AI Generated
milestone_vision: "Establish a robust user authentication foundation that enables secure access, supports enterprise integration, and provides the groundwork for advanced user management features throughout the platform."

# Business Objectives - AI Generated  
business_objectives:
  - "Increase user acquisition by 40% through streamlined registration process"
  - "Enable enterprise customer acquisition through SSO integration capabilities"
  - "Achieve SOC 2 compliance requirements for authentication and access control"
```

**Markdown Content Generation:**
- Generate comprehensive milestone overview and context
- Create detailed scope definitions with clear boundaries
- Populate technical architecture and integration sections
- Generate risk management and mitigation strategies

### 9. Update project manifest with new milestone

**Project Manifest Integration:**

**Milestone Registration:**
```yaml
# Add to current_milestones section
current_milestones:
  - M01_Foundation_Setup: "completed"
  - M02_User_Management: "active"
  - M03_${MILESTONE_NAME}: "planning"  # ← New milestone added
```

**Project Metadata Updates:**
- Update completion percentage calculation
- Adjust timeline projections based on new milestone
- Update team allocation and resource planning
- Refresh project health metrics

**Cross-Reference Validation:**
- Ensure milestone ID is unique and sequential
- Verify integration with existing project timeline
- Check alignment with project vision and goals
- Validate resource allocation feasibility

**Stakeholder Communication Preparation:**
- Generate milestone announcement content
- Prepare stakeholder briefing materials
- Create milestone kickoff checklist
- Schedule milestone planning meetings

### 10. Validate and review generated milestone

**Comprehensive Quality Review:**

**Content Validation:**
- **Completeness**: All template sections populated with meaningful content
- **Consistency**: Alignment with project goals and existing milestones
- **Clarity**: Clear, actionable content that teams can execute
- **Realism**: Feasible timelines, effort estimates, and success criteria

**Technical Validation:**
- **Architecture Alignment**: Integration with existing system architecture
- **Dependency Accuracy**: Correct identification of prerequisite work
- **Risk Assessment**: Comprehensive and realistic risk identification
- **Resource Planning**: Appropriate team size and skill requirements

**Business Validation:**
- **Value Proposition**: Clear business value and impact
- **Success Metrics**: Measurable and achievable KPIs
- **Stakeholder Alignment**: Appropriate stakeholder identification
- **Market Relevance**: Alignment with business objectives

**AI Quality Assurance:**
- Review AI-generated content for accuracy and relevance
- Verify that domain-specific knowledge was applied correctly
- Check that milestone complexity matches the original prompt
- Ensure generated timeline and effort estimates are reasonable

**Interactive Review Process:**
```bash
# Present milestone summary to user
echo "Generated Milestone: ${MILESTONE_NAME}"
echo "Estimated Duration: ${ESTIMATED_EFFORT} weeks"
echo "Team Size: ${TEAM_SIZE} people"
echo "Key Features: ${CORE_FEATURES}"
echo ""
echo "Would you like to:"
echo "1. Accept milestone as generated"
echo "2. Refine specific sections"
echo "3. Regenerate with additional context"
echo "4. Start over with different prompt"
```

**Final Validation Checklist:**
- [ ] Milestone directory created with proper naming
- [ ] Milestone meta file contains comprehensive, AI-generated content
- [ ] Project manifest updated with new milestone
- [ ] All YAML frontmatter properly formatted
- [ ] Sprint breakdown is logical and achievable
- [ ] Risk assessment is thorough and actionable
- [ ] Success criteria are specific and measurable
- [ ] Dependencies are accurately identified
- [ ] Timeline estimates are realistic and achievable

---

## Command Usage Examples

### Basic Usage
```bash
/project:simone:create_milestone "Implement user authentication system with JWT tokens, MFA support, and social login integration"
```

### Advanced Usage with Context
```bash
/project:simone:create_milestone "Build comprehensive product catalog with advanced search, real-time inventory tracking, recommendation engine, and admin management tools for e-commerce platform"
```

### Domain-Specific Examples
```bash
# API Development
/project:simone:create_milestone "Create RESTful API v2 with GraphQL support, rate limiting, comprehensive documentation, and developer portal"

# Data Processing
/project:simone:create_milestone "Implement real-time analytics pipeline with data ingestion, processing, visualization dashboard, and automated reporting"

# DevOps Infrastructure
/project:simone:create_milestone "Establish CI/CD pipeline with automated testing, security scanning, deployment automation, and monitoring integration"
```

## Integration with Existing Commands

After milestone creation, consider these follow-up commands:

```bash
# Generate sprint structure
/project:simone:create_sprints_from_milestone M##_Milestone_Name

# Create initial tasks
/project:simone:create_sprint_tasks S01_M##

# Review and refine
/project:simone:project_review --milestone M##
```

---

**Command Version**: 1.0.0  
**Framework Version**: Simone 2.1.0  
**AI Features**: Advanced prompt analysis, domain-specific intelligence, automated sprint planning