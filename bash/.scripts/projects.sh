#!/bin/bash

FOLDER_NAME="workspaces"
PROJECTS_ROOT="$HOME/$FOLDER_NAME"

PROJECT=$(find $PROJECTS_ROOT -maxdepth 5 -path "*.git" | \
  sed -e "s|$PROJECTS_ROOT/||g" | \
  sed -e "s|/.git||g" | \
  fzf)

if [[ -n "$PROJECT" ]]; then
  PROJECT_FULL_PATH="$PROJECTS_ROOT/$PROJECT"
  clear
  cd "$PROJECT_FULL_PATH"
fi
