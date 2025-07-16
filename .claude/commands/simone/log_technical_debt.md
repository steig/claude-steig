# Log Technical Debt Item

**COGNITIVE PERSONAS INTEGRATION:** This command supports domain expertise for accurate debt categorization and impact assessment.

**AVAILABLE PERSONAS** (reference: `.claude/commands/shared/persona-flags.yml`):
- `--persona-architect`: Architecture debt analysis and system design impact
- `--persona-security`: Security debt identification and risk assessment
- `--persona-frontend`: Frontend-specific debt categorization and UX impact
- `--persona-backend`: Backend performance and API design debt analysis
- `--persona-analyzer`: Code quality metrics and maintainability assessment
- `--persona-mentor`: Educational debt documentation and best practices
- `--persona-refactorer`: Code optimization opportunities and refactoring debt
- `--persona-performance`: Performance bottlenecks and optimization debt
- `--persona-qa`: Testing debt and quality assurance gaps

**ADVANCED FLAGS:**
- `--introspect`: Show transparent reasoning for debt categorization and impact assessment
- `--consensus`: Multi-model consensus for complex debt analysis
- `--think-deep`: Extended analysis for complex technical debt scenarios

**USAGE EXAMPLES:**
- `/project:simone:log_technical_debt --persona-security` (Security-focused debt analysis)
- `/project:simone:log_technical_debt --persona-architect --introspect` (Architecture debt with transparency)
- `/project:simone:log_technical_debt "duplicate validation" --persona-analyzer --persona-refactorer` (Code quality analysis)

Create structured technical debt documentation with comprehensive impact analysis and resolution planning.

## Create a TODO with EXACTLY these 7 items

1. Parse debt description and context
2. Analyze debt categorization and severity
3. Assess business and technical impact
4. Generate unique debt ID and file structure
5. Create comprehensive debt documentation
6. Update debt registry and cross-references
7. Integrate with project tracking systems

---

## 1 · Parse debt description and context

**MCP INTEGRATION:** Use MCP servers to enhance debt analysis:
- **Sequential Thinking**: Structure debt analysis systematically
- **Serena**: Enhance debt pattern recognition and categorization
- **GitHub**: Track similar debt patterns and resolution outcomes

**Argument Analysis:**
- Check `<$ARGUMENTS>` for debt description, category hints, or context
- If empty, prompt user for debt description and context
- Extract keywords for automatic categorization
- Identify source context (task ID, sprint, code review, etc.)

**Context Discovery:**
- Check current git branch for task/feature context
- Read current project manifest for milestone/sprint context
- Scan recent commits for related changes
- Identify affected components from git diff or user description

**PERSONA ACTIVATION:** Analyze debt description for automatic persona activation:

1. **Scan description** for domain-specific keywords:
   - **Security**: authentication, authorization, validation, encryption, sanitization
   - **Architecture**: coupling, abstraction, design pattern, scalability, structure
   - **Frontend**: component, UI, accessibility, performance, user experience
   - **Backend**: API, database, query, service, middleware, performance
   - **Performance**: optimization, bottleneck, caching, efficiency, resource usage

2. **Apply relevant personas automatically** or honor explicit persona flags from user
3. **If `--introspect` flag present**: Show 🤔 Thinking process for categorization
4. **If multiple personas activated**: Plan multi-domain debt analysis approach

## 2 · Analyze debt categorization and severity

**PERSONA-DRIVEN CATEGORIZATION:**

**🏗️ Architecture Persona (if activated):**
- **Design Violations**: Code breaking established architectural patterns
- **Tight Coupling**: Components with excessive interdependencies
- **Missing Abstractions**: Repeated patterns that should be generalized
- **Scalability Issues**: Designs that won't scale with growth

**🔒 Security Persona (if activated):**
- **Input Validation**: Missing or insufficient input sanitization
- **Authentication Gaps**: Weak authentication mechanisms
- **Authorization Flaws**: Inadequate permission controls
- **Data Exposure**: Sensitive data handling issues

**🎨 Frontend Persona (if activated):**
- **Component Debt**: Poor component structure or reusability
- **Accessibility Gaps**: Missing WCAG compliance features
- **Performance Issues**: Bundle size, rendering, or loading problems
- **UX Inconsistencies**: Design system violations or user experience issues

**⚙️ Backend Persona (if activated):**
- **API Design**: RESTful violations, inconsistent patterns
- **Database Issues**: Poor query performance, schema problems
- **Service Architecture**: Microservice boundaries, communication patterns
- **Performance Bottlenecks**: Resource usage, scalability concerns

