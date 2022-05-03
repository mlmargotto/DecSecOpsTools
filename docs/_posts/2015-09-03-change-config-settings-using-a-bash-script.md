---
layout: post
title: Change config settings using a bash script
excerpt: "There is a trend to perform all system administration tasks using
scripts. The benefit of this approach is that the scripts can be checked into a
source control system, such as github."
modified: 2019-01-12
tags: [bash]
comments: false
category: blog
---

There is a trend to perform all system administration tasks using scripts. The
benefit of this approach is that the scripts can be checked into a source
control system, such as <a href="https://github.com/"
target="_blank">github</a>.

One great application of this strategy is the script that you use to harden
your Linux systems.  This hardening script, with the appropriate in-line
comments, can serve as part of your compliance documentation.  Other scripts
can be used to verify the the configuration is actually as intended and has not
been altered.

One of the simple and powerful command line tools that I use is "sed," the
stream editor.  I urge you to read the <a
href="http://www.gnu.org/software/sed/manual/sed.txt" target="_blank">man
page</a> and get to know it well.

In the rest of this post, I will be demonstrating how to use sed to edit the
`/etc/ssh/sshd_config` file.  Let's say that you want to make sure the the file
contains an entry that prevents the root user account from accessing the server
via SSH.  You would want it to contain the following line:

```
PermitRootLogin no
```

and it currently contains the following lines:

```
...
# Authentication:
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
...
```

Well, you could use these lines in your hardening script:

```
sed 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config > temp.txt
mv -f temp.txt /etc/ssh/sshd_config
```

But what about if the current sshd_config file looks like this:

```
...
# Authentication:
LoginGraceTime            120
#PermitRootLogin          yes
StrictModes               yes
...
```

In this case, the line of interest has been commented out and has white space
to content with.  Instead, use the following syntax:

```
sed 's/#\?\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config > temp.txt
mv -f temp.txt /etc/ssh/sshd_config
```

This command says to sed, "find the line that may have an octothorpe in the
beginning position and contains `PermitRootLogin` and whitespace then replace
what ever follows that with a 'no.' but remove the octothorpe"

Note that the `sed -i` can be used to modify a file in place rather than
redirecting to a temp file.

I use this very handy trick all of the time. The one caution is that if sed
does not find a line containing the `PermitRootLogin` search string nothing
happens. For this reason, you should also use another script to audit if the
configuration settings are as expected.
