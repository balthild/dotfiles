---
name: Comment
description: Guidelines for writing and maintaining code comments.
applyTo: "**"
---

# Comment Instructions

## Purpose

Comments carry the intent that code cannot express by itself: the reasons behind a decision, the constraints it respects, and the assumptions it depends on. Every comment exists to serve the readability, understandability, and maintainability of the code. Treat every comment as a maintenance obligation, not as a decoration.

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
- The information is a **trivial design decision**: the width of a UI element, how something looks, or a specific behavior of the product. When such behavior must be documented, state the purpose of the whole module once, at the natural place in modular, single-responsibility code, rather than annotating each fragment.

## Style

- Prefer one clear sentence over a paragraph. Delete the comment if you cannot make it shorter than the code it explains. Exception: when the code interacts with an external condition (e.g. the operating system) and knowledge of some of its mechanisms or behavior is required to understand the code, a longer comment explaining that external condition is allowed — but still state it as concisely as intelligibility permits.
- Keep line comments on their own line above the code they describe, never trailing a statement, except for short annotations on data or configuration entries.
- Match the surrounding file's language for prose comments; keep identifiers, paths, and error messages in the language they appear in the code.
- Mark unfinished work with a scannable tag and a reason: `TODO:`, `FIXME:`, `NOTE:`, `HACK:`. Prefer a tracking reference over a bare tag.

## MARK sections

Group code by **responsibility**, never by length: do not split or merge sections merely to make them shorter or longer.

- Keep each section **cohesive**: its contents should be logically related or similar in purpose.
- A single function may deserve its own section. If it shares no purpose with the surrounding sections, do not merge it into a neighbor for being short — that mixes unrelated code and defeats the signpost.
- Do not split one responsibility across sections to balance their sizes.

## Maintenance

- Update or delete a comment in the same change that makes it inaccurate. A stale comment is a defect: it misleads more than a missing one.
- Keep public doc comments in sync with the signature, and remove them when a symbol stops being public.
- Treat comment accuracy as a review concern, on par with the code around it.
