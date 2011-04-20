require 'rake/clean'

@srcs = FileList["R#{ENV['R']}/**/*.java"]
@classes = @srcs.ext('class')

rule '.class' => '.java' do |t|
  sh "javac -J-Dfile.encoding=UTF-8 #{t.source}"
end

desc 'download documents with report number'
file :download do |x, args|
  sh "ruby downloader.rb R#{ENV['R']}"
end

desc 'exec each class file with classpath'
file :exec => @classes do
  @classes.sort.each do |c|
    p = File.split(c)
    sh "java -cp #{p[0]} -Dfile.encoding=UTF-8 #{p[1].sub(/\.class$/, '')} || echo failed!"
    STDIN.gets
  end
end



