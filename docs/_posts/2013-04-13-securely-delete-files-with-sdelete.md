---
layout: post
title: "Securely Delete Files with SDelete"
excerpt: "There is a variety of GUI-based utilities such as CCleaner or Freeraser, but SDelete is very simple to use for anyone comfortable with the command line.  SDelete is part of the Sysinternals Suite of utilities for Windows but can be downloaded separately from Microsoft Technet."
modified: 2013-04-13
tags: [Encryption]
comments: false
category: blog
---

Yesterday, I needed to securely delete a file from a computer that I was using at work and this computer did not have a utility to do that currently installed.  Remember that when you delete a file in Windows, you are removing only the reference to the file from the “Master File Table.”  Among other things, the Master File Table is essentially an index that keeps track of the location of each file.

There is a variety of GUI-based utilities such as <a href="http://www.piriform.com/ccleaner/builds"  target="_blank" rel="noreferrer noopener">CCleaner</a> or <a href="http://www.freeraser.com/">Freeraser</a>, but **<a href="http://technet.microsoft.com/en-us/sysinternals/bb897443"  target="_blank" rel="noreferrer noopener">SDelete</a>** is very simple to use for anyone comfortable with the command line.  SDelete is part of the Sysinternals Suite of utilities for Windows but can be downloaded separately from <a href="https://technet.microsoft.com/en-us/sysinternals/bb897443"  target="_blank" rel="noreferrer noopener">Microsoft Technet</a>.

Download the zip file and extract **sdelete.exe** to a folder such as c:\temp or to your thumb drive.  Navigate to the directory where you stored SDelete and execute it to see the various options.

![SDelete](/images/SDelete1.png)

Let’s say that I have a Word document of secret information that I want to securely delete in “My Documents,”  I can delete it with the following simple command:

```
c:\temp\sdelete “C:\Users\Ken\Documents\Secret Info.Docx”
```

![Using SDetete to wipe a single file](/images/Sdelete2.png)
*Using SDetete to wipe a single file*

Note that I provided the full path to SDelete, also I put the full path to the file to be deleted in quotations because there is a space in the file name. By default, SDelete overwrites the file in a single pass before deleting its reference from the Master File Table.  If you want more than one pass specify that with the “–p” switch.  Modern hard disks only need a single pass, but this option is provided for compliance with the U.S. Department of Defense standard for the sanitization of magnetic media (DoD 5220-22-M).

If I want to delete the contents of a whole that may also contain directories, I can use the “-s” switch as follows:

```
>C:\temp\sdelete -s -q “c:\Users\Ken\Documents\Secret Documents”>
```

![Using SDelete to wipe the contents of a directory](/images/Sdelete3.png)
*Using SDelete to wipe the contents of a directory*

Another very cool capability of SDelete is that it can clean all of the free space on a hard drive.  This allows one to securely all of the files that were deleted previously without being wiped first.  To do this, launch your <a href="http://technet.microsoft.com/en-us/library/cc947813(v=ws.10).aspx" target="_blank" rel="noreferrer noopener">command prompt as an administrator</a>, and then type:

```
c:\temp\sdelete –c c:
```

![SDelete4](/images/Sdelete4.png)
*Using SDelete to wipe free space*

This will take a while for a large hard drive, so you may want to let it run overnight.  If you like this, you can <a href="https://technet.microsoft.com/en-us/library/cc772785(v=ws.10).aspx">create a scheduled task from the command line</a> so that it runs automatically whenever you want.
