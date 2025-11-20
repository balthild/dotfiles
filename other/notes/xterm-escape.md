# XTerm Input Escape Sequences

## Glossary

- Constants
  - `<ESC>`: Escape character (`\x1b` in Zig; `\u001b` in JSON; `\e` in Bash)
  - `<CSI>`: Control Sequence Introducer (`<ESC>[`)
  - `<SS3>`: Single Shift 3 (`<ESC>O`)
- Parameters
  - `<Char>`: ASCII character
  - `<Int>`: Integer (multiple decimal digits)
  - `<Str>`: String (multiple printable characters)
  - `<Fn>`: Final character of a function
  - `<..>`: Multiple parameters of same type, separated by semicolons
  - `<?>`: Optional parameter

## C0/C1 Control Characters

Format: `<ESC><Char>`

Some of them are interpreted as `Alt-<Char>`. For example, `<ESC>D` is interpreted as <kbd>Alt+D</kbd> and bound to `delete-word` by default.

## VT Application Keypad

Format: `<SS3><Char>`

## VT Control Sequences

Format: `<CSI><Int..?><Fn>`

The sequences with `<Fn>` being `~` are called **function key** sequences; the others are called **cursor control** sequences.

When modifiers are applicable, the encoded modifiers are placed as an extra parameter. Other parameters (or a dummy parameter for those functions accepting no parameters) must be specified to prevent the modifiers from being interpreted as a parameter of the function itself.

For example, `<CSI>1;3C` is <kbd>Alt+Right</kbd> (the `1` is a dummy parameter), but `<CSI>3C` is just <kbd>Right</kbd> (the `3` becomes a parameter being ignored).

## XTerm Extensions

### CSI-27

Format: `<CSI>27;<Int>;<Int>~`

These sequences are used for some special keys like `Tab` or `Space` with modifiers. The format are consistent with VT function key sequences. The first parameter is always `27` - a code that is not used by existing VT sequences. The second parameter is the encoded modifiers, and the third parameter is the ASCII code of the key.

### CSI-u

Format: `<CSI><Int>;<Int>u`

Similar to CSI-27, but looks like cursor control sequences and supports Unicode. The first parameter is the Unicode codepoint and the second parameter is the encoded modifiers.

## Modifiers

Modifiers are encoded into a single integer as `sum(...modifiers) + 1`. The default value is `1` (no modifiers).

| Modifier | Value |
| -------- | ----- |
| Shift    | 1     |
| Alt      | 2     |
| Control  | 4     |
| Meta     | 8     |

## References

- [XTerm Control Sequences](https://invisible-island.net/xterm/ctlseqs/ctlseqs.html)
- [ANSI/VT100 Terminal Control Escape Sequences](https://www2.ccs.neu.edu/research/gpc/VonaUtils/vona/terminal/vtansi.htm)
- [ANSI escape code - Wikipedia](https://en.wikipedia.org/wiki/ANSI_escape_code#Terminal_input_sequences)
