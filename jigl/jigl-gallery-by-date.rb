#!/usr/bin/ruby
# encoding: UTF-8

require 'date'
require 'cgi'
require 'readline'

class String
  def html_safe
    return self.gsub('ü','&uuml;')
      .gsub('Ü','&Uuml;')
      .gsub('ä','&auml;')
      .gsub('Ä','&Auml;')
      .gsub('ö','&ouml;')
      .gsub('Ö','&Ouml;')
  end
end


def get_date filename
  begin
    exiv = `exiv2 #{filename}`
    exiv =~ /.*timestamp : (\d{4}:\d{2}:\d{2}) (\d{2}:\d{2}:\d{2})/
    date, time = $1, $2
    return nil if (not date and not time)
    date.strip!
    date.gsub!(':','.')
    time.strip!
    datetime = DateTime.parse(date + " " + time)
    #puts filename + ": " + datetime.to_s
    return datetime
  rescue StandardError => e
    puts filename + ": " + e.to_s
  end
end

puts ""
puts "+---------------------------------------------------------------------+"
puts "| Generator for jigl gallery file - sort images by exif creation date |"
puts "|   by Sebastian Neumann <me@tempo-tm.de>                             |"
puts "|   created: 2012-12-23, last modified: 2013-07-17                    |"
puts "+---------------------------------------------------------------------+"
puts
puts
puts "+----Notes--------------------------------+"
puts "| * use ruby 1.9.3                        |"
puts "| * execute script within pictures folder |"
puts "| * you need to install program 'exiv2'   |"
puts "+-----------------------------------------+"
puts

# check for directory argument
abort("No directory specified in first argument. I don't now where to look for your photos") unless ARGV[0]


pics = {}

print "-> fetching picture dates.."
Dir.foreach(ARGV[0]) do |d|
  next unless d =~ /\.(jpg|JPG|jpeg|JPEG)/
  pics[d] = get_date(d)
  print "."
end
puts "done."

print "\n-> sorting pictures.."
pics = pics.sort_by{ |a,b| b unless b}
puts "done."

puts "-> asking for gallery texts.."
print "Index-Titlebar: "
titlebar = CGI::escapeHTML(Readline.readline('> ', true)).html_safe
print "Index-Title: "
title = CGI::escapeHTML(Readline.readline('> ', true)).html_safe
print "Index-Header: "
header = CGI::escapeHTML(Readline.readline('> ', true)).html_safe
print "Index-Footer: "
footer = CGI::escapeHTML(Readline.readline('> ', true)).html_safe
puts "done."

print "-> generating gallery.."
gal = ""
gal << "GAL-OPTIONS\n"
gal << "INDEX-TITLEBAR ---- #{titlebar}\n"
gal << "INDEX-TITLE ---- #{title}\n"
gal << "INDEX-HEADER ----#{header}\n"
gal << "INDEX-FOOTER ----#{footer}\n"
pics.each do |name, date|
  line = name + " ----\n"
  gal << line
end
puts "done."

print "-> removing old gallery file.."
begin
  `rm gallery.dat`
rescue StandardError => e
  puts e
end
puts "done."

print "-> save new gallery file: 'gallery.dat'.."
File.open("gallery.dat", 'w') {|f| f.write(gal) }

puts "done."
puts "-> I'm done."
