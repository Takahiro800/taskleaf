# README
現場Railsのtaskleafアプリを作成します

### 目的
久しぶりにモノシリックなRailsアプリを作成することになったので、復習としてさらっと作成します。
以下は今回学んだことを自分用のメモとして残して起きます

# 3 タスク管理アプリケーションを作ろう
- gemfileの変更を行って、bundleコマンドを実行したらサーバーは再起動する必要がある

## 3.3
### redirect_to,renderの違い
- 一覧画面や新規登録画面を表示する際のように、アクションに続けてビューを表示させることはRailsで`render`に当たる
	- 一つのリクエストによって画面が表示される
- 対して、登録処理後に一覧画面に遷移する際のようにビューを表示せず、別のURLに案内する動きをリダイレクトと言う
	- リダイレクトによって２つめのリクエストが発生し、画面が表示される
- render,redirect_toを使う。どちらも記述しない場合は、アクションに対応する場所・名前のビューファイルをrenderする.
- redirect_toのオプションに直接渡すことのできるFlashのキーはデフォルトでは`:notice`,`alert`のみ
- Flashは主に「次のリクエスト」に対してデータを伝える仕組み。同じリクエスト内で（renderするビューに対して）伝えることもできる。その場合は`flash.now`を使う

```ruby
flash.now[:alert] = "提出期限を過ぎています"
```
```ruby
flash.now.alert = "提出期限を過ぎています"
```

### human_attribute_nameについて

### pathとurlの違いについて
- pathは相対path, urlは絶対パス
- HTTPの仕様上、redirectの際は絶対パスが必要になる

### パーシャルを使った新規登録画面と編集画面の共通化
- パーシャルテンプレートのファイル名の先頭にはアンダースコアをつける
- パーシャルテンプレートをrenderメソッドで呼び出す際には、アンダースコアをつけずに呼び出す

呼び出し方法は
```ruby
render partial: 'パーシャル名', locals: {task: @task}
```
- `locals: { task: @task }`と記述することにより、ローカル変数taskをパーシャルから利用できる。
- パーシャルから直接インスタンス変数を利用することもできるが、ローカル変数として渡す方が、インスタンス変数の定義に依存しない、再利用性の高いパーシャルにすることができる。

## 4.3モデルの検証
- DBのデータの制限と同時にモデルでも検証を行うことが必要
  - DB直接いじることもある
  - DB側のエラーの詳細をユーザーに伝えることは難しい

```ruby
task = Task.new
# エラーの詳細を表示
task.errors.full_messages

# 保存済みかどうかの確認
task.persisted?
```

### オリジナルの検証コードを書く
1. 検証を行うメソッドを追加して、そのメソッドを検証用のメソッドとして指定する
	- あるモデル専用の処理を手軽に書くとき
2. 自前のValidatorを作って利用する
	- 複数のモデルで共通利用したい汎用的な処理を書く場合

検証を追加するためのステップは次の２つ
1. 検証用のメソッドをモデルクラスに登録する
2. 検証用のメソッドを実装する

## モデルの状態を自動的に制御する「コールバック」
### コールバックとは
- 「然るべきタイミングが来たらこの処理を呼んでください」というように、あとで呼んで欲しい処理をあらかじめ指定しておく仕組み

# ログイン機能を作る
- 属性とカラムは別？？
  - 属性はモデルが持つもの。カラムはDBに存在するもの
  - password_digest, passwordについての記述より予想した

#### modelのvalidatesってどのタイミングで行われるの？
  - formを送ったとき？？

#### local: trueとは？
  - 何してるか不明
  - これがない場合は、JSの非同期通信でリクエストを投げることになるらしい
  [【Rails】form_with (local: true)について - Qiita](https://qiita.com/hayulu/items/5bf26656d7433d406ede)
  [form_withのlocal: trueって必要なん？これ何なん？（Ruby on Rails） - Qiita](https://qiita.com/kakudaisuke/items/e032c7705db00e8081dc?utm_campaign=popular_items&utm_medium=feed&utm_source=popular_items)

### session_paramsについて
`require`は引数にモデルを渡すはずだったけど、sessionモデルとか作ってない
	- おそらく、railsでデフォルトで使えるのではないか？

### ぼっち演算子とは？
[Ruby ぼっち演算子について - Qiita](https://qiita.com/yoshi_4/items/e987b698c1978d248cfc)

### ログアウト
セッションから`user_id`の情報だけをピンポイントで消すためには以下のようにすれば良い
```ruby
session.delete(:user_id)
```

セッション内のデータを全て削除するさいは以下のようにする
```ruby
reset_session
```

## application controllerのメソッドを特定の子コントローラーではスキップしたい
- `skip_before_action`を利用する

## migration ファイルの `index: true`とは？
p.169

## 404ページを表示するには？
p.174

## 4-6 データを絞り込む
1. 起点
2. 絞り込み条件
3. 実行部分

- rails consoleで絞り込み条件までを書いた状態の場合、　`to_sql`というメソッドを使って、生成予定のSQLを見ることができる