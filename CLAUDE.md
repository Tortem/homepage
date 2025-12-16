# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
pip install -r requirements.txt   # Install dependencies
mkdocs serve                      # Local dev server (http://127.0.0.1:8000)
mkdocs build                      # Build static site to site/
mkdocs build --strict             # Build with strict mode (fails on warnings)
```

## Architecture

MkDocs Material blog/documentation site.

### Structure

```
homepage/
├── docs/
│   ├── index.md              # Landing page
│   ├── posts/                # Blog posts
│   └── stylesheets/extra.css # Custom styles
├── helm/                     # Kubernetes Helm chart
├── mkdocs.yml               # MkDocs configuration
├── Dockerfile               # Multi-stage build (Python → nginx)
└── requirements.txt         # mkdocs + mkdocs-material
```

### Configuration (mkdocs.yml)

- Theme: Material with light/dark mode toggle
- Plugins: search, blog (posts in `docs/posts/`)
- Blog categories: Kubernetes, Operator
- Extensions: attr_list, pymdownx.emoji

### Deployment

Two deployment paths:
1. **GitHub Pages** - `.github/workflows/deploy-github-pages.yaml`
2. **Kubernetes** - `.github/workflows/deploy-kubernetes.yaml` builds Docker image, Helm chart in `helm/`

### Docker Build

Multi-stage Dockerfile:
1. Python 3.11 Alpine builds static site with `mkdocs build --strict`
2. nginx Alpine serves from `/usr/share/nginx/html`

## Dependencies

- Python 3.11+
- mkdocs 1.6.0
- mkdocs-material 9.5.30
