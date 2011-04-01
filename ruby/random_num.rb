#!/usr/bin/env ruby
#
# vim:syntax=ruby:sw=4:ts=4:expandtab

randomNumber = rand(10)
usersNumber = -1

until usersNumber == randomNumber
    puts "Enter a Number:"
    usersNumber = gets.to_i
    if usersNumber > randomNumber
        puts "Your choice is higher"
    elsif usersNumber < randomNumber
        puts "Your choice is lower"
    end
end

puts "You got the right number -> #{usersNumber}"
