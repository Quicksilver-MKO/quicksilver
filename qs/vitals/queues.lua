-- QS - creates the various queues.

qss.new_queue("balance", "qsv.bal.balance")
qss.new_queue("equil", "qsv.bal.equil")
qss.new_queue("offhand", "qsv.bal.offhand")
qss.new_queue("psi", "qsv.bal.psi")

function qsf.queue_bal(what, eq_required, bal_consumed, eq_consumed)
 local req = { "qsv.bal.balance" }
 if eq_required then
  table.insert(req, "qsv.bal.equil")
 end
 local cons
 if bal_consumed or eq_consumed then
  cons = {}
  if bal_consumed then
   table.insert(cons, "balance")
  end
  if eq_consumed then
   table.insert(cons, "equil")
  end
 end
 qsq.balance:Add({code = what, required = req, consumed = cons})
end

function qsf.queue_eq(what, bal_required, bal_consumed, eq_consumed)
 local req = { "qsv.bal.equil" }
 if bal_required then
  table.insert(req, "qsv.bal.balance")
 end
 local cons
 if bal_consumed or eq_consumed then
  cons = {}
  if bal_consumed then
   table.insert(cons, "balance")
  end
  if eq_consumed then
   table.insert(cons, "equil")
  end
 end
 qsq.equil:Add({code = what, required = req, consumed = cons})
end

function qsf.queue_psi(what)
 qsq.psi:Add({code = what, consumed = "psi"})
end

function qsf.queue_offhand(what)
 qsq.offhand:Add({code = what, consumed = "offhand"})
end
