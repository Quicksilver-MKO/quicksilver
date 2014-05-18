-- QS - functions to handle sending to the MUD, repeating..

function qss.send(s)
 local t = type(s)
 if t == "string" then
  send(s,false)
  qss.debug(string.format("Sent [%s] to the MUD",s), 90)
 elseif t == "table" then
  sendAll(s, false)
  for k,v in pairs(s) do
   qss.debug(string.format("Sent [%s] to the MUD",v), 90)
  end
 elseif t == "function" then
  qss.send(t())
 elseif t == "nil" then
  qss.send(" ")
 else
  local e = string.format("Invalid argument type (%s) in qss.send()",t)
  error(e,2)
 end
end
