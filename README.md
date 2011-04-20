# ta-support
劣悪なTA環境を改善するスクリプト  
mechanize、rakeに依存

## conf.yaml.sample
コンフィグのサンプル  
見たら分かる感じなので中身を書き換えてconf.yamlにリネームする  
担当クラスとかログイン情報とか担当の学生のIDとかを書く

## Rakefile
rakeコマンドで提出物のダウンロードと、それぞれ実行していくのができる  

### 提出物ぶっこぬき
`$ rake download R=1` 
でR1の提出物をダウンロードしてくる、R=2にすればR2をダウンロードしてくる。 
tmpディレクトリを作成してそこにダウンロードして差分があるやつのみをRディレクトリに移してる。 

### 連続実行
`$ rake exec R=1` 
で各個人のその回の提出物をクラスパスに追加してそれぞれのクラスファイルを実行していく
必要に応じてコンパイルされる、差分のみコンパイルするようにした
1クラスファイルごとに止まるのでenterとか押せば次にいく  