**📊 Analyzer Persona (if activated):**
- **Code Quality**: Duplication, complexity, naming, structure
- **Maintainability**: Documentation, clarity, refactoring needs
- **Technical Metrics**: Cyclomatic complexity, code coverage gaps
- **Quality Gates**: Linting violations, standard deviations

**SEVERITY ASSESSMENT:**

**Critical (Immediate Action Required):**
- Security vulnerabilities with exploit potential
- Production blockers or system instability risks
- Data corruption or loss possibilities
- Compliance violations with legal implications

**High (Plan for Next Sprint):**
- Performance degradation affecting users
- Significant maintenance burden increase
- Risk accumulation in critical system areas
- Customer-facing functionality impacts

**Medium (Include in Milestone Planning):**
- Code maintainability degradation
- Future scalability concerns
- Development workflow friction
- Quality standard violations

**Low (Address During Refactoring):**
- Code clarity improvements
- Convention violations without functional impact
- Optimization opportunities without urgency
- Nice-to-have enhancements

## 3 · Assess business and technical impact

**INTROSPECTION MODE** (if `--introspect` flag present):
- Show 🤔 Thinking process for impact assessment
- Display 🎯 Decision rationale for severity classification
- Provide 🔍 Analysis of risk calculation methodology
- Conclude with ✅ Final impact summary

**Business Impact Analysis:**

1. **User Experience Impact:**
   - Direct effects on end-user functionality or performance
   - Customer satisfaction or retention implications
   - Support burden increase due to issues

2. **Development Velocity Impact:**
   - Time overhead for working around the debt
   - Cognitive load increase for team members
   - Feature development slowdown quantification

3. **Maintenance Cost Analysis:**
   - Additional time required for related changes
   - Testing complexity increase
   - Deployment and operational overhead

4. **Risk Assessment:**
   - Probability of debt-related failures or incidents
   - Business continuity implications
   - Competitive advantage erosion

**Technical Impact Analysis:**

1. **System Reliability:**
   - Stability risks and failure probabilities
   - Error rate increases or edge case handling
   - Monitoring and observability impacts

2. **Performance Characteristics:**
   - Response time degradation
   - Resource usage inefficiencies
   - Scalability limitations

3. **Code Quality Metrics:**
   - Maintainability index impact
   - Technical debt ratio increase
   - Testing coverage implications

4. **Architecture Integrity:**
   - Design pattern violations
   - Dependency management issues
   - System boundary violations

**Risk Score Calculation (1-25 scale):**
- **Likelihood** (1-5): Probability of negative impact occurring
- **Impact** (1-5): Severity of consequences if impact occurs
- **Risk Score**: Likelihood × Impact

## 4 · Generate unique debt ID and file structure

**Debt ID Generation:**

1. **Check Existing Debt Items:**
   - Scan `.simone/07_TECHNICAL_DEBT/ACTIVE/` for existing TD_### IDs
   - Scan `.simone/07_TECHNICAL_DEBT/RESOLVED/` for historical IDs
   - Find next available sequential number

2. **Generate ID Format:**
   - Format: `TD_###` (e.g., TD_001, TD_042, TD_123)
   - Zero-pad to 3 digits for proper sorting
   - Ensure uniqueness across active and resolved items

3. **Create File Structure:**
   - **Active Item**: `.simone/07_TECHNICAL_DEBT/ACTIVE/TD_###_brief_description.md`
   - **Brief Description**: 2-4 words describing the issue (snake_case)
   - **Example**: `TD_042_duplicate_validation_logic.md`

**Directory Validation:**
- Ensure `.simone/07_TECHNICAL_DEBT/` directory exists
- Create `ACTIVE/` and `RESOLVED/` subdirectories if missing
- Verify write permissions and file system access

## 5 · Create comprehensive debt documentation

**Use Technical Debt Template:**

1. **Load Template:**
   - Copy `.simone/99_TEMPLATES/technical_debt_template.md`
   - Prepare for placeholder replacement

2. **Populate YAML Frontmatter:**
   ```yaml
   debt_id: "TD_###"
   title: "{Descriptive Title}"
   category: "{code_quality|architecture|security|performance|documentation|testing}"
   severity: "{critical|high|medium|low}"
   created_date: "{YYYY-MM-DD}"
   discovered_by: "Claude"
   discovered_in: "{Context - task ID, code review, etc.}"
   status: "active"
   estimated_effort: "{Hours estimate}"
   business_impact: "{Brief business impact description}"
   technical_impact: "{Brief technical impact description}"
   affected_components: ["{Component1}", "{Component2}"]
   risk_score: "{1-25 calculated risk score}"
   ```

