# YankCode (vim)

Yank code to the clipboard. Code is automatically unindented. A header is added
in the form of a comment that includes the file name and lines copied. Adding
the header relies on `commentstring` being set correctly. If `commentstring` is
set to an empty string (e.g. JSON), no header will be added.

Instead of yanking:

```ruby
    def valid?(*)
      if instance_variable_defined?(:@_interaction_valid)
        return @_interaction_valid
      end

      super
    end
```

You'll get:

```ruby
#  lib/active_interaction/concerns/runnable.rb (lines 48-54)
def valid?(*)
  if instance_variable_defined?(:@_interaction_valid)
    return @_interaction_valid
  end

  super
end
```

Now you're ready to paste it into Slack or wherever you need!

## Installation

## Vim Plug

```vim
Plug 'AaronLasseigne/yank-code'
```

## Usage

Visually select an area and then call `:YankCode`.

You can also map it:

```vim
map <leader>y <plug>YankCode
```

The mapping will work in normal and visual modes, e.g. `<leader>yip` or `vip<leader>y` to yank a paragraph.

YankCode is licensed under [the MIT License][].

[the mit license]: LICENSE.md
