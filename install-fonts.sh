#!/bin/bash

set -e

FONT_DIR="$HOME/.local/share/fonts"
FONT_FILE="MesloLGLDZNerdFontMono-Regular"
FONT_REPO="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
#FONT_REPO="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip"

mkdir -p "$FONT_DIR"
cd $FONT_DIR 

#if fc-list | grep -qi "MesloLGLDZNerdFontMono-Regular"; then
#  echo "Meslo Nerd Font is already installed. Skipping download"
#
if fc-list |grep -i "JetBrainsMonoNLNerdFont-Regular"; then
  echo "JetBrainsMonoNLNerdFont is already installed. Skipping download"
else
  echo "Installing JetBrains Mono Nerd Font..."
  curl -fL -o "downloaded_font.zip" $FONT_REPO
  unzip downloaded_font.zip 
  rm downloaded_font.zip
fi

fc-cache -f -v >/dev/null;
echo -e "Font installation complete. #\ue0b0 \ueE0A0 \u26A1 \ufb8a \uf121 \uf306  \e[1;38;5;199;49m\ue0b6\e[00m"

# Verification function
verify_fonts() {
    echo -e "\nFont verification:"

    # Check Meslo installation
    if fc-list | grep -qi "MesloLGLDZNerdFontMono-Regular"; then
        echo "✓ Meslo Nerd Font is installed"
    else
        echo "✗ Meslo Nerd Font not found!"
    fi

    # Check JetBrainsMonoNerdFont installation
    if fc-list | grep -qi "JetBrainsMonoNLNerdFont-Regular"; then
        echo "✓ JetBrains Mono Nerd Font is installed"
    else
        echo "✗ JetBrains Mono Nerd Font not found!"
    fi

    # Check Powerline symbols
    # if [ -f "$FONT_DIR/$POWERLINE_FILE" ]; then
    #     echo "✓ Powerline Extra Symbols are installed"
    # else
    #     echo "✗ Powerline Extra Symbols not found!"
    # fi

    # Test symbol rendering
    echo -e "\nTest symbol rendering:"
    echo -e "Powerline: \uE0B0 \uE0B4 \uE0C8"
    echo -e "Nerd Font: \uF415 \uF7C2 \uE62B"
}

verify_fonts
