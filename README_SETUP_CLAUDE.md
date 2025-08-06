# Guide to setup Claude CLI on your local

Though you can read the official guide by reaching [this page provide by Anthropic](https://docs.anthropic.com/en/docs/claude-code/setup), you can also refer to the followings.

## System Requirements

- Operating Systems: macOS 10.15+, Ubuntu 20.04+/Debian 10+, or Windows 10+ (with WSL 1, WSL 2, or Git for Windows)    Hardware: 4GB+ RAM
- Software: Node.js 18+
- Network: Internet connection required for authentication and AI processing
- Shell: Works best in Bash, Zsh or Fish
- Location: Anthropic supported countries

## Standard Installation for macOS or Ubuntu

Please run the following command on your local machine.

```zsh
npm install -g @anthropic-ai/claude-code
```

After the installation process completes, navigate to your project and start Claude Code:

```zsh
cd your-awesome-project
claude
```

## Installation commands for Windows

Please refer to the official guide provided on the beginning of this page.

## How to use MCP server to use advanced functionalities of Claude

- Please setup `.claude/.mcp.json` file.
- It is not allowed to retrieve `.mcp.json` from the repo, thus please duplicate `.mcp.json.sample` and rename to `.mcp.json`.
- Before using the MCP server, please change ` "GITHUB_PERSONAL_ACCESS_TOKEN": "..."` to replace `...` with your Github PAT (PAT = Personal Access Token).
- You can generate your PAT via [this PAT setting page](https://github.com/settings/tokens).


## How to deny Claude run any dangerous commands

- Please setup `.claude/settings.json`
- Official guide is here: https://docs.anthropic.com/en/docs/claude-code/settings
