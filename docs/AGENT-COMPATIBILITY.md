---
type: reference
description: Per-agent compatibility matrix and platform-specific guidance for using Agent Council skills.
---

# Agent Compatibility

Agent Council skills are structured markdown workflows. Any AI coding agent that can read files and follow instructions can use them — the level of automation depends on the agent's capabilities.

## Feature Matrix

| Feature | Claude Code | Cursor | Codex CLI | GitHub Copilot | Aider | Other |
|---------|:-----------:|:------:|:---------:|:--------------:|:-----:|:-----:|
| Slash command invocation | Yes | No | No | No | No | No |
| Task subagent spawning | Yes | No | No | No | No | No |
| Parallel council evaluation | Yes | No | No | No | No | No |
| Checkpoint pausing | Yes | Partial | No | No | No | No |
| Model selection per agent | Yes | No | No | No | No | No |
| GitHub CLI integration | Yes | Partial | Partial | Partial | Partial | Varies |
| File reading and editing | Yes | Yes | Yes | Yes | Yes | Varies |
| Multi-file changes | Yes | Yes | Yes | Yes | Yes | Varies |

### Legend

- **Yes** — Feature works natively with no workarounds
- **Partial** — Feature works with manual steps or workarounds
- **No** — Feature is not supported; must be done manually
- **Varies** — Depends on the specific agent and configuration

## Per-Agent Guidance

### Claude Code (Full Support)

Claude Code provides native support for Agent Council skills. All features work out of the box.

**Setup**:

```bash
npx skills add andrewvaughan/agent-council
```

**Usage**:

- Invoke skills as slash commands: `/plan-feature`, `/build-feature`, `/review-code`, `/submit-pr`
- Council members run in parallel via Task subagents
- Checkpoints pause for user approval automatically
- Model selection follows the `## Model` section in each agent definition

**Tips**:

- Use `/plan-feature <description>` to start a new feature
- Use `/build-feature #<issue-number>` to implement from a GitHub issue
- Skills chain naturally — each suggests the next step when done

### Cursor (Partial Support)

Cursor can follow skill workflows by reading SKILL.md files as context, but lacks native slash command support and Task subagents.

**Setup**:

1. Install the package: `npx skills add andrewvaughan/agent-council`
2. Point Cursor to `AGENTS.md` as project context

**Usage**:

1. Open the relevant `skills/<skill-name>/SKILL.md` file
2. Tell Cursor: "Follow the workflow in this file"
3. At checkpoints, Cursor will present its work for your review
4. For council steps, ask Cursor to evaluate from each member's perspective sequentially

**Limitations**:

- Council members evaluate sequentially, not in parallel
- No automatic model selection — Cursor uses its configured model for all agents
- Slash command invocation not supported — reference skill files directly
- GitHub CLI commands may need to be run manually in the terminal

**Workarounds**:

- For council evaluation, prompt: "Now evaluate this as the Security Engineer, focusing on [their focus areas]"
- Copy checkpoint output to review before approving continuation
- Run `gh` commands in Cursor's integrated terminal

### Codex CLI (Partial Support)

Codex CLI can reference AGENTS.md and follow skill workflows step by step.

**Setup**:

1. Install the package: `npx skills add andrewvaughan/agent-council`
2. Reference AGENTS.md in your Codex configuration

**Usage**:

1. Tell Codex to read `skills/<skill-name>/SKILL.md`
2. Follow the workflow steps, running commands as needed
3. At council steps, ask Codex to evaluate from each agent's perspective

**Limitations**:

- No slash command support
- No Task subagents — council evaluation is sequential
- No checkpoint pausing — you must manage the flow manually
- Model selection not supported

### GitHub Copilot (Partial Support)

Copilot can assist with individual steps but cannot orchestrate full workflows autonomously.

**Setup**:

1. Install the package: `npx skills add andrewvaughan/agent-council`
2. Reference skill workflows in Copilot Chat

**Usage**:

1. Open a SKILL.md file and ask Copilot to help follow the steps
2. Use Copilot Chat for council-style evaluation by prompting with specific agent perspectives
3. Run GitHub CLI commands in the terminal

**Limitations**:

- Cannot orchestrate multi-step workflows autonomously
- No subagent spawning for parallel council evaluation
- No persistent context between steps — may need to re-reference the workflow
- Limited file creation and editing compared to Claude Code

### Aider (Partial Support)

Aider can read and edit files following skill workflow instructions.

**Setup**:

1. Install the package: `npx skills add andrewvaughan/agent-council`
2. Add AGENTS.md and the relevant SKILL.md to Aider's context

**Usage**:

1. Add the skill file: `/add skills/<skill-name>/SKILL.md`
2. Ask Aider to follow the workflow
3. At council steps, prompt for each agent's perspective

**Limitations**:

- No slash command support
- Sequential council evaluation only
- No checkpoint pausing — manage flow manually
- Model selection not supported natively (uses configured model)

### Other Agents

Any agent that can read markdown files and follow structured instructions can use Agent Council skills. The general approach:

1. Load the SKILL.md file for the desired workflow
2. Follow the numbered steps in order
3. At council steps, evaluate from each listed agent's perspective using the agent definitions in the `agents/` subdirectory
4. At checkpoints, pause and present work for review
5. Run shell commands (`git`, `gh`, etc.) as needed

The more capable the agent (file editing, command execution, context retention), the more automated the experience.

## Reporting Compatibility Findings

If you test Agent Council skills with an agent not listed here, or discover new workarounds for listed agents, please report your findings:

1. Open an [Agent Compatibility Report](https://github.com/andrewvaughan/agent-council/issues/new?template=agent-compatibility.yml) issue
2. Describe which agent and version you tested
3. Note what worked, what didn't, and any workarounds you found

Community compatibility reports help improve the documentation and identify opportunities for better cross-agent support.
