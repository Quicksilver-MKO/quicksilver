lfs = require "lfs"

function element_to_xml(filename)
 if filename:sub(-1) == "." then
  return
 end
 if lfs.attributes(filename, "mode") == "file" then
  file_to_xml(filename)
 else
  directory_to_xml(filename)
 end
end

function spaces(c)
 return string.rep("    ",c)
end

function btyn(bool)
 if bool then
  return "yes"
 else
  return "no"
 end
end

function directory_to_xml(filename)
 local c = filename:gsub("[^/]", ""):len() - sn
 local bn = filename:gsub("[^/]*/", "")
 io.write( spaces(c) .. [[<TriggerGroup isActive="yes" isFolder="yes" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
]] )
 c = c + 1
 io.write( spaces(c) .. [[<name>]]..bn..[[</name>
]] )
 io.write( spaces(c) .. [[<triggerType>0</triggerType>
]] )
 io.write( spaces(c) .. [[<conditonLineDelta>0</conditonLineDelta>
]] )
 io.write( spaces(c) .. [[<mStayOpen>0</mStayOpen>
]])
 io.write( spaces(c) .. [[<mCommand></mCommand>
]] )
 io.write( spaces(c) .. [[<packageName></packageName>
]] )
 io.write( spaces(c) .. [[<mFgColor>#000000</mFgColor>
]] )
 io.write( spaces(c) .. [[<mBgColor>#000000</mBgColor>
]] )
 io.write( spaces(c) .. [[<mSoundFile></mSoundFile>
]] )
 io.write( spaces(c) .. [[<colorTriggerFgColor>#000000</colorTriggerFgColor>
]] )
 io.write( spaces(c) .. [[<colorTriggerBgColor>#000000</colorTriggerBgColor>
]] )
 io.write( spaces(c) .. [[<regexCodeList/>
]] )
 io.write( spaces(c) .. [[<regexCodePropertyList/>
]] )

 for file in lfs.dir(filename) do
  element_to_xml(filename.."/"..file)
 end

 io.write( spaces(c-1) .. [[</TriggerGroup>
]] )
end

function file_to_xml(filename)
 local c = filename:gsub("[^/]", ""):len() - sn
 local bn = filename:gsub("[^/]*/", "")
 local b, e = pcall(dofile, filename) 
 if b then
  trigger_to_xml(c,trigger)
 else
  io.stderr:write(e)
  os.exit(1)
 end
end

