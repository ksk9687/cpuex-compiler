cat lib_ml.ml globals.ml min-rt.ml > tmp.ml
..\min-caml.opt tmp
cat macro.s tmp.s lib_asm.s > min-rt.s
rm tmp.ml tmp.s
