-- QS - defines the GMCP functions relative to vitals

function qsg.vitals()
 qsv.status.dead = false

 local v = gmcp.Char.Vitals
 --Adrenaline
 if v.ap == "1000" then --check for recklessness

 else
  qsv.vitals.old.A = qsv.vitals.cur.A
  qsv.vitals.cur.A = tonumber(v.ap)/10
 end

 --Health
 qsv.vitals.old.H = qsv.vitals.cur.H
 qsv.vitals.cur.H = tonumber(v.hp)
 qsv.vitals.max.H = tonumber(v.maxhp)

 --Endurance
 qsv.vitals.old.E = qsv.vitals.cur.E
 qsv.vitals.cur.E = tonumber(v.ep)
 qsv.vitals.max.E = tonumber(v.maxep)

 --Faith
 qsv.vitals.old.F = qsv.vitals.cur.F
 qsv.vitals.cur.F = tonumber(v.fp)
 qsv.vitals.max.F = tonumber(v.maxfp)

 --Guile
 qsv.vitals.old.G = qsv.vitals.cur.G
 qsv.vitals.cur.G = tonumber(v.gp)
 qsv.vitals.max.G = tonumber(v.maxgp)

 --Magic
 qsv.vitals.old.M = qsv.vitals.cur.M
 qsv.vitals.cur.M = tonumber(v.mp)
 qsv.vitals.max.M = tonumber(v.maxmp)

 for s,n in pairs(qsv.vitals.cur) do
  qsv.vitals.prc[s] = math.floor(n*100/qsv.vitals.max[s])
  qsv.vitals.diff[s] = qsv.vitals.old[s] - n
 end
end

function qsg.status()
 local s = gmcp.Char.Status

 --Class
 local c = s.class
 if string.find(c, "Soldier") then
  qsv.status.class = "soldier"
 elseif string.find(c, "Rogue") then
  qsv.status.class = "rogue"
 elseif string.find(c, "Magician") then
  qsv.status.class = "Mian"
 elseif string.find(c, "Priest") then
  qsv.status.class = "priest"
 else
  qsv.status.class = nil
 end

 --Name
 qsv.status.name = s.name

 --Unread news/messages
 qsv.status.unread.news = tonumber(s.unread_news)
 qsv.status.unread.msgs = tonumber(s.unread_msgs)

 --Level
 local l = s.level
 qsv.vitals.level.cur = tonumber(l:match("%d+"))
 qsv.vitals.level.tnl = l:match("%d+%.*%d*%%"):gsub("%%","")
end
