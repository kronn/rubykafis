---
title: Ruby Versions v2025
theme: theme/puzzle.css
revealOptions:
    transition: 'fade'
---

# Ruby Kafi März 2025

<!-- .slide: class="master01" -->

---

# `whoami`

<ul>
<li>Matthias Viehweger
<li>Ruby seit 1.8.7
<li>Rails seit 2.3
<li>Puzzle ITC seit 2016
<li>github.com/kronn
<li>@kronn@ruby.social
</ul>

Note:

- Warum sollte man mir zuhören?
- Vermutlich gar nicht, man kann sich das ja auch selbst erarbeiten.

<!-- .slide: class="master01" -->

----

# Was bisher geschah…
## eine Reise durch die Changelogs

<img src="ruby.png" alt="The Ruby Logo" height="200px">


<!-- .slide: class="master01" -->

----

# Überblick

<ol>
<li class="fragment">Version 3.3
<li class="fragment">Version 3.4
</ol>

<!-- .slide: class="master01" -->

---

# Version 3.3

<!-- .slide: class="master02 intro" -->

----

## Prism

<ul>
<li class="fragment">Alternative zu Ripper
<li class="fragment">ruby --parser=prism
</ul>

Note:

- wird erstmal nur hinzugefügt und _kann_ genutzt werden

<!-- .slide: class="master02" -->

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

- YJIT kann schon ab Ruby 3.2 aktiviert werden

<!-- .slide: class="master02" -->

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

<!-- .slide: class="master02" -->

----

## `it`

<ul>
<li class="fragment">it -> warning (und NameError)
<li class="fragment">it("does not affect rspec")
<li class="fragment">it { "has also one param" }
<li class="fragment">it = "is fine"
</ul>

Note:

._

- warning: `it` calls without arguments will refer to the first block param in Ruby 3.4; use it() or self.it
- siehe auch `yield_self` -> `then`

<!-- .slide: class="master02" -->

----

## Weiteres?

- Mehr und mehr StdLib wird zu Gems
- z.B. csv und base64
- diese gehören dann ins Gemfile
- bootsnap verhindert, dass eine Warnung angezeigt wird
- einmal mit <code>DISABLE_BOOTSNAP=1</code> starten

<!-- .slide: class="master02" -->

----

Mit diesen Änderungen wurden seit Ruby&nbsp;3.2.0

 * 5532 Dateien geändert,
 * 326851 Einfügungen(+)
 * 185793 Löschungen(-)

Frohe Weihnachten, schöne Ferien und viel Spaß bei der Programmierung mit Ruby&nbsp;3.3!

<!-- .slide: class="master02" -->

---

# Version 3.4

<!-- .slide: class="master03 intro" -->

----

## Prism

<ul>
<li class="fragment">Default Parser
<li class="fragment"><code>ruby --parser=parse.y</code>
</ul>

Note:

- gleiches Thema wie bei 3.3?
- kam in 3.3 dazu, ist jetzt default. Man _kann_ noch zurück.
- Community ist aber eher begeistert von Prism

<!-- .slide: class="master03" -->

----

## YJIT

<ul>
<li class="fragment">mehr schneller, weniger Speicher
<li class="fragment"><code>--yjit-log</code> / <code>RubyVM::YJIT.log</code>
<li class="fragment"><code>--yjit-mem-size</code>
<li class="fragment"><code>RubyVM::YJIT.runtime_stats</code>
<li class="fragment">viele neue Optimierungen
</ul>

Note:

- Das Memory-Limit hat ein Default von 128MiB
- Wenn YJIT läuft, werden einige Core-Methoden in Ruby verwendet, damit sie optimiert werden können. Das betrifft: Array#each, Array#select, Array#map
- triviale Methoden werden inlined, zum Beispiel:
  - leere Methode
  - Methoden mit Konstanten Werten
  - Methoden, die direkt self zurückgeben
  - Methoden, die direkt ein Argument zurückgeben
- String-Methoden und bitwise-Operationen

<!-- .slide: class="master03" -->

----

## RFC 8305 Support

<ul>
<li class="fragment">Happy Eyeballs V2
<li class="fragment"><code>TCPSocket.open</code> / <code>Socket.tcp</code>
<li class="fragment">neu: parallele lookups
<li class="fragment">aktiv per default
</ul>

Note:

- RFC: IPv4 und IPv6 DNS Auflösung parallel
- Verbindungsversuche zu allen Adressen, prioritär IPv6
- weitere zeitversetzte Versuche im Abstand von 250ms
- erste erfolgreiche Verbindung gewinnt, die anderen werden abgebrochen
- Kann mit `RUBY_TCP_NO_FAST_FALLBACK=1` ausgeschaltet werden
- Oder mit `fast_fallback: false` direkt beim Method-Call
- `TCPSocket.new(slow_traditional_style: true)` funktioniert nicht

<!-- .slide: class="master03" -->

----

## Modularer GC

<ul>
  <li class="fragment">erlaubt dynamisches Laden von GCs
  <li class="fragment">Rubys GC wurde dafür "extrahiert"
  <li class="fragment">neue GC libary auf mmtk (experimentell)
  <li class="fragment"><code>GC.config</code>
</ul>

Note:

- mmtk basiert auf der JVM
- mmtk ist gesponsert von Shopify, Huawei und Google
- Ruby 2.* war sehr GC-heavy, aber da kommt wohl noch was
- siehe auch YJIT
- GC kann damit zur Laufzeit noch angepasst werden, aktuell, welche Objekte im Full-Run für den Mark/Sweep-GC betrachtet werden: Alle oder nur "junge" Objekte.
- Der default GC ist aktuell incremental und generational, junge/kurzlebige Objekte werden also schneller weggeräumt. Im "Full"-Run wird dann alles analysiert.
- Watch the GC-Space :-)

