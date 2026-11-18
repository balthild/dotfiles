---
name: Writing
description: Guidelines for writing and maintaining comments or docs.
applyTo: "**"
---

## Purpose

Comments or internal docs carry the intent that code cannot express by itself: the reasons behind a decision, the constraints it respects, and the assumptions it depends on.

Unlike normal docs which are user-facing, internal docs are for developer or agents. For example, `README.md` is usually considered a normal doc, but `AGENTS.md` is an internal doc.

## Write a comment when

- The **reason** for the code is not visible in it: a trade-off, a rejected alternative, a business rule, or a compatibility constraint.
- The code is **surprising**: bit tricks, regular expressions, magic numbers, protocol quirks, or performance-motivated non-idiomatic code.
- The code is a **workaround**: explain the bug or limitation it works around and link to the issue that tracks its removal.
- The code defines a **public API**: document the contract — purpose, parameters, return value, thrown errors, side effects, and thread-safety — in the doc-comment format of the language (JSDoc/TSDoc, docstring, doc comment).
- A block is long enough that a reader needs a **signpost** to navigate it in editors (e.g. `// MARK: section name`, `# MARK: section name`, or `#pragma MARK - section name`). About how to use MARK sections, see "MARK sections" below.

## Do not write a comment when

- The code already says it. Do not narrate control flow or restate a statement in prose.
- A name, a type, or a test can carry the information instead. Prefer the rename.
- The information belongs to version history: no changelog entries, no author tags, no dates.
- The line is dead. Delete commented-out code rather than keeping it "just in case".
- The information is a **trivial design decision**: a specific look & feel or specific behavior of the product. When such decisions must be documented, state the purpose of the whole module once, at the natural place in modular, single-responsibility code, rather than annotating each fragment.

## Write an internal doc when

- The code has some engineering or architectural design need to be recorded and become a systematic constraint.
- The code interacts with an external condition (e.g. hardware, operating system, external services, etc.) and the knowledge of its mechanisms or behavior is required to understand the code.
- You have the reasons above to write a comment, but you want to write more detailed explanation that doesn't fit into a short comment.

## Do not write an internal doc when

- Describing knowledge about this developer's specific computer or environment, which is better to be put into memory. Exception: when a personal environment represents a certain type of situation concerned by the project, it becomes project-level knowledge after stripping personal info.

## Style

- Prefer few concise, simple, and clear sentences over long paragraph. You are not to write thesis with advanced grammar to charm your english teacher, but to deliver information efficiently.
- Joining multiple sentences into one with `;` is **strongly discourged**, unless the sentences cant express its desired meaning if kept separate.
- Keep line comments on their own line above the code they describe, never trailing a statement, except for short annotations on data or configuration entries.
- Match the surrounding file's language for prose comments; keep identifiers, paths, and error messages in the language they appear in the code.
- Mark unfinished work with a scannable tag and a reason: `TODO:`, `FIXME:`, `NOTE:`, `HACK:`. Prefer a tracking reference over a bare tag.

## MARK sections

Group code by **responsibility**, never by length: do not split or merge sections merely to make them shorter or longer.

- Keep each section **cohesive**: its contents should be logically related or similar in purpose.
- A single function may deserve its own section. If it shares no purpose with the surrounding sections, do not merge it into a neighbor for being short — that mixes unrelated code and defeats the signpost.
- Do not split one responsibility across sections to balance their sizes.

## Maintenance

- Update or delete comments or docs in the same change that makes it inaccurate. A stale text is a defect: it misleads more than a missing one.
- Keep public doc comments in sync with the signature, and remove them when a symbol stops being public.
- Treat comment accuracy as a review concern, on par with the code around it.
