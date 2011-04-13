require 'rake/clean'

SOURCES = FileList["**/*.java"]
CLASSES = SOURCES.ext('class')

task :default => :exec
  
desc 'download reports with arg'
file :download, "R"
file :download do |x, args|
  sh "ruby downloader.rb #{args.R}"
end

desc 'compile all .java files'
file :compile do
  SOURCES.each do |s|
    sh "javac -J-Dfile.encoding=UTF-8 #{s}"
  end
end

desc 'exec each class file with classpath'
task :exec do
  CLASSES.each do |c|
    p = File.split(c)
    sh "java -cp #{p[0]} -Dfile.encoding=UTF-8 #{p[1].sub(/\.class$/, '')} || echo failed!"
    STDIN.gets
  end
end

#rule '.class' => ['.java'] do |t|
#  sh "javac -J-Dfile.encoding=UTF-8 #{t.source}"
#end

