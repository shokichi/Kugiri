#!/usr/bin/env ruby
#
#
#

require "../lib/base.rb"
require "clockwork" 
include JikanWarin
include Timer
include Clockwork  

cal = Schedule.new(ARGV[0])

print "=> Ctrl-C to exit\n"
#Signal.trap(:INT){
#  print "--- Exiting\n"
#  exit(0)}

handler do |type|
  Timer.time_check(cal) if type == "check"
  cal.reload if type == "sync"  
end

every(30.seconds, 'check')
every(30.minutes, 'sync')
