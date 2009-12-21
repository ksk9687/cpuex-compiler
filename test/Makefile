LIB = ../lib
MIN_CAML = ../min-caml.opt
SIM = ../../sim/sim.jar
MIN_CAML_OPTION = -inline 0
CPU = Debug
RUN_SIM = java -jar -Xmx256M -Xss32M $(SIM) -cpu $(CPU)

.PHONY: cui gui

test.s: test.ml
	cat $(LIB)/lib_ml.ml test.ml > tmp.ml
	$(MIN_CAML) $(MIN_CAML_OPTION) tmp
	cat $(LIB)/macro.s $(LIB)/lib_asm.s $(LIB)/debug.s tmp.s > test.s
	rm tmp.ml tmp.s

cui: test.s
	$(RUN_SIM) -in test.in -out test.out -cui test.s

gui: test.s
	$(RUN_SIM) -in test.in -out test.out -gui test.s

test.bin: test.s
	$(RUN_SIM) -asm test.bin test.s
