---
layout: post
title:  "Pro-tip: Symbolic links for navigating git diffs"
date:   2025-07-19 07:14:00 -0600
categories: git, vim
---

git patches typically contain text of the form:
{% highlight sh %}
--- a/rel/path/to/file
+++ b/rel/path/to/file
{% endhighlight %}

vim has a convenient keybinding (gf) to quickly open the path under
the cursor, but the relative path to "file" does not begin "a/"
or "b/"!

Pro-tip: create symbolic links a and b that both refer to '.',
and now gf will work in vim!
