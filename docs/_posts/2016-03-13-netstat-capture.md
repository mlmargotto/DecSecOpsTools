---
layout: post
title: Capture a spurious outbound connection with NETSTAT
excerpt: "Need something quick and dirty to create a log of outbound connections on Windows?"
modified: 2016-03-13
tags: [Windows]
comments: false
category: blog
---


Several years ago, I created a <a href="/blog/powershell-script-to-log-network-connections/">PowerShell script</a> to create a log of outbound connections.  What if you need something quick and dirty and cannot use a script like that or external tools like Process Explorer, etc?

Here is a batch script that runs in an infinite loop and catches changes to the output of netstat:

```
#netstat-changes.bat
#Capture changes to a netstat output
netstat -naob > old.txt
:loop
netstat -naob > new.txt
fc old.txt new.txt >> change.txt
copy /y new.txt old.txt
goto loop

```

The output is certainly not pretty, but it gets the job done.
