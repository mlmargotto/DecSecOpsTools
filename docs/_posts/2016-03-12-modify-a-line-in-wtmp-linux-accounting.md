---
layout: post
title: Modify a line in wtmp - Linux Accounting
excerpt: "The /var/log/wtmp file in a Linux system contains data about past
user logins."
modified: 2016-03-12
tags: [hacking]
comments: false
category: blog
---

The **/var/log/wtmp** file in a Linux system contains data about past user
logins.  An attacker may want to modify this file as one of the steps they take
in covering their track.  One may also want to modify utmp or btmp as well.
This same technique can be used.

The wtmp log is a binary format and is owned by root:

```
root@ubuntu:/home/ken# ls -als /var/log/wtmp
12 -rw-rw-r-- 1 root utmp 9984 Feb 15 09:00 /var/log/wtmp
```

It can be viewed using the last command, as shown below:

```
root@ubuntu:/home/ken# last -f /var/log/wtmp
ken      pts/0        192.168.3.69     Wed Feb 15 09:00   still logged in
ken      pts/1        192.168.3.69     Fri Feb 10 11:41 - 11:47  (00:05)
ken      pts/0        192.168.3.69     Fri Feb 10 07:45 - 20:10  (12:25)
reboot   system boot  4.2.0-16-generic Thu Feb  9 08:33   still running
ken      pts/1        192.168.3.69     Mon Feb  6 10:23 - down  (2+09:49)
ken      pts/0        192.168.3.69     Mon Feb  6 10:15 - 18:59 (2+08:43)
ken      tty1                          Mon Feb  6 10:08 - 10:22  (00:14)
reboot   system boot  4.2.0-16-generic Mon Feb  6 10:07 - 20:13 (2+10:05)

wtmp begins Mon Feb  6 10:07:23 2017

```

The **utmpdump** works great for this and may be on the image by default.  In
this case, let's say we want to remove the entry that shows user ken logged in
from the console (tty1).  Here is how to do it:

```
utmpdump /var/log/wtmp | grep -v "tty1" > temp.txt
utmpdump -r &lt; temp.txt > /var/log/wtmp
rm -f temp.txt # Use 'shred' if it is installed
```

Now, let's take a look at the output again using the 'last' command:

```
root@ubuntu:/home/ken# last -f /var/log/wtmp
ken      pts/0        192.168.3.69     Wed Feb 15 09:00   still logged in
ken      pts/1        192.168.3.69     Fri Feb 10 11:41 - 11:47  (00:05)
ken      pts/0        192.168.3.69     Fri Feb 10 07:45 - 20:10  (12:25)
reboot   system boot  4.2.0-16-generic Thu Feb  9 08:33   still running
ken      pts/1        192.168.3.69     Mon Feb  6 10:23 - down  (2+09:49)
ken      pts/0        192.168.3.69     Mon Feb  6 10:15 - 18:59 (2+08:43)
reboot   system boot  4.2.0-16-generic Mon Feb  6 10:07 - 20:13 (2+10:05)

wtmp begins Mon Feb  6 10:07:23 2017

```

Note that the line is now missing.  Of course, the timestamp on wtmp has also
been updated, but that is a different issue:

```
root@ubuntu:/home/ken# ls -als /var/log/wtmp
8 -rw-rw-r-- 1 root utmp 5760 Feb 16 15:46 /var/log/wtmp
```
