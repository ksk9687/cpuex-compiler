# Sumii's Makefile for Min-Caml (for GNU Make)

RESULT = min-caml
NCSUFFIX = .opt
CC = gcc
CFLAGS = -g -O2 -Wall

default: top native-code
clean:: nobackup

# ↓もし実装を改造したら、それに合わせて変える
SOURCES = util.ml type.ml id.ml m.ml s.ml \
syntax.ml parser.mly lexer.mll builtIn.mli builtIn.ml typing.mli typing.ml kNormal.mli kNormal.ml expand.mli expand.ml \
alpha.mli alpha.ml beta.mli beta.ml assoc.mli assoc.ml inline.mli inline.ml betaTuple.mli betaTuple.ml \
constArray.mli constArray.ml constFold.mli constFold.ml movelet.mli movelet.ml cse.mli cse.ml constArg.mli constArg.ml loadArgs.mli loadArgs.ml \
closure.mli closure.ml asm.mli asm.ml virtual.mli virtual.ml constFold2.mli constFold2.ml sfl.mli sfl.ml sglobal.mli sglobal.ml\
beta2.mli beta2.ml absNegFlag.mli absNegFlag.ml preSchedule.mli preSchedule.ml\
regAlloc.mli regAlloc.ml block.mli block.ml moveAsm.mli moveAsm.ml emit.mli emit.ml\
main.mli main.ml

OCAMLFLAGS = -dtypes

include OCamlMakefile
