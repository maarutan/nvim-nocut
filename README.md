# No-Cut.nvim

`No-Cut.nvim` is a simple and efficient Neovim plugin that remaps delete, change, and paste commands to prevent deleted text from being stored in the clipboard. This is especially useful when you want to avoid accidentally overwriting clipboard content.

---

## Features

- **Delete text without copying to the clipboard:**
  Commands like `d`, `x`, `dd`, and `D` are remapped to use the black hole register (`"_`), ensuring deleted text does not overwrite clipboard content.

- **Replace text without copying:**
  Commands like `c`, `C`, `s`, and their visual mode equivalents are remapped similarly to avoid copying replaced text to the clipboard.

- **Paste without copying:**
  When pasting (`p`, `P`), the replaced text is not saved to the clipboard, maintaining the original clipboard content.

- **Flexible configuration:**
  You can customize which commands to remap and which to keep with their default behavior.

- **Exceptions:**
  Specify commands that should not be remapped (e.g., `Y`).

---

## Installation

### Using `packer.nvim`

```lua
use {
    'maarutan/nvim-nocut',
    config = function()
        require('no-cut').setup({
            d = true,
            x = true,
            dd = true,
            paste_without_copy = true,
            exceptions = { "Y" }
        })
    end
}
```

### Using `lazy.nvim`

```lua
{
    'maarutan/nvim-nocut',
    config = function()
        require('no-cut').setup({
            d = true,
            x = true,
            dd = true,
            paste_without_copy = true,
            exceptions = { "Y" }
        })
    end
}
```

---

## Configuration

The `setup` function allows you to customize the plugin to your preferences. Below are the available options:

### Options:

- **`d`, `x`, `s`, `c`, `dd`, `D`, `C`, `S`:**

  - `true`: Remap the command to use the black hole register.
  - `false`: Keep the command's default behavior.

- **`visual_commands`:**
  A table of commands to be remapped only in visual mode.

  Example:

  ```lua
  visual_commands = {
      d = true, -- Remap 'd' in visual mode
      c = false -- Keep default behavior for 'c'
  }
  ```

- **`exceptions`:**
  A list of commands that should not be remapped, even if enabled. For example:

  ```lua
  exceptions = { "Y" }
  ```

- **`paste_without_copy`:**
  - `true`: When pasting, replaced text is not saved to the clipboard.
  - `false`: Keep the default paste behavior.

---

### Full Example Configuration

Here is an example configuration that demonstrates the plugin's flexibility:

```lua
require('no-cut').setup({
    d = true,  -- Remap 'd'
    x = true,  -- Remap 'x'
    s = false, -- Keep default behavior for 's'
    c = true,  -- Remap 'c'
    dd = true, -- Remap 'dd'
    D = true,  -- Remap 'D'
    C = true,  -- Remap 'C'
    S = false, -- Keep default behavior for 'S'
    visual_commands = {
        d = true, -- Remap 'd' in visual mode
        c = true, -- Remap 'c' in visual mode
    },
    exceptions = { "Y" }, -- Exclude 'Y' from remapping
    paste_without_copy = true, -- Enable paste without copying
})
```

---

## Usage Examples

### Deleting a line

The `dd` command deletes a line without saving it to the clipboard.

### Replacing text

Highlight text in visual mode and press `c` to replace it. The replaced text will not be saved to the clipboard.

### Pasting

When pasting (`p` or `P`), the replaced text is ignored and not saved to the clipboard.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
