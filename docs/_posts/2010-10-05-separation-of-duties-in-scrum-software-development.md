---
layout: post
title: "Separation of Duties in Scrum Software Development"
excerpt: "An important consideration for organizations incorporating agile
techniques into their Software Development Life Cycle (SDLC)."
modified: 2010-10-05
tags: [Security Management]
comments: false
category: blog
---

**<em>The following excerpt is a thread from a discussion on Linkedin in the
CISSP group.  I repost it because I think that it is an important consideration
for organizations incorporating agile techniques into their Software
Development Life Cycle (SDLC). </em> **

**Date:** October 5, 2010

## Question:

<em>I am looking for some input on “separation of duties” and “access
control” concerns in regard with the SCRUM software development model. </em>

<em>My R&D team is running a pilot on SCRUM. The developers on the pilot team
test each other code (apparently both unit and system testing), have access to
the QA environment, etc. They believe it is a standard practice for SCRUM. </em>

<em>Thoughts, comments, practical recommendations?</em>

## Ken Hartman:

Ideally you would have a separate person/team installing the code on a QA box.
This would ensure that the essential documentation and "packaging" is in place
because you have a different set of hands touching it. Besides the security
benefit, the other advantage of separation of duties is that it must be
packaged better. We (Visonex) roll up several sprints into a quarterly release.
Only after you have the code deployment nailed on the QA server is it ready to
be deployed into production (Ideally by a third person/team).

If you are doing SCRUM, a 'must read' book is <em>Agile Testing</em> by Crispin
& Gregory. Among other things, the book introduces "Agile Testing Quadrants"
and talks about the various tests and which team member should be doing them.

## Question:

<em>Code promotion from Dev to QA - I agree, code promotion needs to be
controlled. We can try to put some process in place to restrict code promotion
to QA only. May not be easy though if developers are also to QA (testing often
require write access), but should be possible.</em>

<em>What are your thoughts on developers to perform integration testing? Any
concern that it violates the segregation of duties principle? The same person,
who developed new code, will be testing the code?</em>

## Ken Hartman:

Good points . I should clarify what I meant. Each SCRUM user story, according
to the authors of the book that I cited, should list the tests that the new
functionality should pass at the time that each user story is created. The
developers definitely need to test their code before passing it on to QA. In
fact, some software development systems can be configured to require that the
code pass the corresponding unit test before it can be checked back into the
source control system.

I think that having the developer create the automated unit tests that proves
that they coded the functionality per the user story causes the developer to
create higher quality code. The developers should run every test (including
integration testing) they need to so as to prove that their functionality:

1. Meets the new user stories, and
2. Didn’t break anything that was working---but they need to do this on an
anonymized server under their control.

Then, and only then, should it be passed to QA. When I stated above that the
code needed to be properly packaged, I meant that if the code is not
sufficiently documented so that a QA person can deploy it to their QA
environment without needing a developer to tweak it, then the code package
should be rejected back to development. This is essential for adequate
configuration management. If a developer has to tweak things on the QA system,
do you really have configuration management?

Now, the QA function should run all the same unit tests that were created by
the developer but this time on the anonymized QA environment. This way, the QA
function is verifying the adequacy of the unit tests in addition to the program
code. However, the QA function should not ever fix the program code or the
automated unit tests—it needs to be sent back to development and repackaged.

QA can and should run additional tests (these are mentioned in the Agile
Testing book) that include usability, performance, load, stress, and
scalability but one of the main qoals of the QA function is to make sure that
everything is packaged up properly, meets the requirements and is ready for
production.

In summary, developers should definitely do testing before the hand off to QA.
QA should verify that development tested adequately. Preventing QA from making
fixes increases transparency and achieves separation of duties.
