---
layout: post
title:  "interpretable vs. readable"
date:   2025-10-30 06:29:00 -0600
categories: ai
---

I recently discovered that people are using the word "interpretable" to
describe software.  Curious about this new usage of the word, I asked
GPT for some clarity and got:

~~~
Readable code is easy to read — that is, the syntax, structure, and
naming make it clear what the code is doing at a surface level.  It
emphasizes clarity.

Readability = syntactic and stylistic clarity.

Examples of what affects readability:
	Consistent indentation and formatting
	Clear variable and function names
	Logical ordering of code
	Minimal cognitive overhead to follow control flow
	Avoiding unnecessary cleverness or obfuscation

Readable code lets someone scan a function and follow the flow
without getting lost in syntax or naming confusion.

---

Interpretable code is easy to understand conceptually — that is,
someone can determine why it behaves the way it does, and what it
means in the larger context.  It emphasizes semantic clarity and
intent.

Interpretability = semantic and conceptual clarity.

Examples of what affects interpretability:
	Well-chosen abstractions that match domain concepts
	Meaningful architecture and decomposition
	Comments that explain why something is done, not what
	Code that aligns with expected mental models or business logic

Interpretable code lets someone understand the reasoning behind it
— not just follow its syntax.
~~~

I fundamentally disagree.  This definition of "interpretable" is
*exactly* what people have always meant by "readable".  Or, at
least, it is what I have always meant!  Are other people using the
word differently than I am?  Perhaps it is good to have this new
word which means exactly the same thing as the old word if
it provides clarity to new users, but redefining words
is dangerous.  If we redefine "readable" to only refer to the lexical
aspects of the code, we are essentially changing the meaning of
every book, article, and document written over the last several
decades.  Entering the query "knuth definition of readable" into
Google, the AI Overview gives:

~~~
Donald Knuth's definition of "readable" code is central to his
concept of literate programming, which he introduced in 1984. He
did not define "readability" in terms of specific coding conventions
(like indentation or naming styles), but rather as the overall
quality of a program that is structured and written primarily for
human understanding.  Key aspects of Knuth's view on readability:

**Human-Centered**: He famously stated, "Programs are meant to be read
by humans and only incidentally for computers to execute". The main
goal of a programmer should be clear communication to other people
(and their future selves).

**Narrative Flow**: A readable program, in Knuth's view, should be
presented as an essay or a literary work, with a logical and clear
narrative flow that explains the thought process and reasoning
behind the code, rather than just the mechanics.

**Integrated Documentation**: Readability is achieved by naturally
integrating extensive documentation (written in natural language)
with code snippets. This contrasts with traditional coding where
comments are often terse additions to a compiler-mandated structure.

**Comprehensible Order**: The program's components should be introduced
in an order that is best for human comprehension, not the linear
order required by the compiler. Tools (like his WEB system, which
used "tangle" to produce compilable code and "weave" to produce
documentation) manage the process of generating both the executable
program and the readable documentation from the same source file.

In essence, Knuth viewed a readable program as one that is an
excellent exposition of its own logic and design, written in a style
that emphasizes clarity, exposition, and excellence of style for
the human reader.
~~~

If we reduce the definition of "readable" to only apply to syntactic
and stylistic clarity, we dumb down every past article on the
subject and hamstring a generation's efforts to encourage readable
code.  The word "readable" means that a human can understand it easily,
and has always meant "interpretable".  Introducing the new
word hinders the discourse.
