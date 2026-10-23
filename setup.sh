#!/bin/bash
# Устанавливает скиллы из BOlga-mur/my-skills в ~/.claude/skills
SRC=""
for d in /home/user/my-skills "$HOME/my-skills"; do
  [ -d "$d/.claude/skills" ] && SRC="$d" && break
done
if [ -z "$SRC" ]; then
  SRC="$(mktemp -d)/my-skills"
  git clone --depth 1 https://github.com/BOlga-mur/my-skills "$SRC" || { echo "my-skills: clone failed"; exit 0; }
fi
mkdir -p "$HOME/.claude/skills"
cp -r "$SRC"/.claude/skills/* "$HOME/.claude/skills/"
(cd "$HOME/.claude/skills/playwright-skill" && npm install --silent) || true
