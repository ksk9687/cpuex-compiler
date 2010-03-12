* 外部関数の呼び出し規約
$i1, $f1: 返り値
$i2~, $f2~: 引数
$ra: リンクレジスタ
全てのレジスタを退避無しで使用可能

* 外部変数のデータ構造
配列aのi番目の要素はaのアドレス+iの位置に置く
タプル型の場合は、コンパイラが出力したデータ配置に従う
この際、外部変数の配列長はコンパイラが勝手に妄想するので、実際と異なる場合には-noExpandオプションを指定する

* コンパイルオプション
-inline 関数のインライン展開の上限サイズ指定(=0)
-inline_cont If文の継続のインライン展開の上限サイズ指定(=0)
-iter 最適化の反復回数指定(=100)
-noHoge 各種最適化をオフにする
	(Movelet, ConstArg, ConstFold, Cse, ConstArray, Inline, Assoc, BetaTuple, Beta,
	 ChangeArgs, Simm, Slabel, Sfl, Sglobal, Beta2, AbsNegFlag, PreSchedule, MoveAsm)
-lib ライブラリ作成用
	-noChangeArgs -noSfl -noSlabel
	使われていない関数の削除を行わない
	関数名にext_をつける
	ラベルが被らないようにする
