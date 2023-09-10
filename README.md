## MoziPittanGame
ターミナルで起動できる文字合わせゲームです

## 環境構築

```
$ cd mozi_pittan_game
$ make init
```

## 文字合わせゲームの起動

```
$ make start
```

## ゲームのルール
プレイヤーは隠された単語を制限回数以内にあてなくてはいけません
ゲームを実行すると、コンソール上には2つの情報が表示されます。
1. 1文字ずつアンダースコアで隠された単語
2. 残り失敗可能数
この状態で、ユーザーはアルファベットを1文字入力します。

## デモ動画
https://github.com/TakKoubu/mozi_pittan/assets/48621700/1e4460a3-6809-42c5-bad4-4bde3da085f1

## 仕様 & コードについて
- 単語はすべて英語の名詞とし、最低でも10個以上からランダムに選ばれる
- ユーザーが入力できる文字はアルファベットの1文字
- 大文字・小文字は同一とみなす。もし他の文字種が入力されたら、再度入力を促す
- 失敗可能数は5回
- ゲームが終了したら、アプリケーションを終了する
- Rspecによる単体テスト
