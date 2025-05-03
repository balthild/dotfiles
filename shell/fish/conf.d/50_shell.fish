# Carapace
set -Ux CARAPACE_BRIDGES 'fish'
set -Ux CARAPACE_MATCH 'CASE_INSENSITIVE'
carapace _carapace | source

# Starship
set -Ux STARSHIP_LOG 'error'
starship init fish | source

# Direnv
direnv hook fish | source
