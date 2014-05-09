-- QS - root file of the quicksilver system
-- this file is loaded first, and then the others are loaded according to the order mentioned in this file, depth-first (that means, all the scripts that are called by the first file listed here will be loaded before the second file is)

qst = qst or {} --triggers [they will be checked for illusions automatically]
qsf = qsf or {} --system functions
qsv = qsv or {} --temporary variables
qsg = qsg or {} --functions called by GMCP messages

qss.load_lua("utils/")

-- setup (variables, config...)
qss.load_lua("setup/")

-- triggers
qss.load_lua("vitals/")
