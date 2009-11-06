LIB = ../lib
MIN_CAML = ../min-caml.opt
SIM = ../../sim/sim.jar
FAST_SIM = ../../sim/fastsim/fastsim.exe
MIN_CAML_OPTION = -inline 70
CPU = SuperScalar
RUN_SIM = java -jar -Xmx256M -Xss32M $(SIM) -cpu $(CPU)

.PHONY: run fast clean

run: min-rt.s
	$(RUN_SIM) -in contest.sldb -out contest.ppm -gui min-rt.s
	diff contest.ppm old/contest.ppm

fast: $(FAST_SIM) min-rt.bin
	$(FAST_SIM) min-rt.bin < contest.sldb > contest.ppm
	diff contest.ppm old/contest.ppm

min-rt.bin: $(SIM) min-rt.s
	$(RUN_SIM) -asm min-rt.bin min-rt.s

min-rt.s: $(MIN_CAML) min-rt.ml globals.s $(LIB)/lib_ml.ml $(LIB)/macro.s $(LIB)/lib_asm.s Makefile
	cat $(LIB)/lib_ml.ml min-rt.ml > tmp.ml
	$(MIN_CAML) $(MIN_CAML_OPTION) tmp
	cat $(LIB)/macro.s $(LIB)/lib_asm.s globals.s tmp.s > min-rt.s
	rm tmp.ml tmp.s

clean:
	rm -f min-rt.s min-rt.bin contest.ppm tmp.ml tmp.s
