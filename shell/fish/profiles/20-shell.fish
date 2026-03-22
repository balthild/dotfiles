# Carapace
set -gx CARAPACE_MATCH 'CASE_INSENSITIVE'
carapace _carapace | source

# Starship
set -gx STARSHIP_LOG 'error'
starship init fish --print-full-init | source

# Direnv
direnv hook fish | source
