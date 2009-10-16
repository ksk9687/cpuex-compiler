*配布ファイルからの変更点
**min-rt.ml
trueとfalseの定義を削除
出力をバイナリ形式に変更

**globals.ml
文末にinを追加

*コンパイル方法
cat lib_ml.ml globals.ml min-rt.ml > tmp.ml
min-caml.opt tmp
cat macro.s tmp.s lib_asm.s > min-rt.s
sim -asm min-rt.s > min-rt.bin

min-camlとsimのパスに合わせててきとーに実行
