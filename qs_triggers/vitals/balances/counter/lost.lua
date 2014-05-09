trigger = {
 name = "counter used",
 lines = {
  { tr = [[^Recovering your balance from your \w+, you launch a counterattack at \w+.$]], type = "p" },
  { tr = [[You need to defend against that person, first.]], type = "e" },
 },
 script = "counter_loss",
}
