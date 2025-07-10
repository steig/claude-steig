# Interactive Tutorial: Your First Simone Project

---
title: "Interactive First Project Tutorial"
type: "tutorial"
category: "getting_started"
difficulty: "beginner"
duration: "30 minutes"
audience: ["new_users", "project_managers", "developers"]
created_date: "2025-07-10"
updated_date: "2025-07-10"
version: "1.0.0"
prerequisites: ["basic_command_line", "text_editor"]
learning_outcomes: ["project_setup", "milestone_creation", "task_management"]
tags: ["tutorial", "interactive", "beginner", "hands-on"]
related_docs: ["../getting-started/quick-start.md", "../core-components/project-structure.md"]
---

## Welcome to Your First Simone Project! 🚀

This interactive tutorial will guide you through creating your first Simone project from scratch. You'll learn the core concepts by actually building a real project structure.

**What You'll Build**: A simple "Personal Blog" project with milestones, sprints, and tasks  
**Time Required**: ~30 minutes  
**Skills Learned**: Project setup, milestone planning, task creation, and basic workflows

---

## 📋 Prerequisites Checklist

Before we start, make sure you have:
- [ ] Simone Framework installed ([Installation Guide](../getting-started/installation.md))
- [ ] Basic command line knowledge
- [ ] A text editor (VS Code, Sublime, etc.)
- [ ] 30 minutes of focused time

**Quick Check**: Run this command to verify Simone is working:
```bash
ls .claude/commands/simone/
```
You should see a list of available Simone commands.

---

## 🎯 Step 1: Create Your Project Directory

Let's start by creating a new directory for your blog project.

**Your Turn**:
```bash
# Create a new directory
mkdir my-blog-project
cd my-blog-project

# Verify you're in the right place
pwd
```

**Expected Output**: You should see the full path to your `my-blog-project` directory.

**✅ Checkpoint**: You're now in your project directory. This will be the root of your Simone project.

---

## 🏗️ Step 2: Initialize Simone Structure

Now we'll set up the basic Simone framework structure.

**Your Turn**:
```bash
# Initialize Simone project structure
# (This creates the .simone directory and basic structure)
curl -s https://raw.githubusercontent.com/your-repo/simone/main/install-simone.sh | bash
```

**Alternative** (if you have the script locally):
```bash
# Copy the install script to your project
cp /path/to/simone/install-simone.sh .
bash install-simone.sh
```

**What Just Happened?**
- Created `.simone/` directory with organized subdirectories
- Set up basic project structure
- Created template files for project management

**✅ Checkpoint**: Check that you now have a `.simone` directory:
```bash
ls -la .simone/
```

---

## 📝 Step 3: Create Your Project Manifest

The project manifest is the "command center" of your Simone project. Let's create one for your blog.

**Your Turn**: Open `.simone/00_PROJECT_MANIFEST.md` in your text editor and replace the content with:

```markdown
# Personal Blog Project Manifest

---
id: "personal-blog-2025"
title: "Personal Blog Development"
type: "web_application"
created_date: "2025-07-10 16:00"
updated_date: "2025-07-10 16:00"
status: "active"
priority: "medium"
business_value: "medium"
technical_complexity: "simple"
project_lead: "Your Name"
product_owner: "Your Name"
technical_lead: "Your Name"
team_size: 1
estimated_duration: "2 months"
target_launch: "2025-09-10"
current_phase: "planning"
completion_percentage: 0
quality_score: 8.0
risk_level: "low"
version: "1.0.0"
---

**Status**: Active Planning | **Priority**: Medium | **Completion**: 0%  
**Target Launch**: 2025-09-10 | **Business Value**: Medium | **Risk**: Low

## Project Vision
Create a personal blog website to share thoughts, experiences, and technical knowledge with a clean, responsive design and good user experience.

## Objectives
1. **Content Management**: Easy way to create and manage blog posts
2. **User Experience**: Fast, responsive, and accessible design
3. **SEO Optimization**: Good search engine visibility
4. **Social Integration**: Easy sharing on social platforms

## Technology Stack
- **Frontend**: HTML5, CSS3, JavaScript
- **Backend**: Static site generator (Jekyll/Hugo)
- **Hosting**: GitHub Pages or Netlify
- **CMS**: Markdown files or headless CMS

## Success Criteria
- [ ] Blog is live and accessible
- [ ] At least 5 blog posts published
- [ ] Mobile-responsive design
- [ ] Page load time under 3 seconds
- [ ] Basic SEO optimization complete

---

**Created**: 2025-07-10 by Your Name
```

