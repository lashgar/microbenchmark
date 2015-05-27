
CUDAHOME = /usr/local/cuda/

openacc:
	mkdir obj/ -p
	mkdir log/ -p
	gcc src/openacc.c -fPIC -g -I$(CUDAHOME)/include/ -D__NVCUDA__ -c -o obj/openacc.o -I ./include/

clean:
	rm obj/ log/ nmergerLastRunLog -rf
