Lately, I have been doing some analysis of BitTorrent Descriptor Files, or ¿metainfo¿ files as the [BitTorrent Protocol Specification](http://www.bittorrent.org/beps/bep_0003.html) calls them. One could simply open the \*.torrent file in a text editor. If that is done, you would see something like:

```
    d8:announce44:udp://tracker.openbittorrent.com:80/announce13:announce-listll44:udp://tracker.openbittorrent.com:80/announceel38:udp://tracker.publicbt.com:80/announceel32:udp://tracker.ccc.de:80/announceee10:created by14:uTorrent/3.4.213:creation datei1420935116e8:encoding5:UTF-84:infod5:filesld6:lengthi37330e4:pathl52:7 All previous animal species speeds in one list.pdfeed6:lengthi34436e4:pathl43:2 List of mammal species running speeds.pdfeed6:lengthi30210e4:pathl40:4 List of bird species flight speeds.pdfeed6:lengthi29518e4:pathl8:info.pdfeed6:lengthi28882e4:pathl42:5 List of fish species swimming speeds.pdfeed6:lengthi28811e4:pathl31:Special human running speed.pdfeed6:lengthi26834e4:pathl33:6 List of other animal speeds.pdfeed6:lengthi26418e4:pathl26:Extra 2 homing pigeons.pdfeed6:lengthi26149e4:pathl44:3 List of reptile species running speeds.pdfeed6:lengthi25297e4:pathl17:1 information.pdfeed6:lengthi22476e4:pathl35:Extra 1 the fastest land animal.pdfeed6:lengthi2268e4:pathl52:7 All previous animal species speeds in one list.txteed6:lengthi1195e4:pathl43:2 List of mammal species running speeds.txteed6:lengthi488e4:pathl17:1 information.txteed6:lengthi420e4:pathl42:5 List of fish species swimming speeds.txteed6:lengthi378e4:pathl40:4 List of bird species flight speeds.txteed6:lengthi365e4:pathl31:Special human running speed.txteed6:lengthi319e4:pathl26:Extra 2 homing pigeons.txteed6:lengthi293e4:pathl8:info.txteed6:lengthi276e4:pathl44:3 List of reptile species running speeds.txteed6:lengthi229e4:pathl33:6 List of other animal speeds.txteed6:lengthi117e4:pathl35:Extra 1 the fastest land animal.txteee4:name65:List of animal speeds (mammals, reptiles, birds and fish species)12:piece lengthi16384e6:pieces400:¿7°ºp½mhÉ14Û]à«@N]@¿F¿¿?¿¿W^ö=¬4ñ5R8ÿó¿¿uä|&amp;nbsp;À¨¿)¥¬H¿qa¿0¡»¿«Ã9Zû³×Üï&gt;
    ¨$C°&gt;ØÔ¿½¿î:f¿o¤ñü0¿Ý³q({Øi­Å'£§ÕRñ©ø·¿é@{§Æh¶Ë¬ýØd¿ÏØùèÄ¿cÿ¹ctj^-¿H/¿Q®àÕ§Teý¿&lt;ò%CßV"%&amp;÷¿7ùXgÿ´Fó/7¿¿¿8ß
    dHÙnP:Â°c,ð=Û¿&gt;ãbÎüóÜrÆ¿O¢îêÙºÐräçÓ&lt;Ô¨¿^ö{y%F+ýÚ»K	¿öÅ¿¿\ÑÇÈ4g¿°Á»É¿+¿±W¡¿Bxþü¿o¿¿¿¡å¿T msÙ¿ª~b,Ò¤	¿.B¡¿¿X¿?æð¿¶WjuËif¿¿yº¹­øú¦¢³¥Ù#Q¿Ãé¦¿ç'æÜÅ§þà|IM/ã*Ò0Þ%9½R:®ee
```

The first part of the file is ¿almost readable.¿ The file is ¿bencoded¿ and uses epoch dates, but one can tell the names of the files in the torrent descriptor. The end of the file contains a SHA1 hash of each of the pieces and it looks garbled because text editors cannot properly represent all possible bytes as a printable character.

Remember that per the specification, BitTorrent breaks the collection of file files referred to by the metainfo file into a number of smaller pieces of the same size so that the swarm can share the work of distributing them. Don¿t confuse the files referenced by the torrent descriptor file as a piece. The files are all concatenated together and then divided up into uniform sized pieces.

A SHA1 Hash is 20 bytes long, so the end of a \*.torrent file is an array of SHA1 hashes such the first 20 bytes are the SHA1 hash of piece 0, and the next 20 bytes correspond to the hash for piece 1, and so on.

To help understand the data contained in a metainfo file, I created a python script called ¿bittorrent-parse.py.¿ It can be found on Github, here:[https://github.com/Resistor52/bittorrent-parser](https://github.com/Resistor52/bittorrent-parser)

The **bittorrent-parse.py** program generates HTML output. Using the above example, the output would look as follows:

* * *

### **Beginning of sample output**

* * *

Torrent Descriptor File Details
===============================

_\* Denotes an optional field in the Torrent Descriptor File. As a result it may be blank. Refer to the [BitTorrent Specification](https://wiki.theory.org/BitTorrentSpecification#Metainfo_File_Structure)._

Meta Data
---------

**torrent filename**

test.torrent

**infohash**

634a9cfcf056dcdb9bf673663f720197f52cd177

**announce**

udp://tracker.openbittorrent.com:80/announce

**announce-list\***

udp://tracker.openbittorrent.com:80/announce udp://tracker.publicbt.com:80/announce udp://tracker.ccc.de:80/announce

**creation date\*** (epoch time)

1420935116 (2015-01-10 16:11:56)

**comment\***

**created by\***

uTorrent/3.4.2

**encoding\***

UTF-8

**piece length** (bytes)

16384 (16K)

**private\***

**name\***

Calculated Data
---------------

**type of torrent**

multiple file torrent

**number of pieces**

20

**length of last piece** (bytes)

4971 (4K)

**last piece as % of piece length**

30.3%

**size of torrent** (bytes)

322709 (315K)

_NOTE: the length of last piece is calculated as: (number of pieces X piece length) - size of torrent_

This Torrent Descriptor has the following file paths:
-----------------------------------------------------

File Path

Length

md5sum\*

7 All previous animal species speeds in one list.pdf

37330

2 List of mammal species running speeds.pdf

34436

4 List of bird species flight speeds.pdf

30210

info.pdf

29518

5 List of fish species swimming speeds.pdf

28882

Special human running speed.pdf

28811

6 List of other animal speeds.pdf

26834

Extra 2 homing pigeons.pdf

26418

3 List of reptile species running speeds.pdf

26149

1 information.pdf

25297

Extra 1 the fastest land animal.pdf

22476

7 All previous animal species speeds in one list.txt

2268

2 List of mammal species running speeds.txt

1195

1 information.txt

488

5 List of fish species swimming speeds.txt

420

4 List of bird species flight speeds.txt

378

Special human running speed.txt

365

Extra 2 homing pigeons.txt

319

info.txt

293

3 List of reptile species running speeds.txt

276

6 List of other animal speeds.txt

229

Extra 1 the fastest land animal.txt

117

This Torrent Descriptor has the following SHA1 Hashes for each piece, respectively:
-----------------------------------------------------------------------------------

_NOTE PER THE SPEC: ¿For the purposes of piece boundaries in the multi-file case, consider the file data as one long continuous stream, composed of the concatenation of each file in the order listed in the files list. The number of pieces and their boundaries are then determined in the same manner as the case of a single file. Pieces may overlap file boundaries.¿_

Piece 0

8537b0ba7005bd116d10817f0e0668c97f193103

Piece 1

34db5de0ab404e5d409e4698863f8c1497575ef6

Piece 2

3dac34f13552381efff3949c75e47f7ca0c0a884

Piece 3

29a5ac48987161108530a18dbb88abc3395afbb3

Piece 4

d7dcef3e200aa82443b09d3ed8d494bd86ee3a1c

Piece 5

0466960b6fa4f11afc3084ddb371287bd86901ad

Piece 6

c527a3a7d55213f1a9f8b793e940027ba7c668b6

Piece 7

0bcbacfdd8648ecfd8f9e8c4916301ff08b96374

Piece 8

6a5e2d9f482f9351aee0d5a7010c5465fd9c3cf2

Piece 9

2543df56222526f79737f958677fffb446f32f37

Piece 10

84809438df0a6448d96e503ac2b0632cf03ddb99

Piece 11

021e173ee362cefc19f3811fdc72c611834fa205

Piece 12

ee08ead91bbad072e4e7d33cd4a8995e02f67b79

Piece 13

25462bfddabb4b099617f6c58e149f5cd181c7c8

Piece 14

347f67bfb0c1bb17c988072b94b157a19c4278fe

Piece 15

8d05fc826f889395a1e58954206d73d91084aa7e

Piece 16

62172cd2a41809882e42a1848502589c3fe61ff0

Piece 17

86b6576a75cb8f69668bbf79bab9adf8fa03168d

Piece 18

a6a2b3a5d9235192c3e9a68b10e727e6dcc5a7fe

Piece 19

e07c494d042fe32ad2300fde2539bd110b523aae

* * *

### **End of sample output**

* * *

References and acknowledgements:
--------------------------------

[https://www.cloudwards.net/what-is-torrenting/](https://www.cloudwards.net/what-is-torrenting/) [https://wikigurus.com/Article/Show/298784/Extract-the-SHA1-hash-from-a-torrent-file](https://kennethghartman.com/dead-link/) [http://error.news/question/139520/extract-the-sha1-hash-from-a-torrent-file/](https://kennethghartman.com/dead-link/) [http://www.kristenwidman.com/blog/33/how-to-write-a-bittorrent-client-part-1/](/dead-link/) [https://wiki.theory.org/BitTorrentSpecification#Metainfo\_File\_Structure](https://wiki.theory.org/BitTorrentSpecification#Metainfo_File_Structure)

* * *

**A Python Parser for BitTorrent Metainfo Files** was published on November 12, 2015 and last modified on January 12, 2019.
