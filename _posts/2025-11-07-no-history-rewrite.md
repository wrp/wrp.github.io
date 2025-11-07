---
layout: post
title:  "History is never re-written"
date:   2025-11-07 03:54:21 -0700
categories: blog
---

Commits in git are immutable.  This is a fundamental feature of the tool.  The
oid of a commit (often referred to as the "hash" or the "sha" of the commit, since
the two primary implementations of computing an oid use either the sha-1 or the
sha-256 algorithm to compute the value) is a hash of all of the information
stored in the commit.  As such, a commit cannot be modified.

You will often see the phrase "re-write history", and this phrase is patently
absurd.  You cannot rewrite history.  Neither in the real world (unless you
are a politician) nor in git.  History is fixed, commits are immutable.  Period.
When you rebase a commit, your are *not* rewriting history!!

Branches, however, are *not* immutable.  They constantly change,
but changing the referrant of a branch is *not* rewriting history.

Consider:

~~~
$ d=git-example; rm -rf $d; mkdir $d; cd $d; git init --template=/dev/null > /dev/null 2>&1
$ git config user.email bob@foo.org; git config user.name bob
$ for i in a b c; do echo $i > $i; git add $i; git commit -m "Append line to $i" > /dev/null; done
$ git log --pretty=oneline
cb8b457eb38041da256e0fa0b26ee74444bfa4de (HEAD -> main) Append line to c
373eef38f6c8f1fabc2ea5acf09c47f27039a97f Append line to b
50f3819a8e57fa449e4faf2f4d3e2fd1184228e9 Append line to a
$ GIT_SEQUENCE_EDITOR='sh -c "cat << EOF > $1
> p 373eef38f
> p cb8b457e
> p 50f3819a8e5
> EOF
> "' git rebase -i --root
Successfully rebased and updated refs/heads/main.
$ git log --pretty=oneline
b3a020f9c6f3e08ed22322144d98f63c38237dc9 (HEAD -> main) Append line to a
8f8ee615a2a382b442aaa984d72217842b629db7 Append line to c
c9b6d7316bf36c446ed4d526618083310d81f9fb Append line to b
~~~

At first glance, a naive user will say that history has been re-written.  The
main branch used to look like A-B-C, but now it looks like B'-C'-A'!  It has
changed, history has been re-written!!  Nonsense.  The ref "main" used
to refer to the immutable commit cb8b457eb, but now it refers to the
immmutable commit b3a020f9c6f.  Nothing has changed.  cb8b457eb still
exists and is accessible, and if you want "main" to refer to it you
can change it to do so.

Stop abusing language, and stop talking about re-writing history.  Or,
perhaps more importantly, stop expecting branches to be something other
than what they are.  A branch is a reference to a particular
commit and the commit a branch refers to can (and is expected to!)
change.  Commits are immutable, but refs are not (nor should they be).
But when you change the referent commit of a branch, you are *not*
"re-writing history".

In other words, don't be afraid to rebase.  Your data is safe. With
one minor caveat; git does garbage collect, so although commits are
immutable and can never be changed, they certainly can get deleted.
Make sure any commit you care about has at least one ref to it to prevent
it from being discarded.
