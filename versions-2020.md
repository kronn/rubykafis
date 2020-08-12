---
title: Ruby Version v2020
theme: theme/puzzle.css
revealOptions:
    transition: 'fade'
---

# Ruby Kafi August 2020

<!-- .slide: class="master01" -->

----

# Was bisher geschah…
## eine Reise durch die Changelogs

<img src="ruby.png" alt="The Ruby Logo" height="200px">


<!-- .slide: class="master01" -->

----

# Überblick

<ol>
<li class="fragment">Version 2.3 - 2.5
<li class="fragment">Version 2.6
<li class="fragment">Version 2.7
</ol>

<!-- .slide: class="master01" -->

---

# Version 2.3 - 2.5

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

<!-- .slide: class="master02" -->

----

# Version 2.4

- binding.irb
- Fixnum | Bignum -> Integer
- Unicode-Handling
- Performance
- Deadlock-Erkennung für Threads

<!-- .slide: class="master02" -->

----

# Version 2.5

- rescue/else/ensure in Blöcken
- yield_self
- Enumerable.any?(/re/)
- Backtrace ist jetzt rückwärts im TTY
- Performance
- StdLib -> StdGems

Note: cmath, csv, date, dbm, etc, fcntl, fiddle, fileutils, gdbm, ipaddr, scanf, sdbm, stringio, strscan, webrick, zlib

<!-- .slide: class="master02" -->

---

# Version 2.6

<!-- .slide: class="master03 intro" -->

----

# Experimente I

## JIT

<ul>
<li class="fragment">Method JIT
<li class="fragment">ruby --jit
<li class="fragment">ruby --jit-verbose=1
</ul>

Note: Mit Stand Ruby 2.6.0 wurde eine 1,7-fache Verbesserung der Performanz gegenüber Ruby 2.5 bei einem CPU-intensiven, nicht-trivialen Belastungstest namens Optcarrot festgestellt.

<!-- .slide: class="master03" -->

----

# Experimente II

## RubyVM::AbstractSyntaxTree

<ul>
<li class="fragment">parse(ruby_string)
<li class="fragment">parse_file(filename)
<li class="fragment">RubyVM::AbstractSyntaxTree::Node
</ul>

Note: Die Kompatibilität dieses Moduls mit zukünftigen Versionen kann nicht garantiert werden. Mithilfe von Node-Objekten können die Positionsinformationen und Angaben über Kindknoten ermittelt werden.

<!-- .slide: class="master03" -->

----

# Syntax und Details

<ul>
<li class="fragment">Kernel#yield_self -> #then
<li class="fragment">class Ärgernisse; end
<li class="fragment">Binding#source_location
</ul>

Note: `source_location` gibt ein 2-Element-Array mit den Bestandteilen __FILE__ und __LINE__ zurück, die beschreiben, an welcher Stelle im Quelltext ein Binding definiert wurde

<!-- .slide: class="master03" -->

----

# Endlos-Range

```ruby
# identisch zu ary[1..-1] ohne magische -1
ary[1..]

# Endlosschleife ab Index 1
(1..).each {|index| ... }

# ary.each.with_index(1) { ... }
ary.zip(1..) {|elem, index| ... }
```

<!-- .slide: class="master03" -->

----

# Methoden-Komposition

```ruby
f = proc{|x| x + 2}
g = proc{|x| x * 3}

(f << g).call(3) # -> 11; identical to f(g(3))
(f >> g).call(3) # -> 15; identical to g(f(3))
```

<!-- .slide: class="master03" -->

----

# Enumerator-Chaining

```ruby
enum = (1..3).chain([4, 5])
enum.to_a #=> [1, 2, 3, 4, 5]

enum = (1..3).each + [4, 5]
enum.to_a #=> [1, 2, 3, 4, 5]
```

<!-- .slide: class="master03" -->

----

# Performance&shy;verbesserungen

<ul>
<li class="fragment">Proc#call
<li class="fragment">block.call
<li class="fragment">Transient Heap
<li class="fragment">Fiber
</ul>

Note: Bei Transient Heap handelt es sich um einen automatisch verwalteten Freispeicher für kurzlebige Objekte im Speicher, auf welche von bestimmten Klassen (Array, Hash, Object und Struct) verwiesen wird. Dies führt beispielsweise dazu, dass die Erstellung kleiner und kurzlebiger Hash-Objekte doppelt so schnell ist.

<!-- .slide: class="master03" -->

----

# Sonstiges

<ul>
<li class="fragment">Bundler included
<li class="fragment">Unicode 11 (:puzzle: -> 🧩)
<li class="fragment">Unicode 12 (:mate: -> 🧉)
<li class="fragment">Unicode 12.1 (ERA NAME REIWA -> ㋿)
</ul>

Note: Unicode Versionen 12 und 12.1 wird seit 2.6.3 unterstützt und damit Unterstützung für die neue japanische Ära eingeführt.

<!-- .slide: class="master03" -->

----

Mit diesen Änderungen wurden seit Ruby&nbsp;2.5.0

 * 6437 Dateien geändert,
 * 231471 Einfügungen(+)
 * 98498 Löschungen(-)

Frohe Weihnachten, schöne Ferien und viel Spaß bei der Programmierung mit Ruby&nbsp;2.6!

<!-- .slide: class="master03" -->

---

# Ruby 2.7

<!-- .slide: class="master04" -->

----

# Experiment

## Pattern Matching

```ruby
json = '{
  "name": "Alice",
  "age": 30,
  "kids": [
    { "name": "Bob", "age": 2 }
  ]
}'

case JSON.parse(json, symbolize_names: true)
in {name: "Alice", kids: [{name: "Bob", age: age}]}
  p age #=> 2
end
```

Note: Pattern Matching -> case/when + multiple assignment

