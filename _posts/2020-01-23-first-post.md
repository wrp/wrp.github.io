---
layout: post
title:  "Setting up Jekyll"
date:   2020-01-23 12:22:00 +0000
categories: blog
---

Just playing around with Jekyll and github pages.  I've started many blogs in the past and
never really followed through, and I suspect this will be the same!

A few notes on first experiences with Jekyll.  It seems relatively easy to setup.  The
entire setup can be described succinctly, and so many of the pages I found wasted a lot
of words trying to "make it simple" by making it a lot harder than it has to be. Basically,
it boils down to:

create a github repo named $user.github.io and clone it to $dir
{% highlight sh %}
$ gem install jekyll
$ jekyll new $dir
$ cd $dir && git add . && git commit -a -m 'New page' && git push
{% endhighlight %}

When I actually did it, I did:

{% highlight sh %}
cd $dir; jekyll new blog; mv blog/* .
{% endhighlight %}

and then selected files to commit, but the above is basically all there is to it.
When I first edited \_config.yml, I made a syntax error (used '-' as twitter feed, fixed
by changing to 'none') and github threw a build error which I didn't notice for awhile.
Initially, the site served by github just reverted back to the most recent green build,
and I didn't notice the issue until I went to [commits](https://github.com/wrp/wrp.github.io/commits/master)
and saw some failures.

To create a new post, add a new markdown in \_posts following the convention
that the name be \_posts/YYYY-MM-DD-the-title-of-the-post.markdown.

View the changes locally with:

{% highlight sh %}
$ cd $dir && bundle exec jekyll serve
{% endhighlight %}

And you're off and running with a brand new blog that you can ignore for months at a time!
