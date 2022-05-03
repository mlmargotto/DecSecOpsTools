---
layout: post
title: HTTPS: Is it Possible to Forge a Web Server Certificate?
excerpt: "Yes, it is possible in theory..."
modified: 2016-03-12
tags: [PKI]
comments: false
category: blog
---

Yes, it is possible in theory to forge the Web Server Certificate that is used in SSL/TLS communication. This is because the certificate is signed by a certificate authority that your browser trusts using a cryptographic hashing algorithm of a specific length. The hashing algorithms that have been used to sign certificates are (from newest to oldest) SHA256, SHA1, and MD5. The output of a MD5 hash function is 128 bits, while a SHA1 digest is 160 bits, and a SHA256 is (you guessed it) 256 bits. One of the design features of a cryptographic hashing algorithm is that it is infeasible to predict the output (the “digest”) based on its input. However, for any hash function, there are only a limited number of possible outputs, although this is a very large number. The number of possible digests doubles for every additional bit added to the length of the digest.

When two different inputs to a given hash function generate the same digest, it is called a “collision.” At a conceptual level, the fact that collisions are possible should make sense because there are literally an infinite number of possible inputs but only a large, but finite number of outputs of a hash function. However, even though collisions are theoretically possible, in practice they are computationally expensive to determine, particularly when trying to identify a second certificate that creates the same digest of the certificate that you are attempting to forge.

As an example, Bruce Schneier, a crypto expert wrote a blog post in 2012 projecting that it would take about $700,000 to generate a bogus SHA1 Web Server Certificate in 2015 using Amazon EC2 pricing. More importantly, he predicted that the price would drop to about $43k by 2021. (See <a href="https://www.schneier.com/blog/archives/2012/10/when_will_we_se.html" target="_blank" rel="noreferrer noopener">When Will We See Collisions for SHA-1?</a>)

It is for this reason that the internet community is moving away from SHA1 Certificates to SHA256 Certificates. In 2008, a group of security researchers actually published details on how they forged the MD5 certificate of a Certificate Authority using a collision-based attack. (See <a href="http://www.win.tue.nl/hashclash/rogue-ca/" target="_blank" rel="noreferrer noopener">MD5 considered harmful today</a>.)  This research hastened the move away from MD5 to SHA1.
There are other innovations that such as Certificate Transparency and Certificate Pinning that also help to mitigate the threat of a forged web server certificate in practice. But those are potential topics for future posts.

NOTE: This has been cross-posted from <a href="https://www.quora.com/HTTPS/Is-it-possible-in-theory-practice-to-forge-an-SSL-certificate/answer/Kenneth-G-Hartman" target="_blank" rel="noreferrer noopener">Quora.com</a>
