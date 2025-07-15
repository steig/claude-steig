# Prime your knowledge

Prime yourself with basic information about this project.
Make sure you are aware of the environment.

## FIRST: Verify MCP Servers

**Verify the MCP servers (installed during framework setup):**
```bash
# Verify Serena MCP is installed and active
claude mcp status serena

# Verify Context7 MCP is installed and active
claude mcp status context7

# Verify Playwright MCP is installed and active
claude mcp status playwright

# Verify GitHub MCP is installed and active
claude mcp status github

# Verify Sequential Thinking MCP is installed and active
claude mcp status sequential-thinking

# Verify Fetch MCP is installed and active
claude mcp status fetch
```

**Load Serena instructions and tools:**
```bash
/mcp__serena__initial_instructions
```

This ensures all MCP servers (installed during framework setup) are ready and Claude is properly configured to use:
- **Serena's tools** for enhanced IDE assistance and project management capabilities
- **Context7's tools** for advanced context management and retrieval
- **Playwright's tools** for browser automation and testing
- **GitHub's tools** for repository management and API integration
- **Sequential Thinking's tools** for enhanced reasoning and structured problem-solving
- **Fetch's tools** for web content retrieval and markdown extraction

## USE **PARALLEL AGENTS** to

- READ .simone/01_PROJECT_DOCS/ARCHITECTURE.md for basic Project Information
- READ .simone/00_PROJECT_MANIFEST.md for the Project status