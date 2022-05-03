---
layout: post
title: How to Install TSHARK in Unattended Mode via Script
excerpt: "After extensive searching the InterWebs and finding a lack of documentation on how to install TShark in a silent/unattended mode, I came across a related StackExchange post that got me on the right track. Here is what I came up with for Debian"
modified: 2015-09-12
tags: [bash]
comments: false
category: blog
---

After extensive searching the InterWebs and finding a lack of documentation on how to install <a href="https://www.wireshark.org/docs/man-pages/tshark.html" target="_blank" rel="noopener">TShark</a> in a silent/unattended mode, I came across a related <a href="http://superuser.com/questions/164553/automatically-answer-yes-when-using-apt-get-install" target="_blank" rel="noopener">StackExchange post</a> by Franck Dernoncourt that got me on the right track.  

Here is what I came up with for Debian:

```
DEBIAN_FRONTEND=noninteractive apt-get -y install tshark
```
## Background

For a pet project I am working on, I am creating an install script to install several security tools onto a virtual machine and got stuck when TShark  popped the following Qt screen:

![Qt Screen for configuring wireshark](/images/Configuring_wireshark-common-1-300x120.png)

My goal is to have everything installed and properly configured without a user's involvement.  There are several <a href="http://superuser.com/questions/319865/how-to-set-up-wireshark-to-run-without-root-on-debian" target="_blank" rel="noopener">resources</a> that show how to run Wireshark (TSHARK) as non-root, but that is not what I wanted.  I was ok with the default "<No>" but wanted to avoid being prompted for it.
