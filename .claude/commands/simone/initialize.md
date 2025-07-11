# Initialize Simone Framework

Initialize the Simone project management framework through an adaptive, interactive process.

## Create a TODO with EXACTLY these items

1. Scan and analyze the project
2. Verify MCP servers are active
3. Interactive confirmation with user
4. Check for existing Simone documents
5. Guide document creation process
6. Create first milestone for Simone
7. Generate project manifest
8. Provide next steps

## DETAILS on every TODO item

### 1. Scan and analyze the project

**Detect project characteristics:**
- Check for package.json, requirements.txt, composer.json, etc.
- Identify project type (Node.js, Python, PHP, etc.)
- Scan overall project structure
- Check if this is a new or existing project
- Look for existing documentation (README, docs/, etc.)

**Keep findings brief** - Just identify the essentials

### 2. Verify MCP servers are active

**Check status of all MCP servers (installed during framework setup):**
```bash
# Verify Serena MCP is installed and active
claude mcp status serena

# Verify Context7 MCP is installed and active
claude mcp status context7

# Verify Playwright MCP is installed and active
claude mcp status playwright

# Verify Work History MCP is installed and active
claude mcp status work-history

# Verify Sequential Thinking MCP is installed and active
claude mcp status sequential-thinking
```

**If any MCP servers are missing:**
- Inform user that MCPs should have been installed during framework setup
- Suggest running `/project:simone:prime` to troubleshoot
- Note: MCPs can be manually installed using the commands in prime.md if needed

**Available capabilities:**
- Enhanced IDE assistance and code analysis (Serena)
- Improved project management capabilities (Serena)
- Context-aware development support throughout Simone initialization (Serena)
- Advanced context management and retrieval (Context7)
- Browser automation and testing capabilities (Playwright)
- Command history tracking and output logging (Work History)
- Sequential reasoning and structured thinking capabilities (Sequential Thinking)

### 3. Interactive confirmation with user

**Present findings conversationally:**
```
I found this to be a [project type] project named [detected name].
Is this correct? Should I proceed with Simone setup?
```

**Get user confirmation before continuing**

### 4. Check for existing Simone documents

**Scan .simone/ directory for:**
- Any documents in 01_PROJECT_DOCS/
- Any milestones in 02_REQUIREMENTS/
- Any existing sprints or tasks
- Current manifest status

**Interactive decision:**
- If documents found: "I found existing documents: [list]. Should we work with these or extend them?"
- If no documents: "No Simone documents found yet. Do you have any existing project documentation you'd like to copy in before we continue?"

**Allow user to:**
- Use existing documents
- Add new documents
- Start fresh
- Cancel to add documents manually first

### 5. Guide document creation process

**Based on user's choice:**

**If starting fresh or extending:**
- Perform deep analysis of the codebase using **MCP servers**:
  - **Serena**: Code analysis and structure detection
  - **Sequential Thinking**: Systematic architecture analysis
  - **Context7**: Maintain context about architectural decisions
- Identify key components and architecture patterns
- **Use architecture_template.md** from `.simone/99_TEMPLATES/`
- Create comprehensive ARCHITECTURE.md with:
  - **Auto-detected tech stack** (language, framework, database, testing tools)
  - **Project structure analysis** (folder organization, patterns)
  - **Development workflow patterns** (testing, deployment, CI/CD)
  - **Performance and scalability considerations**
  - **Security and compliance requirements**
- Use Q&A style to refine and complete:
  - "What's the main purpose and business goals of this project?"
  - "What are the key technical decisions and why were they made?"
  - "What are the performance and scalability requirements?"
  - "What are the security and compliance considerations?"
  - "How should the development workflow be organized?"
  - "What are the testing and quality standards?"

**If using existing docs:**
- Import and adapt existing documentation
- Fill in any Simone-specific sections
- Ensure compatibility with framework structure

**Keep it conversational and adaptive**

### 6. Create first milestone for Simone

**Determine appropriate first milestone:**
- If new project: Start with setup/foundation milestone
- If existing project: Identify current phase and create appropriate milestone

**Interactive milestone creation:**
- "Based on the project state, I suggest creating milestone: [name]"
- "What would you like to focus on in this milestone?"
- Create milestone structure with initial requirements
- Keep scope realistic and focused

### 7. Generate project manifest

**Automatically generate manifest using:**
- Information gathered during setup
- Created/imported documentation
- Current milestone details
- Project metadata

**No user interaction needed** - Just inform when complete

### 8. Provide next steps

**Customized guidance based on setup:**
```
✅ Simone initialized for [project name]!

Current setup:
- Project type: [type]
- Current milestone: [milestone]
- Documents: [created/imported]

Next steps:
- Review your architecture: 01_PROJECT_DOCS/ARCHITECTURE.md
- Check milestone requirements: 02_REQUIREMENTS/[milestone]/
- Start first task: /project:simone:create_general_task

Ready to begin development!
```

## ADAPTIVE PROCESS NOTES

- **Stay conversational** - Ask questions naturally, not like a form
- **Be smart** - Use AI to understand context and make intelligent suggestions
- **Allow flexibility** - User can skip, cancel, or modify at any point
- **Focus on value** - Only create what's useful for the specific project
- **Keep it simple** - Don't overwhelm with options or details