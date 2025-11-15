---
layout: post
title:  "Timezone info in timestamps"
date:   2025-11-15 05:59:38 -0700
categories: blog
---

Please include timezone information every time you print a timestamp.
A string like "4:42 AM" is completely worthless.  When the user
asks for clarification, it does not help to use expressions like
"your timezone".  Be explicit and tell them what you think their
timezone is.  When the user has their laptop's local time set to
London but their configured address with your service is in New
York and they are currently in Los Angeles while using a VPN out
of Singapore, phrases like "your timezone" are completely worthless.
Allow me to say it for the 3rd time.  "Completely worthless".


Similarly, relative times like "two hours ago" and "1 week ago"
should be avoided.  First, they lack precision.  If something
happened "last week", did it happen on Monday, or on Friday?  For
"last week" in particular, that introduces an error bound that can
greatly exceed the actual value!  If today is Monday, "last week"
could refer to events occurring anywhere between 2 and 8 days ago!
Or even 1 to 9 days ago depending on which day the week starts,
introducing yet another ambiguity!  Second, what happens when your
service says something happened "two minutes ago"?  Alice takes a
screen shot and posts it in a messaging service (which slaps an
ambiguous timestamp on the message) and then Bob reads the message
from an archive 4 days later.  When Bob is reading it, the event
did not happen "two minutes ago".

Not only is including timestamps more precise and more informative,
it is easier.  You can greatly abbreviate most of the time.  And
even if you are in a timezone which is not an integer hour away
from UTC, you could normalize and still provide that information
with at most 3 characters. "0442-6" is shorter than "4:42 AM".
"0442+11" is exactly the same length.  The only reason to prefer
the ambiguous, uniformative, and completely worthless timestamp
format is that some people find it "prettier".  A little bit of
prettiness is not worth the ambiguity and headaches caused by
the ambiguity.
