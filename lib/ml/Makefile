
all : lib.mli lib.ml test.ml
	ocamlc -c lib.mli
	ocamlc -c lib.ml
	ocamlc unix.cma lib.cmo test.ml -o test

clean :
	rm -f *.cmo *.cmi
	rm -f test
