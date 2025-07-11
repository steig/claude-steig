# Contributing to Simone Framework

Thank you for your interest in contributing to the Simone Framework! This guide will help you get started with development and ensure your contributions meet our quality standards.

## Getting Started

### Prerequisites

- Git
- Python 3.8+ (for pre-commit hooks)
- Bash (for shell scripts)

### Development Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/steig/claude-steig.git
   cd claude-steig
   ```

2. **Install pre-commit hooks**
   ```bash
   # Install pre-commit
   pip install pre-commit
   
   # Install the hooks
   pre-commit install
   
   # Test the installation (optional)
   pre-commit run --all-files
   ```

## Code Quality Standards

### Pre-commit Hooks

We use pre-commit hooks to ensure code quality and consistency. The hooks will run automatically on every commit and check for:

- **Shell Script Quality**: Linting with ShellCheck and formatting with shfmt
- **Markdown Quality**: Linting and auto-fixing with markdownlint
- **General Quality**: Trailing whitespace, file endings, YAML syntax
- **Security**: Secret detection with detect-secrets

### Pre-commit Configuration

Our pre-commit configuration includes:

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/koalaman/shellcheck-precommit
    rev: v0.10.0
    hooks:
      - id: shellcheck
        args: [--severity=warning]

  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.41.0
    hooks:
      - id: markdownlint
        args: [--fix]

  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-executables-have-shebangs
      - id: check-shebang-scripts-are-executable

  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets
        args: [--baseline, .secrets.baseline]

  - repo: https://github.com/mvdan/sh
    rev: v3.7.0
    hooks:
      - id: shfmt
        args: [-i, '2', -w]
```

### Markdown Standards

We follow these markdown standards (configured in `.markdownlint.yaml`):

- Maximum line length: 120 characters
- Inline HTML is allowed
- Duplicate headings are allowed (for template structures)
- Trailing punctuation in headings is allowed

### Shell Script Standards

- Use ShellCheck for linting
- Format with shfmt (2-space indentation)
- Include proper shebangs
- Make scripts executable

## Development Workflow

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the coding standards
   - Add tests for new functionality
   - Update documentation as needed

3. **Run quality checks**
   ```bash
   # Run pre-commit hooks manually
   pre-commit run --all-files
   
   # Run tests
   ./tests/verify-installation.sh
   ```

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```
   
   The pre-commit hooks will run automatically and must pass before the commit succeeds.

5. **Push and create a pull request**
   ```bash
   git push origin feature/your-feature-name
   ```

## Bypassing Pre-commit Hooks

In rare cases, you may need to bypass pre-commit hooks:

```bash
# Bypass all hooks (use sparingly)
git commit --no-verify -m "emergency fix"

# Skip specific hooks
SKIP=shellcheck git commit -m "skip shellcheck for this commit"
```

**Note**: Only bypass hooks in emergencies. The CI/CD pipeline will still run all checks.

## Manual Quality Checks

If you need to run quality checks manually:

```bash
# Run shellcheck on all shell scripts
find . -name "*.sh" -exec shellcheck {} \;

# Run markdownlint on all markdown files
markdownlint **/*.md

# Check for secrets
detect-secrets scan .

# Format shell scripts
shfmt -i 2 -w **/*.sh
```

## Testing

Before submitting your contribution:

1. **Run the test suite**
   ```bash
   ./tests/verify-installation.sh
   ./tests/verify-commands.sh
   ```

2. **Test your changes**
   - Install Simone in a test directory
   - Run through the basic workflow
   - Verify documentation accuracy

## Pull Request Guidelines

- Use descriptive commit messages
- Keep changes focused and atomic
- Include tests for new features
- Update documentation for user-facing changes
- Reference related issues in the PR description

## Getting Help

- Check the [documentation](docs/)
- Review existing [issues](https://github.com/steig/claude-steig/issues)
- Ask questions in pull request comments

## Code Review Process

All contributions go through code review:

1. Automated checks must pass
2. Manual review by maintainers
3. Feedback addressed
4. Final approval and merge

Thank you for contributing to the Simone Framework!