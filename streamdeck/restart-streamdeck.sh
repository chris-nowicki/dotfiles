#!/bin/bash

# Quit Stream Deck if it’s running
osascript -e 'tell application "Stream Deck" to quit'

# Wait a bit
sleep 3

# Re-open Stream Deck (adjust the path if your install is different)
open "/Applications/Elgato Stream Deck.app"
