---
layout: post
title: Check Multiple AWS S3 Buckets for Missing Default Encryption
excerpt: "Here is a simple one-liner to check all the buckets in a single
account:"
modified: 1/4/2021, 13:14:00
tags: [AWS, scripting]
comments: false
category: blog
---

Amazon Web Services has made it easy to implement encryption-at-rest for S3
buckets, but older S3 buckets may have predated this feature enhancement.  If
you have a large number of buckets, this could be a tedious thing to check via
the console.  Here is a simple one-liner to check all the buckets in a single
account:

```
for ITEM in $(aws s3api list-buckets --profile $MYACCOUNT --output json | grep
Name \
    | cut -d":" -f2 | cut -d'"' -f2); do echo $ITEM " --- " $(aws s3api
get-bucket-encryption \
    --bucket $item --profile $MYACCOUNT 2&gt;&amp;1); done
```

Obviously you would set the value of `MYACCOUNT` with the name of the AWS
Account you are inspecting.  Alternatively you could also iterate through a
number of AWS accounts by nesting the above command in another FOR loop.

The output will look like the following two lines, where the first example
bucket ("my-unencrypted-bucket") shows the error that is returned by the
get-bucket-encryption command when the default encryption is not set while the
other line shows the response when default encryption is set.

```
my-unencrypted-bucket --- An error occurred
(ServerSideEncryptionConfigurationNotFoundError) when
calling the GetBucketEncryption operation: The server side encryption
configuration was not found

my-encrypted-bucket --- APPLYSERVERSIDEENCRYPTIONBYDEFAULT AES256
```