<!-- .slide: class="master04" -->

----

# Pattern Matching

```ruby
def parse_request(request_hash)
  case request_hash
  in { method: "HEAD" }
    puts "HEAD"
  in { method: "PUT", page: '/status',
       attributes: attrs }
    puts "Updating Status with #{attrs.inspect}"
  in { method: "PUT", page: page,
       attributes: attrs }
    puts "Updating #{page} with #{attrs.inspect}"
  end
end
```

<!-- .slide: class="master04" -->

----

# Pattern Matching

```ruby
parse_request({ method: "HEAD" }) # => HEAD

parse_request({ method: "HEAD", page: '/foo' })
# => HEAD

parse_request({ method: "PUT", page: '/status',
               attributes: [1, 2, 3] })
# => Updating Status with [1, 2, 3]

parse_request({ method: "PUT", page: '/data',
               attributes: [1, 2, 3] })
# => Updating /data with [1, 2, 3]
```

<!-- .slide: class="master04" -->

----

# Binding.irb

<ul>
<li class="fragment">mehrzeiliges bearbeiten
<li class="fragment">ri aufrufen mit <TAB><TAB>
<li class="fragment">automatische Einrückung
<li class="fragment">farbliche Hervorhebung
</ul>

<!-- .slide: class="master04" -->

----

# Defragmentierender GC

<ul>
<li class="fragment">weniger Speicherverbrauch
<li class="fragment">Copy-on-Write freundlich
<li class="fragment">manueller Schritt
<li class="fragment">GC.compact
</ul>

<!-- .slide: class="master04" -->

----

# Methoden-Argumente

<ul>
<li class="fragment">Trennung von Positions- und KWArgs ab Ruby 3.0
<li class="fragment">Using the last argument as keyword parameters is deprecated
<li class="fragment">Passing the keyword argument as the last hash parameter is deprecated
<li class="fragment">Splitting the last argument into positional and keyword parameters is deprecated
</ul>

<!-- .slide: class="master04" -->

----

# Keywordargs übergeben

<ul>
<li class="fragment">foo(key: value)
<li class="fragment">foo(**kwargs)
<li class="fragment">kwargs -> { key: value }
</ul>

<!-- .slide: class="master04" -->

----

# Keywordargs annehmen

<ul>
<li class="fragment">def foo(key: default)
<li class="fragment">def foo(key:)
<li class="fragment">def foo(**kwargs)
<li class="fragment">kwargs -> { key: value }
</ul>

<!-- .slide: class="master04" -->

----

# Argumente ohne Probleme

<ul>
<li class="fragment">nur kwargs
<li class="fragment">hash nicht als letztes argument
<li class="fragment">nur ein hash als argument
</ul>

<!-- .slide: class="master04" -->

----

# Argumente und Versionen

<ul>
<li class="fragment">2.7 ist Migrationspfad
<li class="fragment">2.6: `def foo(*args, &block)`
<li class="fragment">3.0: `def foo(*args, **kwargs, &block)`
<li class="fragment">2.7, 3.0: `def foo(...); target(...); end`
</ul>

Note: Das letzte ist eine neue Syntax zur einfacheren Weiterleitung.

<!-- .slide: class="master04" -->

----

# JIT

<ul>
<li class="fragment">immer noch experimentell
<li class="fragment">verschiedene Optimierungsstrategien
<li class="fragment">MethodInlining von pure Functions
<li class="fragment">Fokus auf "very hot spots" (10_000 Aufrufe)
</ul>

<!-- .slide: class="master04" -->

----

# Performance&shy;verbesserungen

<ul>
<li class="fragment">Fiber
<li class="fragment">Module#name, true.to_s, false.to_s, und nil.to_s -> frozen String
<li class="fragment">MethodCache
</ul>

Note: 

<!-- .slide: class="master04" -->

----

# Sonstige Features

<ul>
<li class="fragment">Beginless Ranges
<li class="fragment">Enumerable#tally
<li class="fragment">self.private_method
</ul>

<!-- .slide: class="master04" -->

----

# Sonstige Features

```ruby
ary[..3]  # identical to ary[0..3]
rel.where(sales: ..100)

["a", "b", "c", "b"].tally
#=> {"a"=>1, "b"=>2, "c"=>1}

def foo; end
private :foo
self.foo
```

<!-- .slide: class="master04" -->

----

# mitgelieferte Gems

* Bundler 2.1.2
* RubyGems 3.1.2
* CSV 3.1.2
* Racc, REXML, RSS

<!-- .slide: class="master04" -->

----

# neu extrahierte gems

* benchmark
* delegate
* open3
* singleton
* ...

<!-- .slide: class="master04" -->

----

# Ökosystem

<ul>
<li class="fragment">SourceCode auf git ab 2.7
<li class="fragment">Github bleibt Mirror
<li class="fragment">Offizielles Snap-Paket
</ul>

<!-- .slide: class="master04" -->

----

Mit diesen Änderungen wurden seit Ruby&nbsp;2.6.0

 * 4190 Dateien geändert,
 * 227498 Einfügungen(+)
 * 99979 Löschungen(-)

Frohe Weihnachten, schöne Ferien und viel Spaß bei der Programmierung mit Ruby&nbsp;2.7!

<!-- .slide: class="master04" -->

---

# Merci vielmol

<img src="ruby.png" alt="The Ruby Logo" height="200px">

<!-- .slide: class="master01" -->

----

# Link

* https://ruby-lang.org
* https://speakerdeck.com/k_tsj/pattern-matching-new-feature-in-ruby-2-dot-7
* https://www.ruby-lang.org/de/news/2019/12/12/separation-of-positional-and-keyword-arguments-in-ruby-3-0/

<!-- .slide: class="master01" -->
