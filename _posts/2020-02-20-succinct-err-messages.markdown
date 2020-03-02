---
layout: post
title:  "Error messages should be succinct"
date:   2020-02-20 20:56:59 -0800
github_comments_issueid: "1"
categories: blog
---

I was just playing around with gcloud, and got the rather annoying error:
{% highlight sh %}
$ gcloud compute instance list
ERROR: (gcloud.compute) Invalid choice: 'instance'.
Maybe you meant:
  gcloud compute instance-groups list-instances
  gcloud compute instances list
  gcloud compute instance-groups list
  gcloud compute instance-templates list
  gcloud compute target-instances list
  gcloud compute instances os-inventory list-instances
  gcloud compute instance-groups managed list-instances
  gcloud compute instance-groups unmanaged list-instances
  gcloud compute instance-groups managed list
  gcloud compute instance-groups unmanaged list

To search the help text of gcloud commands, run:
  gcloud help -- SEARCH_TERMS
{% endhighlight %}

Why is this annoying?  Surely it is useul to allow the tool to provide helpful
hints about the source of the error?  Similarly:

{% highlight sh %}
$ git push origin
fatal: 'origin' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
{% endhighlight %}

What could possibly be wrong with such verbosity?  Everything.
The excess verbosity makes it difficult to see what the actual
problem is.  It is sufficient if the error message were restricted
to the line: "ERROR: (gcloud.compute) Invalid choice: 'instance'."
Printing an additional 14 lines of text imposes an unnecessary
cognitive burden on the user and obscures the actual problem.  In cases
where the tool is embedded in a pipeline in which perhaps multiple
commands are invoked incorrectly, that noise quickly becomes
substantial.  In short, it decreases the signal to noise ratio.
It is spam.

This sort of thing is only (marginally) helpful when the tool is
being used interactively, and tool writers need to stop assuming
that the tool will be used that way.  If the user instead
were to invoke something like:

{% highlight sh %}
$ for host in $long_list_of_hostnames; do
	ssh "$host" git push origin 2>&1 >&3 | sed "s/^/$host: /"
done >&2 3>&1
{% endhighlight %}

the error messages are multiplied by a large factor with
no benefit.  Basically, in anything but the simple interactive
use case, the excessive verbosity is just an annoyance.   In
the simple interactive use, the excessive verbosity is only (marginally) useful
the first time it is seen, and subsequent occurrences are line noise.
Tool writers should be striving to make their tools useful in more
settings than the simple interactive use case.

This is similar in spirit to the misuse of stack traces.  Software
should not use a stack trace as a replacement for a well written
error message.  A stack trace is an indication of a programming
error, and a developer ought to be embarrassed if their code ever
throws one in production. Operational errors are not programming errors,
and an operational error deserves a well-written, succinct error
message.  Consider, as a concrete example, this error generated
by kafka-connect:

`"trace": "org.apache.kafka.connect.errors.ConnectException: Exiting WorkerSinkTask due to unrecoverable exception.\n\tat org.apache.kafka.connect.runtime.WorkerSinkTask.deliverMessages(WorkerSinkTask.java:560)\n\tat org.apache.kafka.connect.runtime.WorkerSinkTask.poll(WorkerSinkTask.java:321)\n\tat org.apache.kafka.connect.runtime.WorkerSinkTask.iteration(WorkerSinkTask.java:224)\n\tat org.apache.kafka.connect.runtime.WorkerSinkTask.execute(WorkerSinkTask.java:192)\n\tat org.apache.kafka.connect.runtime.WorkerTask.doRun(WorkerTask.java:177)\n\tat org.apache.kafka.connect.runtime.WorkerTask.run(WorkerTask.java:227)\n\tat java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n\tat java.util.concurrent.FutureTask.run(FutureTask.java:266)\n\tat java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n\tat java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n\tat java.lang.Thread.run(Thread.java:748)\nCaused by: com.google.cloud.bigquery.BigQueryException: Exceeded rate limits: too many api requests per user per method for this user_method. For more information, see https://cloud.google.com/bigquery/troubleshooting-errors\n\tat com.google.cloud.bigquery.spi.v2.HttpBigQueryRpc.translate(HttpBigQueryRpc.java:103)\n\tat com.google.cloud.bigquery.spi.v2.HttpBigQueryRpc.getTable(HttpBigQueryRpc.java:250)\n\tat com.google.cloud.bigquery.BigQueryImpl$14.call(BigQueryImpl.java:558)\n\tat com.google.cloud.bigquery.BigQueryImpl$14.call(BigQueryImpl.java:555)\n\tat com.google.api.gax.retrying.DirectRetryingExecutor.submit(DirectRetryingExecutor.java:105)\n\tat com.google.cloud.RetryHelper.run(RetryHelper.java:76)\n\tat com.google.cloud.RetryHelper.runWithRetries(RetryHelper.java:50)\n\tat com.google.cloud.bigquery.BigQueryImpl.getTable(BigQueryImpl.java:554)\n\tat com.wepay.kafka.connect.bigquery.BigQuerySinkTask.maybeCreateTable(BigQuerySinkTask.java:169)\n\tat com.wepay.kafka.connect.bigquery.BigQuerySinkTask.getRecordTable(BigQuerySinkTask.java:144)\n\tat com.wepay.kafka.connect.bigquery.BigQuerySinkTask.put(BigQuerySinkTask.java:207)\n\tat org.apache.kafka.connect.runtime.WorkerSinkTask.deliverMessages(WorkerSinkTask.java:538)\n\t... 10 more\nCaused by: com.google.api.client.googleapis.json.GoogleJsonResponseException: 403 Forbidden\n{\n  \"code\" : 403,\n  \"errors\" : [ {\n    \"domain\" : \"usageLimits\",\n    \"message\" : \"Exceeded rate limits: too many api requests per user per method for this user_method. For more information, see https://cloud.google.com/bigquery/troubleshooting-errors\",\n    \"reason\" : \"rateLimitExceeded\"\n  } ],\n  \"message\" : \"Exceeded rate limits: too many api requests per user per method for this user_method. For more information, see https://cloud.google.com/bigquery/troubleshooting-errors\",\n  \"status\" : \"PERMISSION_DENIED\"\n}\n\tat com.google.api.client.googleapis.json.GoogleJsonResponseException.from(GoogleJsonResponseException.java:150)\n\tat com.google.api.client.googleapis.services.json.AbstractGoogleJsonClientRequest.newExceptionOnError(AbstractGoogleJsonClientRequest.java:113)\n\tat com.google.api.client.googleapis.services.json.AbstractGoogleJsonClientRequest.newExceptionOnError(AbstractGoogleJsonClientRequest.java:40)\n\tat com.google.api.client.googleapis.services.AbstractGoogleClientRequest$1.interceptResponse(AbstractGoogleClientRequest.java:451)\n\tat com.google.api.client.http.HttpRequest.execute(HttpRequest.java:1089)\n\tat com.google.api.client.googleapis.services.AbstractGoogleClientRequest.executeUnparsed(AbstractGoogleClientRequest.java:549)\n\tat com.google.api.client.googleapis.services.AbstractGoogleClientRequest.executeUnparsed(AbstractGoogleClientRequest.java:482)\n\tat com.google.api.client.googleapis.services.AbstractGoogleClientRequest.execute(AbstractGoogleClientRequest.java:599)\n\tat com.google.cloud.bigquery.spi.v2.HttpBigQueryRpc.getTable(HttpBigQueryRpc.java:248)\n\t... 20 more\n",`

