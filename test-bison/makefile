.PHONY: clean distclean

CC=gcc
CFLAGS=-Wall

compiler: lexer.o rpcalc.o
	$(CC) $(CFLAGS) -o $@ $^

lexer.c: lexer.l
	flex -s -o $@ $^

lexer.o: lexer.c lexer.h rpcalc.h

rpcalc.h rpcalc.c: rpcalc.y
	bison -dv -o rpcalc.c $^

rpcalc.o: rpcalc.c lexer.h

clean:
	$(RM) lexer.c rpcalc.output *.o lexer compiler

distclean: clean
	$(RM) compiler

