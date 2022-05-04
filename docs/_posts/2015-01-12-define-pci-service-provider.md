---
layout: post
title: "Define: PCI Service Provider"
excerpt: "When working with the Payment Card Industry Data Security Standard
(PCI-DSS) it is important to understand this definition to make sure your
compliance program is properly focused.  A company may be both a service
provider, a merchant, as well as simply a cardholder."
modified: 2015-01-12
tags: [Compliance]
comments: false
category: blog
---

A **PCI Service Provider** is a "_Business entity that is not a payment
brand, directly involved in the processing, storage, or transmission of
cardholder data on behalf of another entity. This also includes companies that
provide services that control or could impact the security of cardholder data.
Examples include managed service providers that provide managed firewalls, IDS
and other services as well as hosting providers and other entities."_ [1]

When working with the Payment Card Industry Data Security Standard (PCI-DSS),
it is important to understand this definition to make sure your compliance
program is properly focused.  A company may be both a service provider, a
merchant, as well as simply a cardholder.  Each of these roles has different
compliance implications.  When a company issues corporate credit cards to its
staff, the company is in the same role as the individual employees--cardholder.


**Cardholders** are defined as "_Non-consumer or consumer customer to whom a
payment card is issued to or any individual authorized to use the payment
card_ [1]."  Cardholders are not subject to the PCI-DSS, only merchants,
service providers, acquiring banks, and issuing banks.   Also note that the
payment brands (MasterCard, Visa, American Express, JCB, and Discover)
themselves are not required to be PCI compliant, even though they comprise the
PCI Security Standards Council.

The PCI Council defines a **Merchant** _as any entity that accepts payment
cards bearing the logos of any of the five members of PCI SSC (American
Express, Discover, JCB, MasterCard or Visa) as payment for goods and/or
services. Note that a merchant that accepts payment cards as payment for goods
and/or services can also be a service provider, if the services sold result in
storing, processing, or transmitting cardholder data on behalf of other
merchants or service providers. For example, an ISP is a merchant that accepts
payment cards for monthly billing, but also is a service provider if it hosts
merchants as customers" _[1] .

For Service providers, there is the "telecommunications exception" which
states, _"If an entity provides a service that involves only the provision
of public network access—such as a telecommunications company providing just
the communication link—the entity would not be considered a service provider
for that service (although they may be considered a service provider for other
services)"_ [1].

## What does all this mean?

If you are a Merchant who uses vendors, you should have a clear understanding
of which of your vendors are PCI Service Providers (as defined above).  PCI
Service Providers may also have sub-contractors that are considered PCI Service
Providers.  Furthermore, there should be a contractual requirement to have the
vendor provide their Report of Compliance (RoC) or at a minimum, an Attestation
of Compliance (AoC) on an annual basis.

There are 12 Requirements of PCI and each of these requirements have
sub-requirements.  Not all of the requirements have to be met by a PCI Service
Provider but the customer of the service provider should agree on exactly which
ones the Service Provider shall meet.  It is also in the Service provider's
best interest to clarify this with their customers so that there is not any
misplaced trust.  One of the best ways to facilitate this discussion is to
create a "Controls Responsibility Matrix" that lists each of the requirement
and sub-requirements in a table with an indication of who is responsible to
meet each specific security control.  Although this can be a tedious process,
it positions the vendor to best meet the needs of their customer.

[1] <a
href="https://www.pcisecuritystandards.org/documents/PCI_DSS_Glossary_v3-1.pdf">
https://www.pcisecuritystandards.org/documents/PCI_DSS_Glossary_v3-1.pdf</a>
