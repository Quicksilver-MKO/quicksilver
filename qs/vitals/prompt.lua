-- QS - triggers that are about the prompt (get, display, ...)

function qst.prompt(matches,multimatches)
 qsf.extract_prompt(matches)
 
 qsf.print_prompt()
end

function qsf.print_prompt()
 --add a toggle to print the non standard prompt.
 deleteLine()
 local s = "\n"
 --add something to custom the coloring
 s = s .. "<green>"..qsv.vitals.cur.H.."h, "
 s = s .. "<green>"..qsv.vitals.cur.E.."e, "
 if qsv.vitals.cur.F then
  s = s .. "<green>"..qsv.vitals.cur.F.."f, "
 end
 if qsv.vitals.cur.M then
  s = s .. "<green>"..qsv.vitals.cur.M.."m, "
 end
 if qsv.vitals.cur.G then
  s = s .. "<green>"..qsv.vitals.cur.G.."g, "
 end
 
 if qsv.vitals.level.tnl then
  s = s .. "<green>"..qsv.vitals.level.tnl.."x "
 end

 s = s .. "<white>"
 if qsv.bal.equil then
  s = s .. "x"
 else
  s = s .. "-"
 end
 if qsv.bal.balance then
  s = s .. "b"
 else
  s = s .. "-"
 end
 if qsv.status.riding then
  s = s .. "r"
 end
 if qsv.status.shielded then
  s = s .. "@"
 else
  s = s .. "-"
 end
 if qsv.status.prone then
  s = s .. "p"
 end
 if qsv.status.asleep then
  s = s .. "l"
 end
 s = s .. " "
 
 if qsv.vitals.charges > 0 then
  s = s .. "<blue>"
  for i = 1,qsv.vitals.charges do
   s = s .. "*"
  end
 end

 s = s .. "<white>A:<red>"..qsv.vitals.cur.A.."% "

 for k,v in pairs(qsv.vitals.diff) do
  if v > 0 then
   s = s .. "<white>"..k..":+"..v
  elseif v < 0 then
   s = s .. "<white>"..k..":"..v
  end
 end

 if qsv.status.unread.msgs and qsv.status.unread.news and (qsv.status.unread.msgs + qsv.status.unread.news > 0) then
  s = s .. "<yellow>U: "
  if qsv.status.unread.msgs > 0 then
   s = s .. qsv.status.unread.msgs.."m"
  end
  if qsv.status.unread.news > 0 then
   s = s .. qsv.status.unread.news.."n"
  end
 end

 cecho(s)
 -- add target
 -- add the vote link?
 -- add the enemy status
 -- add the timestamps
 -- add the informations about important toggles
 
end

function qsf.extract_prompt(matches)
 qsv.waiting.prompt = false
 qsv.vitals.blood = tonumber(matches[7])
 qsv.vitals.stats = matches[8]
 qsv.enemy.health = matches[9]
 qsv.status.combat = string.find(qsv.vitals.stats, "A:")
 qsv.bal.balance = string.find(qsv.vitals.stats, "b")
 qsv.bal.equil = string.find(qsv.vitals.stats, "x")
 qsv.status.riding = string.find(qsv.vitals.stats, "r")
 qsv.status.prone = string.find(qsv.vitals.stats, "p")
 qsv.status.asleep = string.find(qsv.vitals.stats, "l")
 qsv.status.shielded = string.find(qsv.vitals.stats, "@") --temporary
 _, qsv.vitals.charges = string.gsub(qsv.vitals.stats, "%*", "")

 qsf.first_prompt_extract()
end

function qsf.first_prompt_extract()
 if qsv.reload.prompt then -- you want to rerun that one after class change/vampire status change...
  if qsv.vitals.blood then
   qsv.status.vampire = true
  else
   qsv.status.vampire = false
  end
  qsv.reload.prompt = false
 end
end
