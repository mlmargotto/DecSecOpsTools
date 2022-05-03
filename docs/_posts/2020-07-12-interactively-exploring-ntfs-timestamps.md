---
layout: post
title: Interactively Exploring NTFS Timestamps
excerpt: "Interactively explore how common operating system activities impact
NTFS timestamps."
modified: 2020-07-12
tags: [Forensics]
comments: false
category: blog
---

Much has been [written](https://www.sans.org/white-papers/36842/) about NTFS
Timestamps because a proper understanding is critical to reconstructing events
during a digital forensic investigation. Typically the author will use a tool
like [_The Slueth Kit_](https://www.sleuthkit.org/) to examine changes to a
hard drive image, however creating an image of a hard drive takes too long when
one is really just looking for some quick insights into how common operating
system activities impact NTFS timestamps.

Of course, the techniques discussed in this post would not be used **_on_**
forensic evidence. Instead, we are demonstrating operating system behavior that
can be produced **_as_**  forensic evidence.

## Window System & Tools

The experiment discussed in this post used a Windows 10 computer with multiple
hard drives. The system also had Windows Subsystem for Linux (WSL) installed
and configured to run Ubuntu. WSL allows access to the live Windows Recycle Bin
in much the same manner that an investigator would access the recycle bin on a
hard drive image attached to a SIFT Forensic Workstation.

Our test data consists of five different photos of cats downloaded from the
Internet.  An open source tool, **nTimeStomp**,  is used to  set the date
stamps of each file to known values and a related tool by the same author,
**nTimeView**  is used to  view all four of the timestamps for each file. These
tools are available at
[https://limbenjamin.com/pages/ntimetools](https://limbenjamin.com/pages/ntimeto
ols) along with a nice discussion of each.

Lastly, for real-time examination of the deleted files, [AccessData's FTK
Imager](https://accessdata.com/product-download/ftk-imager-version-4-3-0) was
used.

## Setup

Set the MACB Times using **nTimestomp** to dates in 2018 as shown below:

```
B:\temp>nTimestomp.exe B:\temp\cat1.jpg "2018-12-01 01:34:56.7890123"
"2018-12-02 02:34:56.7890123" "2018-12-03 03:34:56.7890123" "2018-12-04
04:34:56.7890123"
nTimestomp, Version 1.1
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       B:\temp\cat1.jpg
File size:                      75785

File timestamp successfully set

[M] Last Write Time:            2018-12-01 01:34:56.7890123 UTC
[A] Last Access Time:           2018-12-02 02:34:56.7890123 UTC
[C] Metadata Change Time:       2018-12-03 03:34:56.7890123 UTC
[B] Creation Time:              2018-12-04 04:34:56.7890123 UTC
```

## Test One - Windows Explorer View

Use Windows File Explorer to list the image file (without opening it) and then
examine date stamps:

```
B:\temp>nTimeview cat1.jpg
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       cat1.jpg
File size:                      75785

[M] Last Write Time:            2018-12-01 01:34:56.7890123 UTC
[A] Last Access Time:           2020-07-11 11:41:53.8899325 UTC  <==
[C] Metadata Change Time:       2018-12-03 03:34:56.7890123 UTC
[B] Creation Time:              2018-12-04 04:34:56.7890123 UTC
```

Windows shows that the _Last Access Time_ was updated simply by causing the
file to be
listed along with others in its directory.

**NOTE:** This is an important reminder that the _Last Access Time_ timestamp
does not mean that the file was viewed/opened.

## Test Two - Open the file to view it

Double-click the file in Windows explorer to view it and inspect the time
stamps:

```
B:\temp>nTimeview cat1.jpg
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       cat1.jpg
File size:                      75785

[M] Last Write Time:            2018-12-01 01:34:56.7890123 UTC
[A] Last Access Time:           2020-07-11 11:48:35.3733487 UTC <==
[C] Metadata Change Time:       2018-12-03 03:34:56.7890123 UTC
[B] Creation Time:              2018-12-04 04:34:56.7890123 UTC
```

The _Last Access Time_ is once again updated.

## Test Three - Open the file in paint

Open the cat1.jpg file in paint and crop the image and save it. Inspect the
time stamps:

```
B:\temp>nTimeview cat1.jpg
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       cat1.jpg
File size:                      118328

[M] Last Write Time:            2020-07-11 11:57:06.6043747 UTC <==
[A] Last Access Time:           2020-07-11 11:57:07.1635197 UTC <==
[C] Metadata Change Time:       2020-07-11 11:57:06.6133835 UTC <==
[B] Creation Time:              2018-12-04 04:34:56.7890123 UTC
```

Since the file changed, it makes sense that the _Last Write Time_ is updated.
The Metadata Change Time was updated as well because the metadata about the
file (such as the **size** of the file) were changed in the Master File Table
(MFT).

## Test Four - Windows Explorer Copy

Use Windows File Explorer to Copy & Paste another copy of the file and then
examine date stamps:

```
B:\temp>nTimeview "cat1 - Copy.jpg"
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       cat1 - Copy.jpg
File size:                      75785

[M] Last Write Time:            2018-12-01 01:34:56.7890123 UTC
[A] Last Access Time:           2020-07-11 11:09:42.9076971 UTC <==
[C] Metadata Change Time:       2018-12-03 03:34:56.7890123 UTC
[B] Creation Time:              2020-07-11 11:07:35.3160584 UTC <==
```

Observe that the Creation Time and Access time are set to the current time.

## Test Five - Windows Explorer Rename

Use Windows File Explorer to rename the copied file and then examine date
stamps. Rename "cat1 - Copy.jpg" to "dog1.jpg":

```
B:\temp>nTimeview dog1.jpg
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       dog1.jpg
File size:                      75785

[M] Last Write Time:            2018-12-01 01:34:56.7890123 UTC
[A] Last Access Time:           2020-07-11 11:13:19.3956418 UTC  <==
[C] Metadata Change Time:       2020-07-11 11:13:19.3148846 UTC  <==
[B] Creation Time:              2020-07-11 11:07:35.3160584 UTC
```

Notice that the Access Time and the Metadata Change Time were updated. The
metadata about the file, such as the **name** of the file were changed in the
Master File Table (MFT).

## Test Six - Windows Explorer Move File (Same Volume)

Reset the timestamps on cat1.jpg and move the file into a sub-directory in the
**same** volume:

```
B:\temp>nTimeview stuff\cat1.jpg
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       stuff\cat1.jpg
File size:                      75785

[M] Last Write Time:            2018-12-01 01:34:56.7890123 UTC
[A] Last Access Time:           2020-07-11 11:26:32.3751792 UTC <==
[C] Metadata Change Time:       2020-07-11 11:26:33.6403843 UTC <==
[B] Creation Time:              2018-12-04 04:34:56.7890123 UTC
```

This test shows that the Access Time and the Metadata Change Time were updated.
The metadata about the file, such as the **path** of the file were changed in
the Master File Table (MFT).

## Test Seven - Windows Explorer copy File (Different Volume)

Reset the timestamps on cat1.jpg and copy the file into a sub-directory in a
**different**
volume:

```
B:\temp>nTimeview F:\temp\cat1.jpg
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       F:\temp\cat1.jpg
File size:                      118328

[M] Last Write Time:            2018-12-01 01:34:56.7890123 UTC
[A] Last Access Time:           2020-07-11 12:15:02.2310219 UTC <==
[C] Metadata Change Time:       2018-12-03 03:34:56.7890123 UTC
[B] Creation Time:              2020-07-11 12:14:36.2806533 UTC <==
```

Notice that the _Last Write Time_ is unchanged, the same as Test Four, when the
copy operation was performed to the same volume. The _Creation Time_ is updated
to reflect the
new copy. **NOTE:** This explains how that the _Creation Time_ can be more
recent than
the _Last Write Time_.

## Test Seven - Windows Explorer Move File (Different Volume)

Replace cat1.jpg in `B:\temp` and reset the timestamps. Now move the file to a
different volume:

```
B:\temp>nTimeview F:\temp\cat1.jpg
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       F:\temp\cat1.jpg
File size:                      118328

[M] Last Write Time:            2018-12-01 01:34:56.7890123 UTC
[A] Last Access Time:           2020-07-11 12:41:18.3939236 UTC <==
[C] Metadata Change Time:       2018-12-03 03:34:56.7890123 UTC
[B] Creation Time:              2018-12-04 04:34:56.7890123 UTC
```

Even though the F: Volume has a different MFT, the _Creation time_ and
_Metadata Change Time_ are unchanged!

## Test Eight - Recycle a File

Reset the timestamps and then send the cat1.jpg file to the Recycle Bin and
examine the resulting timestamps.

**NOTE:** [Windows Subsystem for
Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) (WSL) will
be used for interactive examination of the files that are moved to the Windows
Recycle Bin.

1. Run a directory listing of the empty Recycle Bin:

```
ken@msi:/mnt/b$ ls
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/
desktop.ini
```

2. Delete the cat1.jpg file and observe it in the Recycle Bin:

```
ken@msi:/mnt/b$ ls
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/
'$I7T65ZS.jpg'  '$R7T65ZS.jpg'   desktop.ini
```

The $R file contains the contents of the file that was deleted and the $I file
contains the metadata about the original file.

3. Look at the timestamps using the Linux `stat` command. First, look at the $I
file:

```
ken@msi:/mnt/b$ stat
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/'$I7T65ZS.jpg'
  File: $RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/$I7T65ZS.jpg
  Size: 62              Blocks: 0          IO Block: 4096   regular file
Device: eh/14d  Inode: 36028797018964064  Links: 1
Access: (0777/-rwxrwxrwx)  Uid: ( 1000/     ken)   Gid: ( 1000/     ken)
Access: 2020-07-11 08:53:31.269001000 -0400
Modify: 2020-07-11 08:53:31.237117600 -0400
Change: 2020-07-11 08:53:31.237117600 -0400
 Birth: -
```

And then the $R file:

```
ken@msi:/mnt/b$ stat
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/'$R7T65ZS.jpg'
  File: $RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/$R7T65ZS.jpg
  Size: 118328          Blocks: 232        IO Block: 4096   regular file
Device: eh/14d  Inode: 1407374883565226  Links: 1
Access: (0777/-rwxrwxrwx)  Uid: ( 1000/     ken)   Gid: ( 1000/     ken)
Access: 2020-07-11 08:43:35.510368500 -0400
Modify: 2018-11-30 20:34:56.789012300 -0500
Change: 2020-07-11 08:53:31.239080500 -0400
 Birth: -
```

## Test Nine - Recycle an entire directory

Set the timestamps on four different cat images in the `B\temp` directory and
then recycle the entire directory.

1. Set the timestamps using nTimestomp (output condensed):

```
Filename:                       B:\temp\cat2.jpg
[M] Last Write Time:            2018-12-05 05:34:56.7890123 UTC
[A] Last Access Time:           2018-12-06 06:34:56.7890123 UTC
[C] Metadata Change Time:       2018-12-07 07:34:56.7890123 UTC
[B] Creation Time:              2018-12-08 08:34:56.7890123 UTC

Filename:                       B:\temp\cat3.jpg
[M] Last Write Time:            2018-12-09 09:34:56.7890123 UTC
[A] Last Access Time:           2018-12-10 10:34:56.7890123 UTC
[C] Metadata Change Time:       2018-12-11 11:34:56.7890123 UTC
[B] Creation Time:              2018-12-12 12:34:56.7890123 UTC

Filename:                       B:\temp\cat4.jpg
[M] Last Write Time:            2018-12-13 13:34:56.7890123 UTC
[A] Last Access Time:           2018-12-14 14:34:56.7890123 UTC
[C] Metadata Change Time:       2018-12-15 15:34:56.7890123 UTC
[B] Creation Time:              2018-12-16 16:34:56.7890123 UTC

Filename:                       B:\temp\cat5.png
[M] Last Write Time:            2018-12-17 17:34:56.7890123 UTC
[A] Last Access Time:           2018-12-18 18:34:56.7890123 UTC
[C] Metadata Change Time:       2018-12-19 19:34:56.7890123 UTC
[B] Creation Time:              2018-12-20 20:34:56.7890123 UTC
```

2. Show the files in the `B:\temp` directory:

```
B:\temp>dir
 Volume in drive B is DATA
 Volume Serial Number is 826E-253A

 Directory of B:\temp

07/11/2020  09:09 AM    <DIR>          .
07/11/2020  09:09 AM    <DIR>          ..
12/05/2018  01:34 AM             5,552 cat2.jpg
12/09/2018  05:34 AM            83,415 cat3.jpg
12/13/2018  09:34 AM             5,573 cat4.jpg
12/17/2018  01:34 PM         1,246,129 cat5.png
               4 File(s)      1,340,669 bytes
               2 Dir(s)  167,123,972,096 bytes free
```

3. Use WSL to Run a directory listing of the Recycle Bin prior to deleting the
directory:

```
ken@msi:/mnt/b$ ls
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/
'$I7T65ZS.jpg'  '$R7T65ZS.jpg'   desktop.ini
```

4. Use Windows File Explorer to Delete the `B:\temp` directory, sending it to
the recycle bin and then use WSL to list the contents of the recycle bin:

```
ken@msi:/mnt/b$ ls
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/
'$I7T65ZS.jpg'  '$IQ8QP2G'  '$R7T65ZS.jpg'  '$RQ8QP2G'   desktop.ini
```

5. The new files without the extensions are the deleted folder. Now, run the
stat command on each, starting with the $I file:

```
ken@msi:/mnt/b$ stat
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/'$IQ8QP2G'
  File: $RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/$IQ8QP2G
  Size: 44              Blocks: 0          IO Block: 4096   regular file
Device: eh/14d  Inode: 8162774324609707  Links: 1
Access: (0777/-rwxrwxrwx)  Uid: ( 1000/     ken)   Gid: ( 1000/     ken)
Access: 2020-07-11 09:19:48.856720800 -0400
Modify: 2020-07-11 09:19:48.565509800 -0400
Change: 2020-07-11 09:19:48.565509800 -0400
 Birth: -
```

And now the $R file:

```
ken@msi:/mnt/b$ stat
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/'$RQ8QP2G'
  File: $RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/$RQ8QP2G
  Size: 4096            Blocks: 0          IO Block: 4096   directory
Device: eh/14d  Inode: 562949953479220  Links: 1
Access: (0777/drwxrwxrwx)  Uid: ( 1000/     ken)   Gid: ( 1000/     ken)
Access: 2020-07-11 09:19:48.571485000 -0400
Modify: 2020-07-11 09:15:30.638214100 -0400
Change: 2020-07-11 09:19:48.571485000 -0400
 Birth: -
```

6. Note that the $RQ8QP2G is actually a directory. Lets look inside it:

```
ken@msi:/mnt/b$ ls
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/'$RQ8QP2G'
cat2.jpg  cat3.jpg  cat4.jpg  cat5.png
```

7. lets look at the timestamps of the files inside, starting with cat2:

```
ken@msi:/mnt/b$ stat
\$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/\$RQ8QP2G/cat2.jpg
  File:
$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/$RQ8QP2G/cat2.jpg
  Size: 5552            Blocks: 16         IO Block: 4096   regular file
Device: eh/14d  Inode: 4785074604093289  Links: 1
Access: (0777/-rwxrwxrwx)  Uid: ( 1000/     ken)   Gid: ( 1000/     ken)
Access: 2020-07-11 09:14:15.197543400 -0400
Modify: 2018-12-05 00:34:56.789012300 -0500
Change: 2020-07-11 09:19:48.571485000 -0400
 Birth: -
```

The _Last Modify Time_ is unchanged.

cat3:

```
File:
$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/$RQ8QP2G/cat3.jpg
Size: 83415           Blocks: 168        IO Block: 4096   regular file
Device: eh/14d  Inode: 2251799813697388  Links: 1
Access: (0777/-rwxrwxrwx)  Uid: ( 1000/     ken)   Gid: ( 1000/     ken)
Access: 2020-07-11 09:14:15.197543400 -0400
Modify: 2018-12-09 04:34:56.789012300 -0500
Change: 2020-07-11 09:19:48.571485000 -0400
Birth: -
```

cat4:

```
ken@msi:/mnt/b$ stat
\$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/\$RQ8QP2G/cat4.jpg
  File:
$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/$RQ8QP2G/cat4.jpg
  Size: 5573            Blocks: 16         IO Block: 4096   regular file
Device: eh/14d  Inode: 2814749767118704  Links: 1
Access: (0777/-rwxrwxrwx)  Uid: ( 1000/     ken)   Gid: ( 1000/     ken)
Access: 2020-07-11 09:14:15.199556800 -0400
Modify: 2018-12-13 08:34:56.789012300 -0500
Change: 2020-07-11 09:19:48.571485000 -0400
 Birth: -
```

cat5:

```
ken@msi:/mnt/b$ stat
\$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/\$RQ8QP2G/cat5.png
  File:
$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001/$RQ8QP2G/cat5.png
  Size: 1246129         Blocks: 2440       IO Block: 4096   regular file
Device: eh/14d  Inode: 2251799813697383  Links: 1
Access: (0777/-rwxrwxrwx)  Uid: ( 1000/     ken)   Gid: ( 1000/     ken)
Access: 2020-07-11 09:14:15.199556800 -0400
Modify: 2018-12-17 12:34:56.789012300 -0500
Change: 2020-07-11 09:19:48.571485000 -0400
 Birth: -
```

## Test Ten - Restore the Deleted Directory

Use Recycle Bin to restore the deleted `B:\temp` directory and examine the
timestamps.

cat2:

```
B:\>nTimeview B:\temp\cat2.jpg
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       B:\temp\cat2.jpg
File size:                      5552

[M] Last Write Time:            2018-12-05 05:34:56.7890123 UTC
[A] Last Access Time:           2020-07-11 13:41:21.5013215 UTC <==
[C] Metadata Change Time:       2020-07-11 13:40:12.5740427 UTC <==
[B] Creation Time:              2018-12-08 08:34:56.7890123 UTC
```

cat3:

```
B:\>nTimeview B:\temp\cat3.jpg
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       B:\temp\cat3.jpg
File size:                      83415

[M] Last Write Time:            2018-12-09 09:34:56.7890123 UTC
[A] Last Access Time:           2020-07-11 13:52:37.4038578 UTC <==
[C] Metadata Change Time:       2020-07-11 13:40:12.5740427 UTC <==
[B] Creation Time:              2018-12-12 12:34:56.7890123 UTC
```

Note that the cat2 and cat3 files have the original _Last Write Time_ and
_Creation Time_ from when they were recycled. The same holds true for files
cat4.jpg and cat5.png which are not shown for brevity sake.

What is interesting is that after the restore operation the $IQ8QP2G file
(which contains the metadata) is left in the Recycle Bin:

```
ken@msi:/mnt/b$ ls
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/
'$I7T65ZS.jpg'  '$IQ8QP2G'  '$R7T65ZS.jpg'   desktop.ini
```

## Test Eleven - Restore the Deleted File

Next, restore the single cat1.jpg file that we deleted in Test Eight and
inspect the timestamps:

```
B:\>nTimeview B:\temp\cat1.jpg
nTimeview, Version 1.0
Copyright (C) 2019 Benjamin Lim
Available for free from https://limbenjamin.com/pages/ntimetools

Filesystem type:                NTFS
Filename:                       B:\temp\cat1.jpg
File size:                      118328

[M] Last Write Time:            2018-12-01 01:34:56.7890123 UTC
[A] Last Access Time:           2020-07-11 14:05:03.9381958 UTC <==
[C] Metadata Change Time:       2020-07-11 14:04:51.8741065 UTC <==
[B] Creation Time:              2020-07-11 12:43:35.4542439 UTC
```

Similar to the files that were restored when the directory was restored, the
_Last Access Time_ and _Metadata Change Time_ were all that were modified.

Using WSL to examine the Recycle Bin directory, we can see that the
'$I7T65ZS.jpg' remains in the recycle bin:

```
ken@msi:/mnt/b$ ls
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/
'$I7T65ZS.jpg'  '$IQ8QP2G'   desktop.ini
```

## Test Twelve - Recycle the Folder and Empty the Recycle Bin

Recycle the `B:\temp` folder a second time and observe the Recycle Bin with WSL:

```
ken@msi:/mnt/b$ ls
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/
'$I7T65ZS.jpg'  '$IFBFYIR'  '$IQ8QP2G'  '$RFBFYIR'   desktop.ini
```

This time the new files are '$IFBFYIR' and '$RFBFYIR'.

When the Recycle Bin is emptied, both of the files are marked as unallocated
and no longer show in the directory listing:

```
ken@msi:/mnt/b$ ls
'$RECYCLE.BIN/S-1-5-21-2164529489-2119001881-1909558872-1001'/
'$I7T65ZS.jpg'  '$IQ8QP2G'   desktop.ini
```

However, other forensic tools can still read the deleted file and its
corresponding metadata. For example the image below uses AccessData FTK Imager:

![FTK Imager Screenshot of the deleted cat2 image](/images/deletedCat2.png)
<em>FTK Imager Screenshot of the deleted cat2 image</em>

## Conclusion

There is no substitute for experience. Try this hands-on. It is critical to
validate every assumption and not rely solely on others' work.
