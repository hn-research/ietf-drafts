#!/bin/bash
# VSCode Extensions for RFCXML Development
# Run this script to install all required extensions

echo "Installing VSCode extensions for RFCXML development..."

# 1. Red Hat XML - Essential for RFCXML validation and auto-complete
code --install-extension redhat.vscode-xml

# 2. Live Preview - Auto-refresh HTML preview
code --install-extension ms-vscode.live-server

# 3. Save and Run - Auto-run commands on save (optional but useful)
code --install-extension wk-j.save-and-run

# 4. File Watcher - Alternative to Save and Run
code --install-extension appulate.filewatcher

# 5. XML Tools - Additional XML formatting (optional)
code --install-extension DotJoshJohnson.xml

echo ""
echo " All extensions installed!"
echo ""
echo "Extensions installed:"
echo "  1. Red Hat XML Language Support"
echo "  2. Live Preview" 
echo "  3. Save and Run"
echo "  4. File Watcher"
echo "  5. XML Tools"
echo ""
echo "Restart VSCode to activate all extensions."
