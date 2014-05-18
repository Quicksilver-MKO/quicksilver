-- QS - general queues

qsq = {}

function qss.do_queue(queue)
 if (not queue) or (type(queue) ~= "string") then
  for _, queue in pairs(qsq) do
   queue:Do()
  end
 else
  if not qsq[queue] then
   error(string.format("Queue '%s' does not exist.", queue) , 2)
  else
   qsq[queue]:Do()
  end
 end
end

function qss.delete_queue(queue)
 if (not queue) or (not qsq[queue]) then
  error(string.format("Queue '%s' does not exist.", queue), 2)
 else
  qsq[queue] = nil
 end
end

function qss.new_queue(name, conditions)
 --sanity checks
 if (not name) or (type(name) ~= "string") then
  error("Must pass a string as the first argument of qss.new_queue().", 2)
 end
 if qsq[name] then
  error(string.format("A queue with the name '%s' already exists", name), 2)
 end
 if (not conditions) or (type(conditions) == "number") then
  error("Must pass a table or a string or a boolean as the second argument of qss.new_queue().", 2)
 else
  if type(conditions) == "table" then
   for _, cond in ipairs(conditions) do
    local bad_types = {["table"] = true, ["number"] = true, ["boolean"] = true}
    if bad_type[type(cond)] then
     error("Elements in the second argument of qss.new_queue() can only be strings or booleans", 2)
    end
   end
  end
 end
 
 local queue = {}

 local actions = {}
 local action_count = 0

 local waiting = false
 local wait_timer

 local function get_field(f)
  local v = _G
  for k in f:gfind("[%w_]+") do
   if type(v) ~= "table" then
    return nil
   end
   v = v[k]
  end
  return v
 end

 local function set_field(f)
  local v = _G
  local v2
  local j
  for k in f:gfind("[%w_]+") do
   if type(v) ~= "table" then
    return
   end
   v2,j,v = v,k,v[k]
  end
  v2[j] = value
 end

 local function check_conditions(condition)
  local function do_check(cond)
   local ct = type(cond)
   if ct == "table" then
    for _, c in ipairs(cond) do
     if not do_check(c) then return false end
    end
    return true
   elseif ct == "string" then
    if get_field(cond) then return true end
   elseif ct == "function" then
    if cond() then return true end
   elseif ct == "boolean" then
    return cond
   end
  end
  return do_check(condition)
 end

 local function exec_code(code)
  local ct = type(code)
  if ct == "table" then
   for _,c in ipairs(code) do
    exec_code(c)
   end
  elseif ct == "string" then
   qss.send(code)
  elseif ct == "function" then
   code()
  end
 end

 function queue:Do()
  if action_count == 0 then
   return
  end
  if waiting then
   return
  end
  if (not check_conditions(conditions)) then
   return
  end

  local action = actions[1]
  local action_index = 1

  local do_action = true
  if action.required then
   do_action = check_conditions(action.required)
  end
  if not do_action then
   return
  end

  exec_code(action.code)
  table.remove(actions, action_index)
  action_count = action_count - 1

  if action.consumed then
   local c = action.consumed
   local ct = type(c)
   if ct == "table" then
    for _, cond in ipairs(c) do
     local cot = type(cond)
     if cot == "string" then
      if qsq[cond] then
       qsq[cond]:Wait()
      end
     end
    end
   elseif ct == "string" then
    if qsq[consumed] then
     qsq[consumed]:Wait()
    end
   end
  elseif action_count > 0 then
   queue:Do()
  end
 end

 function queue:Wait()
  waiting = true
  wait_timer = tempTimer(1, function() queue:StopWait() end)
 end

 function queue:StopWait()
  waiting = false
  if wait_timer then
   killTimer(wait_timer)
   wait_timer = nil
  end
 end

 function queue:Add(action)
  local code_types = {["string"] = true, ["function"] = true}
  if type(action) == "table" then
   if not action.code then
    for _,code in ipairs(action) do
     if not code_types[type(code)] then
      error("Invalid action passed to Add().", 2)
     end
    end
    actions[#actions+1] = {code = action}
    action_count = action_count + 1
   else
    for _,field in ipairs( {"code", "required", "consumed" } ) do
     if action[field] then
      local ft = type(field)
      if ft == "table" then
       for _,v in ipairs(action[field]) do
        if not code_types[type(v)] then
         error(string.format("Invalid value in action table '%s'.", field), 2)
        end
       end
      elseif not code_types[ft] then
       error(string.format("Action field '%s' must be a table, string or function.", field), 2)
      end
     end
    end
    actions[#actions+1] = action
    action_count = action_count + 1
   end
  elseif code_types[type(action)] then
   actions[#actions+1] = {code = action}
   action_count = action_count + 1
  else
   error("Invalid action passed to Add(). Must be table, string or function.", 2)
  end
 end

 function queue:Reset()
  actions = {}
  action_count = 0
 end

 qsq[name] = queue
end
