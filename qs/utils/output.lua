-- QS : handle the various output types

function qss.error(location)
 if not qsv.err_msg then
  qsv.err_msg = "Unknown error"
 end
 tempTimer(0,string.format([[cecho("<red>ERROR in %s: <cyan>%s\n")]], location, qsv.err_msg))
 qsv.err_msg = nil
end

function qss.debug(m,l)
 tempTimer(0,string.format([[cecho("<yellow>DEBUG%s -<white> %s\n")]],l,m))
end
