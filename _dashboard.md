---
category: "dashboard"
tags: [dashboard, dataview, skills-study]
last_updated: "2026-03-01"
---

# Skills Study — Dashboard

*Dataview-powered overview of writing skills progress.*

---

## At a Glance

```dataviewjs
const skills = dv.pages('"WP-Skills-Study"').where(p => p.category && p.category !== "dashboard");

const count = (pages, s) => pages.where(p => p.status === s).length;

const total      = skills.length;
const notStarted = count(skills, "not-started");
const researching = count(skills, "researching");
const practicing  = count(skills, "practicing");
const proficient  = count(skills, "proficient");

dv.paragraph(
  `⬜ Not Started: **${notStarted}**  ·  ` +
  `🔍 Researching: **${researching}**  ·  ` +
  `✍️ Practicing: **${practicing}**  ·  ` +
  `✅ Proficient: **${proficient}**  ·  ` +
  `**${total} total**`
);
```

---

## Currently Practicing

```dataview
TABLE skill AS "Skill", category AS "Category", priority AS "Priority", seen_in_authors AS "Authors"
FROM "WP-Skills-Study"
WHERE status = "practicing"
SORT priority DESC, skill ASC
```

---

## Priority Queue

*High-priority skills not yet started.*

```dataview
TABLE skill AS "Skill", category AS "Category"
FROM "WP-Skills-Study"
WHERE status = "not-started" AND priority = "high"
SORT category ASC, skill ASC
```

---

## Skills by Category

### Character Writing

```dataview
TABLE skill AS "Skill", status AS "Status", priority AS "Priority", seen_in_authors AS "Seen In"
FROM "WP-Skills-Study/character_writing"
WHERE category = "character-writing"
SORT file.name ASC
```

### Prose Techniques

```dataview
TABLE skill AS "Skill", status AS "Status", priority AS "Priority", seen_in_authors AS "Seen In"
FROM "WP-Skills-Study/prose_techniques"
WHERE category = "prose-techniques"
SORT file.name ASC
```

### Story Writing

```dataview
TABLE skill AS "Skill", status AS "Status", priority AS "Priority", seen_in_authors AS "Seen In"
FROM "WP-Skills-Study/story_writing"
WHERE category = "story-writing"
SORT file.name ASC
```

---

## Author Cross-Reference

*Which skills have been observed in which authors. Update `seen_in_authors` in any skill file to populate this.*

```dataviewjs
const skills = dv.pages('"WP-Skills-Study"')
  .where(p => p.seen_in_authors && p.seen_in_authors.length > 0);

if (skills.length === 0) {
  dv.paragraph("*No author cross-references recorded yet. Add author names to the `seen_in_authors` field in any skill file.*");
} else {
  const authorMap = {};
  for (const skill of skills) {
    for (const author of skill.seen_in_authors) {
      if (!authorMap[author]) authorMap[author] = [];
      authorMap[author].push(skill.skill);
    }
  }
  const rows = Object.entries(authorMap)
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([author, skillList]) => [author, skillList.join(", ")]);

  dv.table(["Author", "Skills Observed"], rows);
}
```

---

## Full Skills Overview

```dataview
TABLE skill AS "Skill", category AS "Category", status AS "Status", priority AS "Priority"
FROM "WP-Skills-Study"
WHERE category != "dashboard"
SORT category ASC, file.name ASC
```
