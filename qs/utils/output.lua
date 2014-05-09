-- QS : handle the various output types

function qsf.error(e)
 cecho("<red>"..e.."\n")
end

function qsf.debug(m,l)
 cecho("<yellow>DEBUG"..l.." -<white> "..m.."\n")
end
