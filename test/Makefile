LIB = ../lib
MIN_CAML = ../min-caml.opt
SIM = ../../sim/sim.jar
MIN_CAML_OPTION = -inline 0 -inline_cont 0
CPU = MasterScalar
RUN_SIM = java -jar -Xmx256M -Xss32M $(SIM) -cpu $(CPU)

.PHONY: clean
.SUFFIXES: .ml .s .bin

.ml.s:
	cat $(LIB)/lib_ml.ml $< > tmp.ml
	$(MIN_CAML) $(MIN_CAML_OPTION) tmp
	touch $*_asm.s
	cat $(LIB)/macro.s $(LIB)/lib_asm.s $*_asm.s tmp.s > $@
	rm tmp.ml tmp.s

.s.bin:
	touch $*.in
	$(RUN_SIM) -asm $@ < $*.in > $*.out -gui $<

clean:
	rm -f *.bin *.out tmp.s tmp.ml
