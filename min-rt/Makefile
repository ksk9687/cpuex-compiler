LIB = ../lib
MIN_CAML = ../min-caml.opt
SIM = ../../sim/sim.jar
FAST_SIM = ../../sim/fastsim/fastsim.exe
MIN_CAML_OPTION = -inline 150 -inline_cont 20
CPU = MasterScalar
RUN_SIM = java -jar -Xmx256M -Xss32M $(SIM) -cpu $(CPU)

.PHONY: run fast stat fpu cui inline0 clean

run: min-rt.s
	$(RUN_SIM).NoStat -asm min-rt.bin < contest.sldb > contest.ppm -gui min-rt.s
	diff contest.ppm old/contest.ppm

fast: $(FAST_SIM) min-rt.bin
	$(FAST_SIM) min-rt.bin < contest.sldb > contest.ppm
	diff contest.ppm old/contest.ppm

stat: min-rt.s
	$(RUN_SIM) -asm min-rt.bin < contest.sldb > contest.ppm -gui min-rt.s
	diff contest.ppm old/contest.ppm

fpu: min-rt.s
	$(RUN_SIM).FPU -asm min-rt.bin < contest.sldb > contest_fpu.ppm -gui min-rt.s
	diff contest_fpu.ppm old/contest_fpu.ppm

cui: min-rt.s
	$(RUN_SIM).NoStat -asm min-rt.bin < contest.sldb > contest.ppm -cui min-rt.s
	diff contest.ppm old/contest.ppm

min-rt.bin: $(SIM) min-rt.s
	$(RUN_SIM) -asm min-rt.bin min-rt.s

min-rt.s: $(MIN_CAML) min-rt.ml globals.s $(LIB)/lib_ml.ml $(LIB)/macro.s $(LIB)/lib_asm.s Makefile
	cat $(LIB)/lib_ml.ml min-rt.ml > tmp.ml
	$(MIN_CAML) $(MIN_CAML_OPTION) tmp
	cat $(LIB)/macro.s $(LIB)/lib_asm.s globals.s tmp.s > min-rt.s
	rm tmp.ml tmp.s

inline0:
	cat $(LIB)/lib_ml.ml min-rt.ml > tmp.ml
	$(MIN_CAML) tmp
	cat $(LIB)/macro.s $(LIB)/lib_asm.s globals.s tmp.s > min-rt.s
	rm tmp.ml tmp.s

inst.coe: boot.s
	$(RUN_SIM) -noOffset -vhdl inst.coe boot.s

clean:
	rm -f min-rt.s min-rt.bin contest.ppm contest_fpu.ppm tmp.ml tmp.s
