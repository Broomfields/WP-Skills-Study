# WP-Skills-Study

A project for studying different writing skills and techniques, to better my own writing.

---

## Structure

```
WP-Skills-Study/
├── _dashboard.md           — Dataview dashboard (open in Obsidian)
├── _templates/
│   └── _skill.md           — Master template for new skill files
├── new-skill.sh            — Script to scaffold a new skill file
├── character_writing/      — Skills related to writing characters
├── prose_techniques/       — Skills related to prose and sentence craft
└── story_writing/          — Skills related to narrative and structure
```

## Adding a New Skill

Run the script from the repo root:

```bash
./new-skill.sh "Skill Name" <category>
```

**Categories:**
- `character-writing`
- `prose-techniques`
- `story-writing`

**Example:**
```bash
./new-skill.sh "Free Indirect Discourse" story-writing
```

This creates a pre-filled skill file in the correct folder, ready to study.

---

## Skill Statuses

| Status | Meaning |
| ------ | ------- |
| `not-started` | Aware of the skill, haven't studied it yet |
| `researching` | Actively reading and learning what it is |
| `practicing` | Applying it in writing experiments |
| `proficient` | Confident using it; may revisit to deepen |

---

## Linking to Author Study

When you observe a skill in an author's work, add their folder name to the `seen_in_authors` field in the skill file. This populates the Author Cross-Reference section of the dashboard automatically.

```yaml
seen_in_authors: [casualfarmer, pirateaba]
```
