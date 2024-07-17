--- This filter numbers second-level headings as chapters, and treats
-- first-level headings as "parts".

--- Fix numbering when using parts
--
-- This filter numbers second-level headings as chapters, and treats
-- first-level headings as "parts".
--
-- Copyright: © 2024 Albert Krewinkel <albert+pandoc@tarleb.com>
-- License: MIT

PANDOC_VERSION:must_be_at_least '3.0'  -- We need pandoc.structure

local struct = require 'pandoc.structure'
local utils  = require 'pandoc.utils'

local chapter_number = 0

local fix_number = function (num)
  if not num then
    return nil
  end
  return num
    :gsub('^%d+$', utils.to_roman_numeral)       -- roman numerals for parts
    :gsub('^%d+%.%d+', tostring(chapter_number))
end

function Pandoc (doc)
  -- Create numbered sections
  doc.blocks = struct.make_sections(doc.blocks, {number_sections=true})

  -- Return the document with modified numbering
  return doc:walk {
    traverse = 'topdown',  -- ensures processing in the correct order
    Div = function (div)
      local header = div.content[1]
      if not header or header.t ~= 'Header' then
        -- not a section div; return it unchanged
        return div
      end

      -- keep track of the number of chapters
      if header.level == 2 then
        chapter_number = chapter_number + 1
      end

      -- set the numbers attributes
      header.attributes.number = fix_number(header.attributes.number)
      div.attributes.number = fix_number(div.attributes.number)

      return div, true
    end
  }
end
