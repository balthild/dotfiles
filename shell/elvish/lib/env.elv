use platform

if (eq $platform:os darwin) {
  use env/darwin
}

if (eq $platform:os windows) {
  use env/windows
}
