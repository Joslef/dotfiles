# Documentation Writer Memory

## ~/scripts/ README Style (confirmed across archmaint, gitstatus, pkgsync, dotfiles)

- **Title**: `# <emoji> toolname` — one emoji, lowercase tool name
- **Tagline**: single sentence immediately under the title, no heading
- **Features** (`## ✨ Features`): bullet list, each entry: `<emoji> **Bold Label** — em-dash description`
- **Usage** (`## 🚀 Usage`): bash code blocks; show interactive invocation first, then flags/modes
- **Menu Options** (`## 📋 Menu Options`): markdown table with Option | Action columns; options in backtick code spans
- **Dependencies** (`## 📦 Dependencies`): flat bullet list; note which are optional and what falls back to what
- **Installation** (`## 🔧 Installation`): bash code block with `cp` + `chmod +x`; add any auth/setup steps needed before first run
- **Requirements** (`## 🖥️ Requirements`): short bullet list: OS, shell version, any runtime constraints
- **Tone**: direct, present tense, active voice; concise but complete
- **Emojis on all `##` section headings** — match the emoji semantics of the other READMEs
- **Service/tool tables**: columns are Service | Description | Link; bold the tool name inside the Description cell using `**Name** — em-dash description` pattern

## File locations

- READMEs live alongside the script in each tool's subdirectory under `~/scripts/`
- No separate `/docs` directory; all documentation is inline or in the per-tool README

## chezmoi dotfiles repo

- Directory naming conventions: `dot_` prefix maps to `.` prefix, `private_` prefix means restricted permissions (0600/0700)
- `.chezmoiignore` uses Go templates for OS-conditional deployment (`{{ if ne .chezmoi.os "linux" }}`)
- Fish shell is macOS-only in this setup (excluded on Linux via `.chezmoiignore`)
