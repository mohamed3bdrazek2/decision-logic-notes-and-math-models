#!/bin/bash
# Quick setup script for GitHub Topics automation
# Usage: bash setup-topics.sh

set -e

echo "🚀 GitHub Topics Setup Script"
echo "=============================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Python installation
echo "📋 Checking Python installation..."
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Python3 not found!${NC}"
    echo "Install from: https://www.python.org/downloads/"
    exit 1
fi

PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
echo -e "${GREEN}✅ Python $PYTHON_VERSION found${NC}"
echo ""

# Check pip installation
echo "📋 Checking pip installation..."
if ! command -v pip3 &> /dev/null; then
    echo -e "${RED}❌ pip3 not found!${NC}"
    echo "Install: python3 -m ensurepip --default-pip"
    exit 1
fi

echo -e "${GREEN}✅ pip3 available${NC}"
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
echo "   • PyGithub (GitHub API wrapper)"
echo "   • PyYAML (Configuration parser)"
echo ""

pip3 install -q PyGithub pyyaml

echo -e "${GREEN}✅ Dependencies installed${NC}"
echo ""

# Verify installation
echo "🔍 Verifying installation..."
python3 -c "import github; import yaml" 2>/dev/null && \
    echo -e "${GREEN}✅ All dependencies verified${NC}" || \
    { echo -e "${RED}❌ Verification failed${NC}"; exit 1; }

echo ""
echo "=============================="
echo "✅ Setup Complete!"
echo "=============================="
echo ""
echo "📝 Next steps:"
echo "1. Get GitHub PAT: https://github.com/settings/tokens/new"
echo "2. Copy PAT and set environment variable:"
echo "   export GITHUB_PAT='ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'"
echo ""
echo "3. Test with dry run:"
echo "   python3 scripts/add-github-topics.py --token \$GITHUB_PAT --dry-run --verbose"
echo ""
echo "4. Run for real:"
echo "   python3 scripts/add-github-topics.py --token \$GITHUB_PAT --verbose"
echo ""
echo "📚 Full guide: GITHUB_TOPICS_SETUP.md"
echo ""

# Prompt for GitHub token
read -p "Do you want to set up your GitHub PAT now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "📖 Instructions:"
    echo "1. Visit: https://github.com/settings/tokens/new"
    echo "2. Name: 'GitHub Topics Manager'"
    echo "3. Scopes: repo, public_repo"
    echo "4. Generate and copy token"
    echo ""
    read -p "Paste your GitHub PAT: " PAT
    
    if [ -z "$PAT" ]; then
        echo -e "${YELLOW}⚠️  No PAT provided. You can add it later.${NC}"
    else
        # Test the token
        echo ""
        echo "🔐 Testing authentication..."
        if python3 -c "from github import Github; g = Github('$PAT'); u = g.get_user(); print(f'✅ Authenticated as: {u.name}'); print(f'✅ Repos: {u.public_repos}')" 2>/dev/null; then
            
            # Save to .bashrc/.zshrc
            SHELL_RC=""
            if [ -f ~/.bashrc ]; then
                SHELL_RC=~/.bashrc
            elif [ -f ~/.zshrc ]; then
                SHELL_RC=~/.zshrc
            fi
            
            if [ -n "$SHELL_RC" ]; then
                read -p "Save PAT to $SHELL_RC? (y/n) " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    echo "" >> $SHELL_RC
                    echo "# GitHub Topics Manager Token" >> $SHELL_RC
                    echo "export GITHUB_PAT='$PAT'" >> $SHELL_RC
                    echo -e "${GREEN}✅ Saved to $SHELL_RC${NC}"
                    echo "   Run: source $SHELL_RC"
                fi
            fi
            
            # Export for current session
            export GITHUB_PAT=$PAT
            
            # Offer to run dry run
            echo ""
            read -p "Run dry run now? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                echo ""
                python3 scripts/add-github-topics.py --token $GITHUB_PAT --dry-run --verbose
            fi
        else
            echo -e "${RED}❌ Authentication failed. Check your PAT.${NC}"
        fi
    fi
fi

echo ""
echo "🎉 Ready to add topics to your repositories!"