<!-- .slide: class="master03" -->

----

## `it`

<ul>
<li>it -> warning und NameError in 3.3
<li>it("does not affect rspec")
<li>it { "has also one param" }
<li>it = "is fine"
<li class="fragment"><code>it</code> is better than <code>_1</code>
</ul>

<!-- .slide: class="master03" -->

----

## Vorher

```ruby
# Generate CSV and convert it to a configurable
# encoding. By default, this is ISO-8859-1.
def call
  convert(generate)
end
```

Note:

- hitobito/hitobito: app/domain/export/tabular/csv/generator.rb
- the original comment is longer, but mostly explains that the DB uses UTF-8

<!-- .slide: class="master03" -->

----

## Ruby 2.5

```ruby
# Generate CSV and convert it to a configurable
# encoding. By default, this is ISO-8859-1.
def call
  generate.yield_self { |csv| convert(csv) }
end
```

<!-- .slide: class="master03" -->

----

## Ruby 2.6

```ruby
# Generate CSV and convert it to a configurable
# encoding. By default, this is ISO-8859-1.
def call
  generate.then { |csv| convert(csv) }
end
```

<!-- .slide: class="master03" -->

----

## Ruby 2.7

```ruby
# Generate CSV and convert it to a configurable
# encoding. By default, this is ISO-8859-1.
def call
  generate.then { convert(_1) }
end
```

<!-- .slide: class="master03" -->

----

## Ruby 3.4

```ruby
# Generate CSV and convert it to a configurable
# encoding. By default, this is ISO-8859-1.
def call
  generate.then { convert(it) }
end
```

<!-- .slide: class="master03" -->

----

## Vergleich

```ruby
def old
  convert(generate)
end

def new
  generate.then { convert(it) }
end

def call = generate.then { convert it }
```

<!-- .slide: class="master03" -->

----

## `it`

<ul>
<li class="fragment">it -> NameError || _1
<li class="fragment">nicht mischbar mit _2, _3, ...
<li class="fragment"><code>it</code> kann zu lesbarem Code führen
<li class="fragment">ausschreiben von allen parametern aber auch 😉
</ul>

Note:

- SyntaxError: numbered parameters are not allowed when 'it' is already used

<!-- .slide: class="master03" -->

----

## Sprachänderungen

<ul>
<li class="fragment"><code>frozen_string_literal: true</code> ist default
<li class="fragment">Splats: <code>**nil == **{}</code>
</ul>

Note:

- Genau wie `encoding: utf8` bekommt damit auch das `frozen_string_literal: true` ein Ende
- frozen_string_literal kam mit Version 2.3

<!-- .slide: class="master03" -->

----

## Core-Classes

<ul>
<li class="fragment"><code>raise Error, "msg", caller_locations</code>
<li class="fragment"><code>Ractor</code>
<li class="fragment"><code>Range#size</code>
</ul>

Note:

- Exception#set_backtrace akzeptiert ein Array von locations, wie sie von `Kernel#caller_locations` erzeugt werden
- require in Ractors geht, findet dann im main-Ractor statt
- Range#size kann TypeError raisen, wenn Range keine diskreten Werte enthält

<!-- .slide: class="master03" -->

----

## B0rken Things

<ul>
<li class="fragment">Exceptions: Backticks -> Single Quotes
<li class="fragment">Exceptions: Klassenname werden angezeigt
<li class="fragment">Hash#inspect verwendet "neue" Syntax
<li class="fragment">Float("1.") und Float("1.E-1") geht
<li class="fragment">Refinement#refined_class -> #target
</ul>

Note:

- Backticks waren in einigen Kombinationen von Sprache, Kultur, Grammatik und Font noch historisch erklärbar. Willkommen im Heute.
- Es werden nur permamente Klassennamen angezeigt
- Die "neue" Syntax ist von einer 1.9-Version, irgendwann zwischen 2007 und 2010
- Float/to_f waren vorher inkonsistent

<!-- .slide: class="master03" -->

----

## B0rken StdLib

<ul>
<li class="fragment">DidYouMean::SPELL_CHECKERS[]=
<li class="fragment">Net::HTTP deprecated constants
<li class="fragment">Timeout.timeout(-1)
<li class="fragment">URI::Generic nutzt URI::RFC3986_PARSER
</ul>

Note:

- DidYouMean hatte auswechselbare Spellchecker?
- Net::HTTPs Konstanten waren seit 2012 deprecated...
- Was genau soll ein negatives Timeout sein?
- URI::Generic hat den parser geändert

<!-- .slide: class="master03" -->

----

Mit diesen Änderungen wurden seit Ruby&nbsp;3.3.0

 * 4942 Dateien geändert,
 * 202244 Einfügungen(+)
 * 255528 Löschungen(-)

Frohe Weihnachten, schöne Ferien und viel Spaß bei der Programmierung mit Ruby&nbsp;3.4!

<!-- .slide: class="master03" -->

---

# Merci viumau

<img src="ruby.png" alt="The Ruby Logo" height="200px">

<!-- .slide: class="master01" -->

----

# Links

- https://ruby-lang.org
- https://allaboutcoding.ghinda.com/exploring-it-default-block-param-warning-in-ruby-33

<!-- .slide: class="master01" -->
