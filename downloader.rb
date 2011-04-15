# -*- coding: utf-8 -*-

require 'rubygems'
require 'mechanize'
require 'fileutils'
require 'yaml'

def exit_with_message
  puts 'this downloader needs a arg like'
  puts '$ ruby downloader.rb R1'
  exit
end

exit_with_message if ARGV.length != 1
target = ARGV[0]
puts ARGV

#load config
conf = YAML.load_file('conf.yaml')
class_id = conf['class_id']
agent = Mechanize.new
agent.auth(conf['username'], conf['password'])
pat = Regexp.new(conf['ext'].map{ |s| "\\.#{s}$"}.join('|'))
download_to = conf['download_to']
student_ids = conf['students']

agent.get("http://ist.ksc.kwansei.ac.jp/~kitamura/cgi-bin/2011prog2/report/report.cgi?act_display_report=1&c=#{class_id.to_s}&r=#{target}")

links = agent.page.links_with(:href => pat)
links.each do |l|
  id = l.href.scan(/\d{4}/).first
  l.href =~ /&i=(.+)/
  if student_ids.include?(id)
    dir = target + '/' + id + '/'
    FileUtils.mkdir_p(dir)
    path = dir + $1
    puts path
    l.click.save_as(path)
  end
end

