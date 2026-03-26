---
name: Scripts README Style Guide
description: README style for ~/scripts tools — apply when writing or updating script documentation
type: feedback
---

Confirmed across archmaint, gitstatus, pkgsync, dotfiles READMEs:

- **Title**: `# <emoji> toolname` — one emoji, lowercase tool name
- **Tagline**: single sentence immediately under title, no heading
- **`## ✨ Features`**: bullet list, each entry: `<emoji> **Bold Label** — em-dash description`
- **`## 🚀 Usage`**: bash code blocks; interactive invocation first, then flags/modes
- **`## 📋 Menu Options`**: markdown table, columns: Option | Action; options in backtick code spans
- **`## 📦 Dependencies`**: flat bullet list; note optional deps and fallbacks
- **`## 🔧 Installation`**: bash code block with `cp` + `chmod +x`; add auth/setup steps before first run
- **`## 🖥️ Requirements`**: short bullet list: OS, shell version, runtime constraints
- **Tone**: direct, present tense, active voice; concise but complete
- **All `##` headings carry an emoji**
- **READMEs live alongside the script** in each tool's subdirectory under `~/scripts/` — no separate `/docs`
