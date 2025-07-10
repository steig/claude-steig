# Quick Start Guide

**Time Required**: 15 minutes  
**Prerequisites**: Claude Code installed and configured

## Overview

This guide will get you started with Simone in 15 minutes. You'll set up a project, create your first milestone, and execute your first task using the framework.

## Step 1: Install Simone (2 minutes)

### Quick Installation
```bash
curl -sSL https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh | bash
```

### Or Manual Installation
```bash
# Download installer
wget https://raw.githubusercontent.com/steig/claude-steig/main/install-simone.sh
chmod +x install-simone.sh

# Run installer
./install-simone.sh
```

The installer will:
- ✅ Create the `.simone/` directory structure
- ✅ Install all templates in `99_TEMPLATES/`
- ✅ Set up Claude Code commands in `.claude/commands/simone/`
- ✅ Create initial project manifest

## Step 2: Initialize Your Project (3 minutes)

Open Claude Code in your project directory and run:

```
/project:simone:initialize
```

This interactive command will:
1. **Analyze your project** - Detects tech stack, existing documentation
2. **Install MCP servers** - Adds 5 powerful MCP servers for enhanced capabilities
3. **Create project documentation** - PRD, architecture docs, or use existing ones
4. **Set up first milestone** - Creates M01 folder with initial requirements
5. **Update project manifest** - Central reference file for your project

**Example interaction:**
```
🚀 Simone Framework Initialization
================================

Project detected: my-awesome-app (Node.js/React)
Tech stack: JavaScript, React, Node.js, PostgreSQL

Would you like me to:
1. Create a new PRD from scratch
2. Use existing documentation
3. Help analyze existing codebase

Choose option: 1

Let's create your Product Requirements Document...
```

## Step 3: Create Additional Milestones (Optional - 2 minutes)

**NEW**: Use AI-powered milestone generation for faster planning:

```
/project:simone:create_milestone "Build user authentication system with JWT tokens, social login, and MFA support"
```

This AI command will:
- 🤖 **Analyze your prompt** and extract features, requirements, and constraints
- 📝 **Generate comprehensive milestone** with business objectives, success criteria, and risk assessment
- 🎯 **Create sprint breakdown** with timeline estimation and dependency mapping
- 📊 **Populate all metadata** automatically (30+ YAML fields)
- 🔗 **Integrate with project** by updating manifest and creating proper directory structure

**Example AI generation:**
```
🤖 Analyzing prompt: "Build user authentication system..."

✅ Generated M02_User_Authentication:
   📊 Business Value: High (enables user acquisition)
   ⏱️  Estimated Effort: 6-8 weeks (3 sprints)
   🎯 Key Features: JWT auth, social login, MFA, audit logging
   ⚠️  Risks: Security compliance, third-party integration
   📋 Sprints: Foundation → Social Integration → Advanced Security

Milestone created at: .simone/02_REQUIREMENTS/M02_User_Authentication/
```

## Step 4: Create Your First Sprint (2 minutes)

After initialization (or milestone creation), break down your milestone into sprints:

```
/project:simone:create_sprints_from_milestone
```

This command will:
- 📋 Analyze your milestone requirements
- 🎯 Create logical sprint boundaries (e.g., S01_M01_Backend_Setup, S02_M01_Frontend_Setup)
- ⚡ Estimate timeline and capacity
- 🔗 Set up dependencies between sprints

**Example output:**
```
Created 3 sprints for M01_Basic_Application:
✅ S01_M01_Backend_Setup (Week 1-2)
✅ S02_M01_Frontend_Setup (Week 3-4)  
✅ S03_M01_Integration_Testing (Week 5)
```

## Step 5: Generate Detailed Tasks (3 minutes)

Create implementation-ready tasks for your current sprint:

```
/project:simone:create_sprint_tasks
```

This advanced command will:
1. **Load context** using multiple parallel agents
2. **Research your codebase** to understand existing patterns
3. **Create detailed tasks** with acceptance criteria and implementation guidance
4. **Ensure proper scoping** - automatically splits complex tasks
5. **Generate quality checklists** and testing requirements

