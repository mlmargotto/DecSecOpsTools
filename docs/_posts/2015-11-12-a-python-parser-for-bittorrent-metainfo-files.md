---
layout: post
title: A Python Parser for BitTorrent Metainfo Files
excerpt: "To help understand the data contained in a metainfo file, I created a
python script called “bittorrent-parse.py.”"
modified: 2019-01-12
tags: [BitTorrent]
comments: false
category: blog
---

Lately, I have been doing some analysis of BitTorrent Descriptor Files, or
"metainfo" files as the <a
href="http://www.bittorrent.org/beps/bep_0003.html">BitTorrent Protocol
Specification</a> calls them. One could simply open the *.torrent file in a
text editor. If that is done, you would see something like:

```
d8:announce44:udp://tracker.openbittorrent.com:80/announce13:announce-listll44:u
dp://tracker.openbittorrent.com:80/announceel38:udp://tracker.publicbt.com:80/an
nounceel32:udp://tracker.ccc.de:80/announceee10:created
by14:uTorrent/3.4.213:creation
datei1420935116e8:encoding5:UTF-84:infod5:filesld6:lengthi37330e4:pathl52:7 All
previous animal species speeds in one list.pdfeed6:lengthi34436e4:pathl43:2
List of mammal species running speeds.pdfeed6:lengthi30210e4:pathl40:4 List of
bird species flight
speeds.pdfeed6:lengthi29518e4:pathl8:info.pdfeed6:lengthi28882e4:pathl42:5 List
of fish species swimming speeds.pdfeed6:lengthi28811e4:pathl31:Special human
running speed.pdfeed6:lengthi26834e4:pathl33:6 List of other animal
speeds.pdfeed6:lengthi26418e4:pathl26:Extra 2 homing
pigeons.pdfeed6:lengthi26149e4:pathl44:3 List of reptile species running
speeds.pdfeed6:lengthi25297e4:pathl17:1
information.pdfeed6:lengthi22476e4:pathl35:Extra 1 the fastest land
animal.pdfeed6:lengthi2268e4:pathl52:7 All previous animal species speeds in
one list.txteed6:lengthi1195e4:pathl43:2 List of mammal species running
speeds.txteed6:lengthi488e4:pathl17:1
information.txteed6:lengthi420e4:pathl42:5 List of fish species swimming
speeds.txteed6:lengthi378e4:pathl40:4 List of bird species flight
speeds.txteed6:lengthi365e4:pathl31:Special human running
speed.txteed6:lengthi319e4:pathl26:Extra 2 homing
pigeons.txteed6:lengthi293e4:pathl8:info.txteed6:lengthi276e4:pathl44:3 List of
reptile species running speeds.txteed6:lengthi229e4:pathl33:6 List of other
animal speeds.txteed6:lengthi117e4:pathl35:Extra 1 the fastest land
animal.txteee4:name65:List of animal speeds (mammals, reptiles, birds and fish
species)12:piece
lengthi16384e6:pieces400:…7°ºp½mhÉ14Û]à«@N]@žF˜†?Œ—W
^ö=¬4ñ5R8ÿó”œuä|&amp;nbsp;À¨„)¥¬H˜qa…0¡»ˆ«Ã9Zû³×�
�ï&gt;
¨$C°&gt;ØÔ”½†î:f–o¤ñü0„Ý³q({Øi­Å'£§ÕRñ©ø·�
�é@{§Æh¶Ë¬ýØdŽÏØùèÄ‘cÿ¹ctj^-ŸH/“Q®àÕ§Teýœ&lt;ò%C
ßV"%&amp;÷—7ùXgÿ´Fó/7„€”8ß
dHÙnP:Â°c,ð=Û™&gt;ãbÎüóÜrÆƒO¢îêÙºÐräçÓ&lt;Ô¨�
�^ö{y%F+ýÚ»K
–öÅŽŸ\ÑÇÈ4g¿°Á»Éˆ+”±W¡œBxþü‚oˆ“•¡å‰T
msÙ„ª~b,Ò¤
ˆ.B¡„…Xœ?æð†¶WjuËif‹¿yº¹­øú¦¢³¥Ù#Q’Ãé¦‹
ç'æÜÅ§þà|IM/ã*Ò0Þ%9½R:®ee
```

The first part of the file is "almost readable." The file is "bencoded" and
uses epoch dates, but one can tell the names of the files in the torrent
descriptor. The end of the file contains a SHA1 hash of each of the pieces and
it looks garbled because text editors cannot properly represent all possible
bytes as a printable character.

Remember that per the specification, BitTorrent breaks the collection of file
files referred to by the metainfo file into a number of smaller pieces of the
same size so that the swarm can share the work of distributing them. Don't
confuse the files referenced by the torrent descriptor file as a piece. The
files are all concatenated together and then divided up into uniform sized
pieces.

A SHA1 Hash is 20 bytes long, so the end of a *.torrent file is an array of
SHA1 hashes such the first 20 bytes are the SHA1 hash of piece 0, and the next
20 bytes correspond to the hash for piece 1, and so on.

