-- QS - defines the balances-related functions

function qst.overdrive_regain(matches,multimatches)
 qsf.bal_regain("od") 
end
function qst.overdrive_loss(matches,multimatches)
 qsf.bal_loss("od")
end
function qst.overdrive_wait(matches,multimatches)
 qsf.bal_wait("od")
end
function qst.counter_loss(matches,multimatches)
end
function qst.psi_regain(matches,multimatches)
 qsf.bal_regain("psi")
end
function qst.psi_loss(matches,multimatches)
 qsf.bal_loss("psi")
end
function qst.psi_wait(matches,multimatches)
 qsf.bal_wait("psi")
end
function qst.focus_regain(matches,multimatches)
 qsf.bal_regain("focus")
end
function qst.focus_loss(matches,multimatches)
 qsf.bal_loss("focus")
end
function qst.focus_wait(matches,multimatches)
 qsf.bal_wait("focus")
end
function qst.balance_regain(matches,multimatches)
 qsf.bal_regain("balance")
end
function qst.balance_wait(matches,multimatches)
 qsf.bal_wait("balance")
end
function qst.equil_regain(matches,multimatches)
 qsf.bal_regain("equil")
end
function qst.equil_wait(matches,multimatches)
 qsf.bal_wait("equil")
end
function qst.offhand_regain(matches,multimatches)
 qsf.bal_regain("offhand")
end

function qsf.bal_regain(type)
 qsv.bal[type] = true
 deleteLine()
 cecho("<dark_orange>REGAIN: "..type)
end

function qsf.bal_loss(type)
 -- add a stopwatch timer
 qsf.bal_wait(type)
end

function qsf.bal_wait(type)
 qsv.bal[type] = false
 qsv.waiting[type] = false
end
