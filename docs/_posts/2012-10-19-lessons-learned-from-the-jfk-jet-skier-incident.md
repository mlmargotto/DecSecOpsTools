---
layout: post
title: "Lessons Learned from the JFK Jet Skier Incident"
excerpt: "Earlier this week media outlets had a field day with the news story about Daniel Casillo, the guy who swam up to the JFK runway..."
modified: 2012-10-19
tags: [Incident Response]
comments: false
category: blog
---

Earlier this week media outlets had a field day with the news story about Daniel Casillo, the guy who swam up to the JFK runway, climbed 8 feet of barbed wire, walked across two runways and then entered Delta's terminal 3.  <a href="http://abcnews.go.com/US/jet-skier-breaks-jfk-airports-100-million-security/story?id=16992190#.UCq1_1ZlT1Y">(See the ABC News Story.)</a>

Apparently this all went undetected until a Delta employee noticed the guy in the terminal, all dripping wet wearing his bright yellow life jacket.  Yikes!

Naturally, this type of news story is inflammatory and obviously mistakes were made.  Since I am not in any way connected with the incident, I can talk about it--unlike the folks dealing with all of the fallout there at JFK, TSA, and Homeland Security.  This posting is not about taking cheap shots at the hardworking people trying to secure the airport and since there is undoubtedly lots of information that will never be made public, I will stick to defensible high level lessons that we (as the public) can learn.

## Incident Handling

The general approach to Incident Handling holds that there are six phases.  These are:

* **Preparation**--Steps taken in advance to reduce the impact of an incident, in the event that it occurs.
* **Identification**--Detection that an incident has occurred to trigger an incident response.  The goal being detection as early as possible to reduce the impact.
* **Containment**--Steps taken reduce the spread of the security breach.  For instance to keep malware from spreading to other systems than haven't been infected or to prevent a physical intruder from breaching deeper into sensitive systems.
Eradication--Cleaning up and removing the artifacts left by the attacker.
Recovery--Returning systems to a state of normal or a new normal, as the case may be.
* **Lessons Learned**--Determining what went wrong and improving operations to prevent it from happening again.

These phases do not always apply in all situations and obviously a malware outbreak is handled differently than a physical security breach.  During the Lessons Learned exercise, it is helpful review the actions taken during each of the preceding phases.  Let's do that, because it is very instructive.

### Preparation

The media has loved to state the 100 Million Dollar price tag for the airport's Raytheon's Perimeter Intrusion Detection System.  The lesson here is that technologies are not solutions.  No amount of money can solve the problem, by itself.  Solutions are about <em>**people**</em> and <em>**processes**</em> as well as <em>technology.</em>

Think about the complexity of a system that costs $100MM.  Think about the complexity of a system that would be required to secure the perimeter of an airport the size of JFK.  Consider the quantity of inputs for each section of fencing and each door.  I wonder how many false alarms they have per day.  I wonder if they ever "mask" the inputs when environmental conditions (such as snow or ice) interfere with the proper functioning of the devices.  What is the policy for masking and unmasking the alarm inputs?

There are two security concepts that come into play--<em>defense-in-depth</em> and <em>compensating controls</em>.  The concept of defense-in-depth is about designing multiple overlapping controls (security measures) so that if a single control does not function as expected, there are other controls that are still effective.  The idea behind compensating controls is that if a control (such as a door alarm) is not operational; it is augmented by another control (such as a security guard).

When you read the story about the Jet Skier, it is easy to see that the concepts of defense-in-depth and compensating controls were violated.  This is conjecture only, but I suspect that this was not a failure in the original <em>technical design</em>.  I would also speculate that it is quite likely not even a failure in the <em>process design</em>, that is to say the Policies and Procedures around masking alarm inputs.  Most likely it was a failure of leadership, in not enforcing those policies.

### Identification

Surely, the JFK perimeter intrusion detection system must have been designed with early warning alarms to alert security to an intruder on the periphery.  We have already discussed defense-in-depth.  The reason that this <em>is</em> a public relations fiasco is because multiple layers of security <em>must </em>have failed for Casillo to have reached the terminal undetected by security.  Perhaps the system did detect the guy, but "detective controls" require a security guard to respond with appropriate action.  The key take-away here is that the earlier an intrusion is detected and responded to the lower the impact will be.  Think of the non-story this would be if the instant Casillo started to climb the fence a security vehicle confronted him.

## Containment

With regard to a physical security incident in progress, containment means keeping intruders from penetrating further into your sensitive areas than they already are when they were detected and the event was determined to be a security incident. Ideally, this is before the intruder reaches any sensitive areas like planes or airport terminals.

### Eradication

In an airport security breach, the eradication can be the hard part.  It was not simply a matter of arresting Daniel Casillo on charges of criminal trespassing.  They also had to make absolutely sure of the security of the airplanes near that terminal before they could take off.  This eradication phase would be easiest if they have complete video coverage of the intruder from the moment he climbed the fence until they arrested him.  Otherwise it could involve physical inspection of the airplanes.  This is where preparation phase pays off.

### Recovery

The recovery phase involves giving the all clear after validating that it is safe to return to normal operations.  This decision is made by management after making sure that eradication is complete, but continuing to monitor the situation to make sure that eradication was successful.

### Lessons Learned

In the ABC article posted above, the Port Authority is quoted as calling for an "expedited review of the incident and a complete investigation to determine how Raytheon's perimeter intrusion detection system-which exceeds federal requirements-could be improved."  Based on the quote, it seems as if the Port Authority is already assigning blame--prior to the investigation.  The <em>Lessons Learned</em> phase could be quite painful for the security team involved and I empathize with them.  But, this is how improvements are made.

If they focus on just the technology and its manufacturer and not the people or the processes around how it is used then it is quite likely that they will not have learned all that much after all.

## Final Thoughts

We really do not know the motivation of Daniel Casillo.  I suspect that he probably was just tired, cold, and frustrated.  But allegedly, he did climb a fence (a preventive control) and ignore signage (a deterrent control).  None the less, I do hope that he is dealt with gracefully.

Lastly, it is unlikely that we will know many of the details of the specific failures because they would reveal sensitive information that would be useful to an attacker with truly malicious intentions.  An insider with more complete information may think that I am way off base--If so please forgive me.  However, because there is learning value in dissecting this incident as reported I have done so.