How long did it take you to see that the core of the problem is:
`BigQueryException: Exceeded rate limits: too many api requests per user per method for this user_method`
I would argue, that if it took more than 25ms, then it took too long.  If a succinct
error message were given, (eg, just that one line), the operator could
immediately see what the problem is.  If those error messages are buried
in 10s of MiB of log files, the additional time it takes to find the problem
in the noise is not small.  Note that there is an occurrence
of the string "PERMISSION_DENIED" in the above garbage dump.  I leave
it as an exercise to the reader to determine if there is any authentication
error here.


Maybe this is just me ranting "get off my lawn", but I believe
this is a significant problem.  Similar to printing a usage
statement in response to an error.  Don't do it!  If a user
is using the tool interactively and wants an error message,
they should ask for it with a flag (eg, -h, or --help).
If you spam 75 lines of usage in response to an error,
it is not useful even in the simple use case and a major
headache when the tool is being used non-interactively.
Consider:

{% highlight sh %}
$ echo $LINES
18
$ git status --cruft banana | ...
{% endhighlight %}

after invoking git-status, the terminal will display:

{% highlight sh %}
    -b, --branch          show branch information
    --show-stash          show stash information
    --ahead-behind        compute full ahead/behind values
    --porcelain[=<version>]
                          machine-readable output
    --long                show status in long format (default)
    -z, --null            terminate entries with NUL
    -u, --untracked-files[=<mode>]
                          show untracked files, optional modes: all, normal, no. (Default: all)
    --ignored[=<mode>]    show ignored files, optional modes: traditional, matching, no. (Default: traditional)
    --ignore-submodules[=<when>]
                          ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)
    --column[=<style>]    list untracked files in columns
    --no-renames          do not detect renames
    -M, --find-renames[=<n>]
                          detect renames, optionally set similarity index

$
{% endhighlight %}

What does `--porcelain` and `--untracked-files` have to do with
this error?  Absolutely nothing, so why am I being told about them?
Clearly some error occurred, but it would be much easier if the
error message stating that `--cruft` is an unrecognized option were
still visible.  Suspecting that there's probaly some useful information
at the top of the output, the user might reasonably run:

{% highlight sh %}
$ git status --cruft banana | head
{% endhighlight %}

but that's no good because the usage statement was treated as an error message
and written to stderr!  So now the user has to do:

{% highlight sh %}
$ git status --cruft banana 2>&1 | head
{% endhighlight %}

In this case, the tool writer made a half-baked attempt to fix this
problem, and when the tool is invoked in the simplest case the error
message is piped to a pager to avoid the scroll-off.  But that's
just weird, because suddenly the error stream is being redirected,
misleading the user into believing that the error message was printed
to stdout!  But when the output is being post-processed in a pipeline,
the error message goes to stderr.  This is a violation of the
principle of least surprise.  The tool has made it difficult to see
what the error message is, rather than bringing it to the attention
of the user.

In short, assume your users are semi-competent beings who can type
'-h' if they need to and are able to understand the implications
of a simple error message like "permission denied".  You are not
writing a tutorial; you are provided a description of the error
that occurred.  Make it succinct.  Don't write out a bunch of useless
verbiage that will almost always be ignored.
