# my-skills

Скиллы для Claude Code в `.claude/skills/`:

- `apple-design` — emilkowalski/skill
- `ui-ux-pro-max` — nextlevelbuilder/ui-ux-pro-max-skill
- `impeccable` — pbakaus/impeccable
- `taste-skill` — Leonxlnx/taste-skill
- `playwright-skill` — lackeyjb/playwright-skill (перед использованием: `cd .claude/skills/playwright-skill && npm install`)
- `humanizer` — blader/humanizer
- `stop-slop` — hardikpandya/stop-slop

Чтобы скиллы работали в любом проекте, скопируйте их в `~/.claude/skills/`:

```sh
git clone https://github.com/BOlga-mur/my-skills /tmp/my-skills && mkdir -p ~/.claude/skills && cp -r /tmp/my-skills/.claude/skills/* ~/.claude/skills/
```

Для облачных сессий Claude Code: вставьте содержимое `setup.sh` в Setup script окружения.
