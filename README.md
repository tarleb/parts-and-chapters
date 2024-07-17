parts-and-chapters
==================

Number first- and second-level headings as parts and chapters,
respectively.

This Lua filter helps to number sections in a style that's
appropriate for *parts* and *chapters*. Chapters should always be
numbered continuously, i.e., even numbering must *not* restart
from 1 in each part.

Such behavior works out of the box for a few output formats,
including LaTeX and ConTeXt, via pandoc's
`--top-level-division=part` command line parameter. That parameter
causes pandoc to treat top-level divisions as *parts*, in which
case the second level headings become *chapters*. Numbering works
as described above when pandoc is called with the additional
`--number-sections`/`-N` parameter.

However, this no such option exists for HTML and similar formats,
and this is where this filter is useful.
