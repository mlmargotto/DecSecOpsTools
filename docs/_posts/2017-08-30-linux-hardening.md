---
layout: post
title: Linux Hardening
excerpt: "I have found that [Lynis](https://cisofy.com/lynis/), is a great way
to audit a system for CIS benchmark compliance"
modified: 2017-08-30
tags: [hardening]
comments: false
category: blog
---

From a compliance perspective, organizations need to have a hardening standard
derived from an authoritative source with solid engineering-based reasons of
why we depart from any of the recommendations.  Most organizations use the
Center for Internet Security (CIS) Hardening Benchmarks because that choice is
easy to defend.  The CIS benchmarks reflect industry consensus around hardening
best practices and therefore adopting the benchmarks is an example of due care.

A hardening standard is intended to be a shared, living document that evolves
with threats and lessons learned by the organization via a change control
process. To ensure consistency and follow DevOps principles, the application of
the hardening standard should be scripted and managed via change control.  It
should also be audited to ensure that the expected configuration remains in
place over time.  I have found that [Lynis]("https://cisofy.com/lynis/"),
an open source tool is is a great way to audit a system for
CIS benchmark compliance.

Obviously, there are multiple ways to script the implementation of the
hardening guidance.  Here is an example for Ubuntu 14 that simply modifies the
weak, default security settings of the base OS as distributed
[harden-Ubuntu-Server]("https://github.com/Resistor52/SampleLinuxScripts/blob/master/harden-UbuntuServer14.sh")
