# ANSI Escape Sequence

https://en.wikipedia.org/wiki/ANSI_escape_code#Terminal_input_sequences

Format:

- VT: `<esc>[<keycode>~`
- VT: `<esc>[<keycode>;<modifier>~`
- Xterm: `<esc>[<Ps><char>`
- Xterm: `<esc>[<Ps>;<modifier><char>`

Modifiers:

| Modifier | Value |
| -------- | ----- |
| Shift    | 1     |
| Alt      | 2     |
| Control  | 4     |
| Meta     | 8     |

The value of `<modifier>` is `sum(...modifiers) + 1`.

Modifiers are put as an extra parameter before the final character. Therefore, if the character has its own parameter (such as `C` and `D`), the semicolon must not be omitted even when the parameter is omitted, otherwise the modifier will be interpreted as the parameter.
