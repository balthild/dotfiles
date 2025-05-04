# Carapace
set -gx CARAPACE_MATCH 'CASE_INSENSITIVE'
carapace _carapace | source

# Starship
set -gx STARSHIP_LOG 'error'
starship init fish | source

# Direnv
direnv hook fish | source