**Example tasks created:**
```
✅ task-01-s01: Set up Express.js server with middleware
✅ task-02-s01: Configure PostgreSQL database with Prisma ORM
✅ task-03-s01: Implement user authentication with JWT
✅ task-04-s01: Create RESTful API endpoints for user management
✅ task-05-s01: Add comprehensive error handling and logging
```

## Step 6: Execute Your First Task (5 minutes)

Let Simone execute a task with the new guided approval workflow:

```
/project:simone:do_task task-01-s01
```

Experience the enhanced workflow:
1. **Load rich context** - Project requirements, architecture decisions, existing code patterns
2. **Validate scope** - Ensures task is ready for execution
3. **Create git branch** - Automatic branch creation with proper naming
4. **Implement with quality** - Code generation following your project's patterns
5. **Quality review** - Pre-commit assessment and validation
6. **Run integrated code review** - Quality checks and architectural compliance
7. **NEW: Commit approval gate** - Review changes and approve commit with preview
8. **NEW: Auto-commit** - Automatic commit execution with task reference
9. **NEW: PR approval gate** - Review PR details and approve creation
10. **NEW: Auto-PR creation** - Automatic PR with documentation and team assignment
11. **NEW: Status sync** - Task status updated to "review" with full traceability

**Approval Gate Benefits**:
- 🛡️ **User Control**: Review and approve each step
- 🔍 **Quality Assurance**: Validate changes before integration
- 🔄 **Complete Workflow**: End-to-end task completion with Git integration
- ⚡ **Team Ready**: PRs created with proper reviewers and documentation

**Example execution:**
```
🎯 Executing task-01-s01: Set up Express.js server with middleware

📋 Loading context...
   ✅ Project manifest loaded
   ✅ Architecture decisions reviewed  
   ✅ Existing code patterns analyzed
   ✅ Sprint requirements understood

🔄 Creating branch: task/t01-s01-express-setup

🛠️  Implementing...
   ✅ Express server created with TypeScript
   ✅ Middleware stack configured (cors, helmet, morgan)
   ✅ Environment configuration added
   ✅ Health check endpoint implemented
   ✅ Error handling middleware added

🔍 Code review passed:
   ✅ Architecture compliance verified
   ✅ Security best practices followed
   ✅ Test coverage adequate (85%)
   ✅ Documentation complete

✅ Task completed successfully!
```

## What You Just Accomplished

In 15 minutes, you've:

✅ **Set up enterprise-grade project structure** with comprehensive metadata  
✅ **Created strategic milestone planning** with clear business objectives  
✅ **Generated implementation-ready tasks** with detailed acceptance criteria  
✅ **Executed high-quality development** with automated code review  
✅ **Established complete traceability** from requirements to implementation  

## Step 7: Experience Domain Expertise with Cognitive Personas (3 minutes)

Simone includes **9 specialized AI personas** that provide domain-specific expertise to enhance your development workflow. These personas automatically analyze your work and provide specialized guidance. This innovative system builds upon concepts pioneered by **SuperClaude**, bringing advanced cognitive AI patterns to enterprise development workflows:

### Basic Persona Usage

Try executing a task with security expertise:

```
/project:simone:do_task task-03-s01 --persona-security
```

**What happens**:
- 🔒 **Security analysis** automatically applied during implementation
- 🛡️ **OWASP compliance** validation built into code generation
- 🔍 **Vulnerability assessment** performed on authentication logic
- ✅ **Security best practices** enforced throughout development

### Multi-Domain Analysis

For comprehensive analysis, combine multiple personas:

```
/project:simone:do_task task-03-s01 --persona-security --persona-backend --introspect
```

**Enhanced capabilities**:
- 🔒 **Security Persona**: OWASP compliance, vulnerability analysis
- ⚙️ **Backend Persona**: API design optimization, database security
- 🤔 **Introspection Mode**: Shows AI reasoning and decision-making process

