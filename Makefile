# Sumii's Makefile for Min-Caml (for GNU Make)
# 
# ack.mlなどのテストプログラムをtest/に用意してmake do_testを実行すると、
# min-camlとocamlでコンパイル・実行した結果を自動で比較します。

RESULT = min-caml
NCSUFFIX = .opt
CC = gcc
CFLAGS = -g -O2 -Wall

default: top native-code
clean:: nobackup

# ↓もし実装を改造したら、それに合わせて変える
SOURCES = util.ml type.ml id.ml m.ml s.ml \
syntax.ml parser.mly lexer.mll builtIn.mli builtIn.ml typing.mli typing.ml kNormal.mli kNormal.ml \
alpha.mli alpha.ml beta.mli beta.ml assoc.mli assoc.ml inline.mli inline.ml\
constArray.mli constArray.ml constFold.mli constFold.ml movelet.mli movelet.ml cse.mli cse.ml constArg.mli constArg.ml\
closure.mli closure.ml asm.mli asm.ml virtual.mli virtual.ml preSchedule.mli preSchedule.ml\
simm.mli simm.ml slabel.mli slabel.ml sfl.mli sfl.ml sglobal.mli sglobal.ml beta2.mli beta2.ml absNegFlag.mli absNegFlag.ml\
regAlloc.mli regAlloc.ml scalar.mli scalar.ml moveAsm.mli moveAsm.ml emit.mli emit.ml\
main.mli main.ml

OCAMLFLAGS = -dtypes

include OCamlMakefile
