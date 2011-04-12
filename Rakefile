require 'rake/clean'

SOURCES = FileList["**/*.java"]
CLASSES = SOURCES.ext('class')
  
task :default => :exec

desc 'exec each class file'
file :exec do
  CLASSES.each do |c|
    p = File.split(c)
    sh "java -cp #{p[0]} -Dfile.encoding=UTF-8 #{p[1].sub(/\.class$/, '')} || echo failed!"
    gets
  end
end

rule '.class' => ['.java'] do |t|
  sh "javac -J-Dfile.encoding=UTF-8 #{t.source}"
end

desc 'download reports with arg'
task :download, "R"
task :download do |x, args|
  sh "ruby downloader.rb #{args.R}"
end
