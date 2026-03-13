#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_header() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect OS
detect_os() {
    case "$(uname -s)" in
        Linux*)     echo "linux";;
        Darwin*)    echo "macos";;
        MINGW*|MSYS*|CYGWIN*) echo "windows";;
        *)          echo "unknown";;
    esac
}

# Install mise
install_mise() {
    print_header "Setting up mise"

    if command_exists mise; then
        print_success "mise is already installed ($(mise --version))"
        return 0
    fi

    print_info "Installing mise..."

    local os=$(detect_os)

    if [ "$os" = "macos" ]; then
        if command_exists brew; then
            brew install mise
        else
            curl https://mise.run | sh
        fi
    elif [ "$os" = "linux" ]; then
        curl https://mise.run | sh

        # Add mise to PATH for current session
        export PATH="$HOME/.local/bin:$PATH"

        # Suggest shell integration
        print_warning "Please add the following to your shell configuration (~/.bashrc, ~/.zshrc, etc.):"
        echo ""
        echo "    eval \"\$(mise activate bash)\"  # for bash"
        echo "    eval \"\$(mise activate zsh)\"   # for zsh"
        echo ""
    else
        print_error "Unsupported OS: $os"
        print_info "Please install mise manually from https://mise.jdx.dev/"
        exit 1
    fi

    print_success "mise installed successfully"
}

# Install mise tools
install_mise_tools() {
    print_header "Installing mise tools"

    if ! command_exists mise; then
        print_error "mise is not available. Please restart your terminal or run: export PATH=\"\$HOME/.local/bin:\$PATH\""
        exit 1
    fi

    print_info "Installing tools from .mise.toml..."
    mise install

    print_success "mise tools installed successfully"

    # Show installed versions
    print_info "Installed versions:"
    mise list
}

# Install Aikido Safe Chain
install_safe_chain() {
    print_header "Setting up Aikido Safe Chain"

    # Check if safe-chain command exists
    if command_exists safe-chain; then
        print_success "Aikido Safe Chain is already installed"

        # Verify it's working
        if npm safe-chain-verify >/dev/null 2>&1; then
            print_success "Safe Chain is properly configured"
            return 0
        else
            print_warning "Safe Chain is installed but not configured properly"
        fi
    fi

    # Check if npm is available
    if ! command_exists npm; then
        print_error "npm is not available. Please install Node.js first or run 'mise install'"
        exit 1
    fi

    # Install Safe Chain globally
    print_info "Installing @aikidosec/safe-chain globally..."
    npm install -g @aikidosec/safe-chain

    print_success "Aikido Safe Chain installed successfully"

    # Setup shell integration
    print_info "Setting up shell integration..."
    safe-chain setup

    print_success "Shell integration configured"

    print_warning "Please restart your terminal for Safe Chain to take effect"
    print_info "After restart, run 'npm safe-chain-verify' to verify the installation"
}

# Install project dependencies
install_dependencies() {
    print_header "Installing project dependencies"

    if ! command_exists pnpm; then
        print_error "pnpm is not available. Please run 'mise install' first"
        exit 1
    fi

    print_info "Installing dependencies with pnpm..."
    pnpm install

    print_success "Dependencies installed successfully"
}

# Setup git hooks
setup_git_hooks() {
    print_header "Setting up Git hooks"

    if ! command_exists lefthook; then
        print_info "Installing lefthook..."
        pnpm add -D lefthook
    fi

    print_info "Installing Git hooks with lefthook..."
    pnpm exec lefthook install

    print_success "Git hooks installed successfully"
}

# Main setup flow
main() {
    print_header "Trip Planner Development Environment Setup"

    print_info "This script will set up your development environment with:"
    echo "  • mise (development tool version manager)"
    echo "  • Node.js and pnpm (from .mise.toml)"
    echo "  • Aikido Safe Chain (supply chain protection)"
    echo "  • Project dependencies"
    echo "  • Git hooks (lefthook)"
    echo ""

    # Check if we're in the project root
    if [ ! -f "package.json" ] || [ ! -f ".mise.toml" ]; then
        print_error "Please run this script from the project root directory"
        exit 1
    fi

    # Step 1: Install mise
    install_mise

    # Step 2: Install mise tools (Node.js, pnpm, etc.)
    install_mise_tools

    # Step 3: Install Aikido Safe Chain
    install_safe_chain

    # Step 4: Install project dependencies
    install_dependencies

    # Step 5: Setup git hooks
    setup_git_hooks

    # Final message
    print_header "Setup Complete!"

    print_success "Your development environment is ready!"
    echo ""
    print_info "Next steps:"
    echo "  1. Restart your terminal (or run: source ~/.zshrc or source ~/.bashrc)"
    echo "  2. Verify Safe Chain: npm safe-chain-verify"
    echo "  3. Start developing: pnpm dev"
    echo ""
    print_info "Useful commands:"
    echo "  • pnpm dev          - Start development server"
    echo "  • pnpm build        - Build the project"
    echo "  • pnpm lint         - Run linter"
    echo "  • pnpm type-check   - Check TypeScript types"
    echo "  • pnpm commit       - Interactive commit with commitlint"
    echo "  • mise list         - Show installed tool versions"
    echo ""
}

# Run main function
main "$@"