**✅ Checkpoint**: Save the file. You now have a project manifest that defines your blog project!

---

## 🎯 Step 4: Plan Your First Milestone

Milestones are major project deliverables. Let's create your first milestone: "Blog Foundation".

**Your Turn**: Create the file `.simone/02_REQUIREMENTS/M01_Blog_Foundation/milestone.md`:

```bash
# Create the milestone directory
mkdir -p .simone/02_REQUIREMENTS/M01_Blog_Foundation
```

Now create `.simone/02_REQUIREMENTS/M01_Blog_Foundation/milestone.md`:

```markdown
# M01: Blog Foundation

---
milestone_id: "M01"
milestone_name: "Blog Foundation"
milestone_type: "feature_delivery"
created_date: "2025-07-10 16:00"
updated_date: "2025-07-10 16:00"
start_date: "2025-07-10"
target_date: "2025-08-10"
status: "planning"
priority: "high"
business_value: "critical"
technical_complexity: "moderate"
estimated_effort: "40 hours"
completion_percentage: 0
quality_score: 0
risk_level: "low"
dependencies: []
sprint_count: 2
task_count: 8
---

## Milestone Overview

**Goal**: Establish the foundational infrastructure and design for the personal blog

**Business Value**: Creates the core platform that enables all future content creation and user engagement

## Acceptance Criteria

### Technical Requirements
- [ ] Static site generator set up and configured
- [ ] Responsive design system implemented
- [ ] Basic page templates created (home, post, about)
- [ ] Navigation and footer implemented
- [ ] Mobile-responsive layout tested

### Content Requirements  
- [ ] Homepage with introduction and recent posts
- [ ] About page with personal information
- [ ] Contact page with contact form
- [ ] Blog post template with proper formatting
- [ ] Basic SEO meta tags implemented

### Quality Requirements
- [ ] Cross-browser compatibility (Chrome, Firefox, Safari)
- [ ] Mobile responsiveness (phone, tablet)
- [ ] Page load speed under 3 seconds
- [ ] Accessibility basics (alt tags, semantic HTML)
- [ ] Clean, professional design

## Success Metrics
- **Performance**: Page load time < 3 seconds
- **Accessibility**: Basic WCAG 2.1 compliance
- **Responsiveness**: Works on devices 320px and up
- **SEO**: Basic meta tags and structured data

## Planned Sprints
1. **S01**: Setup and Infrastructure (Week 1-2)
2. **S02**: Design and Templates (Week 3-4)

---

**Milestone Lead**: Your Name  
**Created**: 2025-07-10
```

**✅ Checkpoint**: You've created your first milestone! This defines what you'll deliver in the next month.

---

## 🏃 Step 5: Create Your First Sprint

Sprints are shorter work cycles (usually 1-2 weeks). Let's create Sprint 1 for your milestone.

**Your Turn**: Create `.simone/03_SPRINTS/S01_Setup_Infrastructure/sprint.md`:

```bash
# Create the sprint directory
mkdir -p .simone/03_SPRINTS/S01_Setup_Infrastructure
```

Create the sprint file:

```markdown
# S01: Setup and Infrastructure

---
sprint_id: "S01"
sprint_name: "Setup and Infrastructure"
milestone_id: "M01"
sprint_number: 1
created_date: "2025-07-10 16:00"
updated_date: "2025-07-10 16:00"
start_date: "2025-07-10"
end_date: "2025-07-24"
status: "planning"
priority: "high"
estimated_effort: "20 hours"
actual_effort: 0
completion_percentage: 0
velocity_target: 15
velocity_actual: 0
team_capacity: 20
---

## Sprint Goal
Set up the basic infrastructure and tools needed for blog development.

## Sprint Backlog

### High Priority Tasks
1. **Choose and set up static site generator**
   - Research options (Jekyll, Hugo, Gatsby)
   - Install and configure chosen tool
   - Create basic project structure

2. **Set up development environment**
   - Configure local development server
   - Set up version control (Git)
   - Create repository on GitHub

3. **Domain and hosting setup**
   - Choose domain name
   - Set up hosting (GitHub Pages/Netlify)
   - Configure DNS settings

4. **Basic project structure**
   - Create folder organization
   - Set up configuration files
   - Test build and deployment

## Definition of Done
- [ ] Static site generator is working locally
- [ ] Code is in version control
- [ ] Basic deployment pipeline is working
- [ ] Site is accessible via chosen domain
- [ ] Development workflow is documented

## Sprint Success Criteria
- All infrastructure tasks completed
- Can create and publish a test page
- Development to deployment workflow works
- No blockers for next sprint

---

**Sprint Master**: Your Name  
**Duration**: 2 weeks (2025-07-10 to 2025-07-24)
```

