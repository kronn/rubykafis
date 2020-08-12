#!/usr/bin/env ruby

# # Diese Methode akzeptiert nur ein Schlüsselwortargument
# def foo(k: 1)
#   p k
# end

# h = { k: 42 }

# # Dieser Methodenaufruf übergibt ein positionsgebundenes Hash-Argument.
# # In Ruby 2.7: Das Hash wird automatisch in ein Schlüsselwortargument konvertiert
# # In Ruby 3.0: Dieser Aufruf verursacht einen ArgumentError
# foo(h)
# # => demo.rb:11: warning: The last argument is used as the keyword parameter
# #    demo.rb:2: warning: for `foo' defined here; maybe ** should be added to the call?
# #    42

# # Wenn Sie das alte Verhalten in Ruby 3.0 behalten wollen, nutzen Sie
# # den double-splat-Operator:
# foo(**h) #=> 42

# puts '-' * 40

# # Diese Methode akzeptiert ein positionsgebundenes Argument und ein
# # Schlüsselwort-Restargument
# def bar(h, **kwargs)
#   p h
# end

# # Dieser Aufruf übergibt nur ein Schlüsselwortargument und keine
# # positionsgebundenen Argumente.
# # In Ruby 2.7: Das Schlüsselwort wird in ein
# #              positionsgebundenes Hash-Argument konvertiert
# # In Ruby 3.0: Dieser Aufruf verursacht einen ArgumentError
# bar(k: 42)
# # => demo2.rb:9: warning: The keyword argument is passed as the last hash parameter
# #    demo2.rb:2: warning: for `bar' defined here
# #    {:k=>42}

# # Wenn Sie das alte Verhalten in Ruby 3.0 beibehalten wollen,
# # verlangen Sie mit geschweiften Klammern ausdrücklich ein Hash.
# bar({ k: 42 }) # => {:k=>42}

# puts '-' * 40

head = { method: "HEAD", page: '/foo' }
head_plain = { method: "HEAD" }
get = { method: "GET", page: '/foo' }
put_status = { method: "PUT", page: '/status', attributes: [1, 2, 3] }
put = { method: "PUT", page: '/data', attributes: [1, 2, 3] }

def parse_request(request_hash)
  case request_hash
  in { method: "HEAD" }
    puts "HEAD"
  in { method: "GET", page: page }
    puts "GET #{page}"
  in { method: "PUT", page: '/status', attributes: attrs }
    puts "Updating Status with #{attrs.inspect}"
  in { method: "PUT", page: page, attributes: attrs }
    puts "Updating #{page} with #{attrs.inspect}"
  end
end

parse_request head       # => HEAD
parse_request head_plain # => HEAD
parse_request get        # => GET /foo
parse_request put_status # => Updating Status with [1, 2, 3]
parse_request put        # => Updating /data with [1, 2, 3]
