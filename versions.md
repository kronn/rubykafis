# Ruby Kafi 56.0

<!-- .slide: class="master01" -->

----

# Was bisher geschah…
## eine Reise durch die Changelogs

<img src="ruby.png" alt="The Ruby Logo" height="200px">


<!-- .slide: class="master01" -->

----

# alle Jahre wieder,<br>am 25.12.

Seit Ruby 2.1 wird jährlich zu Weihnachten eine neue minor-Version
herausgegeben, die API-kompatibel sein KANN. Releases, die nur die teeny-Version
anheben, sind immer API-kompatibel.

<!-- .slide: class="master01" -->

----

# Überblick

<ol>
<li class="fragment">Version 2.3
<li class="fragment">Version 2.4
<li class="fragment">Version 2.5
</ol>

<!-- .slide: class="master01" -->

---

# Version 2.3

<!-- .slide: class="master02 intro" -->

----

# frozen_string_literal: true

```ruby
# frozen_string_literal: true
'direct modification'.upcase!

#=> RuntimeError "can't modify frozen String"
```

```ruby
# frozen_string_literal: true
'return modification'.upcase

#=> FROZEN STRING
```

<!-- .slide: class="master02" -->

----

# &.
## the loneliness-Operator

```ruby
nil.name

#=> NoMethodError "undefined method `name' for nil:NilClass"
```

```ruby
nil&.name

#=> nil
```

<!-- .slide: class="master02" -->

----

# Array#dig, Hash#dig

```ruby
config = { language: { ruby: { version: '2.3.0' } } }

config.dig(:language, :ruby, :version)    #=> 2.3.0
config.dig(:language, :python, :version)  #=> nil
config.dig(:language, @user_language.to_sym, :version)
```

<!-- .slide: class="master02" -->

----

# did_you_mean

```ruby
[1, 2, 3].mix

#=> NoMethodError "undefined method `mix' for [1, 2, 3]:Array"
#   Did you mean?  min
#                  max
```

<!-- .slide: class="master02" -->

----

Mit diesen Änderungen wurden seit Ruby&nbsp;2.2.0

* 2946 Dateien geändert.
* 104057 Einfügungen(+)
* 59478 Löschungen(-)

Frohe Weihnachten, schöne Ferien und haben Sie Spaß an der Programmierung mit Ruby&nbsp;2.3!

<!-- .slide: class="master02" -->

---

# Version 2.4

<!-- .slide: class="master03 intro" -->

----

# binding.irb

<ul>
<li class="fragment">fast wie binding.pry
<li class="fragment">eher eine IRB
<li class="fragment">weniger luxus, aber immer vorhanden
</ul>

<!-- .slide: class="master03" -->

----

# Integer
## Fixnum | Bignum

<ul>
<li class="fragment">Fixnum und Bignum sind deprecated
<li class="fragment">Ruby-Code warnt
<li class="fragment">C-Code bricht
</ul>

<!-- .slide: class="master03" -->

----

# Unicode-Handling

```ruby
'Håkon René Piñioça'.upcase #=> HÅKON RENÉ PIÑIOÇA
```

<!-- .slide: class="master03" -->

----

# Performance
## weniger temporäre Objekte

* Array#min, Array#max
* Regexp#match?

<!-- .slide: class="master03" -->

----

# Debugging

* Thread#report_on_exception<br />(statt report-on-GC)
* Deadlock-Erkennung für Threads

<!-- .slide: class="master03" -->

----

Mit diesen Änderungen wurden seit Ruby&nbsp;2.3.0

* 2523 Dateien geändert.
* 289129 Einfügungen(+)
* 84670 Löschungen(-)

Frohe Weihnachten, schöne Ferien und haben Sie Spaß an der Programmierung mit Ruby&nbsp;2.4!

<!-- .slide: class="master03" -->

---

# Version 2.5

<!-- .slide: class="master04 intro" -->

----

# rescue/else/ensure in Blöcken
## wie in Methoden schon jetzt

```ruby
block_method do |arg|
  arg.upcase
rescue => e
  puts "Cannot upcase #{arg}, Rescued #{e.class}"
  arg
end
```

<!-- .slide: class="master04" -->

----

# yield_self
## ähnlich #tap, aber ändert den Return-Value

```ruby
[1, 2, 3].yield_self do |o|
  puts o.inspect
  [4, 5, 6]
end

#=> [4, 5, 6]
```

<!-- .slide: class="master04" -->

----

# Enumerable#any?, all?, none? und one?
## können Regex verwenden

```ruby
%w[ant bear cat].any?(/dog/i) #=> false
%w[ant bear cat].any?(/cat/i) #=> true
```


<!-- .slide: class="master04" -->

----

# Backtrace ist jetzt rückwärts

* neuester Aufruf zuletzt
* nur im Terminal/TTY

```text
Traceback (most recent call last):
	2: from /path/to/test25.rb:49:in `<main>'
	1: from /path/to/test25.rb:42:in `second'
/path/to/test25.rb:38:in `first': undefined method `fist' for [2, 3]:Array (NoMethodError)
Did you mean?  first
```

<!-- .slide: class="master04" -->

----

# Performance

<ul>
<li class="fragment">Tracepoint-API entfernt (5 - 10%)
<li class="fragment">Mutex ist kleiner & schneller
<li class="fragment">lazy block/proc allocation (3x schneller)
<li class="fragment">ERB 2x schneller
<li class="fragment">Array#concat, Enumerable#sort_by, String#concat, String#index, Time#+…
</ul>

<!-- .slide: class="master04" -->

----

# StdLib -> StdGems

cmath, csv, date, dbm, etc, fcntl, fiddle, fileutils, gdbm, ipaddr, scanf,
sdbm, stringio, strscan, webrick, zlib

<!-- .slide: class="master04" -->

----

# Unter der Haube

<ul>
<li class="fragment">SecureRandom nutzt OS-Zufall
<li class="fragment">RDoc-Update -> schnellerer Lexer, schnellere Doku
<li class="fragment">Unicode 10.0.0
<li class="fragment">Thread#report_on_exception = true
</ul>

<!-- .slide: class="master04" -->

----

Mit diesen Änderungen wurden seit Ruby&nbsp;2.4.0

* 6158 Dateien geändert.
* 348484 Einfügungen(+)
* 82747 Löschungen(-)

Frohe Weihnachten, schöne Feiertage und viel Spaß bei der Programmierung mit Ruby&nbsp;2.5!

<!-- .slide: class="master04" -->

---

# Merci vielmol

<img src="ruby.png" alt="The Ruby Logo" height="200px">

<!-- .slide: class="master01" -->

----

# Link

* https://ruby-lang.org

<!-- .slide: class="master01" -->
