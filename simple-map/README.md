# README

git clone https://github.com/nekakoshi/lessons.git
cd lessons/simple-map


環境変数用途のenvファイルを作成する。

```
$ cp .env{_origin,}
```

GoogleMapAPI用途の環境変数にAPIKeyを追加する。

```
$ vim .env 
GOOGLE_MAP_APIKEY=xxxxxxxxxxxxxxxxxxx
```

データベースの初期

```
$ bundle install 
$ bundle exec rails db:create
Created database 'db/development.sqlite3'
Created database 'db/test.sqlite3

$ bundle exec rails db:migrate

$ bundle exec rake db:seed
```

サーバを起動する。
```
$ bundle exec rails s 
```
