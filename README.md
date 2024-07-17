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

Usage
-----

Call pandoc with

``` sh
pandoc --lua-filter=parts-and-chapters.lua --number-sections …
```

Remember that, if you don't want parts to be numbered, numbering
of specific headings can be disabled by adding the `unnumbered`
class, .e.g.,

``` markdown
# Part I {.unnumbered}

## Chapter one
```

Pandoc Markdown supports a special syntax, allowing to use `{-}`
to the same effect:

``` markdown
# Part I {-}
```

Example
-------

Let's use the following structure as an example:

``` markdown
# Part I {-}

## First chapter

### Subsection

## Second chapter

# Part II {-}

## Third chapter

### Some details
```

By default, i.e., without the filter, producing a TOC from
this document yields

> -   1 Part I
>     -   1.1 First chapter
>         -   1.1.1 Subsection
>     -   1.2 Second chapter
> -   2 Part II
>     -   2.1 Third chapter
>         -   2.1.1 Some details

Using this filter the TOC becomes

> -   Part I
>     -   1 First chapter
>         -   1.1 Subsection
>     -   2 Second chapter
> -   Part II
>     -   3 Third chapter
>         -   3.1 Some details
