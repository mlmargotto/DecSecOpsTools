---
layout: post
title: Zero Factor Authentication
excerpt: "What do I mean by Zero Factor Authentication? ... "
modified: 2012-10-13
tags: [Security Management]
comments: false
category: blog
---

There is an important difference between “identification” and
“authentication.”  Identification is how a particular object (such as a
person, a device, or a program) is referenced.  The name badge worn by doctors
and nurses in a hospital is a good example.  Because of the way that identities
are used to reference an object, they should not be considered a secret.

Authentication is the process of vouching for the identity.  More often than
not, the authentication process uses knowledge of a secret to prove that the
identity is valid.  For example, many websites use an email address as the User
ID (the identity) and they also require a password.  When the correct password
is provided for the corresponding User ID, the identity has been authenticated.

This concept is pretty straightforward and works pretty well is the selected
passwords are strong and are rotated regularly.  Several folks have written
extensively on the problems with [weak passwords,](http://lifehacker.com/5505400/how-id-hack-your-weak-passwords)
[how to select them,](http://www.wikihow.com/Create-a-Secure-Password) and
[how hackers get passwords.](/blog/how-hackers-get-passwords/)
That is not what this blog posting is about.  I am writing
about “Zero Factor Authentication.”

What do I mean by Zero Factor Authentication?  Multifactor Authentication is
defined as a combination of more than one of the following factors:

* Something only I know (such as a password)
* Something that I have (such as a RSA Secure ID Token)
* Something that I am (a bio-metric measurement, such as a fingerprint scan)
* Some place that I am (such as my presence in a secure data center)

Zero Factor Authentication is using _something that everyone
knows_—your identity.  It sounds ludicrous, but it happens all of the
time.  Before I give some examples,  imagine what would happen if I presented
myself to the offices of Berkshire Hathaway and simply said I was Warren
Buffett.  Would they let me start transferring funds?  Of course not.

# Apple UDID

On September 3, a group calling themselves “AntiSec” claimed to have hacked
[12 million Apple Device ID’s from the FBI](http://news.cnet.com/8301-1009_3-57505330-83/antisec-claims-to-have-snatched-12m-apple-device-ids-from-fbi/).
This has since been debunked as a result of [an analysisby Security
researcher David Schuetz](https://darthnull.org/security/2012/09/10/tracking-udid-src/)
who determined that they were actually obtained via a security breach at
BlueToad.

None of this came as a surprise to another security researcher, Aldo Cortsi,
who has been raising concerns since last year. In a [blog post
(http://corte.si/posts/security/udid-must-die/index.html), dated September 9, 2011](/dead-link/),
Cortsi illustrated how five of the seven networks that he had
examined used only the Unique Device Identifier (UDID) to authenticate.

# Credit Card Tails

Another example of Zero Factor Authentication is the last four digits of a
Credit Card.  In the Payment Card Industry (PCI) this is referred to as the
tail.  In the US, it is common practice to print the credit card tail on
receipts so that you can _identify_ which credit card was used for the
transaction.  But if you [call the bank](http://www.nbcnews.com/id/44231957/ns/business-consumer_news/t/security-flaw-could-expose-credit-card-data/),
they may actually use the
credit card tail to authenticate you.  If you use information that has become
public for authentication, that is _zero factor authentication._

# Secret Questions

My last example of zero factor authentications is quote/unquote secret
questions.  Remember the [Sarah Palin Email Hack](http://www.wired.com/threatlevel/2008/09/palin-e-mail-ha/)?
The hacker reset her Yahoo password using Palin’s zip code,
birthdate, and the place she met her spouse.  These were all found by a simple
Google search.  My favorite secret question is mother’s maiden name.  Ever
hear of Ancestry.com?

# Summary

There are many other examples, but you get the idea.  When it comes to
authentication, do not use information that can be collected (like UDID’s) or
displayed (like a credit card tail) or is likely to become public (like
personal facts).  Instead, use a unique, strong password and keep your secrets,
secret.
