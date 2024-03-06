---
title: Ruby Versions v2024
theme: theme/puzzle.css
revealOptions:
    transition: 'fade'
---

# Ruby Kafi Januar 2024

<!-- .slide: class="master01" -->

----

# RailsHöck März 2024

<!-- .slide: class="master01" -->

----

# `whoami`

<ul>
<li class="fragment">Matthias Viehweger
<li class="fragment">Ruby since 1.8.7
<li class="fragment">Rails since 2.3
<li class="fragment">Puzzle ITC since 2016
<li class="fragment">github.com/kronn
<li class="fragment">@kronn@ruby.social
</ul>

<!-- .slide: class="master01" -->

----

# Previously, in Ruby…
## a journey through the changelogs

<img src="ruby.png" alt="The Ruby Logo" height="200px">


<!-- .slide: class="master01" -->

----

# Overview

<ol>
<li class="fragment">Version 2.3 - 3.1
<li class="fragment">Version 3.2
<li class="fragment">Version 3.3
</ol>

<!-- .slide: class="master01" -->

---

# Version 2.3 - 3.1

<!-- .slide: class="master02 intro" -->

----

# Version 2.3

```ruby
# frozen_string_literal: true

nil&.name

config = { language: { ruby: { version: '2.3.0' } } }
config.dig(:language, :ruby, :version)    #=> 2.3.0

[1, 2, 3].mix # => Did you mean? ...
```

Note: It's been a while, right?

<!-- .slide: class="master02" -->

----

# Version 2.4

- binding.irb
- Fixnum | Bignum -> Integer
- Unicode-Handling
- Performance
- Deadlock-Detection for Threads

Note:

Try to remember the merge into Integer.

And: since this version, you can have - without pry - a REPL anywhere in your program easily.
Is it the same as pry? no.
Is it present even in air-gapped or "difficult to change" scenarios? yes

<!-- .slide: class="master02" -->

----

# Version 2.5

- rescue/else/ensure in blocks
- yield_self
- Enumerable.any?(/re/)
- Backtrace is now backwards in the TTY
- Performance
- StdLib -> StdGems

Note:

- yield_self? surely we can to better ;-)
- This marks the beginning of the move towards StdGems. Before, famous libraries "lost momentum" when being added to the StdLib.
- Backtrace-changes? When does this ever happen in any language. Surely, this is an exceptional one-time thing.

<!-- .slide: class="master02" -->

----

# Version 2.6

- MJIT (Method JIT)
- Kernel#yield_self -> #then
- Binding#source_location
- endless Ranges `(1..)`
- Method-Compositioning `(f << g).call(3)`
- Enum-Chaining `(1..3).chain([4, 5])`

Note:

- Ooh, a JIT, experimental, but still nice
- Ooh, a nice alias for yield_self
- binding.irb gets more features...

<!-- .slide: class="master02" -->

----

# Version 2.7

- MJIT is still experimental
- Pattern Matching (experimental)
- Compacting GC
- Preparation for Keyword-Args in 3.0
- beginless Ranges `(..42)`

Note:

- oh, a JIT
- finally the compacting GC. Thanks, tenderlove!
- beginless Ranges: 1. why 2. oh, nice 3. I feel this, sometimes

<!-- .slide: class="master02" -->

----

# Version 3.0

- 3x3 Performance ✅ (in OptCarrot)
- MJIT (experimental)
- Ractor (experimental)
- RBS (Typehints)
- Pattern Matching
- Endless Methods
- Hash#except

Note:

- oh, an experimental JIT :yawn:
- Endless Methods: `def one = 1`

<!-- .slide: class="master02" -->

----

# Version 3.1

- YJIT (experimental)
- MJIT (performance improvements)
- some shorter yntax `{a:, b:}`
- IRB Autocompletion

Note:

- oh JIT, they are multiplying (experimentally)
- instead `{a: a, b: b}`
- binding.irb now has a really nice advantage over binding.pry

<!-- .slide: class="master02" -->

---

# Version 3.2

<!-- .slide: class="master03 intro" -->

----

## WASI-based WebAssembly

<ul>
<li class="fragment">Ruby in the Browser
<li class="fragment">WASM-Module usable in Ruby
<li class="fragment">gem install wasmtime
</ul>

Note:

- Demo wasm.html

<!-- .slide: class="master03" -->

----

## YJIT

<ul>
<li class="fragment">production-ready
<li class="fragment">needs Rust 😱
<li class="fragment">official image has Rust 🎉
<li class="fragment">uses Object Shapes
</ul>

Note:

- MJIT is still available and has been reimplemented in pure Ruby, but Shopify made a nice statement here. 
- I'll come back to Shapes shortly, next slide

<!-- .slide: class="master03" -->

----

## Performance

<ul>
<li class="fragment">ReDoS / Regexp.timeout
<li class="fragment"><a href="https://www.youtube.com/watch?v=2aVyTtxs0GU">Object Shapes</a>
</ul>

Note:

- Regex against a long String and with man look-behind/-aheads
- for a thorough explanation of shapes, watch (or remember) the Euruko 2022 talk
- short version: Shapes are the characteristic of a class, how many and which ivars are present
- having this allow caching of lookup-tables and similar optimizations
- If you are interested in this, watch the talk.

<!-- .slide: class="master03" -->

----

## New

<ul>
<li class="fragment">Data (immutable Struct)
<li class="fragment">Set does not need to be required anymore
<li class="fragment">Struct does not need keyword_init: true anymore
<li class="fragment">IRB has debug integration
</ul>

Note:

- Set is "built-in" available, it is being autoloaded once you mention the constant
- binding.irb now has: debug, break, catch, next, delete, step, continue, finish, backtrace, info
- and that even if you do not have debug in your Gemfile
- otherwise, StdGems are distributed, but not loaded if you do not mention them in the Gemfile

