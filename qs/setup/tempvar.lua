-- QS : sets up all the temporary variables

qsv.status = {}
qsv.status.asleep = false
qsv.status.combat = false
qsv.status.prone = false
qsv.status.riding = false
qsv.status.vampire = false

qsv.vitals = {}
qsv.vitals.blood = nil
qsv.vitals.charges = 0 -- cadence for rogues, stormfury charges for mages
qsv.vitals.stats = ""

qsv.bal = {} -- all kind of balances
qsv.bal.balance = true
qsv.bal.equil = true
qsv.bal.focus = true
qsv.bal.od = true
qsv.bal.psi = true

qsv.waiting = {}
qsv.waiting.prompt = false

qsv.enemy = {}
qsv.enemy.health = ""

qsv.reload = {}
qsv.reload.prompt = true
