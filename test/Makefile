LIB = ../lib
MIN_CAML = ../min-caml.opt
SIM = ../../sim/sim.jar
FAST_SIM = ../../sim/fastsim/fastsim.exe
MIN_CAML_OPTION = -noInline
CPU = MasterScalar.FPU
RUN_SIM = java -jar -Xmx256M -Xss32M $(SIM) -cpu $(CPU)

.PHONY: clean
.SUFFIXES: .ml .s .bin .run .fast

.ml.s:
	cat $(LIB)/lib_ml.ml $< > tmp.ml
	$(MIN_CAML) $(MIN_CAML_OPTION) tmp
	touch $*_asm.s
	cat $(LIB)/macro.s $(LIB)/lib_asm.s $(LIB)/math.s $(LIB)/debug.s $*_asm.s tmp.s > $@
	rm tmp.ml tmp.s

.s.bin:
	$(RUN_SIM) -asm $@ $<

.s.run:
	touch $*.in
	$(RUN_SIM) -asm $*.bin < $*.in > $*.out -gui $<

.bin.fast:
	touch $*.in
	$(FAST_SIM) < $*.in > $*.out $<

clean:
	rm -f *.bin *.out tmp.s tmp.ml