**✅ Checkpoint**: You now have a sprint that breaks down your milestone into manageable 2-week chunks!

---

## ✅ Step 6: Add Individual Tasks

Tasks are the actual work items. Let's add a few tasks to your sprint.

**Your Turn**: Create `.simone/04_GENERAL_TASKS/task_001_choose_generator.md`:

```bash
# Create tasks directory
mkdir -p .simone/04_GENERAL_TASKS
```

Create your first task:

```markdown
# Task 001: Choose Static Site Generator

---
task_id: "TASK-001"
title: "Choose and Research Static Site Generator"
milestone_id: "M01"
sprint_id: "S01"
created_date: "2025-07-10 16:00"
updated_date: "2025-07-10 16:00"
status: "todo"
priority: "high"
assignee: "Your Name"
estimated_hours: 3
actual_hours: 0
story_points: 2
task_type: "research"
dependencies: []
labels: ["research", "infrastructure", "tooling"]
---

## Task Description
Research and choose the best static site generator for the personal blog project.

## Acceptance Criteria
- [ ] Research at least 3 static site generators (Jekyll, Hugo, Gatsby)
- [ ] Compare features, ease of use, and deployment options
- [ ] Make decision based on project requirements
- [ ] Document decision with reasoning
- [ ] Set up chosen generator locally

## Research Questions
1. Which generator has the best documentation?
2. Which has good theme/template options?
3. Which integrates well with GitHub Pages?
4. Which has the learning curve that fits my timeline?

## Definition of Done
- [ ] Decision documented with pros/cons
- [ ] Chosen generator installed and working
- [ ] Basic site structure created
- [ ] Test page can be built and served locally

## Resources
- [Jekyll Documentation](https://jekyllrb.com/)
- [Hugo Documentation](https://gohugo.io/)
- [Gatsby Documentation](https://www.gatsbyjs.com/)

---

**Assigned to**: Your Name  
**Due Date**: 2025-07-12
```

**✅ Checkpoint**: You've created your first task! This is where the actual work gets done.

---

## 🧠 Step 7: Experience Cognitive Personas

Now that you have concrete tasks, let's learn how to execute them with specialized AI expertise! Simone includes 9 cognitive personas that provide domain-specific guidance.

### Understanding Personas

Think of personas as specialized consultants that enhance your development process:

**🔒 Security Expert**: "Always consider OWASP guidelines and threat models"  
**🏗️ Architect**: "Focus on scalable design patterns and system integration"  
**🎨 Frontend Specialist**: "Prioritize user experience and accessibility"  
**⚙️ Backend Engineer**: "Optimize APIs and database performance"  

### Hands-On Persona Experience

**Your Turn**: Let's enhance our blog project tasks with persona expertise!

#### 1. Create a Security-Enhanced Task

Create a new authentication task with security expertise:

```bash
# In your terminal, create a security-focused task
cat > .simone/03_SPRINTS/S01_M01_Blog_Foundation/task_002_user_authentication.md << 'EOF'
---
task_id: "TASK_002"
title: "Implement User Authentication"
sprint_id: "S01_M01"
milestone_id: "M01"
type: "feature"
priority: "high"
complexity: "medium"
estimated_hours: 8
status: "todo"
assigned_to: "Developer"

# Cognitive Personas Applied
personas_applied: ["security", "backend"]
security_requirements: "OWASP compliance, JWT tokens, secure password hashing"
backend_considerations: "RESTful API design, session management, database security"
---

# TASK_002: Implement User Authentication

**Enhanced with Security + Backend Personas**

## Security-First Approach

### Security Requirements (Security Persona)
- [ ] Implement bcrypt password hashing (min cost factor 12)
- [ ] Add rate limiting for login attempts (5 attempts per 15 minutes)
- [ ] Implement JWT tokens with secure claims
- [ ] Add HTTPS enforcement and secure cookie settings
- [ ] Include password strength validation

### Backend Implementation (Backend Persona)  
- [ ] Design RESTful authentication endpoints
- [ ] Implement proper HTTP status codes
- [ ] Add comprehensive error handling
- [ ] Create middleware for protected routes
- [ ] Optimize database queries for user lookup

### Quality Gates
- [ ] Security review passed
- [ ] Password security tested
- [ ] API security validated
- [ ] Performance benchmarks met

## Acceptance Criteria

**Security-Enhanced Criteria**:
1. ✅ Users can register with validated email addresses
2. ✅ Passwords meet security requirements (8+ chars, mixed case, numbers)
3. ✅ Login process includes brute force protection
4. ✅ JWT tokens expire appropriately (15 min access, 7 day refresh)
5. ✅ All authentication endpoints return consistent error messages
6. ✅ Security headers implemented (CSRF, XSS protection)

**Implementation Notes**:
- Security persona ensures OWASP compliance from day one
- Backend persona optimizes API design and database interactions  
- Combined expertise prevents common security vulnerabilities
EOF
```

