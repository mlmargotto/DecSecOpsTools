---
layout: post
title: "How Hackers Get Passwords"
excerpt: "Systems that contain more sensitive data need to have stronger passwords.  Strong passwords do not use words from the dictionary and use symbols and numbers..."
modified: 2012-07-13
tags: [Security Management]
comments: false
category: blog
---

Have you considered how some of the systems that you access every day are more critical than others?  Systems that contain more sensitive data need to have stronger passwords.  Strong passwords do not use words from the dictionary and use symbols and numbers.  When it comes to passwords, longer is better.

## Attacking Passwords

To understand how to pick a strong password, it is helpful to understand how passwords are attacked.  There are two methods---guessing and cracking.

* **Password Guessing** involves systematically attempting to use passwords on a live system.  Many modern systems will temporarily lock out the user account or block the source of the guessing attack if too many attempts are made too frequently.
* **Password Cracking** uses a password file that may have been extracted from a system by some sort of hacking attack.  Because the passwords are encrypted (hashed) in the file, <em>cracking </em> involves systematically encrypting a password guess to see if the hash of the guess matches the actual password’s hash.  Unlike password guessing, password cracking software can attempt several hundred passwords a second.

It typically is not too hard for the attacker to figure out the encryption algorithm based on the length of the hash among other things.  This task is made even easier if the attacker can register one or more accounts on the system in advance, because then the attacker will already know some of the passwords and will just have to try different techniques to determine the encryption algorithm.

## Three Techniques for Systematically Guessing or Cracking a Password

Regardless of whether the software is trying to guess or crack a password, there are three techniques for attacking a password:

* **Dictionary Attack**---A dictionary attack consists of a list of potential passwords that is feed into password attacking software.  Where does this list come from?  Every time a large list of passwords is leaked on the internet, hackers use this data for their dictionary attacks.  The lists are sorted in rank order of frequency so that accounts with the most common passwords are at the top.  And if you think that you are clever by using profanity, you would be wrong.  It is not uncommon for attackers to collect dictionary words from the Facebook pages of those they attack and to glean buzzwords from online publications of the industry of the site that they attack.
* **Brute Force Attack**---A brute force attack is simply guessing passwords in sequential order, such as a-z, aa-zz, aaa-zzz, etc.  Of course, mixed case and symbols are also used.
* **Hybrid Attack**---Most modern password attack software will use a combination of both a dictionary attack and a Brute Force Attack.  Some software, such as “John the Ripper” will even try common permutations so typing like a hacker does not make you more secure either.

**Conclusion**

Everyone agrees that we all need to use too many passwords.  Because we need to access so many different systems, people tend to reuse passwords.  However when passwords are reused on sensitive systems, that sensitive information is at risk.  Simply tacking on a number to a word (such as “Ninja99”) is a password that is easy to crack.  Instead use the first letter from a phrase such as “#12GmTotR&R” which can be remembered by “#12 Give me That old time Rock & Roll.”  Or use a password vault to generate the random password for you.

<hr>

NOTE: This is a Security Awareness Article, for a more technical discussion of the topic <a href="http://www.informit.com/articles/article.aspx?p=704311&seqNum=4">check out this excerpt</a> from Ed Skoudis’s Counter Hack Reloaded book. (<a href="http://www.amazon.com/gp/product/0131481045/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0131481045&linkCode=as2&tag=kennetcom-20">Counter Hack Reloaded: A Step-by-Step Guide to Computer Attacks and Effective Defenses (2nd Edition)</a>)
