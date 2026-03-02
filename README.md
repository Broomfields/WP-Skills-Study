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
./new-skill.sh
```

The script will prompt you for a skill title, then present a numbered list of existing categories to choose from. You can also enter `n` to create a new category on the fly.

```
Skill title: Free Indirect Discourse

Available categories:
  1) character_writing
  2) prose_techniques
  3) story_writing
  n) New category

Select category [1-3 or n]: 2

✓ Created: prose_techniques/05_free_indirect_discourse.md
```

Files are automatically assigned the next numeric prefix in the chosen category (e.g. if `01`, `02`, `03` already exist, the new file will be `04`). If the category is empty or new, it starts at `01`.

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