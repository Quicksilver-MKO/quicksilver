-- QS - contains the functions that will be useful for a debug

--[[
List of debugging levels :
0 - errors
100 - function calls
--]]

function qss.error(location)
 if not qsv.err_msg then
  qsv.err_msg = "Unknown error"
 end
 qss.store_debugging(0, location .. " - "..qsv.err_msg)
 qss.error_output(location, qsv.err_msg)
 qsv.err_msg = nil
end

function qss.debug(message, level)
-- add an option to select what to display
 qss.store_debugging(level, message)
 qss.debug_output(level, message)
end

function qss.store_debugging(level, message)
-- add an option to enable debugging, and one to set the size of the debug table.
 local debug = true
 local size = 1000
 if debug then
  qsv.debug = qsv.debug or {}
  qsv.debug.count = qsv.debug.count or 0
-- use better timestamps
  local time = os.time()
  if size and qsv.debug.count == size then
   if #qsv.debug[1].m > 1 then
    table.remove(qsv.debug[1].m,1)
   else
    table.remove(qsv.debug,1)
   end
   qsv.debug.count = qsv.debug.count - 1
  end
  if #qsv.debug > 0 and qsv.debug[#qsv.debug].t == time then
   table.insert(qsv.debug[#qsv.debug].m, { level = level, msg = message })
   qsv.debug.count = qsv.debug.count + 1
  else
   table.insert(qsv.debug, {t = time, m = {{level = level, msg = message }} })
   qsv.debug.count = qsv.debug.count + 1
  end
 end
end

function qss.debug_report(l)
 for i,v in ipairs(qsv.debug) do
  local time = v.t
  local color
  for n,m in ipairs(v.m) do
   if (not l) or (m.level <= l) then
    if m.level < 0 then
     color = "<red>"
    elseif m.level < 10 then
     color = "<orange>"
    elseif m.level < 50 then
     color = "<yellow>"
    else
     color = "<white>"
    end
    cecho(string.format("<black:gray>[%s]<white:black> - %sLv%s %s\n", time, color, m.level, m.msg))
   end
  end
 end
end
