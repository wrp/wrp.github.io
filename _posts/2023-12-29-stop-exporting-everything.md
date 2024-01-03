---
layout: post
title:  "Don't export it unnecessarily"
date:   2023-12-29 12:55:00 -0700
github_comments_issueid: "4"
categories: blog
---


There is a lot of really bad shell code out there.  Really, really bad.
I can't tell if it is because people have the attitude that "shell
isn't really a language, so there's no need to even try to make
it readable", or if it is because so much of the code that is written
is so bad that people say it's not a "real" language.  Fortunately,
determining which (if either or both) of those is true is not the purpose
of this post (rant?...are all my posts "rants"?)  I just want to address
some points on a piece of extremely common code.  Namely:

~~~~
export PATH=${PATH}:/new/entry/in/path
~~~~

Well, that's not really the code I want to talk about, but seeing that
on a website motivated me to this discussion.  But I'm going to address
2 points of that code first before wandering off.  First, don't do
that.  PATHs get cluttered enough with duplicate entries and various
nonsense, and failing to check if a path is already in the PATH
contributes to the problem. Second, there's no need for the "export".
In any reasonable environment, PATH is already exported, and there's no
need to do it again.  And that leads me to what I really want to write
about.

Don't export what you don't need to.

When someone writes code like:

~~~~
export SOME_VARIABLE=foo
cmd arg "$SOME_VARIABLE"
~~~~


it generally indicates that they have no idea what "export" actually does.
Is this variable only being set and used to pass an argument to `cmd`, or does
`cmd` actually check for SOME_VARIABLE in its environment?  By `export` ing the
variable, the programmer has effectively expanded the scope of the variable.
This is similar in spirit to taking a variable with a nice, small local scope
and putting it in the global address space.  Anyone reading this code has
to wonder how `cmd` (and all of the processes it might spawn) will use
SOME_VARIABLE from their environment.  It has cluttered up the environment,
probably unnecessarily.

The purpose of `export` is to put a variable into the environment of all
processes that will be spawned by the shell.  If the variable is just a shell
variable that is not intended to be used by subprocess, then it should not
be exported.  Also, there's no need to SHOUT.  Just write:

~~~~
some_variable=foo
cmd arg "$some_variable"
~~~~
