# Scaffold Recipes

Directory and file patterns for each W2 project type. Used by `/project-init scaffold` to create the correct structure.

---

## Recipe 1: Standard W2 Project

Use for any W2 engineering project not involving Crush tooling.

**Creates:**
- `projects/<name>/README.md` in the Git repo
- `vault/30-Projects/<Title>.md` in the vault

**Git repo README.md template:**
```markdown
# <Project Title>

<One-sentence description of what this project is and what it produces.>

**Status:** Active
**Employer:** Lockheed Martin / Windstream
**Start Date:** YYYY-MM-DD
**Target Date:** YYYY-MM-DD
**Area:** <career | engineering | learning>

## Key Dates
| Milestone | Date | Notes |
|-----------|------|-------|
| Project start | YYYY-MM-DD | |
| Phase 1 complete | YYYY-MM-DD | |
| Done | YYYY-MM-DD | |

## Related
- Vault: `vault/30-Projects/<Title>.md`
```

**Vault note:** Use Variant 1 from `project-note-template.md`.

---

## Recipe 2: Crush Skill Project

Use when building a new Crush skill for the `.crush/skills/` directory.

**Creates:**
- `projects/<name>/README.md` in the Git repo (optional, skip if minor)
- `vault/30-Projects/<Title>.md` in the vault (Variant 2)
- `.crush/skills/<skill-name>/SKILL.md`
- `.crush/skills/<skill-name>/references/.gitkeep` (if references will be needed)

**Skill scaffold:**
```
.crush/skills/<skill-name>/
  SKILL.md
  references/           (create only if references will be needed)
```

After scaffold, run `/skill-builder audit <name>` to verify quality.

Then update `AGENTS.md` -- add the new skill to the Available Skills table.

**Post-scaffold checklist for skill projects:**
- [ ] SKILL.md created and passes quality gates (see `/skill-builder audit`)
- [ ] References directory created if needed
- [ ] AGENTS.md updated with new skill entry
- [ ] Vault project note created
- [ ] `decisions/log.md` updated

---

## Recipe 3: Research Project

Use when the project is primarily an investigation or knowledge-building exercise.

**Creates:**
- `projects/<topic-slug>/` -- full research project structure (via `/recursive-research start`)
- `vault/30-Projects/<Title>.md` in the vault (Variant 1)

**Research project structure (created by `/recursive-research start`):**
```
projects/<topic-slug>/
  program.md
  wiki/
    index.md
  reports/
  sources/
  results.md
  README.md
```

---

## Post-Scaffold Checklist (All Recipes)

After creating the project files, verify and complete:

- [ ] Git repo `projects/<name>/README.md` created
- [ ] Vault `vault/30-Projects/<Title>.md` created with correct frontmatter
- [ ] Parent area note linked -- read-modify-write to append `[[<Title>]]` in Active Projects section of `vault/20-Areas/<Area>.md`
- [ ] Relevant MOC in `vault/70-Atlas/` updated (or created if none exists)
- [ ] Relationship metadata added to vault note (`depends-on`, `feeds-into`, `supports` as applicable)
- [ ] `decisions/log.md` updated with project creation entry

---

## Naming Conventions

| Item | Convention | Example |
|------|-----------|---------|
| Git repo folder | kebab-case | `feature-migration-api` |
| Vault project note | Title Case | `Feature Migration API.md` |
| Crush skill folder | kebab-case | `second-brain` |
| Skill name (in AGENTS.md) | kebab-case with slash | `/second-brain` |
| Research slug | kebab-case | `graphql-vs-rest` |
