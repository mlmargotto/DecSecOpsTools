---
layout: post
title: "ZeroBin as a XSS Attack Platform"
excerpt: "What if you could have hundreds of websites from which to launch an encrypted cross-site-scripting attack?"
modified: 2013-07-12
tags: [Hacking]
comments: false
category: blog
---

<em>What if you could have hundreds of websites from which to launch an encrypted cross-site-scripting attack?</em>

<em>What if the webservers could store the XSS attack code for you but could not decrypt it?</em>

<em>What if the encrypted code could be set to expire after a set time or immediately after attacking a single person?</em>

As it turns out, many reputable (and not so reputable) web hosts across the internet are hosting ZeroBin PHP code that is vulnerable to XSS.  ZeroBin is an open source project authored by Sebastien Sauvage, and hosted on his <a href="http://sebsauvage.net/wiki/doku.php?id=php:zerobin" target="_blank" rel="noreferrer noopener">web page</a>.  The ZeroBin project received considerable publicity after <a href="http://www.informationweek.com/security/vulnerabilities/anonymous-builds-new-haven-for-stolen-da/232900590" target="_blank" rel="noreferrer noopener">Information Week</a> and <a href="http://arstechnica.com/information-technology/2012/04/anonymous-builds-its-own-pastebin-like-site/" target="_blank" rel="noreferrer noopener">Ars Technica</a> wrote articles in April 2012 about Anonymous selecting ZeroBin for their AnonPaste data-sharing sites.  This move by Anonymous was in response to the PasteBin announcement that they were starting to increase the monitoring of the content posted to PasteBin.

In the past year, multiple blog posts have been written about the utility of ZeroBin and several sites now host the vulnerable code.  The ZeroBin Project maintains a version history and while all current versions are vulnerable, Alpha 0.18 (the current version) added a robot meta tag to prevent search engines from indexing the page.

A Google dork was used to find all of the vulnerable Alpha 0.15 systems (http://www.google.com/?q=intitle:zerobin+-site:github.com+%22Alpha+0.15%22) which at the time of this writing is 132 hits.  There are likely to be many more systems out there at the Alpha 0.18 version level that are not crawled by GoogleBot.  Version 0.18 systems will still show up in search results if a user posts a hyperlink to pasted content.

A hyperlink to a ZeroBin posting has a query string that consists of two parts:

* A unique identifier to the content stored on the ZeroBin server, and
* An AES 256 Encryption key

Separating the two components is a number sign symbol, effectively making the browser treat the encryption key as a bookmark that it does not transmit to the ZeroBin server.  All encrypt and decrypt operations happen in the browser.  The full hyperlink, including the key can be exchanged with others via email, instant messanger, or message boards and can be reduced by any common URL shortener that does not remove bookmarks from the URL.  An interesting feature is the pasted content can expire immediately after it is read (executed) once using the “Burn after reading” option.  The content will also expire after a set time.  Refer to the project website for more details.

I discovered the XSS vulnerability after hearing colleagues discussing ZeroBin and out of force of habit plunked in the standard <script>Alert("XSS")</script> to see what would happen.  Up popped the message box, indicating the vulnerability.

Note that the newer web browsers are attempting to mitigate cross-site-scripting vulnerabilities, so Internet Explorer 10 will not permit the pop-up, but IE 9 will.

OWASP has made the dangers of XSS well known, but there are still too many occurrences on the internet.  This particular vulnerability is particularly troubling because the attack hyperlink could be from a trusted domain and forensic analysis is made more complicated due to the nature of the ZeroBin architecture.

The good news is that the fix is very straightforward. Sanitize the input and output.  For the Alpha 0.18 version, this can be done by modifying the zerobin.js file as described below.

Change line 198 from:

```
setElementText($('div#cleartext'), cleartext);
```

To:

```
$('div#cleartext').text(cleartext).html();
```

Change line 353 from:

```
setElementText($('div#cleartext'), $('textarea#message').val());
```

To:

```
$('div#cleartext').text($('textarea#message').val()).html();
```

----------

**UPDATE:** This vulnerability is now patched. Read the [post](/blog/zerobin-xss-vulnerability-patched-in-0-19/).
