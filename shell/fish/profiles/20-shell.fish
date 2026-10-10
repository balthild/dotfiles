if command -q carapace
  set -gx CARAPACE_MATCH 'CASE_INSENSITIVE'
  carapace _carapace | source
end

if command -q starship
  set -gx STARSHIP_LOG 'error'
  starship init fish --print-full-init | source
end

if command -q direnv
  direnv hook fish | source
end
