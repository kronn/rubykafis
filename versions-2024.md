---
title: Ruby Version v2024
theme: theme/puzzle.css
revealOptions:
    transition: 'fade'
---

# Ruby Kafi Januar 2024

<!-- .slide: class="master01" -->

----

# Was bisher geschah…
## eine Reise durch die Changelogs

<img src="ruby.png" alt="The Ruby Logo" height="200px">


<!-- .slide: class="master01" -->

----

# Überblick

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

Note: schon recht lange her, oder?

<!-- .slide: class="master02" -->

----

# Version 2.4

- binding.irb
- Fixnum | Bignum -> Integer
- Unicode-Handling
- Performance
- Deadlock-Erkennung für Threads

Note:

Merkt euch mal den Merge zu Integer.

Und: ab hier kann man auch ohne pry eine REPL irgendwo im Programm starten

<!-- .slide: class="master02" -->

----

# Version 2.5

- rescue/else/ensure in Blöcken
- yield_self
- Enumerable.any?(/re/)
- Backtrace ist jetzt rückwärts im TTY
- Performance
- StdLib -> StdGems

Note:

- yield_self? geht das nicht besser?
- Ab hier beginnt der Weg der StdLib nach Rubygems. Vorher ja eher anders herum...
- Backtrace-Änderungen? Wann gibt es sowas denn schon?

<!-- .slide: class="master02" -->

----

# Version 2.6

- MJIT (Method JIT)
- Kernel#yield_self -> #then
- Binding#source_location
- endlose Ranges
- Methoden-Komposition `(f << g).call(3)`
- Enum-Chaining `(1..3).chain([4, 5])`

Note:

- Ohh ein JIT
- Ohh ein schönes alias zu yield_self
- binding.irb bekommt mehr features...

<!-- .slide: class="master02" -->

----

# Version 2.7

- MJIT immer noch experimentell
- Pattern Matching (experimentell)
- Defragmentierender GC
- Vorbereitung der Keyword-Args ab 3.0
- anfangslose Ranges

Note:

- oh, ein JIT
- aber das wohl am längsten erwartete GC-Feature

<!-- .slide: class="master02" -->

----

# Version 3.0

- 3x3 Performance ✅ (in OptCarrot)
- MJIT (experimentell)
- Ractor (experimentell)
- RBS (Typehints)
- Pattern Matching
- Endless Methods
- Hash#except

Note:

- passiert mit dem MJIT noch was?
- Endless Methods: `def one = 1`

<!-- .slide: class="master02" -->

----

# Version 3.1

- YJIT (experimentell)
- MJIT (performance verbessert)
- teilweise kürzere Syntax `{a:, b:}`
- IRB Autocompletion

Note:

- oh JIT, sie vermehren sich (experimentell)
- statt `{a: a, b: b}`
- binding.irb hat jetzt schon krasse Vorteile gegenüber binding.pry

<!-- .slide: class="master02" -->

---

# Version 3.2

<!-- .slide: class="master03 intro" -->

----

## WASI-based WebAssembly

<ul>
<li class="fragment">Ruby im Browser
<li class="fragment">WASM-Module in Ruby nutzen
<li class="fragment">gem install wasmtime
</ul>

Note:

- Demo wasm.html

<!-- .slide: class="master03" -->

----

## YJIT

<ul>
<li class="fragment">produktiv
<li class="fragment">benötigt Rust 😱
<li class="fragment">offizielles Image hat Rust 🎉
<li class="fragment">nutzt Object Shapes
</ul>

Note:

- MJIT gibt es weiterhin und wurde in Ruby neu implementiert, aber Shopify hat hier einfach mal Tatsachen geschaffen
- Shapes kommen gleich nochmal kurz

<!-- .slide: class="master03" -->

----

## Performance

<ul>
<li class="fragment">ReDoS / Regexp.timeout
<li class="fragment"><a href="https://www.youtube.com/watch?v=2aVyTtxs0GU">Object Shapes</a>
</ul>

Note:

- Regex auf einem langen String und mit vielen look-behing/-aheads
- zu Shapes sollte man sich den Talk ansehen.
- Kurzfassung: Shapes sind die Info, wieviele und welche Instanzvariablen in einer Klasse vorhanden sind.
- Dies erlaubt das Caching von lookup-tables und weitere Optimierungen
- Wen es interessiert, sollte sich den Talk ansehen

<!-- .slide: class="master03" -->

----

## Neu

<ul>
<li class="fragment">Data (immutable Struct)
<li class="fragment">Set braucht kein require mehr
<li class="fragment">Struct braucht kein keyword_init: true mehr
<li class="fragment">IRB hat debug integriert
</ul>

Note:

- Set ist "built-in" verfügbar, wird automatisch nachgeladen, wenn die Klasse referenziert wird.
- binding.irb hat jetzt: debug, break, catch, next, delete, step, continue, finish, backtrace, info
- auch, wenn das gem "debug" nicht im Gemfile ist

<!-- .slide: class="master03" -->

----

## Alt

