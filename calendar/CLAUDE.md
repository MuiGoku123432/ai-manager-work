# Calendar & Reminders

Calendar and reminder management domain powered by macOS AppleScript automation. Manages Apple Calendar events and Apple Reminders tasks directly from Claude Code.

## Prerequisites

- macOS with Calendar.app and Reminders.app
- Automation permissions granted to Terminal/iTerm/ghostty for Calendar and Reminders (macOS will prompt on first use)

## Available Skills

### `/calendar-manager`

Interactive calendar and reminders manager with subcommands:

| Command | Purpose |
|---------|---------|
| `today` | Show today's events and due reminders |
| `week` | Show this week's schedule overview |
| `add event <details>` | Create a calendar event |
| `add reminder <details>` | Create a reminder with optional due date |
| `upcoming` | Show next 7 days of events and reminders |
| `free` | Find free time blocks today or this week |
| `move <event> to <time>` | Reschedule a calendar event |
| `done <reminder>` | Mark a reminder as complete |
| `list reminders [list]` | Show all reminders, optionally filtered by list |

Use without a subcommand for automatic routing based on your question.

### `/applescript`

Low-level AppleScript automation skill. Used as a foundation by calendar-manager. Not typically invoked directly unless you need custom macOS automation.

## Usage Guidance

- **Quick check**: Run `/calendar-manager today` for a daily snapshot
- **Planning**: Run `/calendar-manager week` to see the full week
- **Task capture**: Run `/calendar-manager add reminder` to quickly capture tasks
- **Scheduling**: Run `/calendar-manager free` to find open slots
