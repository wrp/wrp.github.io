---
layout: post
title:  "pip silently violated explicit pins for years"
date:   2026-08-02 12:00:00 -0700
categories: blog
---

For years, pip would silently install the wrong version of a package.
If you specified `foo == 1.2` and also `bar > 2.0`, and `bar` happened
to depend on `foo > 1.2`, pip would happily install `foo 1.3`.  Your
explicit pin was quietly discarded.  No error.  No warning.  It just
did the wrong thing.

This is the worst kind of failure a package manager can have.  An error
would be fine.  A warning would be tolerable.  Silently violating the
one constraint the user bothered to write down is inexcusable.

The old "legacy resolver" processed dependencies in order and allowed
transitive dependencies to override direct pins.  When you told people
about this behavior, many of them insisted it could not happen.  It
could, and it did, routinely.

Pip 20.3, released in November 2020, introduced a new backtracking
resolver that properly detects these conflicts.  With the new resolver,
the `foo == 1.2` and `foo > 1.2` conflict raises a `ResolutionImpossible`
error instead of silently installing the wrong thing.  The legacy
resolver lingered behind an opt-in flag until pip 23.1 (April 2023),
when it was finally removed.

So the resolver is fixed.  But the overall workflow still leaves gaps.
You can still end up with an incoherent environment if you use
`--no-deps`, which bypasses the resolver entirely.  You can also get
there by running multiple `pip install` invocations with different
requirements files, since each invocation only validates the constraints
it can see.  And pre-existing packages in the environment are not
re-validated against new constraints unless they are part of the
current resolution.

If you want to verify that your environment is actually consistent
after installation, run `pip check`.  It will report any installed
packages whose dependencies are unsatisfied or conflicting.  That
this is not the default behavior is itself a design choice worth
questioning.

The resolver took from 2020 to 2023 to fully replace the broken
one, and the broken one had been shipping for years before that.
Silent failure in dependency resolution is a serious defect, and
it persisted for far too long.
