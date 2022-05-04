---
layout: post
title: Are BitTorrent Pieces 250Kb Long?
excerpt: "I was researching BitTorrent and noticed in the Specification that it
said that the typical length of a Piece was 250 kilobytes long.  That made me
curious..."
modified: 2016-03-12
tags: [BitTorrent]
comments: false
category: blog
---

I was researching BitTorrent and noticed in the
[Specification](http://www.bittorrent.org/beps/bep_0003.html)
that it said that the typical
length of a Piece was 250 kilobytes long.  That made me curious so I decided to
perform some quick research to determine the extent of variation.

First, I modified the
[BitTorrent Parser](https://github.com/Resistor52/bittorrent-parser)
that I had created previously to append data to a “statistics.csv” file.  The
[getfiles.sh](https://github.com/Resistor52/bittorrent-parser/blob/master/getfiles.sh)
script downloaded a 279 files from
[www.legittorrents.com](http://www.legittorrents.com)
of which 169 were unique.

After pulling the [raw data](/media/statistics.csv) into MS Excel,
de-duplicating it, and graphing it, I came up with the chart below:

![Metainfo_Statistics_by_Torrent_Size](https://kennethghartman.com/images/Metainfo_Statistics_by_Torrent_Si
ze.png)

Note that the Y-Axis is Log-2.

Fourty-Four percent of the sampled Metainfo files were for a torrent that was
under 1 Gb.  Of these 76 Metainfo files that correspond to smaller torrents,
all but 5 had a piece size of 250Kb and these 5 files were all for torrents
that are under ½ Gb in size.

At the other end of the spectrum, 7% of the Metainfo files correspond to
torrents that are larger than 10 Gb.  All of the Metainfo files in this group
had piece sizes that were 2 Mb or larger.

According to its Metainfo file, the largest torrent in the sample was 61.5 Gb
and its piece size is 16 Mb.

The Metainfo file in the sample with the largest number of pieces (39,975) is
for a torrent that is 9.76 Gb in size, and its piece size is that standard 250
Kb.

## Conclusion

Although this sample is too small to prove anything other than that there is
indeed variation of piece size for Metainfo files in the wild, it does indicate
that Metainfo files may decrease the piece size for small torrents to get more
pieces for the swarm to exchange and conversely, increase the piece size for
very large torrents to keep the number of pieces to a reasonable number for the
swarm.
