#!/usr/bin/env texlua

--[[
  Build script for makelabels project
  Copyright (C) 2009-2021 Markus Kohm

  This file is part of the build system of makelabels.

  It may be distributed and/or modified under the conditions of the
  LaTeX Project Public License (LPPL), either version 1.3c of this
  license or (at your option) any later version.  The latest version
  of this license is in the file

    https://www.latex-project.org/lppl.txt
]]

release_info = "2021/08/12 v1.0"

-- Bundle and modules

module       = "makelabels"

unpackfiles      = { "makelabels.dtx" }

installfiles     = { "makelabels.lco" }

sourcefiles      = { "makelabels.dtx" }

typesetdemofiles = { "makelabels-example.tex", "makelabels-envlab-example.tex" }
demofiles        = { "makelabels-example.tex", "makelabels-envlab-example.tex",
                     "makelabels-example.pdf", "makelabels-envlab-example.pdf" }
docfiles         = { "makelabels-example.pdf", "makelabels-envlab-example.pdf" }

-- Package

packtdszip = false

-- CTAN information

ctanpkg   = "makelabels"

uploadconfig = {
  pkg         = "makelabels",
  version     = release_info,
  author      = "Markus Kohm",
  licencse    = "lppl1.3c",
  summary     = "add label generation feature to KOMA-Script letter class and package",
  topic       = "letters",
  ctanPath    = "/macros/latex/contrib/makelabels",
  bugtracker  = "https://github.com/komascript/makelabels/issues",
  home        = "https://github.com/komascript/makelabels",
  repository  = "https://github.com/komascript/makelabels.git",
}

-- Detail how to set the version automatically
-- Example: `l3build tag --date 2020/02/31 v0.3'

tagfiles = {"*.dtx","README.md","build.lua"}

function update_tag (file,content,tagname,tagdate)
   tagname = string.gsub (tagname, "v(%d+%.%d+)", "%1")
   
   if string.match (file, "%.dtx$") then
      return string.gsub (content,
                          "%[%d%d%d%d%/%d%d%/%d%d v%d+%.%d+",
                          "[" .. tagdate .. " v" .. tagname )
   elseif string.match (file, "%.md$") then
      return string.gsub (content,
                          "\nRelease: %d%d%d%d%/%d%d%/%d%d v%d+%.%d+",
                          "\nRelease: " .. tagdate .. " v" .. tagname )
   elseif string.match (file, "%.lua$") then
      return string.gsub (content,
                          '\nrelease_info = "%d%d%d%d%/%d%d%/%d%d v%d+%.%d+"\n',
                          '\nrelease_info = "' .. tagdate .. " v" .. tagname .. '"\n')
   end
   return content
end

-- Find and run build system

kpse.set_program_name("kpsewhich")
if not release_date then
  dofile(kpse.lookup("l3build.lua"))
end
