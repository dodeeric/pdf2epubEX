#!/usr/bin/ruby

require 'htmlentities'

while line = gets
  puts HTMLEntities.new.encode(line, :basic)
end
