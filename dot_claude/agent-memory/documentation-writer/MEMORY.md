# Documentation Writer Memory

## ~/scripts/ README Style (confirmed across archmaint, gitstatus, pkgsync)

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

## File locations

- READMEs live alongside the script in each tool's subdirectory under `~/scripts/`
- No separate `/docs` directory; all documentation is inline or in the per-tool README