To help understand the data contained in a metainfo file, I created a python
script called "bittorrent-parse.py." It can be found on Github, here:<a
href="https://github.com/Resistor52/bittorrent-parser">https://github.com/Resist
or52/bittorrent-parser</a>

The **bittorrent-parse.py** program generates HTML output. Using the above
example, the output would look as follows:

<hr>

<h3 style="text-align: center;"><strong>Beginning of sample output</strong></h3>

<hr>


<h1>Torrent Descriptor File Details</h1>
_* Denotes an optional field in the Torrent Descriptor File. As a result it
may be blank. Refer to the <a
href="https://wiki.theory.org/BitTorrentSpecification#Metainfo_File_Structure">B
itTorrent Specification</a>._
<h2>Meta Data</h2>
<table style="font-family: sans-serif;" border="1">
<tbody>
<tr>
<td><b>torrent filename</b></td>
<td>test.torrent</td>
</tr>
<tr>
<td><b>infohash</b></td>
<td>634a9cfcf056dcdb9bf673663f720197f52cd177</td>
</tr>
<tr>
<td><b>announce</b></td>
<td>udp://tracker.openbittorrent.com:80/announce</td>
</tr>
<tr>
<td><b>announce-list*</b></td>
<td>udp://tracker.openbittorrent.com:80/announce
udp://tracker.publicbt.com:80/announce
udp://tracker.ccc.de:80/announce</td>
</tr>
<tr>
<td><b>creation date*</b> (epoch time)</td>
<td>1420935116 (2015-01-10 16:11:56)</td>
</tr>
<tr>
<td><b>comment*</b></td>
<td></td>
</tr>
<tr>
<td><b>created by*</b></td>
<td>uTorrent/3.4.2</td>
</tr>
<tr>
<td><b>encoding*</b></td>
<td>UTF-8</td>
</tr>
<tr>
<td><b>piece length</b> (bytes)</td>
<td>16384 (16K)</td>
</tr>
<tr>
<td><b>private*</b></td>
<td></td>
</tr>
<tr>
<td><b>name*</b></td>
<td></td>
</tr>
</tbody>
</table>
<h2>Calculated Data</h2>
<table style="font-family: sans-serif;" border="1">
<tbody>
<tr>
<td><b>type of torrent</b></td>
<td>multiple file torrent</td>
</tr>
<tr>
<td><b>number of pieces</b></td>
<td>20</td>
</tr>
<tr>
<td><b>length of last piece</b> (bytes)</td>
<td>4971 (4K)</td>
</tr>
<tr>
<td><b>last piece as % of piece length</b></td>
<td>30.3%</td>
</tr>
<tr>
<td><b>size of torrent</b> (bytes)</td>
<td>322709 (315K)</td>
</tr>
</tbody>
</table>