<ul>
<li class="fragment">Fixnum und Bignum
<li class="fragment">Object#=~
<li class="fragment">File.exists? und Dir.exists?
<li class="fragment">Kernel#taint und Kernel#trust
</ul>

Note: 

- Wie heißt Fixnum oder Bignum jetzt? (Integer)
- String#=~ gibt es noch
- Deprecations teilweise seit Ruby 2.1

<!-- .slide: class="master03" -->

----

Mit diesen Änderungen wurden seit Ruby&nbsp;3.1.0

 * 3048 Dateien geändert,
 * 218253 Einfügungen(+)
 * 131067 Löschungen(-)

Frohe Weihnachten, schöne Ferien und viel Spaß bei der Programmierung mit Ruby&nbsp;3.2!

<!-- .slide: class="master03" -->

---

# Version 3.3

<!-- .slide: class="master04 intro" -->

----

## Prism

<ul>
<li class="fragment">Alternative zu Ripper
<li class="fragment">ruby --parser=prism
</ul>

Note:

- wird erstmal nur hinzugefügt und _kann_ genutzt werden

<!-- .slide: class="master04" -->

----

## Lrama Parser generator

<ul>
<li class="fragment">Ersatz für Bison
<li class="fragment">weniger Hacks beim Parser-Bau
<li class="fragment"><a href="https://rubykaigi.org/2023/presentations/spikeolaf.html">The future vision of Ruby Parser</a>
</ul>

Note:

- Die Präsentation ist auf japanisch. Und fach-chinesich. fach-japanisch?
- Takeaway: Nicht nur die Sprache, sondern auch das ganzen Tooling drum-herum wird stetig weiter entwickelt.

<!-- .slide: class="master04" -->

----

## YJIT

<ul>
<li class="fragment">mehr schneller
<li class="fragment">weniger Speicher
<li class="fragment">export RUBY_YJIT_ENABLE="1"
<li class="fragment">RubyVM::YJIT.enable
<li class="fragment">default ab Rails 7.2
</ul>

Note:

- Schon lange nichts mehr von JIT gehört, oder?
- YJIT kann schon ab Ruby 3.2 aktiviert werden

<!-- .slide: class="master04" -->

----

## RJIT

<ul>
<li class="fragment">pure Ruby
<li class="fragment">Experimentell
<li class="fragment">Ersatz für MJIT
<li class="fragment">eher YJIT verwenden
</ul>

Note:

- Wieviel JIT haben wir jetzt? (MJIT, YJIT, RJIT)
- es sind 2, weil MJIT herausfällt 😂

<!-- .slide: class="master04" -->

----

## Performance

<ul>
<li class="fragment">M:N Thread Scheduler
<li class="fragment">defined?(@var) nutzt Object Shapes
<li class="fragment">GC Verbesserungen
</ul>

Note:

- Release-Notes fassen es gut zusammen.
- GC-Themen sind immer komplex, daher ist klar, dass immer wieder was verbessert wird.
- Der Performance-Fokus ist aber nicht nur JIT, sondern allgemein die VM
- RUBY_GC_HEAP_INIT_SLOTS -> RUBY_GC_HEAP_{0,1,2,3,4}_INIT_SLOTS

<!-- .slide: class="master04" -->

----

## IRB

<ul>
<li class="fragment">wird immer besser <a href="https://github.com/ruby/irb">(siehe Repo)</a>
<li class="fragment">completion: default Regex-basiert
<li class="fragment">neu auch Type-aware<span class=fragment>, wenn Typehints vorhanden sind</span>
<li class="fragment"><a href="https://github.com/ruby/ruby/blob/master/doc/reline/face.md">Reline::Face</a>
</ul>

Note:

- Schaut euch gerne mal das Repo-an
- Pager support für ls, show_source, show_cmds
- IRB::RegexpCompletor oder IRB::TypeCompletor
- Vielleicht kennt man es aus Elixir-Projekten: Dort kann man via IEx.configure das aussehen steuern.

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
- siehe auch `yield_self` -> `then`

<!-- .slide: class="master04" -->

----

## Weiteres?

<ul>
<li class="fragment">Bug gefunden: https://ruby.social/@idiosyncratic/111651677178474193
<li class="fragment">Bug behoben: https://github.com/ruby/ruby/pull/9373
<li class="fragment"><code>export RUBYOPT="--backtrace-limit=5"</code>
<li class="fragment">wenigstens einmal pro Version: <code>DISABLE_BOOTSNAP=1</code>
</ul>

Note:

- Der Bug wurde am 2023-12-27 gemeldet und schon wieder gefixt
- Mehr und mehr StdLib wird zu Gems
- z.B. csv und base64
- bootsnap verhindert, dass eine Warnung angezeigt wird


<!-- .slide: class="master04" -->

----

Mit diesen Änderungen wurden seit Ruby&nbsp;3.2.0

 * 5532 Dateien geändert,
 * 326851 Einfügungen(+)
 * 185793 Löschungen(-)

Frohe Weihnachten, schöne Ferien und viel Spaß bei der Programmierung mit Ruby&nbsp;3.3!

<!-- .slide: class="master04" -->

---

# Merci viumau

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
