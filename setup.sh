#gem
#wget http://rubyforge.org/frs/download.php/74619/rubygems-1.7.2.tgz
wget -e "http_proxy=http://proxy.ksc.kwansei.ac.jp:8080" http://rubyforge.org/frs/download.php/74619/rubygems-1.7.2.tgz
tar -zxvf rubygems-1.7.2.tgz
cd rubygems-1.7.2
ruby setup.rb

#gems
/usr/bin/gem install mechanize --http-proxy "http://proxy.kwansei.ac.jp:8080"
/usr/bin/gem install rake --http-proxy "http://proxy.kwansei.ac.jp:8080"