# Ghostty
if (and (eq $E:TERM xterm-ghostty) (not-eq $E:GHOSTTY_INTEGRATION_LOADED 1)) {
  use ghostty-integration
  set-env GHOSTTY_INTEGRATION_LOADED 1
}

# Carapace
eval (carapace _carapace elvish | slurp)
# Make the completions case-insensitive
set E:CARAPACE_MATCH = 'CASE_INSENSITIVE'
set edit:completion:matcher[argument] = {|seed| edit:match-prefix $seed &ignore-case=$true }

# Starship
eval (starship init elvish)
# Suppress timeout messages from starship
set E:STARSHIP_LOG = 'error'
