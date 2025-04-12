#!/bin/bash

echo "🚀 Setup für Not-the-MCP-Cookbook-for-Practitioners"

# GitBook CLI installieren
echo "📚 Installiere GitBook CLI..."
npm install -g gitbook-cli

# GitBook Plugins installieren
echo "🔌 Installiere GitBook Plugins..."
gitbook install

# .gitignore erstellen
echo "📝 Erstelle .gitignore..."
cat > .gitignore << EOL
# Build Artefakte
_book/
node_modules/
.DS_Store
*.log
*.tmp

# GitBook
*.pdf
*.epub
EOL

# .nojekyll erstellen
echo "📝 Erstelle .nojekyll..."
touch .nojekyll

# _config.yml erstellen
echo "⚙️ Erstelle Jekyll-Konfiguration..."
cat > _config.yml << EOL
# Jekyll-Konfiguration für GitHub Pages
theme: jekyll-theme-minimal
title: Not-the-MCP-Cookbook-for-Practitioners
description: Ein praktischer Leitfaden für modulare AI-Systeme mit MCP-Struktur und LLM-Agenten
markdown: kramdown
plugins:
  - jekyll-relative-links
  - jekyll-redirect-from
EOL

# CNAME erstellen
echo "🌐 Erstelle CNAME-Datei..."
cat > CNAME << EOL
# Hier die benutzerdefinierte Domain eintragen, z.B.:
# cookbook.mcp-practitioner.de
EOL

# GitHub Actions Workflow erstellen
echo "⚙️ Erstelle GitHub Actions Workflow..."
mkdir -p .github/workflows
cat > .github/workflows/deploy.yml << EOL
name: 📘 Build & Deploy MCP Practitioner Book

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: 📥 Checkout Repository
        uses: actions/checkout@v3

      - name: 🔧 Install GitBook CLI
        run: |
          npm install -g gitbook-cli
          gitbook install

      - name: 📚 Build Book
        run: gitbook build

      - name: 🚀 Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v4
        with:
          github_token: \${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./_book
          publish_branch: gh-pages
EOL

echo "✅ Setup abgeschlossen!"
echo "📚 Starte lokalen Server mit: gitbook serve" 