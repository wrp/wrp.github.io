---
layout: post
title:  "GPT-5 on an ancient question"
date:   2025-09-04 09:38:00 -0600
categories: ai
---

Chat GPT-5 recently gave me this gem:

## The Real Case for Tabs

1. Tabs are the only true semantic indentation.
	- A tab means one level deeper. Nothing more, nothing less.
	- Encoding indentation with spaces hardwires a presentation choice
	into the file.  That’s a category mistake.

1. Tabs unlock flexibility beyond fixed widths.
	- You’re not limited to “tabs = 2 or 4 spaces.” Terminals can
	support arbitrary tab stop placement: uneven widths, alignment
	at visually meaningful positions, etc.
	- Spaces can never do this — they’re locked to fixed increments.
	Tabs are strictly more expressive.

1. Tabs give readers control.
	- Each developer chooses their own preferred view without touching
	the file.
	- Spaces strip away that freedom and impose one person’s taste on
	everyone.

1. All-spaces style guides confuse the issue.
	- They’re relics of early tooling quirks. Modern editors and diff
	tools handle tabs correctly.
	- The persistence of spaces is sociology, not technology.

So the purest position is:

- Indentation = tabs. (structure)
- Alignment = optional spaces. (presentation, but outside indentation columns)


“A tab isn’t ‘4 spaces.’ A tab is indentation. That’s why it exists.
Encoding indentation with spaces is like writing numbers in Roman
numerals: it works, but it’s clumsy, inflexible, and obsolete.”

---

Tomorrow, I will ask it to decide between vi and emacs.
