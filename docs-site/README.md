# Simone Framework Documentation Site

This directory contains the Jekyll-based documentation site for the Simone Framework.

## Setup

To run the documentation site locally:

```bash
cd docs-site
bundle install
bundle exec jekyll serve
```

The site will be available at `http://localhost:4000`

## GitHub Pages Configuration

1. Go to your repository settings
2. Navigate to Pages section  
3. Set Source to "GitHub Actions"
4. The workflow will automatically build and deploy on pushes to main/master

## Structure

- `_config.yml` - Jekyll configuration
- `Gemfile` - Ruby dependencies
- `index.md` - Homepage (auto-generated from docs)
- `_docs/` - Documentation files (copied from ../docs during build)

## Customization

The site uses the GitHub Pages Architect theme for a modern, professional look. All documentation from the main `docs/` directory is automatically included and built into the site.