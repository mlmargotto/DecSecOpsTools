---
layout: post
title: Create an EC2 that Runs Chrome for Sandboxed Web Surfing
excerpt: "Use a temporary system that is totally isolated from anything sensitive"
modified: 2019-01-26
tags: [osint]
comments: false
category: blog
---

Ever want to visit a website but don't trust it enough to use your personal/work computer? What you need is a temporary system that is totally isolated from anything sensitive. Why not use a cloud-based virtual machine, such as offered by Amazon Web Services Elastic Compute Cloud?

Here is how to do it, assuming you have an AWS Account. (If you don't have an account, it is easy to create one, just browse to [https://aws.amazon.com/](https://aws.amazon.com/) and select "Create an AWS Account.")

Launch an <strong>Amazon Linux 2</strong> EC2 Instance and SSH to it, then run:

```
sudo yum update -y
sudo amazon-linux-extras install mate-desktop1.x
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum install -y ./google-chrome-stable_current_*.rpm
```

Once the necessary software is installed, you need to connect to it with a client that supports X11-forwarding. I am a fan of [MobaXterm](https://mobaxterm.mobatek.net/) and the following settings will allow you to connect and run Chrome:

![Image of MobaXterm Configuration](/images/Xwindows-4.png)

After you connect, you should see Chrome listed in the Applications menu:

![Chrome on EC2 Instance Desktop](/images/chrome.png)

There you go, easy peasy. Of course you can install any other browser of graphical software as well.

NOTE: If you need to RDP to the instance instead of using an X-windows client, launch an Ubuntu EC2 instance and run this <a href="https://gist.github.com/Resistor52/726eec699aa06f59b5ed292b376e1888">script</a> as root.