<!-- .slide: class="master03" -->

----

## Old

<ul>
<li class="fragment">Fixnum and Bignum
<li class="fragment">Object#=~
<li class="fragment">File.exists? and Dir.exists?
<li class="fragment">Kernel#taint and Kernel#trust
</ul>

Note:

- What is Fixnum or Bignum now? (Integer)
- String#=~ is still there
- Deprecations since Ruby 2.1 (!)

<!-- .slide: class="master03" -->

----

With those changes,

 * 3048 files changed,
 * 218253 insertions(+),
 * 131067 deletions(-)

since Ruby 3.1.0!

Merry Christmas, Happy Holidays, and enjoy programming with Ruby 3.2!

<!-- .slide: class="master03" -->

---

# Version 3.3

<!-- .slide: class="master04 intro" -->

----

## Prism

<ul>
<li class="fragment">Alternative to Ripper
<li class="fragment">ruby --parser=prism
</ul>

Note:

- it just an addition, which _can_ be used

<!-- .slide: class="master04" -->

----

## Lrama Parser generator

<ul>
<li class="fragment">Replacement für Bison
<li class="fragment">Fewer hacks for Parser-generation
<li class="fragment"><a href="https://rubykaigi.org/2023/presentations/spikeolaf.html">The future vision of Ruby Parser</a>
</ul>

Note:

- The presentation is in japanese. Even with subtitles, I didn't get it
- Takeaway: Not only the Runtime, but also the tooling around creating it is being developed.

<!-- .slide: class="master04" -->

----

## YJIT

<ul>
<li class="fragment">more faster
<li class="fragment">less memory
<li class="fragment">export RUBY_YJIT_ENABLE="1"
<li class="fragment">RubyVM::YJIT.enable
<li class="fragment">default since Rails 7.2
</ul>

Note:

- We didn't here from JIT in a long time, right? 😂
- YJIT can be activated since Ruby 3.2
- measure your result, especially, if you have an optimized app and pay for memory

<!-- .slide: class="master04" -->

----

## RJIT

<ul>
<li class="fragment">pure Ruby
<li class="fragment">experimental
<li class="fragment">replacement for MJIT
<li class="fragment">use YJIT preferably
</ul>

Note:

- How many JITs do we have now?
- MJIT, YJIT, RJIT?
- it's 2, because MJIT got replaced 😂

<!-- .slide: class="master04" -->

----

## Performance

<ul>
<li class="fragment">M:N Thread Scheduler
<li class="fragment">defined?(@var) uses Object Shapes
<li class="fragment">GC improvements
</ul>

Note:

- Release-Notes summarize this better.
- GC-topics are always complex, which almost always leaves room for improvement. 
- the Performance-work is not only done with JIT, but all throughout the VM
- RUBY_GC_HEAP_INIT_SLOTS -> RUBY_GC_HEAP_{0,1,2,3,4}_INIT_SLOTS

<!-- .slide: class="master04" -->

----

## IRB

<ul>
<li class="fragment">gets better and better <a href="https://github.com/ruby/irb">(see Repo)</a>
<li class="fragment">completion: default Regex-based
<li class="fragment">now also type-aware<span class=fragment>, if typehints are available</span>
<li class="fragment"><a href="https://github.com/ruby/ruby/blob/master/doc/reline/face.md">Reline::Face</a>
</ul>

Note:

- Take a look at the repo at gh.com/ruby/irb
- it has paging support for ls, show_source, show_cmds
- IRB::RegexpCompletor or IRB::TypeCompletor
- maybe you know this from elixir-projects. There you use IEx.configure to configure the look and feel

<!-- .slide: class="master04" -->

----

## `it`

<ul>
<li class="fragment">it -> warning
<li class="fragment">it("does not affect rspec")
<li class="fragment">it { "has also one param" }
<li class="fragment">it = "is fine"
<li class="fragment">it is better than _1
</ul>

Note:

._

- warning: `it` calls without arguments will refer to the first block param in Ruby 3.4; use it() or self.it
- see also `yield_self` -> `then`

<!-- .slide: class="master04" -->

----

## Anything else?

<ul>
<li class="fragment">Bug found: https://ruby.social/@idiosyncratic/111651677178474193
<li class="fragment">Bug fixed: https://github.com/ruby/ruby/pull/9373
<li class="fragment"><code>export RUBYOPT="--backtrace-limit=5"</code>
<li class="fragment">at least once per Version: <code>DISABLE_BOOTSNAP=1</code>
</ul>

Note:

- The Bug was found and reported on 2023-12-27 and fixed the same day
- more and more StdLib migrates to Gems
- z.B. csv und base64
- you need to mention them in your Gemfile to have them loaded
- bootsnap suppresses the warning

<!-- .slide: class="master04" -->

----

With those changes,

 * 5532 files changed,
 * 326851 insertions(+)
 * 185793 deletions(-)

since Ruby&nbsp;3.2.0

Merry Christmas, Happy Holidays, and enjoy programming with Ruby 3.3!

<!-- .slide: class="master04" -->

---

# Thank you

<img src="ruby.png" alt="The Ruby Logo" height="200px">

<!-- .slide: class="master01" -->

----

# Links

- https://ruby-lang.org
- Object Shapes: https://www.youtube.com/watch?v=2aVyTtxs0GU
- The future vision of Ruby Parser: https://rubykaigi.org/2023/presentations/spikeolaf.html
- https://github.com/ruby/irb
- Reline::Face https://github.com/ruby/ruby/blob/master/doc/reline/face.md
- https://allaboutcoding.ghinda.com/exploring-it-default-block-param-warning-in-ruby-33

<!-- .slide: class="master01" -->
