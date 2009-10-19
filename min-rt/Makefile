LIB = ../lib
MIN_CAML = ../min-caml.opt
SIM = ../../CPU/sim.bat
MIN_CAML_OPTION = -inline 50
SIM_OPTION = -cpu Scalar.Count -asm min-rt.bin -in contest.sldb -out contest.ppm -gui

.PHONY: min-rt clean

min-rt:
	cat $(LIB)/lib_ml.ml min-rt.ml > tmp.ml
	$(MIN_CAML) $(MIN_CAML_OPTION) tmp
	cat $(LIB)/macro.s tmp.s $(LIB)/lib_asm.s globals.s > min-rt.s
	rm tmp.ml tmp.s
	$(SIM) $(SIM_OPTION) min-rt.s

clean:
	rm -f min-rt.s min-rt.bin contest.ppm
