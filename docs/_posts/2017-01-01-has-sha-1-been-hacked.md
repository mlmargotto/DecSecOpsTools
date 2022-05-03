---
layout: post
title: Has SHA-1 been hacked?
excerpt: "To summarize, SHA-1 has not been hacked, it is just simply not strong
enough with today's computing power."
modified: 2019-01-12
tags: [PKI]
comments: false
category: blog
---

No, not exactly.  The SHA-1 hashing algorithm still does what it is supposed to
do.  SHA-1 creates an unpredictable 20 byte “fingerprint” of the data input
into the function, in this case a web server certificate.  It is the
unpredictability of the output that makes cryptographic hash functions so
useful.  After all, if the fingerprint could be predicted based on how the
input changed, it would be easy for an attacker to forge a web server
certificate.  Simply changing a single bit from a “1” to a “0” produces
a dramatically different fingerprint.

When two different inputs are found that produce the same fingerprint, this is
called a “collision.”  Collisions are certainly possible for any hashing
function, not just SHA-1.  This is because there are an infinite number of
possibilities for the input and only a finite number of outputs.  Since the
output cannot be predicted, the only way for an attacker to generate a bogus
web server certificate is to try one after the other and see if they get a
collision.  In this case, a collision would be a rogue certificate that has the
same SHA-1 hash as the certificate being forged.  This is called a “brute
force attack” and is a well-known technique.

The strength of the hashing function is based on how much work a computer must
do to find a collision.  Therein lies the problem—computers are getting
faster and faster.  Bruce Schneier is a well-known cryptographer, speaker, and
blogger.  He wrote a <a
href="https://www.schneier.com/blog/archives/2012/10/when_will_we_se.html">post<
/a> estimating the cost of creating a single bogus web server certificate that
is signed with the same SHA-1 digest at $700,000 but predicted the cost to drop
to $43,000 by 2021 due to Moore’s Law. A <a
href="https://eprint.iacr.org/2015/967.pdf">2016 paper</a> concludes that the
attack might be able to be performed in a few months using rented Amazon EC2
resources for $75,000 to $120,000.

To summarize, SHA-1 has not been hacked, it is just simply not strong enough
with today's computing power.
