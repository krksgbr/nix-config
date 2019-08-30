from https://gist.github.com/mrkgnao/49c7480e1df42405a36b7ab09fe87f3d


Load `IosevkaConfigGen.hs` in a REPL and run `toToml` or `toElisp` to generate either TOML definitions for the glyphs (to put in parameters.toml), or a list of `prettify-symbol-mode` definitions for Emacs.

An example of generated TOML glyph definitions and elisp code are provided. 

![screenshot](http://img.pixady.com/2017/04/763958_201704050200541366x768scrot.png)

Note that 

  * I have a feature set called `XALL` in my fork that basically enables every possible ligation.

  * I've hacked a few extra ligatures into my local checkout (including `<<`, `>>`, a few attempts to make more `->>-`-ish things a la Fira Code and Pragmata Pro, and also ligatures for `<<<` and `>>>` with a bit of extra space between the arrows because things look ugly without).

  * I'm generating *far* more glyphs than there are ligatures for. In particular, I've added definitions for lots of things like `<~>` which aren't yet in Iosevka. The cool thing is that the generated glyphs end up looking almost *exactly* the same as "plain text". That is, plain `<|` and `prettify-symbols-mode`-enabled Unicode `<|` look the same. Once Iosevka gets those ligatures, I can just recompile Iosevka without having to change anything. (Besides restarting Emacs, ha.)
  
  * A ton of the generated glyphs (hello `==>>>--`) are stupid, but meh. I suppose having Pragmata-like equals chains with little indents near the end of each `=` might make those useful in Some Future ASCII APL/Haskell ("Jaskell"?) :P

1. copy paramaters.toml to iosevka src folder
2. `make custom-config && make custom`