#### 2. Try Different Persona Combinations

**Your Turn**: Experiment with persona-enhanced task execution:

```bash
# Security-focused development for authentication
/project:simone:do_task TASK_002 --persona-security --persona-backend --introspect

# The --introspect flag shows you the AI reasoning process:
# 🤔 Security Thinking: "JWT implementation needs secure signing algorithm"
# 🎯 Backend Decision: "Use HS256 with 256-bit secret for development"
# 🔍 Analysis: "Rate limiting prevents brute force attacks"
# ✅ Conclusion: "Implementation follows OWASP authentication guidelines"
```

#### 3. Create Frontend Task with UX Focus

**Your Turn**: Create a UI task enhanced with frontend expertise:

```bash
cat > .simone/03_SPRINTS/S01_M01_Blog_Foundation/task_003_responsive_design.md << 'EOF'
---
task_id: "TASK_003"
title: "Create Responsive Blog Layout"
type: "feature"
priority: "medium"
complexity: "medium"
estimated_hours: 6

# Multi-Persona Enhancement
personas_applied: ["frontend", "performance", "qa"]
ux_considerations: "Mobile-first design, accessibility compliance"
performance_targets: "Loading time <2s, optimized images"
quality_standards: "Cross-browser testing, accessibility audit"
---

# TASK_003: Create Responsive Blog Layout

**Enhanced with Frontend + Performance + QA Personas**

## Frontend Excellence (Frontend Persona)
- [ ] Mobile-first responsive design
- [ ] WCAG 2.1 AA accessibility compliance
- [ ] Semantic HTML structure
- [ ] Progressive enhancement approach

## Performance Optimization (Performance Persona)
- [ ] Image optimization and lazy loading
- [ ] CSS/JS minification and compression
- [ ] Critical CSS inlining
- [ ] Web Vitals benchmarks met

## Quality Assurance (QA Persona)
- [ ] Cross-browser testing (Chrome, Firefox, Safari, Edge)
- [ ] Accessibility testing with screen readers
- [ ] Performance testing on 3G networks
- [ ] Visual regression testing
EOF
```

#### 4. Experience Multi-Persona Analysis

**Your Turn**: Try the comprehensive analysis approach:

```bash
# Multi-persona consultation for complex decisions
/project:simone:create_milestone "User Management System" --persona-security --persona-backend --persona-frontend --consensus

# What happens:
# - Security persona identifies compliance requirements
# - Backend persona designs scalable data architecture  
# - Frontend persona plans user experience flows
# - Consensus mode validates decisions across all perspectives
```

### Persona Learning Outcomes

After this step, you understand:

- ✅ **Domain Expertise**: How different personas approach the same problem
- ✅ **Quality Enhancement**: How personas prevent common mistakes upfront  
- ✅ **Learning Acceleration**: How mentor persona helps team growth
- ✅ **Cost Optimization**: How UltraCompressed mode reduces AI costs
- ✅ **Transparent AI**: How introspection mode shows reasoning

### When to Use Personas

| Task Type | Recommended Personas | Why |
|-----------|---------------------|-----|
| **Authentication** | Security + Backend | OWASP compliance, secure patterns |
| **User Interface** | Frontend + Performance + QA | UX optimization, speed, testing |
| **Database Design** | Backend + Security + Analyzer | Performance, security, complexity |
| **API Development** | Backend + Security + QA | RESTful design, security, testing |
| **Complex Features** | Multiple + Consensus | Comprehensive validation |

**✅ Checkpoint**: You've experienced how cognitive personas enhance development quality and accelerate learning!

---

## 🎯 Step 8: Track Your Progress

Now let's see how to track progress in your Simone project.

**Your Turn**: Update task status by editing the task file:

1. Open `task_001_choose_generator.md`
2. Change `status: "todo"` to `status: "in_progress"`
3. Add some actual hours: `actual_hours: 1`
4. Check off a few acceptance criteria items

