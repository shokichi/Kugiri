#!/usr/bin/env ruby
# test
require File.expand_path(File.dirname(__FILE__)+"/../lib/notice.rb")
require File.expand_path(File.dirname(__FILE__)+"/../lib/base.rb")
require "clockwork"
include Clockwork
include Kugiri
include Notice

handler do 
  notice_schedule("Test")
end

every(10.seconds,"job")

Schedule.new("test.schedule")




