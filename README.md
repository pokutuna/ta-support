# ta-support
劣悪なTA環境を改善するスクリプト  
mechanize、rakeに依存


## conf.yaml.sample
コンフィグのサンプル、書き換えてconf.yamlにリネームして使う  
担当クラスとかダウンロード先とか担当の学生のIDとかを書く

## Rakefile
基本的にRakeコマンドでなんとかなる  

### 提出物ぶっこぬき
`$ rake download[R1]`  
でR1の提出物をダウンロードしてくる


環境によってはエスケープがいる  
`$ rake download\[R1\]`

### 連続実行
`$ rake exec`  
で各個人ディレクトリをクラスパスに追加してそれぞれのクラスファイルを実行していく  
1クラスファイルごとに止まるのでenterとか押せば次にいく  


### downloader.rb
別にダウンローダだけで実行してもいい  
各回のファイルを落とす  
`$ ruby downloader.rb R1`  
でR1の担当範囲のファイルが落ちてくる



