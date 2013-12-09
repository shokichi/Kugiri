#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
#


module Kugiri
  module Notice
    require "gtk2"
    def notice_schedule(message)
      set_window(message)
      show_window
    end

    def set_window(message)
      window = Gtk::Window.new("Kugiri")
      window.set_default_size(200,100)
      button = Gtk::Button.new(message)
      button.signal_connect("destroy") do
        Gtk.main_quit
      end
      window.add(button)
      window.show_all
     Gtk.main
    end

    def show_window(wait_time=3)
#      Gtk.main
#      sleep 3 #wait_time.to_f
#      Gtk.main_quit
    end
  end
end
