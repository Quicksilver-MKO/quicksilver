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
 io.write( spaces(c) .. [[<AliasGroup isActive="yes" isFolder="yes">
]] )
 c = c + 1
 io.write( spaces(c) .. [[<name>]]..bn..[[</name>
]] )
 io.write( spaces(c) .. [[<script></script>
]] )
 io.write( spaces(c) .. [[<command></command>
]] )
 io.write( spaces(c) .. [[<packageName></packageName>
]] )

 for file in lfs.dir(filename) do
  element_to_xml(filename.."/"..file)
 end

 io.write( spaces(c-1) .. [[</AliasGroup>
]] )
end

function file_to_xml(filename)
 local c = filename:gsub("[^/]", ""):len() - sn
 local bn = filename:gsub("[^/]*/", "")
 alias = nil
 local b, e = pcall(dofile, filename) 
 if b then
  if not alias.name then
   alias.name = bn:gsub(".lua","")
  end
  alias_to_xml(c,alias)
 else
  io.stderr:write(e)
  os.exit(1)
 end
end

function alias_to_xml(c,alias)
  io.write( spaces(c) .. string.format([[<Alias isActive="%s" isFolder="no">
]], btyn(not alias.inactive) ) )
  c = c + 1
  io.write( spaces(c) .. [[<name>]]..alias.name..[[</name>
]] )
  if alias.script then
   io.write( spaces(c) .. [[<script>qsa.]]..alias.script:gsub('&',[[&amp;]]):gsub('<',[[&lt;]]):gsub('>',[[&gt;]]):gsub('"',[[&quot;]])..[[(matches)</script>
]] )
  else
   io.write( spaces(c) .. [[<script></script>
]])
  end
  if alias.command then
   io.write( spaces(c) .. [[<command>]]..alias.command:gsub('&',[[&amp;]]):gsub('<',[[&lt;]]):gsub('>',[[&gt;]]):gsub('"',[[&quot;]])..[[</command>
]] )
  else
   io.write( spaces(c) .. [[<command></command>
]] )
  end
  io.write( spaces(c) .. [[<packageName></packageName>
]] )
  if not alias.regex then alias.regex = "" end
  io.write( spaces(c) .. [[<regex>]]..alias.regex:gsub('&',[[&amp;]]):gsub('<',[[&lt;]]):gsub('>',[[&gt;]]):gsub('"',[[&quot;]])..[[</regex>
]] )
  if alias.chained then
   for _,v in pairs(alias.chained) do
    alias_to_xml(c+1,v)
   end
  end
  c = c - 1
  print( spaces(c) .. [[</Alias>]])
end

io.write([[<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE MudletPackage>
<MudletPackage version="1.0">
    <AliasPackage>
        <AliasGroup isActive="yes" isFolder="yes">
]])

io.write(string.format([[            <name>Quicksilver-%s</name>
]],"0.1"))

io.write([[            <script></script>
            <command></command>
            <packageName>system</packageName>
            <regex></regex>
]])

 filename = arg[1]
 sn = filename:gsub("[^/]", ""):len() - 2
 
 for file in lfs.dir(filename) do
  element_to_xml(filename.."/"..file)
 end


io.write([[        </AliasGroup>
    </AliasPackage>
</MudletPackage>
]])
