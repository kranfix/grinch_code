CC=g++ --std=c++14

01: 01_destructor.cpp
	${CC} 01_destructor.cpp -o 01

run01: 01
	./01

02: 02_smart_pointers.cpp
	${CC} 02_smart_pointers.cpp -o 02

run02: 02
	./02

.PHONY: clear

clear:
	rm -rdf 01 02
	