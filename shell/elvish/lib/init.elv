use platform

if (eq $platform:os windows) {
  use init/windows
}

if (eq $platform:os darwin) {
  use init/darwin
}
