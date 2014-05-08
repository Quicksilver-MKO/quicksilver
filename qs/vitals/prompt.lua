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
 s = s .. "<green>"..qsv.vitals.health.."h, "
 s = s .. "<green>"..qsv.vitals.endurance.."e, "
 if qsv.vitals.faith > 0 then
  s = s .. "<green>"..qsv.vitals.faith.."f, "
 end
 if qsv.vitals.magic > 0 then
  s = s .. "<green>"..qsv.vitals.magic.."m, "
 end
 if qsv.vitals.guile > 0 then
  s = s .. "<green>"..qsv.vitals.guile.."g, "
 end
 
 s = s .. "<white>"
 if qsv.bal.equil then
  s = s .. "e"
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

 cecho(s)
 -- add adrenaline from GMCP
 -- add target
 -- add the vote link?
 -- add the vitals changes
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
 qsv.bal.equil = string.find(qsv.vitals.stats, "e")
 qsv.status.riding = string.find(qsv.vitals.stats, "r")
 qsv.status.prone = string.find(qsv.vitals.stats, "p")
 qsv.status.asleep = string.find(qsv.vitals.stats, "l")
 qsv.status.shielded = string.find(qsv.vitals.stats, "@") --temporary
 _, qsv.vitals.charges = string.gsub(qsv.vitals.stats, "%*", "")

 -- get those from GMCP
 qsv.vitals.health = tonumber(matches[2])
 qsv.vitals.endurance = tonumber(matches[3])
 qsv.vitals.faith = tonumber(matches[4])
 qsv.vitals.magic = tonumber(matches[5])
 qsv.vitals.guile = tonumber(matches[6])

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
