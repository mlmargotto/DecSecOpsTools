---
layout: post
title: "Skype in the Enterprise"
excerpt: "The following excerpt is a thread... This discussion was the impetus
for my article Is Skype Secure?"
modified: 2011-07-04
tags: [Encryption]
comments: false
category: blog
---

_**The following excerpt is a thread from a discussion on LinkedIn in the
Information Security Community group. This discussion was the impetus for my
article [Is Skype Secure?](/media/Is_Skype_Secure.pdf)  which includes an
assessment of Skype Security Risks and an assessment methodology.**_

## Question:

* _Anybody using Skype yet at an enterprise level? If so, what changed your
mind about the "vulnerabilities" claimed to be associated with it?_
* _Is Skype secure for business?_
* _Is Skype Safe?_

## Ken Hartman:

My biggest concern with using Skype in the enterprise is the number of peer to
peer connections that it makes when the software is launched. To see what I
mean, type the command “netstat –no” at the command line before and after
launching Skype.

Skype has posted an independent security review at [http://download.skype.com/share/security/2005-031%20security%20evaluation.pdf](http://download.skype.com/share/security/2005-031%20security%20evaluation.pdf)
which covers the secure design considerations and touts its usage of
encryption. However, I am uncomfortable with multiple encrypted p2p connections
to IP addresses across the globe. To see what I mean use the “nslookup”
command at the command line on some of the connections reported by netstat as
being created by the Skype process ID.

There is a fairly interesting analysis of the Skype Protocol at [http://arxiv.org/ftp/cs/papers/0412/0412017.pdf](http://arxiv.org/ftp/cs/papers/0412/0412017.pdf)
that explains how the peer to peer connections seem work, but the paper was
published in 2004, so it may be not have the most up to date information.

For enterprise communications, I personally prefer a communication product that
uses a centralized server that I can control--such as Microsoft Office
Communications Server (now called “Lync”) because I can also control the
traffic to and from it.

It will be quite interesting to see what Microsoft does with Skype.

## Comment:

_@Kenneth &mdash; Your points are valid certainly. But, the cost MS OCS is
certainly non-trivial as well. If you implement OCS, you have to deal with
redundancy and single-point of failure issues as an engineered solution. The
hardware alone on this type of implementation ran $1.2M for one of my clients
last year. Sure these kinds of consulting projects makes us consultants smile,
but you can certainly understands why many organizations would opt for Skype
instead of spending this level of cost when they could get Skype for free!_

## Ken Hartman:

Point well taken regarding the TCO and I know that “Free” is certainly
alluring. I use Skype and I like it, but I use it in my home office on a
virtual machine. Since “you cannot secure what you do not understand,” I
just wanted to call to everyone’s attention that Skype uses a proprietary,
encrypted protocol that connects to multiple servers based in multiple foreign
countries. As security professionals, we must do a risk assessment in addition
to doing a cost-benefit analysis and of course it depends on the type of data
your enterprise is trying to protect. Some organizations may accept the risk,
but it’s about making informed decisions. Other organizations may feel that
their enterprise is more secure if they have more control over the
communication technology used. Many regulated businesses need to monitor and
log the communications leaving their business. For those organizations, Skype
may not be acceptable, but open source technologies that they can fully control
probably are. I would love to hear from other folks who have made a policy
decision regarding Skype and what they opted instead.

## Comment:

_@Kenneth - Roger, that...I think anybody using Skype does not have a
security policy in mind. They're using it for the sheer convenience of a "FREE"
phone call, or low cost international service, and the video conferencing
capability. It’s all about convenience; not about security._
