-- QS : handle the various output types

function qss.error_output(location, message)
 tempTimer(0,string.format([[cecho("<red>ERROR in %s: <cyan>%s\n")]], location, message))
end

function qss.debug_output(l,m)
 tempTimer(0,string.format([[cecho("<yellow>DEBUG%s -<white> %s\n")]],l,m))
end
