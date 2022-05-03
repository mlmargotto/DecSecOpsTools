---
layout: post
title: "Defense-in-depth, Part 2"
excerpt: "Last post, I discussed the concept of defense-in-depth (DiD) where overlapping controls provide increased security, particularly if one of the controls should happen to fail. Now, I will give a specific example—host-based firewalls."
modified: 2013-08-12
tags: [Security Management]
comments: false
category: blog
---

[Last post](/blog/defense-in-depth/), I discussed the concept of defense-in-depth (DiD) where overlapping controls provide increased security, particularly if one of the controls should happen to fail. Now, I will give a specific example—host-based firewalls.

Both the Windows and Linux operating systems have firewalling capabilities built into the OS. Frequently, I will find that the local system firewall has been turned off. This is especially true with Linux servers because iptables, the Linux firewall process, can take some kung fu to properly configure. When asked why iptables is off, the system owner will typically say that there is no need for it because the system is protected by the network firewall. When I hear this, I recognize that the architecture is missing a valuable DiD layer.

As an example, let’s discuss a Linux web server. For discussion purposes, let’s assume that the system is deployed as a web server that serves web content on ports 80 (http) and 443 (https). The system may also run secure shell on port 22 for remote administration. In this case, the network firewall will be configured to pass in traffic destined for these ports, but one should take the time to configure iptables as well. Why? Remember, that the idea behind defense-in-depth is to provide additional protection when another control fails. How would the network perimeter firewall fail? Well, it could get misconfigured to allow unwanted traffic, or it could be circumvented.

You may even want to configure iptables to log connection attempts on any unauthorized ports, which in our example is 80, 443, and 22. If you do that, then your monitored logs will alert you to the high probability of an intrusion attempt. Also, iptables can help prevent malware or unauthorized processes on the server from opening additional ports or making remote connections to the outside. If you have iptables configured to block outgoing connections, then a log recorded on the network firewall indicating an outbound connection has much more weight as an indication of a compromise.

To add an additional layer of security, an intrusion detection system can be employed between the network firewall and the webserver. If you use an IDS, take the time to whitelist the specific ports that are authorized in both the firewall and the host firewall.

Another example of DiD is to ensure that your logs can be correlated. Consider the path that legitimate traffic will take to the webserver. It will flow through the firewall, possibly an intrusion detection system or web application firewall and load balancers to the host firewall and then ultimately to the web service. If somehow an attacker manages to circumvent a protection layer, it will be evident in some logs but not the logs of the systems that were circumvented. Also, if an attacker manages to corrupt or tamper with a log, the other logs will provide insight. Oh, and by the way, make sure that each logging process is configured to log the appropriate data elements. For example, the default Windows web server (IIS) log settings are generally inadequate to provide useful forensic insight.

Defense-in-depth takes thoughtful consideration and even some testing to get it right, but the peace of mind is well worth the effort.
