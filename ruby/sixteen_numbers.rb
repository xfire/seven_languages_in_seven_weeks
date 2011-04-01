#!/usr/bin/env ruby
#
# vim:syntax=ruby:sw=4:ts=4:expandtab

numbers = 1..16

r1 = numbers.inject([[]]) do |acc, v|
    if acc[-1].count < 4
        acc[-1].push(v)
    else
        acc.push([v])
    end
    acc
end

r1.each {|xs| p xs}
puts
numbers.each_slice(4) {|xs| p xs}
