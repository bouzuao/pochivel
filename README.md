ポチベル
========

## 電話でホテルの絞り込みをするサービス
1. 人数、日にち、電話番号を入力
2. 電話で答える10の質問に答えて、おすすめホテルを1件表示
3. おすすめホテルの概要を表示、予約
4. 予約完了

## 概要

- AWS?
- Ruby
- Rails
- twilio

### Open Hack Day
- 開発          ：2014年2月15日(土) 12:00 – 2月16日(日) 12:00
- 発表会・授賞式：2014年2月16日(日) 13:00 - 18:00


## sidekiq

電話を掛ける部分を非同期にするために`sidekiq`を使っています。

http://qiita.com/nysalor/items/94ecd53c2141d1c27d1f

非同期ジョブを実行するためには

```
bundle exec sidekiq -q default
```

の実行が必要です。

## TODO

https://github.com/bouzuao/pochivel/issues/1
