---
layout: post
title: The Encryption Magic Bullet
excerpt: "Encryption is not a magic bullet, but it does it play a vital role in
a company’s data protection strategy."
modified: 2016-07-12
tags: [Encryption]
comments: false
category: blog
---

This post is a response to a variety of discussions that I have had lately with
a variety of customers, executives, salespeople, and even engineers that are
working on security projects for a variety of companies.  Sometimes, it seems,
that encryption is positioned as the “Magic Bullet” that will cure all of
their data protection woes.  Worse yet, some will say that the “emperor has
no clothes” or call their project “security theater.”

Encryption is not a magic bullet, but it does it play a vital role in a
company’s data protection strategy.  Most people are aware that there are two
high-level types of encryption. These are _encryption-at-rest_ and
_encryption-in-transit_.  Because an end-to-end encryption commitment
uses both types of encryption in various ways, it is important to dive just a
little deeper to eliminate any confusion when a cloud service provider is
discussing encryption.

# Encryption-at-rest

The security goal of encryption-at-rest is to provide access control by
permitting only the authorized users or processes to view or alter the
unencrypted data. As a result, it protects the integrity and confidentiality of
the data.  Unauthorized users or processes will see ciphertext.  Ciphertext
looks like random data and has no discernible patterns or meaning.

The most important thing to remember when thinking about encryption-at-rest is
that _the entity which holds the encryption/decryption key is responsible
for enforcing access control_.  Encryption can be applied at different
layers to mitigate various types of threats pertaining to unauthorized access.
For example, sometimes this is implemented at the storage layer using
self-encrypting disks.  In this case, the storage operating system holds the
key.  If a disk drive is removed and connected to another system, the data will
not be able to be read.  It is important to note that if an attacker can come
through the operating system that _is authorized_ to use the storage
system, this type of encryption will be ineffective.  This kind of encryption
is also known as **_transparent disk encryption_** because the
encryption and decryption operations operate in a manner that is transparent to
the operating system.

Moving up a layer, there is also **_transparent database encryption_**.
The database system performs the encryption, and it is indeed transparent to
the applications which store data in the database.  Because the database
management system holds the key, it has the access control responsibility.
Access to the data must be made via the database management system, which will
typically implement role-based access control.  Anyone attempting to access the
data by circumventing the database management system will only see ciphertext.

With **_application-layer encryption_**, the application holds the
encryption key in memory and encrypts specific fields before inserting them
into the database. Therefore, the application performs the access control
duties. If the database administrator directly queries the database, all that
will be returned are records that contain ciphertext.

So far we have talked about three different types of data encryption at rest,
but what about the storage of the encryption keys? Typically, a **_Hardware
Security Module (HSM)_** is used to store the keys and provides other
important security features.

Encryption keys should never be stored with the application or the data they
encrypt.  Sadly, this is sometimes the case.  Instead, when the application or
database initializes, it will authenticate itself to the HSM and will obtain
its keys using specific function calls that perform the key handling operations
securely.

In addition to storing keys, Hardware Security Modules provide features for
automating the key management processes.  Any manual key handling processes
require the cooperation of two different people to achieve what is known as
“split control,” a security best practice.  HSMs are also tamper-resistant
and will shred the keys if someone tries to open the physical container.

# Encryption-in-transit

The security goal of encryption-in-transit is to create a secure communication
channel between two processes or people so as to protect the confidentiality
and integrity of the information exchanged.  The security of the channel is
typically attacked by trying to eavesdrop or attempting to take a
man-in-the-middle (MITM) position between the two parties that are
communicating.

For an attacker to achieve a man-in-the-middle position, they must impersonate
the client to the server and impersonate the server to the client.  It is for
this reason that it is imperative to authenticate the parties that are
attempting to communicate securely.  The server typically asserts its identity
using a web server certificate that the client trusts.  Sometimes the client
will also use a certificate that the server trusts to authenticate itself to
the server and other times the client authentication is left to the web
application login functionality.  Obviously, it is important that the login
credentials are not passed to an imposter.

Many organizations are either moving to encryption between internal services or
have already implemented it.  By requiring mutual authentication and encryption
for services that exchange sensitive data with other services within an
organization’s production environment, this enables the “least privilege”
security tenant.  Each system or service only needs to talk to only a few other
specific systems or services that need to consume its data.

# What could go wrong?

Most people know better than to create their own cryptographic algorithms.
Security through obscurity never works, especially with encryption.  For this
reason, it is important to use only ciphers that have withstood the test of
time with lots of public scrutiny.  Security should depend on the secrecy of
the key and not the secrecy of the algorithm.  Assuming that an industry
accepted cipher such as the advanced encryption standard (AES) is used, there
is still lots of room for implementation issues.  Implementation issues could
be another lengthy post, but two of the most common tend to be keeping both an
unencrypted copy of the data along with the encrypted data or mishandling the
encryption key.  The main point here is that it is important to do a complete
security analysis of an organization's encryption rather than just to accept
that they have the encryption magic bullet.
