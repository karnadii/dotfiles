#!/bin/bash

set -e

echo "Installing language servers and formatters for Helix..."

# Check if asdf is installed
if ! command -v asdf &> /dev/null; then
    echo "asdf is not installed. Please install asdf first."
    exit 1
fi

# Add plugins if not already added
echo "Adding asdf plugins..."

asdf plugin add dart || echo "dart plugin already added"
asdf plugin add nodejs || echo "nodejs plugin already added"
asdf plugin add golang || echo "golang plugin already added"
asdf plugin add python || echo "python plugin already added"

# Install latest versions
echo "Installing latest versions..."
asdf install dart latest
asdf install nodejs latest
asdf install golang latest
asdf install python latest

# Set global versions
asdf global dart latest
asdf global nodejs latest
asdf global golang latest
asdf global python latest

# Install Dart language server and tools
echo "Installing Dart tools..."
dart pub global activate dart_style
dart pub global activate dartdoc

# Install Node.js tools (TypeScript/JavaScript)
echo "Installing Node.js tools..."
npm install -g typescript typescript-language-server vscode-eslint-language-server prettier

# Install Go tools
echo "Installing Go tools..."
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest

# Install Python tools
echo "Installing Python tools..."
pip install python-lsp-server black
pip install 'python-lsp-server[all]'

# Install additional tools
echo "Installing additional tools..."
npm install -g @taplo/cli
npm install -g vscode-langservers-extracted
npm install -g yaml-language-server
npm install -g marksman

# Install bash language server
echo "Installing bash language server..."
npm install -g bash-language-server

# Install HTML/CSS language servers (included in vscode-langservers-extracted)
echo "HTML/CSS language servers are included in vscode-langservers-extracted"

echo "Installation complete!"
echo "Please restart Helix to load the new configuration."