**Example Progress Update**:
```yaml
status: "in_progress"
actual_hours: 1
```

And in the acceptance criteria:
```markdown
## Acceptance Criteria
- [x] Research at least 3 static site generators (Jekyll, Hugo, Gatsby)
- [ ] Compare features, ease of use, and deployment options
- [ ] Make decision based on project requirements
- [ ] Document decision with reasoning
- [ ] Set up chosen generator locally
```

**✅ Checkpoint**: You're now tracking real progress on your task!

---

## 📊 Step 9: Create a Quick Status Overview

Let's create a simple way to see your project status at a glance.

**Your Turn**: Create `.simone/10_STATE_OF_PROJECT/weekly_status.md`:

```markdown
# Weekly Status Report - Week 1

---
report_date: "2025-07-10"
week_number: 1
overall_status: "on_track"
completion_percentage: 5
---

## This Week's Accomplishments
- [x] Project structure set up
- [x] First milestone planned
- [x] First sprint created
- [x] Initial tasks defined
- [ ] Started research on static site generators

## Current Focus
- **Active Sprint**: S01 Setup and Infrastructure
- **Active Milestone**: M01 Blog Foundation
- **Priority Task**: Choose static site generator

## Upcoming This Week
- Complete generator research and selection
- Set up development environment
- Begin domain and hosting setup

## Blockers & Risks
- None currently identified

## Key Metrics
- **Sprint Progress**: 5% complete
- **Milestone Progress**: 5% complete
- **Team Velocity**: On track for sprint goals

---

**Next Review**: 2025-07-17
```

**✅ Checkpoint**: You now have a way to track weekly progress!

---

## 🎉 Congratulations! Tutorial Complete

You've successfully created your first Simone project! Here's what you accomplished:

### ✅ What You Built
- **Project Structure**: Complete `.simone/` directory organization
- **Project Manifest**: Clear project definition and goals
- **Milestone**: M01 Blog Foundation with acceptance criteria
- **Sprint**: S01 Setup and Infrastructure with 2-week timeline
- **Task**: Detailed work item with acceptance criteria
- **Status Tracking**: Weekly progress reporting system

### 🧠 What You Learned
- How Simone organizes projects (Manifest → Milestones → Sprints → Tasks)
- How to write effective acceptance criteria
- How to track progress using status updates
- How to structure work into manageable chunks

---

## 🚀 Next Steps

Now that you have the foundation, here's what to do next:

### Immediate Actions (Next 2 Hours)
1. **Complete your research task**: Actually research static site generators
2. **Add more tasks**: Create 3-4 more tasks for Sprint 1
3. **Update progress**: Practice updating task status as you work

### This Week
1. **Finish Sprint 1**: Complete all infrastructure setup tasks
2. **Plan Sprint 2**: Create S02 for design and templates
3. **Weekly Review**: Update your weekly status report

### Advanced Learning
1. **Explore Templates**: Check out `.claude/templates/simone/` for more templates
2. **Learn Commands**: Try Simone commands for project management
3. **Read Best Practices**: Review the [best practices guide](../best-practices/)

---

## 📚 Additional Resources

### Continue Learning
- [Project Structure Guide](../core-components/project-structure.md) - Deep dive into Simone organization
- [Template Catalog](../templates/template-catalog.md) - All available templates
- [Command Reference](../core-components/command-reference.md) - Available Simone commands

### Get Help
- [Troubleshooting Guide](../administration/troubleshooting.md) - Common issues and solutions
- [Community Forum](https://github.com/your-repo/simone/discussions) - Ask questions and share experiences

### Share Your Success
- Tag us on social media with your completed project
- Contribute your blog project as an example for other users
- Share feedback on this tutorial to help us improve

---

## 🤔 Reflection Questions

Take a moment to reflect on your learning:

1. **What surprised you** most about the Simone structure?
2. **Which part** felt most natural to you?
3. **What questions** do you still have about project management with Simone?
4. **How might you adapt** this structure for your real projects?

---

**Tutorial Complete! 🎉**

You're now ready to use Simone for real project management. The structure you learned here scales from personal projects to enterprise initiatives.

**Happy project managing!** 🚀

---

**Tutorial Metadata**
- **Completion Time**: ~30 minutes
- **Files Created**: 6 Simone project files
- **Skills Learned**: Project setup, milestone planning, task management
- **Next Tutorial**: [Advanced Sprint Management](interactive-sprint-management.md)