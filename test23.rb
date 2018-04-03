#! /usr/bin/env ruby
# frozen_string_literal: true

puts '-' * 40

puts '# frozen_string_literal: true'

begin
  puts 'frozen string'.upcase!
rescue => e
  puts e.class
  puts e.message
  puts e.backtrace
end

puts '-' * 20

puts 'frozen string'.upcase

puts '-' * 40

# &.

puts '&.'

begin
  nil.name
rescue => e
  puts e.class
  puts e.message
  puts e.backtrace
end

puts '-' * 20

result = nil&.name
puts result.inspect

puts '-' * 40

# Array#dig, Hash#dig

config = { language: { ruby: { version: '2.3.0' } } }

puts config.dig(:language, :ruby, :version).inspect

puts '-' * 20

puts config.dig(:language, :python, :version).inspect

puts '-' * 40

# did_you_mean

begin
  [1,2,3].mix
rescue => e
  puts e.class
  puts e.message
  puts e.backtrace
end

puts '-' * 40
