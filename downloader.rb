# -*- coding: utf-8 -*-

require 'rubygems'
require 'mechanize'
require 'fileutils'
require 'yaml'
require 'time'
require 'tmpdir'

def exit_with_message
  puts 'this downloader needs a arg like'
  puts '$ ruby downloader.rb R1'
  exit
end

exit_with_message if ARGV.length != 1
@target = ARGV[0]
@target = 'EX' if @target == 'REX'

puts ARGV

def load_config
  @conf = YAML.load_file('conf.yaml')
  @agent = Mechanize.new
  @agent.auth(@conf['username'], @conf['password'])
  @pat = Regexp.new(@conf['ext'].map{ |s| "\\.#{s}$"}.join('|'))
end

def mk_dirs
  @downdir = File.expand_path FileUtils.mkdir_p(@conf['download_to'] + @target, {:verbose => true}).first
  @tmpdir = File.expand_path File.join(Dir.tmpdir, 'ta-support' + Time.now.to_i.to_s)
end

def download
  @agent.get("http://ist.ksc.kwansei.ac.jp/~kitamura/cgi-bin/2011prog2/report/report.cgi?act_display_report=1&c=#{@conf['class_id'].to_s}&r=#{@target}")
  links = @agent.page.links_with(:href => @pat)
  links.each do |l|
    id = l.href.scan(/\d{4}/).first
    l.href =~ /&i=(.+)/
    if @conf['students'].include?(id)
      dir = @tmpdir + '/' + id + '/'
      FileUtils.mkdir_p(dir)
      path = dir + $1
      puts 'downloading ' + path
      l.click.save_as(path)
    end
  end
end

def diff_dir(from, to)
  Dir.chdir(from)
  from_files = Dir.glob('./**/*')

  Dir.chdir(to)
  to_files = Dir.glob('./**/*')

  new_files = (to_files - from_files)
  new_files.each{ |f| puts 'new ' + f.to_s}

  diffs = (from_files & to_files).select{ |f| File.ftype(f) == "file"}.reject{ |f|
    FileUtils.cmp(File.join(from, f), File.join(to, f))
  }
  diffs.each{ |f| puts 'updated' + f.to_s}

  (new_files + diffs).select{ |f| File.ftype(f) == 'file'}
end

def cp_all(files)
  files.each do |f|
    FileUtils.mkdir_p(File.dirname(File.join(@downdir, f)))
    FileUtils.cp_r(File.join(@tmpdir, f), File.join(@downdir, f))
  end
end

load_config
mk_dirs
download
diff = diff_dir(@downdir, @tmpdir)
cp_all(diff)



