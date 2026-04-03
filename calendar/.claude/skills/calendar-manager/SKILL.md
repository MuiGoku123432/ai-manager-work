---
name: calendar-manager
description: Use when someone asks to check their calendar, see today's schedule, add an event, create a reminder, find free time, reschedule something, mark a reminder done, or manage their Apple Calendar or Apple Reminders.
argument-hint: [command] [details]
---

## What This Skill Does

Manages Apple Calendar events and Apple Reminders via osascript (AppleScript). Provides a conversational interface for viewing, creating, and managing schedule items.

## Commands

### `today` -- Today's snapshot
Show all events and due reminders for today.

```bash
osascript -e '
tell application "Calendar"
    set today to current date
    set time of today to 0
    set tomorrow to today + (1 * days)
    set output to ""
    repeat with cal in calendars
        set evts to (every event of cal whose start date >= today and start date < tomorrow)
        repeat with evt in evts
            set output to output & (start date of evt) & " | " & (summary of evt) & " | " & (name of cal) & linefeed
        end repeat
    end repeat
    return output
end tell'
```

```bash
osascript -e '
tell application "Reminders"
    set today to current date
    set time of today to 0
    set tomorrow to today + (1 * days)
    set output to ""
    repeat with reminderList in lists
        set dueItems to (every reminder of reminderList whose completed is false and due date >= today and due date < tomorrow)
        repeat with r in dueItems
            set output to output & (name of r) & " | " & (name of reminderList) & " | due: " & (due date of r) & linefeed
        end repeat
    end repeat
    return output
end tell'
```

Present results as a clean table:

| Time | Event/Reminder | Calendar/List |
|------|---------------|---------------|

### `week` -- Weekly overview
Same approach but set the date range to Monday through Sunday of the current week. Group by day.

### `upcoming` -- Next 7 days
Set range from today to today + 7 days. Include both events and reminders.

### `add event <details>` -- Create a calendar event

Parse the user's natural language for:
- **Title** (required)
- **Date** (required -- parse "tomorrow", "next Tuesday", "June 15", etc.)
- **Start time** (required)
- **End time** (optional, default 1 hour after start)
- **Calendar** (optional, default to first calendar)
- **Location** (optional)
- **Notes** (optional)

Confirm details with the user before executing:

```bash
osascript -e '
tell application "Calendar"
    tell calendar "<calendar_name>"
        make new event with properties {summary:"<title>", start date:date "<date_string>", end date:date "<date_string>", location:"<location>"}
    end tell
end tell'
```

Date string format for osascript: `"Monday, January 1, 2026 at 2:00:00 PM"`

### `add reminder <details>` -- Create a reminder

Parse for:
- **Title** (required)
- **Due date** (optional)
- **List** (optional, default to first list or "Reminders")
- **Priority** (optional: low, medium, high)
- **Notes** (optional)

```bash
osascript -e '
tell application "Reminders"
    tell list "<list_name>"
        make new reminder with properties {name:"<title>", due date:date "<date_string>", body:"<notes>"}
    end tell
end tell'
```

### `free` -- Find free time blocks

1. Pull all events for the target day(s)
2. Define working hours (8 AM - 6 PM CST by default)
3. Calculate gaps between events
4. Present free blocks:

| Day | Free Block | Duration |
|-----|-----------|----------|
| Monday | 8:00 AM - 10:00 AM | 2h |

### `move <event> to <time>` -- Reschedule

1. Search for the event by name
2. Confirm the match with the user
3. Update start and end dates:

```bash
osascript -e '
tell application "Calendar"
    repeat with cal in calendars
        set evts to (every event of cal whose summary is "<event_name>")
        repeat with evt in evts
            set start date of evt to date "<new_start>"
            set end date of evt to date "<new_end>"
        end repeat
    end repeat
end tell'
```

### `done <reminder>` -- Complete a reminder

1. Search for the reminder by name
2. Confirm the match
3. Mark complete:

```bash
osascript -e '
tell application "Reminders"
    repeat with reminderList in lists
        set matches to (every reminder of reminderList whose name contains "<search>")
        repeat with r in matches
            set completed of r to true
        end repeat
    end repeat
end tell'
```

### `list reminders [list]` -- Show reminders

Show all incomplete reminders, optionally filtered by list name.

```bash
osascript -e '
tell application "Reminders"
    set output to ""
    repeat with reminderList in lists
        set items to (every reminder of reminderList whose completed is false)
        repeat with r in items
            set dueStr to ""
            try
                set dueStr to due date of r as string
            end try
            set output to output & (name of r) & " | " & (name of reminderList) & " | " & dueStr & linefeed
        end repeat
    end repeat
    return output
end tell'
```

## Execution Rules

1. **Always confirm before creating or modifying** -- show the user what you're about to do and get approval
2. **Parse dates intelligently** -- handle "tomorrow", "next Friday", "June 15 at 3pm", etc. Convert to osascript date format
3. **Handle errors gracefully** -- if Calendar or Reminders isn't accessible, tell the user to grant automation permissions
4. **Use quoted form of** for any user-provided strings to prevent injection
5. **Default timezone is CST** -- Connor's timezone
6. **Working hours: 8 AM - 6 PM** unless told otherwise

## Security

- Never execute raw user-provided AppleScript
- Always use the specific patterns above, interpolating only validated values
- Sanitize all string inputs (escape quotes and backslashes)
- If a script fails with a permissions error, instruct the user to go to System Settings > Privacy & Security > Automation and grant access

## Notes

- First run will trigger a macOS permission prompt. The user needs to approve it once.
- Calendar names and reminder list names are case-sensitive in AppleScript
- If the user asks to "set a task" or "add a task", treat it as `add reminder` unless they specifically say "calendar event"
- When creating reminders for Obsidian-tracked projects, mention that the task should also be added to the project note in the vault
