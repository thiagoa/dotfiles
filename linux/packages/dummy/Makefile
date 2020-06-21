dummy: dummy.c
	gcc dummy.c `pkg-config --cflags --libs gtk+-3.0` -o dummy

.PHONY: install
install: dummy
	cp ./dummy $(HOME)/bin
	rm -f ./dummy
