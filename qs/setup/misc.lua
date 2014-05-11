-- QS - defines the few aliases needed to make the system work

function qsa.reload()
 qss.reload_lua("init")
end

function qsa.debug_report(matches)
 qss.debug_report(tonumber(matches[2]))
end
