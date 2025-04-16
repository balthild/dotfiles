mkdir $nu.user-autoload-dirs.0

# Carapace
carapace _carapace nushell | save -f ($nu.user-autoload-dirs.0 | path join "carapace.nu")
$env.CARAPACE_MATCH = 'CASE_INSENSITIVE'

# Starship
starship init nu | save -f ($nu.user-autoload-dirs.0 | path join "starship.nu")
$env.STARSHIP_LOG = 'error'

# Direnv
if (which direnv | is-not-empty) {
  let hook = {||
    direnv export json | from json | default {} | load-env
    if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
      $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
    }
  }

  $env.config.hooks.pre_prompt = ($env.config.hooks.pre_prompt | append $hook)
}
