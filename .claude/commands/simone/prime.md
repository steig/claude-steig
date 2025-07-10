# Prime your knowledge

Prime yourself with basic information about this project.
Make sure you are aware of the environment.

## FIRST: Initialize MCP Servers

**Activate the existing MCP servers:**
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

**Load Serena instructions and tools:**
```bash
/mcp__serena__initial_instructions
```

This ensures all MCP servers (installed during initialization) are ready and Claude is properly configured to use:
- **Serena's tools** for enhanced IDE assistance and project management capabilities
- **Context7's tools** for advanced context management and retrieval
- **Playwright's tools** for browser automation and testing
- **Work History's tools** for command tracking and output logging
- **Sequential Thinking's tools** for enhanced reasoning and structured problem-solving

## USE **PARALLEL AGENTS** to

- READ .simone/01_PROJECT_DOCS/ARCHITECTURE.md for basic Project Information
- READ .simone/00_PROJECT_MANIFEST.md for the Project status