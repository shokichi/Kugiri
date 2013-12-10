#!/usr/bin/env ruby
#
#
#
require File.expand_path(File.dirname(__FILE__)+"/../lib/base.rb")
require "clockwork" 
include Kugiri
include Timer
include Clockwork  

print "=> Ctrl-C to exit\n"

cal = Schedule.new(ARGV[0])
handler do |type|
  Timer.time_check(cal)
  cal.reload if type == "sync"  
end

every(30.seconds, 'check')
every(30.minutes, 'sync')
