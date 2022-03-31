---
layout: post
title:  "Do not use file name suffixes on executables"
date:   2022-03-31 10:45:00 -0500
github_comments_issueid: "3"
categories: blog
---

Lately have been thinking a little bit about the annoyance of seeing filename
extensions on executables. (eg, foo.sh vs the more sensible foo)   Discovered
this lovely article: https://www.talisman.org/~erlkonig/documents/commandname-extensions-considered-harmful/

I'll duplicate the bullet points here.  Doing this is bad because of:

* unnecessarily expose implementation detail (breaking encapsulation).
* uselessly and incompletely mimic detail from the #! line.
* capture insufficient detail to be useful at the system level (and aren't used).
* clash with recommended Unix (and Linux) practice.
* add noise to the command-level API.
* are very commonly technically incorrect for the script.
* give incorrect impressions about the use of the files they adorn.
* aren't validated even for what little info is present in them.
* interfere with switching scripting languages.
* interfere with changing scripting language versions.
* interfere with changing to presumably-faster compiled forms.
* encourage naïvely running scripts with the extension-implied interpreter.
* infect novice scripters with misinformation about Unix scripting.

