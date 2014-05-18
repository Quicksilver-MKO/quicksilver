-- QS : sets up all the temporary variables

qsv.debug = {}

qsv.status = {}
qsv.status.asleep = false
qsv.status.class = nil
qsv.status.combat = false
qsv.status.dead = false
qsv.status.name = ""
qsv.status.prone = false
qsv.status.riding = false
qsv.status.unread = {news = 0, msgs = 0}
qsv.status.vampire = false

qsv.vitals = {}
qsv.vitals.blood = nil
qsv.vitals.charges = 0 -- cadence for rogues, stormfury charges for mages
qsv.vitals.cur = {A = 0, E = 0, F = 0, G = 0, H = 0, M = 0}
qsv.vitals.diff = {}
qsv.vitals.level = {}
qsv.vitals.max = {A = 100}
qsv.vitals.old = {}
qsv.vitals.prc = {}
qsv.vitals.stats = ""

qsv.bal = {} -- all kind of balances
qsv.bal.balance = true
qsv.bal.equil = true
qsv.bal.focus = true
qsv.bal.od = true
qsv.bal.offhand = true
qsv.bal.psi = true

qsv.waiting = {}
qsv.waiting.focus = false
qsv.waiting.od = false
qsv.waiting.prompt = false

qsv.enemy = {}
qsv.enemy.health = ""

qsv.reload = {}
qsv.reload.prompt = true
