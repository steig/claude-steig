# MCP Integration Demo - Comprehensive MCP Server Usage

**PURPOSE:** Demonstrates comprehensive usage of all available MCP servers in the Simone framework.

**AVAILABLE MCPs:** This command showcases all 6 MCP servers:
- **Serena**: Enhanced IDE assistance and project management
- **Context7**: Advanced context management and retrieval
- **Playwright**: Browser automation and testing
- **GitHub**: Repository management and API integration
- **Sequential Thinking**: Structured reasoning and problem-solving
- **Fetch**: Web content retrieval and markdown extraction

## Create a TODO with EXACTLY these 6 Items

1. Verify all MCP servers are active and demonstrate Serena usage
2. Use Context7 for project context management and retrieval
3. Demonstrate GitHub MCP for repository analysis and integration
4. Use Sequential Thinking for structured problem-solving
5. Use Fetch MCP for external resource retrieval
6. Use Playwright for browser automation (optional demonstration)

## DETAILS on every TODO item

### 1. Verify all MCP servers and demonstrate Serena usage

**MCP VERIFICATION:**
```bash
# Verify all 6 MCP servers are active
claude mcp status serena
claude mcp status context7
claude mcp status playwright
claude mcp status github
claude mcp status sequential-thinking
claude mcp status fetch
```

**SERENA MCP INTEGRATION - Enhanced IDE assistance:**
```bash
# Initialize Serena for project management
/mcp__serena__initial_instructions

# Get project overview using Serena
/mcp__serena__get_symbols_overview .

# Analyze project structure
/mcp__serena__list_dir . true

# Find specific symbols or patterns
/mcp__serena__find_symbol "main" 1

# Think about collected information
/mcp__serena__think_about_collected_information

# Check project onboarding status
/mcp__serena__check_onboarding_performed
```

### 2. Use Context7 for project context management

**CONTEXT7 MCP INTEGRATION - Advanced context management:**

**Context Storage and Retrieval:**
- Store important project context for future sessions
- Retrieve relevant context based on current task
- Maintain project state across multiple sessions
- Preserve architectural decisions and project knowledge

**Usage Pattern:**
```bash
# Context7 commands would be used here for:
# - Storing project context
# - Retrieving relevant information
# - Managing session continuity
# Note: Specific Context7 commands depend on implementation
```

### 3. Demonstrate GitHub MCP for repository analysis

**GITHUB MCP INTEGRATION - Repository management and API integration:**

**Repository Analysis:**
- Analyze repository structure and health
- Review issues and pull requests
- Check repository settings and configurations
- Analyze commit history and contributors

**GitHub API Integration:**
```bash
# GitHub MCP commands for repository analysis:
# - Repository information retrieval
# - Issue and PR management
# - Branch and commit analysis
# - Repository insights and statistics
# Note: Specific GitHub MCP commands depend on implementation
```

### 4. Use Sequential Thinking for structured problem-solving

**SEQUENTIAL THINKING MCP INTEGRATION - Enhanced reasoning:**

**Structured Problem Analysis:**
- Break down complex problems into manageable steps
- Apply systematic reasoning to technical challenges
- Structure decision-making processes
- Validate logical flow and dependencies

**Problem-Solving Process:**
```bash
# Sequential Thinking for systematic analysis:
# - Problem decomposition
# - Logical reasoning chains
# - Decision validation
# - Systematic approach to complex challenges
# Note: Specific Sequential Thinking commands depend on implementation
```

### 5. Use Fetch MCP for external resource retrieval

**FETCH MCP INTEGRATION - Web content retrieval:**

**External Resource Gathering:**
- Retrieve documentation from external sources
- Gather best practices and industry standards
- Fetch API documentation and examples
- Extract relevant information from web resources

**Fetch Usage Examples:**
```bash
# Use Fetch MCP to retrieve external documentation
# Example: Fetching framework documentation
# WebFetch https://docs.example.com/api "Extract API endpoints and usage examples"

# Fetching best practices
# WebFetch https://bestpractices.example.com "Summarize coding best practices for this technology stack"

# Retrieving library documentation
# WebFetch https://library.docs.com "Extract installation and configuration instructions"
```

### 6. Use Playwright for browser automation (optional)

**PLAYWRIGHT MCP INTEGRATION - Browser automation and testing:**

**Browser-Based Operations:**
- Automated testing of web interfaces
- Web scraping for data collection
- UI interaction automation
- End-to-end testing scenarios

**Playwright Usage Examples:**
```bash
# Playwright for browser automation:
# - Web UI testing
# - Automated interaction with web interfaces
# - Screenshot and visual testing
# - End-to-end workflow testing
# Note: Specific Playwright commands depend on implementation
```

## MCP Integration Best Practices

### 1. Serena Usage
- **Always run** `/mcp__serena__initial_instructions` at session start
- **Use symbol analysis** for code understanding before making changes
- **Think about collected information** before proceeding with tasks
- **Validate task adherence** during complex operations

### 2. Context7 Usage
- **Store important context** for future sessions
- **Retrieve relevant context** when starting new tasks
- **Maintain project knowledge** across session boundaries

### 3. GitHub Usage
- **Analyze repository state** before making changes
- **Use API integration** for issue and PR management
- **Check repository health** and compliance

### 4. Sequential Thinking Usage
- **Break down complex problems** into structured steps
- **Apply systematic reasoning** to technical decisions
- **Validate logical flow** in complex operations

### 5. Fetch Usage
- **Retrieve external documentation** when needed
- **Gather industry best practices** for reference
- **Extract relevant information** from web resources

### 6. Playwright Usage
- **Automate browser testing** for web applications
- **Perform UI validation** and interaction testing
- **Generate screenshots** and visual documentation

## Expected Output

**This command should demonstrate:**
1. ✅ All MCP servers are active and responsive
2. ✅ Serena provides enhanced code analysis and project management
3. ✅ Context7 maintains session continuity and project context
4. ✅ GitHub integration provides repository insights
5. ✅ Sequential Thinking structures complex problem-solving
6. ✅ Fetch retrieves external resources effectively
7. ✅ Playwright enables browser automation (if applicable)

**Success Criteria:**
- All 6 MCP servers respond to status checks
- Each MCP demonstrates its core functionality
- Integration between MCPs works seamlessly
- Project context is enhanced by MCP capabilities
- Complex tasks benefit from multi-MCP coordination