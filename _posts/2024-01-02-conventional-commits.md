---
layout: post
title:  "Conventional commits: the wrong approach"
date:   2024-01-02 18:38:31 -0600
github_comments_issueid: "5"
categories: blog
---

[Conventional commits](https://www.conventionalcommits.org) are a popular approach
for maintaining history, but I believe that approach is sub-optimal.
There is a more flexible way to record the same information.  In particular,
conventional commits recognizes the utility of using git trailers to convey
information, and I argue here that *all* of the information that conventional
commits puts in subjects should instead be recorded in trailers, since it
allows the reader greater flexibility in displaying the information.

Consider[^aliases]:

~~~~
$ rm -rf git-example; mkdir git-example; cd git-example; git init > /dev/null
$ git config user.email 'bob@dev_null.com'; git config user.name bob
$ git config commit.gpgSign false
$ make_commit() { f=$1; echo text > $f; git add $f; git commit -m "Add $f" -s --trailer subproject=$2 --trailer ticket=$3 --trailer type=$4 > /dev/null; }
$ make_commit file1 mem MEM-4 chore
$ make_commit file2 storage STORE-1234 docs
$ make_commit file3 comp COMP-134 feat
$ git l1
7dc09e8 bob Add file3
cde0af3 bob Add file2
c8b670b bob Add file1
$ t=ticket git l1
7dc09e8 bob [COMP-134   ] Add file3
cde0af3 bob [STORE-1234 ] Add file2
c8b670b bob [MEM-4      ] Add file1
$ t=type git l1
7dc09e8 bob [feat       ] Add file3
cde0af3 bob [docs       ] Add file2
c8b670b bob [chore      ] Add file1
$ w=4 t=type git l1
7dc09e8 bob [feat] Add file3
cde0af3 bob [docs] Add file2
c8b670b bob [chore] Add file1
~~~~

In the above, we can see that specifying the trailer affords the ability
to select what you want to see and filter out the metadata you may
not care about at the moment.  By embedding the metadata in the commit
trailers, you can build tooling to extract and present the data
as desired.  With conventional commits, you could add filters to manipulate
the data in a similar way but doing so relies on the consistency of
the formatting of the commit subjects.  Keeping the metadata in the trailers
is much more robust.  Rather than trying to make
the simple string of the commit subject into a mechanism for storing
metadata, just use the trailers.



[^aliases]: To generate these outputs, the following alias was used in a global .gitconfig:
	~~~~
	l1 = !bash -c 'trailers=\"${t:+[%<(${w:-11})%(trailers:key=$t,separator=%x2C,valueonly)] }\" \
		&& git log --format=tformat:\"%h% an ${trailers}%s\" \"$@\"' _
	~~~~
