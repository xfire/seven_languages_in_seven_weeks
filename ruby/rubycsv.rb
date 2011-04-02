#!/usr/bin/env ruby
#
# vim:syntax=ruby:sw=4:ts=4:expandtab

module ActsAsCsv
    def self.included(base)
        base.extend ClassMethods
    end

    module ClassMethods
        def acts_as_csv
            include InstanceMethods
        end
    end

    module InstanceMethods
        def read
            @csv_contents = []
            filename = self.class.to_s.downcase + '.txt'
            file = File.new(filename)
            @headers = file.gets.chomp.split(', ')
            file.each do |line|
                row = line.chomp.split(', ')
                @csv_contents << Hash[@headers.zip(row)]
            end
        end

        attr_accessor :headers, :csv_contents

        def initialize
            read
        end

        def each
            @csv_contents.each do |row| 
                class << row # nice trick
                    def method_missing(name, *args)
                        self.fetch(name.to_s, nil)
                    end
                end
                yield row
            end
        end
    end
end

class RubyCsv
    include ActsAsCsv
    acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect

puts
m.each {|row| puts "one -> #{row.one}"}
m.each {|row| puts "two -> #{row.two}"}
m.each {|row| puts "whut -> #{row.whut}"}