_NOTE: the length of last piece is calculated as:
(number of pieces X piece length) - size of torrent_
<h2>This Torrent Descriptor has the following file paths:</h2>
<table style="font-family: sans-serif;" border="1">
<tbody>
<tr>
<th>File Path</th>
<th>Length</th>
<th>md5sum*</th>
</tr>
<tr>
<td>7 All previous animal species speeds in one list.pdf</td>
<td>37330</td>
<td></td>
</tr>
<tr>
<td>2 List of mammal species running speeds.pdf</td>
<td>34436</td>
<td></td>
</tr>
<tr>
<td>4 List of bird species flight speeds.pdf</td>
<td>30210</td>
<td></td>
</tr>
<tr>
<td>info.pdf</td>
<td>29518</td>
<td></td>
</tr>
<tr>
<td>5 List of fish species swimming speeds.pdf</td>
<td>28882</td>
<td></td>
</tr>
<tr>
<td>Special human running speed.pdf</td>
<td>28811</td>
<td></td>
</tr>
<tr>
<td>6 List of other animal speeds.pdf</td>
<td>26834</td>
<td></td>
</tr>
<tr>
<td>Extra 2 homing pigeons.pdf</td>
<td>26418</td>
<td></td>
</tr>
<tr>
<td>3 List of reptile species running speeds.pdf</td>
<td>26149</td>
<td></td>
</tr>
<tr>
<td>1 information.pdf</td>
<td>25297</td>
<td></td>
</tr>
<tr>
<td>Extra 1 the fastest land animal.pdf</td>
<td>22476</td>
<td></td>
</tr>
<tr>
<td>7 All previous animal species speeds in one list.txt</td>
<td>2268</td>
<td></td>
</tr>
<tr>
<td>2 List of mammal species running speeds.txt</td>
<td>1195</td>
<td></td>
</tr>
<tr>
<td>1 information.txt</td>
<td>488</td>
<td></td>
</tr>
<tr>
<td>5 List of fish species swimming speeds.txt</td>
<td>420</td>
<td></td>
</tr>
<tr>
<td>4 List of bird species flight speeds.txt</td>
<td>378</td>
<td></td>
</tr>
<tr>
<td>Special human running speed.txt</td>
<td>365</td>
<td></td>
</tr>
<tr>
<td>Extra 2 homing pigeons.txt</td>
<td>319</td>
<td></td>
</tr>
<tr>
<td>info.txt</td>
<td>293</td>
<td></td>
</tr>
<tr>
<td>3 List of reptile species running speeds.txt</td>
<td>276</td>
<td></td>
</tr>
<tr>
<td>6 List of other animal speeds.txt</td>
<td>229</td>
<td></td>
</tr>
<tr>
<td>Extra 1 the fastest land animal.txt</td>
<td>117</td>
<td></td>
</tr>
</tbody>
</table>
<h2>This Torrent Descriptor has the following SHA1 Hashes for each piece,
respectively:</h2>
_NOTE PER THE SPEC: "For the purposes of piece boundaries in the multi-file
case, consider the file data as one long continuous stream, composed of the
concatenation of each file in the order listed in the files list. The number of
pieces and their boundaries are then determined in the same manner as the case
of a single file. Pieces may overlap file boundaries."_
<table style="font-family: sans-serif;" border="1">
<tbody>
<tr>
<td>Piece 0</td>
<td>8537b0ba7005bd116d10817f0e0668c97f193103</td>
</tr>
<tr>
<td>Piece 1</td>
<td>34db5de0ab404e5d409e4698863f8c1497575ef6</td>
</tr>
<tr>
<td>Piece 2</td>
<td>3dac34f13552381efff3949c75e47f7ca0c0a884</td>
</tr>
<tr>
<td>Piece 3</td>
<td>29a5ac48987161108530a18dbb88abc3395afbb3</td>
</tr>
<tr>
<td>Piece 4</td>
<td>d7dcef3e200aa82443b09d3ed8d494bd86ee3a1c</td>
</tr>
<tr>
<td>Piece 5</td>
<td>0466960b6fa4f11afc3084ddb371287bd86901ad</td>
</tr>
<tr>
<td>Piece 6</td>
<td>c527a3a7d55213f1a9f8b793e940027ba7c668b6</td>
</tr>
<tr>
<td>Piece 7</td>
<td>0bcbacfdd8648ecfd8f9e8c4916301ff08b96374</td>
</tr>
<tr>
<td>Piece 8</td>
<td>6a5e2d9f482f9351aee0d5a7010c5465fd9c3cf2</td>
</tr>
<tr>
<td>Piece 9</td>
<td>2543df56222526f79737f958677fffb446f32f37</td>
</tr>
<tr>
<td>Piece 10</td>
<td>84809438df0a6448d96e503ac2b0632cf03ddb99</td>
</tr>
<tr>
<td>Piece 11</td>
<td>021e173ee362cefc19f3811fdc72c611834fa205</td>
</tr>
<tr>
<td>Piece 12</td>
<td>ee08ead91bbad072e4e7d33cd4a8995e02f67b79</td>
</tr>
<tr>
<td>Piece 13</td>
<td>25462bfddabb4b099617f6c58e149f5cd181c7c8</td>
</tr>
<tr>
<td>Piece 14</td>
<td>347f67bfb0c1bb17c988072b94b157a19c4278fe</td>
</tr>
<tr>
<td>Piece 15</td>
<td>8d05fc826f889395a1e58954206d73d91084aa7e</td>
</tr>
<tr>
<td>Piece 16</td>
<td>62172cd2a41809882e42a1848502589c3fe61ff0</td>
</tr>
<tr>
<td>Piece 17</td>
<td>86b6576a75cb8f69668bbf79bab9adf8fa03168d</td>
</tr>
<tr>
<td>Piece 18</td>
<td>a6a2b3a5d9235192c3e9a68b10e727e6dcc5a7fe</td>
</tr>
<tr>
<td>Piece 19</td>
<td>e07c494d042fe32ad2300fde2539bd110b523aae</td>
</tr>
</tbody>
</table>


<hr>

<h3 style="text-align: center;"><strong>End of sample output</strong></h3>

<hr>

## References and acknowledgements:

<a href="https://www.cloudwards.net/what-is-torrenting/" target="_blank"
rel="noopener noreferrer">https://www.cloudwards.net/what-is-torrenting/</a>
<a href="https://kennethghartman.com/dead-link/" target="_blank" rel="noopener
noreferrer">https://wikigurus.com/Article/Show/298784/Extract-the-SHA1-hash-from
-a-torrent-file</a>
<a href="https://kennethghartman.com/dead-link/" target="_blank" rel="noopener
noreferrer">http://error.news/question/139520/extract-the-sha1-hash-from-a-torre
nt-file/</a>
<a href="/dead-link/" target="_blank" rel="noopener
noreferrer">http://www.kristenwidman.com/blog/33/how-to-write-a-bittorrent-clien
t-part-1/</a>
<a
href="https://wiki.theory.org/BitTorrentSpecification#Metainfo_File_Structure"
target="_blank" rel="noopener
noreferrer">https://wiki.theory.org/BitTorrentSpecification#Metainfo_File_Struct
ure</a>
