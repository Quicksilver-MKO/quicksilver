-- QS - configuration of the special tables

qsb = {}

-- GMCP table
qsb.gmcp = {}
local gmcp_metatable = {
 __index = function (t,k)
  if qsb.gmcp[k] then
   qsf.debug("Called function qsg."..k.."()",100)
   return function (...)
    local b,e = pcall(qsb.gmcp[k], arg)
    if not b then
     qsf.error("Error in function qsg."..k..": "..e:match("profiles/%w+/.*/qs/.*lua.*"))
    end
   end
  else
   return function (...)
    qsf.error("Error: function qsg."..k.." does not exist")
   end
  end
 end,
 __newindex = function (t,k,v)
  if type(v) == "function" then
   qsb.gmcp[k] = v
  else
   qsf.error("Error, trying to add something to qsg that is not a function : "..k)
  end
 end,
}
qsg = setmetatable(qsg,gmcp_metatable)
