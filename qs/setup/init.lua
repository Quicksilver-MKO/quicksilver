-- QS - sets the important things up

-- setup the different special tables (qsf, qsg) before anything is put in them
-- MUST BE THE FIRST THING TO RUN
qss.load_lua("setup/tables")

-- defines a few aliases
qss.load_lua("setup/misc")

-- temporary variables for the normal system use
qss.load_lua("setup/tempvar")
