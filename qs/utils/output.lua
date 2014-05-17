-- QS : handle the various output types

function qss.error_output(location, message)
 cecho(string.format("<red>ERROR in %s: <cyan>%s\n", location, message))
end

function qss.debug_output(l,m)
 cecho(string.format("<yellow>DEBUG%s -<white> %s\n",l,m))
end
