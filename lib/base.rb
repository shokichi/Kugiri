#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# 時間割
#
#
require File.expand_path(File.dirname(__FILE__)+"/notice.rb")

module Kugiri
  class Schedule
    def initialize(file)
      @@file = {name: file}
      @date = []
      @event = []
      parse_file
    end

    def reload
      return if @@file[:stamp] == File.stat(@@file[:name]).mtime
      parse_file
      Timer.time_sync
    end

    def add_event(date,event)
      @date.push(time)
      @event.push(event)
      @schedule[date] = event
    end

    def delete_event(time)
      @date.delete(time)
      @event.delete(@schedule[time])
      @schedule.delete(time)
    end

    def inquiry(day)
      serch_day = parse_day(day).yday
      serch_events = []
      @date.each do |d| 
        serch_events << @schedule[d] if d.yday == serch_day
      end
      return serch_events 
    end

    private
    def set_schedules
      ary = [@date,@event].transpose
      @schedule = Hash[*ary.flatten]
    end

    def parse_file
      File.open(@@file[:name]){|f|
        f.each_line{|l|
          line = l.chop.split(" ")
          break if line.size == 0
          set_date(line[0..-2])
          set_event(line[-1])
        }
        @@file[:stamp] = f.mtime
      }
      set_schedules
      puts "Parse file (#{@@file[:name]})"
    end

    def set_date(date)
      hrs,min = date[-1].split("-")[0].split(":")
      unless date[-2].nil?
        @@month = (date[-2].to_i/100).to_i
        @@day = date[-2].to_i - @@month*100
      end
      @date << Time.mktime(Time.now.year,@@month,@@day,hrs,min)
    end

    def set_event(event)
      @event << event
    end

    def parse_day(day)
      month = (day[-2].to_i/100).to_i
      day = day[-2].to_i - month*100      
      return Time.mktime(Time.now.year,month,day)
    end

    public
    attr_reader :schedule, :date, :event
  end

  module Timer
    include Notice
    def time_check(cal)
      cal.date.each do |time|
        if Time.now-30 < time and time < Time.now 
          notice_schedule(cal.schedule[time])
          cal.delete_event(time)
        end
      end
    end

    def time_sync
      loop do 
        break if Time.now.sec%30 == 0
      end
    end

  end
end
