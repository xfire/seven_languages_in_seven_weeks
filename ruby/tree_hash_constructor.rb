#!/usr/bin/env ruby
#
# vim:syntax=ruby:sw=4:ts=4:expandtab

class TreeHC
    attr_accessor :node_name

    def initialize(data)
        e = data.shift # for simplicity don't support multiple root nodes
        @node_name = e[0]
        @children = to_t(e[1])
    end

    def to_t(children)
        children.map {|k, v| TreeHC.new(Hash[k,v]) }
    end

    def visit_all(&block)
        visit &block
        @children.each {|c| c.visit_all(&block)}
    end

    def visit(&block)
        block.call self
    end
end

ruby_tree = TreeHC.new({'grandpa' =>
                          {'dad' =>
                              {'child 1' => {},
                               'child 2' => {}
                              },
                           'uncle' =>
                              {'child 3' => {},
                               'child 4' => {}
                              }
                          }
                      })

ruby_tree.visit_all {|node| puts node.node_name}
