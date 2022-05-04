---
layout: post
title: "Shannon Entropy of Various File Formats"
excerpt: "Today, I will show the results of using this tool for a cursory
examination of the Shannon entropy of various, common file formats."
modified: 2013-05-13
tags: [Encryption]
comments: false
category: blog
---

In yesterday’s [post](/blog/calculate-file-entropy/), I introduced a tool
(graph_file_entropy.py) that I created to visualize the frequency distribution
of the bytes in a file.  For today, I will show the results of using this tool
for a cursory examination of the Shannon entropy of various, common file
formats.  This will illustrate benefits and limitations of using Shannon
entropy to indicate possible encryption.

## File 1 – TestDoc.DOCX

For a representative MS Word file that would be similar to what might be found
on any computer, I used the word file to create the [Understanding the Role of
Trust in the Protection of Privacy](/media/Understanding-the-Role-of-Trust-in-the-Protection-of-Privacy.pdf)
PDF file and named it “TestDoc.docx.”  Note that docx is the default file
extension of MS Word 2010.

![TestDoc.docx](https://kennethghartman.com/images/TestDoc.docx-1024x464.png)

The frequency distribution of the DOCX file is fairly uniform, with the
exception of a relatively high occurrence of bytes with the value of zero.

## File 2 -  TestDoc.DOC

Next, I saved TestDoc in the _Word 97 – 2003_ format.  This format has
the DOC extension and produced the non-uniform distribution that I was
expecting of File 1.

## File 3 – TestDoc.TXT

TestDoc was also saved as plain text.  Running graph_file_entropy.py produced
the following result.

![TestDoc.TXT](https://kennethghartman.com/images/TestDoc.TXT-1024x464.png)

## File 4 – TestDoc.RTF

I repeated the process after saving the file in rich text format.

![TestDoc.RTF](https://kennethghartman.com/images/TestDoc.RTF-1024x464.png)

## File 5 – TestDoc.PDF

The TestDoc.PDF file has more entropy than the any of the other files we have
examined thus far.

![TestDoc.PDF](https://kennethghartman.com/images/TestDoc.PDF-1024x464.png)

## File 6 – TestDoc.GPG

To generate File 6, I encrypted the TestDoc.DOCX with Gpg4win (GNU Privacy
Guard for Windows).  The result is a file with a very high entropy of 7.9945
out of a possible max of 8.0.

![TestDoc.GPG](https://kennethghartman.com/images/TestDoc.GPG_-1024x464.png)

## File 7 – WINWORD.EXE

For comparison purposes, I thought that it would be interesting to find the
entropy of a common executable, MS Word 2010.  I copied the WINWORD.EXE file
into my working directory and ran graph_file_entropy.py to produce its
corresponding distribution chart.

Like the chart for the DOCX file, this chart is skewed by a high frequency of
bytes with a value of zero.

![WINWORD.EXE](https://kennethghartman.com/images/WINWORD.EXE_-1024x464.png)

## File 8 – Regular-MP3.mp3

I was also curious of the entropy of MP3 files.  I copied the _So Caught up
in You_ MP3 by the classic rock band “38 Special” into my working
directory and renamed it “Regular-MP3.mp3” for the purpose of testing.

![Regular-MP3.mp3](https://kennethghartman.com/images/Regular-MP3-1024x464.png)

The MP3 file format is very compressed, so it is not a surprise that it has
high entropy.

## File 9 – Compressed-MP3.7z

The Regular-MP3 file was compressed using 7-Zip, a popular file compression
utility to get the Compressed-MP3.7z that I processed next.

![Compressed-MP3.7z](https://kennethghartman.com/images/Compressed-MP3.7z-1024x464.png)

## File 10 – GPG-Encrypted-MP3.gpg

I encrypted the Regular-MP3 file using Gpg4win in a manner similar to File 6.

![GPG-Encrypted-MP3.gpg](https://kennethghartman.com/images/GPG-Encrypted-MP3.gpg_-1024x464.png)

## Observations

The following table summarizes the results I obtained from running
graph_file_entropy.py:

![Summary of Results](https://kennethghartman.com/images/Summary.png)

My observations show that although the Regular-MP3 file is compressed already,
7-zip was able to compress it more.  When compressed with 7-zip, it has very
high entropy and cannot be compressed further.  Another interesting observation
is that the GPG encryption process also compressed the size of the file in both
cases that I used it.
