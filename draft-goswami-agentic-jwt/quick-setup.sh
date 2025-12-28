#!/bin/bash
# Quick Setup Script for RFCXML VSCode Workspace
# ===============================================

set -e  # Exit on error

echo " RFCXML VSCode Workspace Quick Setup"
echo "======================================"
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
DRAFT_NAME="draft-goswami-agentic-jwt"
VERSION="00"
PROJECT_DIR="$HOME/workspace/ietf-drafts/${DRAFT_NAME}"

echo -e "${BLUE}Configuration:${NC}"
echo "  Draft name: ${DRAFT_NAME}"
echo "  Version: ${VERSION}"
echo "  Project directory: ${PROJECT_DIR}"
echo ""

# Step 1: Create project directory
echo -e "${BLUE}Step 1: Creating project directory...${NC}"
mkdir -p "${PROJECT_DIR}"
cd "${PROJECT_DIR}"
echo -e "${GREEN} Directory created${NC}"
echo ""

# Step 2: Clone RFCXML templates (if not exists)
echo -e "${BLUE}Step 2: Checking RFCXML templates...${NC}"
if [ ! -d "rfcxml-templates-and-schemas" ]; then
    echo "  Cloning RFCXML templates..."
    git clone https://github.com/ietf-tools/rfcxml-templates-and-schemas.git
    echo -e "${GREEN} Templates cloned${NC}"
else
    echo -e "${GREEN} Templates already present${NC}"
fi
echo ""

# Step 3: Create .vscode directory
echo -e "${BLUE}Step 3: Creating .vscode directory...${NC}"
mkdir -p .vscode
echo -e "${GREEN} .vscode directory created${NC}"
echo ""

# Step 4: Copy starting template
echo -e "${BLUE}Step 4: Copying annotated template...${NC}"
if [ ! -f "${DRAFT_NAME}-${VERSION}.xml" ]; then
    cp rfcxml-templates-and-schemas/templates/draft-rfcxml-general-template-annotated-00.xml \
       "${DRAFT_NAME}-${VERSION}.xml"
    echo -e "${GREEN} Template copied to ${DRAFT_NAME}-${VERSION}.xml${NC}"
else
    echo -e "${GREEN} Draft file already exists${NC}"
fi
echo ""

# Step 5: Check xml2rfc
echo -e "${BLUE}Step 5: Checking xml2rfc installation...${NC}"
if command -v xml2rfc &> /dev/null; then
    XML2RFC_VERSION=$(xml2rfc --version 2>&1 | head -1)
    echo -e "${GREEN} xml2rfc found: ${XML2RFC_VERSION}${NC}"
else
    echo -e "${RED} xml2rfc not found${NC}"
    echo "  Installing xml2rfc..."
    pip install xml2rfc --break-system-packages
    echo -e "${GREEN} xml2rfc installed${NC}"
fi
echo ""

# Step 6: Create Makefile
echo -e "${BLUE}Step 6: Creating Makefile...${NC}"
cat > Makefile << 'EOF'
# Makefile for RFCXML I-Draft
DRAFT = draft-goswami-agentic-jwt
VERSION = 00
XML_SOURCE = $(DRAFT)-$(VERSION).xml
TXT_OUTPUT = $(DRAFT)-$(VERSION).txt
HTML_OUTPUT = $(DRAFT)-$(VERSION).html

.PHONY: all txt html watch clean

all: txt html

txt: $(TXT_OUTPUT)
html: $(HTML_OUTPUT)

$(TXT_OUTPUT): $(XML_SOURCE)
	@echo "Building TXT..."
	@xml2rfc $< --text -o $@
	@echo " TXT created: $@"

$(HTML_OUTPUT): $(XML_SOURCE)
	@echo "Building HTML..."
	@xml2rfc $< --html -o $@
	@echo " HTML created: $@"

watch:
	@echo "  Watching for changes..."
	@while true; do make html 2>/dev/null; sleep 2; done

clean:
	@rm -f $(TXT_OUTPUT) $(HTML_OUTPUT)
	@echo " Clean complete"
EOF
echo -e "${GREEN} Makefile created${NC}"
echo ""

# Step 7: Test build
echo -e "${BLUE}Step 7: Testing build...${NC}"
if make html 2>&1 | grep -q "HTML created"; then
    echo -e "${GREEN} Build test successful!${NC}"
else
    echo -e "${RED} Build test failed${NC}"
    echo "  Check xml2rfc installation"
fi
echo ""

# Final instructions
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN} Setup Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Your project is ready at:"
echo "  ${PROJECT_DIR}"
echo ""
echo "Next steps:"
echo "  1. cd ${PROJECT_DIR}"
echo "  2. code .  (open in VSCode)"
echo "  3. Install VSCode extensions (see guide)"
echo "  4. Copy .vscode config files"
echo "  5. Run: make watch"
echo "  6. Start editing ${DRAFT_NAME}-${VERSION}.xml"
echo ""
echo "Quick commands:"
echo "  make          - Build HTML + TXT"
echo "  make watch    - Auto-rebuild on changes"
echo "  make clean    - Remove generated files"
echo ""
echo "See VSCODE_RFCXML_SETUP_GUIDE.txt for detailed instructions"
echo ""
