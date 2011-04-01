#!/usr/bin/env ruby
#
# vim:syntax=ruby:sw=4:ts=4:expandtab

if ARGV.count < 2
    puts "usage: grep.rb filename regex"
    exit
end

filename = ARGV[0]
re = Regexp.new(ARGV[1])

counter = 0
IO.foreach(filename) do |line|
    counter = counter + 1
    puts "#{counter}: #{line}" if re.match(line)
end
