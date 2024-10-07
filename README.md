# README

cap deploy できるだけの Rails7 アプリ。


# Usage

docker-compose を事前にインストールしておく。

```
$ bundle install

$ docker-compose build
$ docker-compose up -d

$ bundle exec cap production deploy

$ curl http://localhost:4000  # テキストで "Welcome" とだけ返ってくる

$ ssh root@localhost -p 4022  # パスワードは screencast
```
