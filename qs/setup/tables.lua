-- QS - configuration of the special tables

qsb = {}

local err_handler = function(e)
 local fs = package.config:sub(1,1)
 qsv.err_msg = e:match("profiles"..fs..".*"..fs.."qs"..fs..".*lua.*")
end

-- GMCP table
qsb.gmcp = {}
local gmcp_metatable = {
 __index = function (t,k)
  if qsb.gmcp[k] then
   qss.debug("Called function qsg."..k.."()",100)
   return function (...)
    local arg = ...
    local b,e = xpcall(function () return qsb.gmcp[k](arg) end, err_handler)
    if not b then
     qss.error("qsg."..k.."()")
    end
   end
  else
   qsv.err_msg = "Function does not exist"
   qss.error("GMCP function qsg."..k.."()")
   return function (...)
    return nil
   end
  end
 end,
 __newindex = function (t,k,v)
  if type(v) == "function" then
   qsb.gmcp[k] = v
  else
   error("Attempt to add "..k.." to qsg, instead of a function")
  end
 end,
}
qsg = setmetatable(qsg,gmcp_metatable)

-- triggers table
qsb.triggers = {}
local triggers_metatable = {
 __index = function (t,k)
  if qsb.triggers[k] then
   qss.debug("Called function qst."..k.."()",100)
   return function (...)
    local arg = ...
    local b,e = xpcall(function () return qsb.triggers[k](arg) end, err_handler)
    if not b then
     qss.error("qst."..k)
    end
   end
  else
   error("Attempt to access qst."..k.." which does not exist")
  end
 end,
 __newindex = function (t,k,v)
  if type(v) == "function" then
   qsb.triggers[k] = v
  else
   error("Attempt to add "..k.." to qst, instead of a function")
  end
 end,
}
qst = setmetatable(qst,triggers_metatable)

--functions table
qsb.functions = {}
local functions_metatable = {
 __index = function (t,k)
  if qsb.functions[k] then
   qss.debug("Called function qsf."..k.."()",100)
   return function (...)
    local arg = ...
    local b,e = xpcall(function () 
     return qsb.functions[k](arg)
    end, err_handler)
    if not b then
     qss.error("qsf."..k)
    end
   end
  else
   error("Attempt to access qsf."..k.." which does not exist")
  end
 end,
 __newindex = function (t,k,v)
  if type(v) == "function" then
   qsb.functions[k] = v
  else
   error("Attempt to add "..k.." to qsf, instead of a function.")
  end
 end,
}
qsf = setmetatable(qsf,functions_metatable)

--aliases table
qsb.aliases = {}
local aliases_metatable = {
 __index = function (t,k)
  if qsb.aliases[k] then
   qss.debug("Called alias qsa."..k.."()",100)
   return function (...)
    local arg = ...
    local b,e = xpcall(function () 
     return qsb.aliases[k](arg)
    end, err_handler)
    if not b then
     qss.error("qsa."..k)
    end
   end
  else
   error("Attempt to access qsa."..k.." which does not exist")
  end
 end,
 __newindex = function (t,k,v)
  if type(v) == "function" then
   qsb.aliases[k] = v
  else
   error("Attempt to add "..k.." to qsa, instead of a function.")
  end
 end,
}
qsa = setmetatable(qsa,aliases_metatable)
