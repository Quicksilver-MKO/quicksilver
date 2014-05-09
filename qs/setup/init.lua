-- QS - sets the important things up

-- setup the different special tables (qsf, qsg) before anything is put in them
-- MUST BE THE FIRST THING TO RUN
qss.load_lua("setup/tables")

-- temporary variables for the normal system use
qss.load_lua("setup/tempvar")
