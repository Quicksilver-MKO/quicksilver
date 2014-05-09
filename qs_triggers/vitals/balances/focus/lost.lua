trigger = {
 name = "focus used",
 lines = {
  { tr = [[^You focus intently on your \w+ ailments\.$]], type = "p" },
  { tr = [[^You spin .* in a dominating strike at .*, sending it smashing into h\w\w gut\.$]], type = "p" },
  { tr = [[^You spin.* at .*, but miss\.$]], type = "p" },
  { tr = [[You have no \w+ afflictions to cleanse.]], type = "e" },
 },
 script = "focus_loss",
}