### Available Personas

| Persona | Domain | Best For |
|---------|--------|----------|
| 🏗️ `--persona-architect` | System design | Architecture decisions, scalability |
| 🔒 `--persona-security` | Security analysis | Auth, API security, data protection |
| 🎨 `--persona-frontend` | UI/UX optimization | React components, accessibility |
| ⚙️ `--persona-backend` | API & database | Express APIs, database design |
| 📊 `--persona-analyzer` | Code quality | Code metrics, technical debt |
| 🎓 `--persona-mentor` | Best practices | Learning, team guidance |
| ⚡ `--persona-performance` | Optimization | Performance bottlenecks |
| ✅ `--persona-qa` | Testing strategy | Test coverage, quality gates |

### Smart Auto-Activation

Personas automatically activate based on task content:

```
# Creating authentication → Security persona auto-activates
/project:simone:do_task task-03-s01

# Database optimization → Backend + Performance personas activate
/project:simone:do_task task-db-optimization

# UI components → Frontend persona activates
/project:simone:do_task task-dashboard-ui
```

**Advanced Features** (explore after completing your first sprint):
- `--consensus`: Multi-model analysis for critical decisions
- `--think-deep`: Extended reasoning for complex problems
- `--uc`: Token optimization for large projects

> 📖 **Learn More**: [Complete Cognitive Personas Guide](../advanced/cognitive-personas.md)

## Next Steps

### Immediate Actions (Next 30 minutes)
1. **Review your task** - Check the generated code and documentation
2. **Run tests** - Use `/project:simone:test` to validate implementation
3. **Continue development** - Execute more tasks with `/project:simone:do_task`

### Short Term (Next few days)
1. **Complete Sprint 1** - Execute remaining tasks in S01_M01
2. **Conduct sprint review** - Use `/project:simone:project_review` for health check
3. **Plan Sprint 2** - Create tasks for your next sprint when ready

### Advanced Features to Explore
1. **YOLO Mode** - `/project:simone:yolo` for autonomous sprint execution
2. **Quality Reviews** - Built-in code review and architectural compliance
3. **Release Management** - End-to-end delivery with semantic versioning
4. **Team Collaboration** - Multi-developer workflows and governance

## Key Commands Reference

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/project:simone:initialize` | Project setup | Once per project |
| `/project:simone:create_milestone "<description>"` | AI milestone generation | When planning new features |
| `/project:simone:create_sprints_from_milestone` | Sprint planning | After milestone creation |
| `/project:simone:create_sprint_tasks` | Task generation | Start of each sprint |
| `/project:simone:do_task [ID]` | Task execution | Daily development work |
| `/project:simone:prime` | Context refresh | Start of each session |
| `/project:simone:status` | Project overview | Progress check-ins |
| `/project:simone:project_review` | Health assessment | End of sprint/milestone |

## Troubleshooting

**Command not found**: Ensure install-simone.sh completed successfully and `.claude/commands/simone/` exists

**No tasks created**: Check that your milestone has clear requirements in `02_REQUIREMENTS/M01_*/M01_PRD.md`

**Task execution fails**: Run `/project:simone:prime` to refresh context and try again

**Need help**: Check the [Troubleshooting Guide](../administration/troubleshooting.md) or review your project manifest

## Success Indicators

You know Simone is working well when:
- ✅ Tasks are scoped to 2-4 hours of work
- ✅ Code follows your project's existing patterns
- ✅ Documentation stays up-to-date automatically  
- ✅ Quality gates catch issues before review
- ✅ Progress is visible to all stakeholders

---

**🎉 Congratulations!** You've successfully set up Simone and executed your first AI-assisted enterprise development workflow. You're now ready to build amazing software with structured, quality-first development practices.

**Next**: Read the [Framework Overview](./framework-overview.md) to understand the deeper concepts, or jump into [Task Management](../core-components/task-management.md) to learn about advanced task features.