#! /usr/bin/env ruby
# frozen_string_literal: true

puts '-' * 40

variable = 23

binding.irb if binding.respond_to?(:irb)

puts "Die Antwort ist #{variable}"

puts '-' * 40

small = 20
big   = 20_000_000_000_000_000_000

puts [small, big].map(&:class).join(', ')

puts '-' * 40

puts 'Håkon René Piñioça'.upcase #=> HÅKON RENÉ PIÑIOÇA

puts '-' * 40