3. **Complete Content Sections:**

   **Problem Description:**
   - Detailed issue analysis with specific examples
   - Code snippets demonstrating the problem
   - Context of discovery and current workarounds

   **Impact Analysis:**
   - Development velocity impact quantification
   - Maintenance cost analysis
   - Business and technical risk assessment

   **Resolution Planning:**
   - Proposed solution approach with phases
   - Implementation tasks and effort estimates
   - Success criteria and validation methods

   **Alternative Solutions:**
   - Other approaches considered with trade-offs
   - Risk analysis for different resolution strategies
   - Recommendation rationale

## 6 · Update debt registry and cross-references

**Update Debt Registry:**

1. **Create or Update Registry:**
   - File: `.simone/07_TECHNICAL_DEBT/DEBT_REGISTRY.md`
   - Maintain master list of all debt items
   - Include metadata summary and cross-references

2. **Registry Entry Format:**
   ```markdown
   | ID | Title | Category | Severity | Created | Status | Effort | Components |
   |---|---|---|---|---|---|---|---|
   | TD_042 | Duplicate Validation Logic | code_quality | medium | 2025-01-10 | active | 4h | user-service, auth-service |
   ```

3. **Update Statistics:**
   - Total active debt count by category
   - Total estimated effort for resolution
   - Risk distribution and priority matrix

**Cross-Reference Integration:**

1. **Link to Source Context:**
   - Reference originating task, sprint, or review
   - Update source document with debt item reference
   - Maintain bidirectional traceability

2. **Component Mapping:**
   - Link to architecture documentation
   - Reference affected code modules or services
   - Update component-specific debt tracking

3. **Dependency Tracking:**
   - Link related debt items
   - Identify blocking relationships
   - Update dependency graphs

## 7 · Integrate with project tracking systems

**Project Manifest Integration:**

1. **Update Project Health Metrics:**
   - Increment technical debt counters in `.simone/00_PROJECT_MANIFEST.md`
   - Update risk assessment if severity is high or critical
   - Adjust project health indicators

2. **Sprint/Milestone Integration:**
   - If debt blocks current work, flag in sprint documentation
   - Consider adding resolution task to current or future sprint
   - Update milestone risk assessment

**Task Integration:**

1. **Resolution Task Creation (if needed):**
   - For critical/high severity debt, consider creating resolution task
   - Use task template with debt resolution focus
   - Link task to debt item in metadata

2. **Sprint Planning Integration:**
   - Add debt metrics to sprint planning considerations
   - Include debt resolution capacity in velocity planning
   - Balance feature work with debt resolution

**Reporting Integration:**

1. **Update Project Reviews:**
   - Include new debt item in next project review scope
   - Update technical debt health score
   - Inform stakeholder communication

2. **Team Communication:**
   - Generate summary for team notification
   - Include in code review or standup discussions
   - Update risk communication for critical items

---

**COMPLETION REPORT:**

```markdown
✅ **Technical Debt Item Logged**: TD_###

📋 **Details**:
- **Category**: {category}
- **Severity**: {severity}
- **Estimated Effort**: {effort}h
- **Risk Score**: {score}/25

🎯 **Impact**:
- **Business**: {business_impact_summary}
- **Technical**: {technical_impact_summary}

📁 **Files Created/Updated**:
- `.simone/07_TECHNICAL_DEBT/ACTIVE/TD_###_description.md`
- `.simone/07_TECHNICAL_DEBT/DEBT_REGISTRY.md`
- `.simone/00_PROJECT_MANIFEST.md` (health metrics)

⏭️ **Next Steps**:
- Review with team during next sprint planning
- Consider resolution task creation for high/critical severity
- Include in next project review assessment
- Monitor for related debt accumulation

🔍 **Integration**:
- Linked to: {source_context}
- Components: {affected_components}
- Related Items: {related_debt_items}
```

**Benefits of This Approach:**
- 🎯 **Comprehensive**: Captures full context and impact analysis
- 📊 **Quantified**: Risk scoring and effort estimation for prioritization  
- 🔗 **Integrated**: Seamless integration with existing project workflows
- 📝 **Documented**: Rich documentation for future resolution planning
- 🎭 **Persona-Enhanced**: Domain expertise for accurate categorization