function trigger_to_xml(c,trigger)
  io.write( spaces(c) .. string.format([[<Trigger isActive="%s" isFolder="no" isTempTrigger="no" isMultiline="%s" isPerlSlashGOption="no" isColorizerTrigger="%s" isFilterTrigger="%s" isSoundTrigger="no" isColorTrigger="%s" isColorTriggerFg="%s" isColorTriggerBg="%s">\n
]], btyn(not trigger.inactive), btyn(trigger.multiline), btyn(trigger.hl_fgcolor or trigger.hl_bgcolor), btyn(trigger.filter), btyn(trigger.color), btyn(trigger.fg), btyn(trigger.bg) ) )
  c = c + 1
  io.write( spaces(c) .. [[<name>]]..trigger.name..[[</name>
]] )
  io.write( spaces(c) .. [[<script>qst.]]..trigger.script:gsub('&',[[&amp;]]):gsub('<',[[&lt;]]):gsub('>',[[&gt;]]):gsub('"',[[&quot;]])..[[(matches,multimatches)</script>
]] )
  io.write( spaces(c) .. [[<triggerType>0</triggerType>
]] )
  if not trigger.linedelta then 
   io.write( spaces(c) .. [[<conditonLineDelta>0</conditonLineDelta>
]] )
  else
   io.write( spaces(c) .. [[<conditonLineDelta>]]..trigger.linedelta..[[</conditonLineDelta>
]] )
  end
  if trigger.stayopen then
   io.write( spaces(c) .. [[<mStayOpen>]]..trigger.stayopen..[[</mStayOpen>
]] )
  else
   io.write( spaces(c) .. [[<mStayOpen>0</mStayOpen>
]] )
  end
  io.write( spaces(c) .. [[<mCommand></mCommand>
]] )
  io.write( spaces(c) .. [[<packageName></packageName>
]] )
  if trigger.hl_fgcolor then
   io.write( spaces(c) .. [[<mFgColor>#]]..trigger.hl_fgcolor..[[</mFgColor>
]] )
  else
   io.write( spaces(c) .. [[<mFgColor>#fffff</mFgColor>
]] )
  end
  if trigger.bgcolor then
   io.write( spaces(c) .. [[<mBgColor>#]]..trigger.hl_bgcolor..[[</mBgColor>
]] )
  else
   io.write( spaces(c) .. [[<mBgColor>#000000</mBgColor>
]] )
  end
  io.write( spaces(c) .. [[<mSoundFile></mSoundFile>
]] )
  fg = nil
  if tonumber(trigger.fg) or colornames[trigger.fg] then
   fg = trigger.fg
   if not tonumber(fg) then
    fg = colornames[fg]
   end
   io.write( spaces(c) .. [[<colorTriggerFgColor>#]]..colors[fg]..[[</colorTriggerFgColor>
]] )
  end
  bg = nil
  if tonumber(trigger.bg) or colornames[trigger.bg] then
   bg = trigger.bg
   if not tonumber(bg) then
    bg = colornames[bg]
   end
   io.write( spaces(c) .. [[<colorTriggerBgColor>#]]..colors[bg]..[[</colorTriggerBgColor>
]] )
  end
  io.write( spaces(c) .. [[<regexCodeList>
]] )
  for _,l in pairs(trigger.lines) do
   local type = 0 --substring, the default
   if l.type == "perl" or l.type == "p" then
    type = 1
   elseif l.type == "color" or l.type == "c" then
    type = 6
   elseif l.type == "lua" or l.type == "l" or l.type == "function" or l.type == "f"  then
    type = 4
   elseif l.type == "begin" or l.type == "b" then
    type = 2
   elseif l.type == "exact" or l.type == "e" then
    type = 3
   elseif l.type == "spacer" or l.type == "ls" then
    type = 5
   end
   if type == 6 then
    io.write( spaces(c+1) .. [[<string>FG]]..fg..[[BG]]..bg..[[</string>
]] )
   else
    io.write( spaces(c+1) .. [[<string>]]..l.tr:gsub('&',[[&amp;]]):gsub('<',[[&lt;]]):gsub('>',[[&gt;]]):gsub('"',[[&quot;]])..[[</string>
]] )
   end
  end
  io.write( spaces(c) .. [[</regexCodeList>
]] )
  io.write( spaces(c) .. [[<regexCodePropertyList>
]] )
  for _,l in pairs(trigger.lines) do
   local type = 0 --substring, the default
   if l.type == "perl" or l.type == "p" then
    type = 1
   elseif l.type == "color" or l.type == "c" then
    type = 6
   elseif l.type == "lua" or l.type == "l" or l.type == "function" or l.type == "f"  then
    type = 4
   elseif l.type == "begin" or l.type == "b" then
    type = 2
   elseif l.type == "exact" or l.type == "e" then
    type = 3
   elseif l.type == "spacer" or l.type == "ls" then
    type = 5
   end
   io.write( spaces(c+1) .. [[<integer>]]..type..[[</integer>
]] )
  end
  io.write(spaces(c) .. [[</regexCodePropertyList>
]] )

  if trigger.chained then
   for _,v in pairs(trigger.chained) do
    trigger_to_xml(c+1,v)
   end
  end
  c = c - 1
  print( spaces(c) .. [[</Trigger>]])
end

colors = {
 "808080", --light black
 "000000", --black
 "ff0000", --light red
 "800000", --red
 "00ff00", --light green
 "00b300", --green
 "ffff00", --light yellow
 "808000", --yellow
 "ff0000", --light blue
 "000080", --blue
 "ffff00", --light magenta
 "800080", --magenta
 "00ffff", --light cyan
 "008080", --cyan
 "ffffff", --light white
 "c0c0c0", --white
}

colornames = {
 ["light black"] = 1,
 black = 2,
 ["light red"] = 3,
 red = 4,
 ["light green"] = 5,
 green = 6,
 ["light yellow"] = 7,
 yellow = 8,
 ["light blue"] = 9,
 blue = 10,
 ["light magenta"] = 11,
 magenta = 12,
 ["light cyan"] = 13,
 cyan = 14,
 ["light white"] = 15,
 white = 16,
}


--io.output("triggers.xml")

io.write([[<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE MudletPackage>
<MudletPackage version="1.0">
    <TriggerPackage>
        <TriggerGroup isActive="yes" isFolder="yes" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
]])

io.write(string.format([[            <name>Quicksilver-%s</name>
]],"0.1"))

io.write([[            <script></script>
            <triggerType>0</triggerType>
            <conditonLineDelta>0</conditonLineDelta>
            <mStayOpen>0</mStayOpen>
            <mCommand></mCommand>
            <packageName>system</packageName>
            <mFgColor>#ff0000</mFgColor>
            <mBgColor>#ffff00</mBgColor>
            <mSoundFile></mSoundFile>
            <colorTriggerFgColor>#000000</colorTriggerFgColor>
            <colorTriggerBgColor>#000000</colorTriggerBgColor>
            <regexCodeList/>
            <regexCodePropertyList/>
]])

 filename = arg[1]
 sn = filename:gsub("[^/]", ""):len() - 2
 
 for file in lfs.dir(filename) do
  element_to_xml(filename.."/"..file)
 end


io.write([[        </TriggerGroup>
    </TriggerPackage>
</MudletPackage>
]])
