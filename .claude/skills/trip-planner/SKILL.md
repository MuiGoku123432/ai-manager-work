---
name: trip-planner
description: Use when someone asks to plan a trip, research a trail, build an overlanding itinerary, create a gear checklist, plan a camping or wilderness trip, or prepare for an overland adventure. Also triggers on specific trip names like Flat Tops.
argument-hint: [destination or trip name]
model: opus
---

## What This Skill Does

Plans overlanding and wilderness trips end-to-end. Researches trails, builds gear checklists, creates route notes, and saves everything to Obsidian. Designed for Connor's overlanding lifestyle and The Narrow Road content planning.

## Steps

### 1. Identify the Trip

If `$ARGUMENTS` is provided, use it as the destination or trip name. Otherwise, ask:
- Where are you going?
- What dates (or rough timeframe)?
- How many days?
- Solo or group?
- Any specific goals? (filming for The Narrow Road, training, relaxation, gospel conversations)

### 2. Research the Destination

Use WebSearch to gather:
- **Trail conditions** -- current road status, seasonal closures, difficulty ratings
- **Weather** -- forecast for the target dates, historical averages
- **Campsite options** -- dispersed camping, established sites, reservations needed
- **Points of interest** -- scenic stops, trailheads, landmarks, towns for resupply
- **Regulations** -- permits, fire restrictions, vehicle requirements
- **Cell coverage** -- carrier maps for the area

Present findings as a structured brief before proceeding.

### 3. Build the Route

Create a day-by-day itinerary:

| Day | Route | Miles | Camp | Notes |
|-----|-------|-------|------|-------|
| 1 | Start -> ... | XX | Site name | ... |

Include:
- Drive times and distances between stops
- Fuel stops (note distance between gas stations)
- Elevation changes and notable terrain
- Backup plans for weather or road closures

### 4. Gear Checklist

Generate a categorized gear checklist based on trip specifics:

**Categories:**
- Vehicle prep (fluids, tire pressure, recovery gear, spare parts)
- Camping (shelter, sleep system, cooking, water)
- Safety (first aid, comms, navigation, fire)
- Personal (clothing layers, toiletries, documents)
- Content gear (if filming: cameras, DJI Air 3S batteries, mounts, storage)
- Food and water (meal plan, water capacity, resupply points)

Mark items as required vs optional. Flag anything that needs purchasing or prep time.

### 5. Content Planning (if filming for The Narrow Road)

If the trip is for The Narrow Road content, add:
- Shot list per location (drone shots, POV driving, campfire, landscape)
- Episode theme and gospel angle
- Conversation prompts for intentional gospel discussions
- B-roll opportunities
- Audio notes (ambient sound, voiceover spots)

### 6. Save to Obsidian

Use the obsidian CLI to create the trip note in the vault:

```
obsidian create path="30-Projects/<Trip Name>.md" content="<full trip plan>"
```

Frontmatter:
```yaml
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - project/active
  - trip
status: active
area: overlanding
start-date: YYYY-MM-DD
target-date: YYYY-MM-DD
---
```

Include all sections: itinerary, gear checklist, route notes, content plan (if applicable).

### 7. Create Project Folder

Create a project folder in this repo if one doesn't exist:
- `projects/<trip-name>/README.md` with one-line description, status, key dates

### 8. Summary

Present the complete trip plan and confirm:
- Total distance and drive time
- Number of nights
- Key logistics to book or reserve
- Items to purchase
- Pre-trip vehicle prep needed
- Content deliverables (if filming)

## Output

- Obsidian note in `30-Projects/`
- Project folder in `projects/` (this repo)
- Structured summary in conversation

## Notes

- Always check trail conditions close to the trip date, not just during planning
- Flag anything that needs booking (campsite reservations, adventure parks, etc.)
- For winter/shoulder season trips, emphasize cold weather gear and vehicle prep
- If the Ram 2500 build is relevant to the trip (clearance, tires, recovery), note any dependencies
- Keep gear lists practical, not aspirational. Only list what Connor actually owns or plans to buy.
