---
layout: post
title: FIPS 140-2 in a Nutshell
excerpt: "Guide to understanding FIPS 140-2 validation levels"
modified: 2016-08-26
tags: [Security Management]
comments: false
category: blog
---

The US Federal Government requires that its agencies protect sensitive, but
unclassified information using cryptographic modules that have been validated
to
[Federal Information Processing (FIPS) Standard 140-2 “Security Requirements
for Cryptographic Modules.“](http://csrc.nist.gov/publications/fips/fips140-2/fips1402.pdf) 

This standard replaced its predecessor, FIPS
140-1.  In this context, the term “validated” means tested by accredited
testing organizations to demonstrate that the module itself provides a specific
level of security assurance.

To fully understand what FIPS 140-2 validation of a particular security
product, it is important to understand the contextual meaning of “module”
as defined by the standard:

**Cryptographic module**: the set of hardware, software, and/or firmware that
implements approved security functions (including cryptographic algorithms and
key generation) and is contained within the cryptographic boundary._

In the field of information security, the concept of a security boundary is of
vital importance.  Security is assurance (to a specific level) is only offered
within a specific, defined boundary.  In other words, if a certain HSM has FIPS
140-2 validation it can be trusted to perform its cryptographic functions
securely _within the limits of the defined level of security_.  However,
it is still possible to implement an HSM in an insecure manner making the FIPS
140-2 validation misleading to a layman who does not understand the limitations
of the validation.  The Overview section of the standard even contains the
following caveat:

_Similarly, the use of a validated cryptographic module in a computer or
telecommunications system is not sufficient to ensure the security of the
overall system._

Discussions regarding FIPS 140-2 typically involve a determination of what
_level_ of security is appropriate.  The FIPS 140-2 Standard defines
four different levels:

* **Security Level 1** – This is the lowest level of security. While only
approved security functions or algorithms may be used there are no specific
physical security requirements.  This security level allows the cryptographic
module to be implemented in software.  The standard reads, “Security Level 1
allows the software and firmware components of a cryptographic module to be
executed on a general purpose computing system using an unevaluated operating
system.”

* **Security Level 2** – Requires tamper-evidence as a physical security
measure. This is typically implemented by using special coatings or seals of
physical boundary of the security module.  In addition, the operating system
must meet the specified Common Criteria Protection Profiles listed in the
Standard’s Annex B.  As a result of these requirements the security module
must take on a specific form factor and is listed as a specific product on the
[list](http://csrc.nist.gov/groups/STM/cmvp/documents/140-1/1401vend.htm)
maintained by NIST.  Security Level 2 also requires role-based authentication.

* **Security Level 3** – Attempts to thwart an attacker from obtaining the
plaintext secrets (called “critical security parameters” by the standard)
by securely wiping the memory when the module is tampered with. Level 3
requires that the plaintext secrets moved in or out of the cryptographic module
use a trusted path to protect their integrity and confidentiality.

* **Security Level 4**–This is the highest and most rigorous level of
security and is suitable for operation in physically unprotected environments.
The goal at this security level is to detect and thwart all manner of physical
access attempts, including manipulations of voltage or temperature, destroying
the secrets if necessary.

The four different levels of security allow the data owner to determine the
level of security that is warranted based on the data’s classification and
the threat model.  Additional security comes at an increasing cost.  Since it
is expensive for the device manufacturers to obtain FIPS 140-2 validation for
each product, this expense is baked into the cost of the unit.
