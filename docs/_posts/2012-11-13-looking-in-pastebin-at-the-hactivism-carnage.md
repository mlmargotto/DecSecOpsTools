---
layout: post
title: Looking in Pastebin at the Hactivism Carnage
excerpt: "The Web is full of news about websites that have been breached or
defaced by internet hackers. Occasionally these articles will include a
hyperlink to Pastebin.com..."
modified: 2012-11-13
tags: [Hacking]
comments: false
category: blog
---

The Web and Twitter is full of news about all of the Israeli websites that have
been breached or defaced by internet hackers.  Occasionally these articles
will include a hyperlink to Pastebin.com, such as the “[Ano nymous declares
'cyberwar' on Israel](http://www.cnn.com/2012/11/19/tech/web/cyber-attack-israel-anonymous/)”
story on CNN.com that references a pastebin.com [link](/dead-link/) with
more than 650 defaced websites.

There are multiple sites that are similar to Pastebin.com, how does a person
stay on top of them all?  My favorite resource is “The Oz Data Centa” at
[www.ozdc.net](/blog/goodbye-oz-data-centa/).  This site monitors the various
breach “dumping grounds” and catalogs its findings by Attacker, Target,
Attack Method, Dump Type, and source, among others.

The attacker’s twitter account is linked, if available, so you can read his
latest tweets or filter the Oz Data Centers result set to find his activity. 
The target contains the URL of the breached website.  One click and the victim
site loads in a new window.  The source is a hyperlink, typically to
pastebin.com.

## Looking at the Data

Poking around in the Oz Data Centa, the first thing that I noticed this week in
the archives at [www.ozdc.net](/blog/goodbye-oz-data-centa/) is the large
number of targets with the top level domain (TLD) of “il” for Israel.  Not
too surprising with all of the hactivism in the past week.

The next thing that jumped out at me is a record that was labeled “[13k
israeli personal details](/dead-link/)” (sic) that led to a dump
at [http://pastebin.com/raw.php?i=iSgmm2ec](/dead-link/) of user names and
passwords.  The top of the file said “15,000 Israelis Email Information part
1” and there were less than 5800 records.  I guess that he is still working
on the other parts.

Another interesting target was (allegedly) [www.condor-security.co.il](http://www.condor-security.co.il). 
According to their website, _“Condor is licensed by the Israeli Ministry
of Defense to engage in the consulting and training of the security field,
including Anti-Terrorism, Executive Protection, Security Management, Combat
Personnel, Corporate Security, Intelligence, Integrated Security Solutions and
Professional Equipment.”_

I am always aware that one cannot always believe everything one reads in
pastebin, however if this is true, they probably have some very upset
customers.  The dump at [http://pastebin.com/Vy5hqrF5](http://pastebin.com/Vy5hqrF5)
by Anonymous contained the first name, lastname, email, and plain text
passwords for a long list of contacts.  The list contained emails with TLD’s
of FR (France), NO (Norway),
FI (Finland), AU (Austrailia), RU (Russia) as the common email service
providers like gmail, yahoo, and Hotmail.  There is even an account with a
domain of “@US.ARMY.MIL.”  Very concerning.

Another attacker who calls himself “c0mandEr0r” posted his results from an
attack on Condor two days earlier but omitted the first and last names.
Apparently the attacks are not coordinated.  A quick look at the data showed
duplicate records.

Another [record](/dead-link/) in the Oz Data Centa
shows that a group calling themselves “The Wolf Pack” ran the OWASP Joomla!
Vulnerability Scanner and identified multiple cross-site scripting errors on
the [www.investinisrael.gov.il](http://www.investinisrael.gov.il). 
This site seems to be running an out-dated webserver (Microsoft-IIS/6.0). 
This proves once again that if you do not use a vulnerability scanner on your
website, someone else will.

![Screen Shot](https://kennethghartman.com/images/screenclip-300x89-300x89.png)

Another record stated “[35.000 Israelis Personal In...](/dead-link/)” but
just had hyperlinks.

But wait before you surf to hyperlinks found in pastebin!!  Remember that
these could be a phishing site loaded with malware just waiting for you to
drive by.  I always like to test them with [Wepawet](/dead-link/) and [Virus
Total](https://www.VirusTotal.com">www.VirusTotal.com) before surfing to
them.  And then, because I am really paranoid, I surf to them with a virtual
machine in EC2 ([aws.amazon.com/ec2/](http://aws.amazon.com/ec2/)).
In this case, I just got an anti-climatic 404-page-not-found error.

In the Oz Data Centa there were also some sites with a TLD of “PS” which
designates the Palestinian territories.  Most of these attacks were made by a
guy with the twitter handle of “th3inf1d3l.” He claimed several attacks,
including [pflp.ps](http://pflp.ps) which is the
website for the “Popular Front for the Liberation of Palestine.”

Another guy with the twitter handle of “r0gu3An0n” attacked
[www.thisweekinpalestine.com](http://www.thisweekinpalestine.com) and
then left a long rant on “MoralFaggotry” and killing in the name of
religion along with a list of breached accounts.  His post started with:
> “you like war?...you like killing and terrorism in the name of religion?
all humans need to stop this bullshit...no one owns land based upon a
religion ...NO ONE”

## Concluding Thoughts

Hacktivism is a very real threat and the amount of activity peaks during times
of conflict.  Innocent folks get caught in the crossfire.  If you collect
personal information, you have an obligation to protect that information with
adequate security.  Many of the sites that end up with information leaked to
pastebin.com were breached using SQL injection.  Test your sites with a
vulnerability scanner and monitor your logs.  Lastly, use sites like the OZ
Data Center to detect a breach after the fact.  And if you are breached, get
your data out of pastebin!
