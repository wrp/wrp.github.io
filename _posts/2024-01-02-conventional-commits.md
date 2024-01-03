---
layout: post
title:  "Conventional commits: the wrong approach"
date:   2024-01-02 18:38:31 -0600
github_comments_issueid: "5"
categories: blog
---

[Conventional commits](https://jekyllrb.com/docs/home) are a popular approach for
for maintaining history history, but I believe that approach is sub-optimal.
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
$ f=file1; echo text > $f; git add $f; git commit -m "Add $f" -s --trailer subproject=mem --trailer ticket=MEM-4 --trailer type=chore > /dev/null
$ f=file2; echo text > $f; git add $f; git commit -m "Add $f" -s --trailer subproject=storage --trailer ticket=STORE-1234 --trailer type=docs > /dev/null
$ f=file3; echo text > $f; git add $f; git commit -m "Add $f" -s --trailer subproject=comp --trailer ticket=COMP-134 --trailer type=feat > /dev/null
$ git l1
 f24ad31 bob           Add file3
 d3ff3e1 bob           Add file2
 fd6c37b bob           Add file1
$ t=ticket git l1
 f24ad31 bob           [COMP-134   ] Add file3
 d3ff3e1 bob           [STORE-1234 ] Add file2
 fd6c37b bob           [MEM-4      ] Add file1
$ t=type git l1
 f24ad31 bob           [feat       ] Add file3
 d3ff3e1 bob           [docs       ] Add file2
 fd6c37b bob           [chore      ] Add file1
$ w=10 t=ticket,subproject git l1
 f24ad31 bob           [COMP-134  ][comp      ] Add file3
 d3ff3e1 bob           [STORE-1234][storage   ] Add file2
 fd6c37b bob           [MEM-4     ][mem       ] Add file1
~~~~

In the above, we can see that specifying the trailer affords 2 benefits:
you can select what you want to see and filter out the metadata you may
not care about at the moment, and you can control the width of the
formatting.  With conventional commits, it is very difficult to
maintain consistent widths for the headers.  If you want to get
output that is identical to that which would be provided by
conventional commits, you just need to tweak the format:

~~~~
$ t=type git l1
 f24ad31 bob           feat: Add file3
 d3ff3e1 bob           docs: Add file2
 fd6c37b bob           chore: Add file1
~~~~





[^aliases]: To generate these outputs, the following alias was used in a global .gitconfig:
~~~~
        l1 = !bash -c 'cd ${GIT_PREFIX:-.} && a=$(printf \"%s\" ${t-$(git config \
                core.default-trailers)} | \
                sed -E \"s/([^,]*)(\\$|,)/[%<(${w:-11})%(trailers:key=\\1,separator=%x2C,valueonly)]/g\" \
                ) && \
                git log \
                --format=tformat:\"$(echo \"\
                %Cgreen%h%Cblue\
                %Cred%<($(($(tput cols)/10 - 2)),trunc)%an%Creset\
                ${a}\
                %<($(($(tput cols) / 3)),trunc)%s \
                %Creset\
                \" | tr -s \" \"  )\" \"$@\"' _
~~~~
