#!/usr/bin/env ruby
# frozen_string_literal: true

puts '-' * 40

def block_method
  yield 23
end

result = block_method do |arg|
           arg.upcase
         rescue => e
           puts e.inspect
           arg
         ensure
           puts "Ensure #{arg}, Rescued #{e.class}"
         end

puts result.inspect

puts '-' * 40

result = [1,2,3].yield_self do |o|
           puts o.inspect
           [4, 5, 6]
         end

puts result.inspect

puts '-' * 40

puts %w[ant bear cat].any?(/dog/i) #=> false
puts %w[ant bear cat].any?(/cat/i) #=> true

puts '-' * 40

def first(list)
  list.fist
end

def second(list)
  first(rest(list))
end

def rest(list)
  list[1..-1]
end

puts second([1, 2, 3])
