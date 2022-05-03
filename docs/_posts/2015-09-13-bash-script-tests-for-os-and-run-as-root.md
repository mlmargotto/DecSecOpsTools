---
layout: post
title: Bash Script Tests for OS and Run as Root
excerpt: "Using sed in bash scripts to check for root and OS version"
modified: 2015-09-13
tags: [bash]
comments: false
category: blog
---

In my [last post](/blog/change-config-settings-using-a-bash-script/), I discussed using sed, the stream editor to make configuration file changes via a bash script.  There are two important factors to keep in mind:

* Many configuration files can only be modified as root, and
* The location of configuration files will vary depending on the Linux distribution.

Therefore it is important to test for both of these conditions at the beginning of your Bash script.

## Test to ensure expected OS Distribution and Version

```
#Test to ensure expected OS Distribution and Version
OSTEST=$(grep "Red Hat Enterprise Linux Server release 6." /etc/*release | wc -c)
if [ $OSTEST == 0 ]
then
echo "Incorrect Operating System - Expected RHE6"
exit 1
fi
```
The example above example is for Red Hat, so the string to grep will vary depending on the Linux distribution.

## <span style="font-weight: 400;">Test to Ensure Script is Run as Root</span>

```
#Test to ensure script is run as root
USERTEST=$(whoami)
if [ $USERTEST != "root" ]
then
echo "Incorrect Permissions - Run this script as root"
exit 1
fi
```

You may prefer a tight one-liner to test for root.  In that case you can use something like:

```
# Check for root
[ "$(id -u)" -ne 0 ] && echo "Incorrect Permissions - Run this script as root" && exit 1
```
