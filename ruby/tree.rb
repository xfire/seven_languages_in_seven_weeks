#!/usr/bin/env ruby
#
# vim:syntax=ruby:sw=4:ts=4:expandtab

class Tree
    attr_accessor :children, :node_name

    def initialize(name, children = [])
        @children = children
        @node_name = name
    end

    def visit_all(&block)
        visit &block
        children.each {|c| c.visit_all(&block)}
    end

    def visit(&block)
        block.call self
    end
end

ruby_tree = Tree.new('Ruby',
                     [Tree.new('Reia'),
                      Tree.new('MacRuby')])

puts 'Visiting a Node'
ruby_tree.visit {|node| puts node.node_name}
puts

puts 'Visiting entire Tree'
ruby_tree.visit_all {|node| puts node.node_name}
