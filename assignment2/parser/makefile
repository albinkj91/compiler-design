.PHONY: clean distclean

CC=gcc
CFLAGS=-Wall

compiler: lexer.o parser.o
	$(CC) $(CFLAGS) -o $@ $^

lexer.c: lexer.l
	flex -s -o $@ $^

lexer.o: lexer.c lexer.h parser.h

parser.h parser.c: parser.y
	bison -dv -o parser.c $^

parser.o: parser.c lexer.h

clean:
	$(RM) lexer.c parser.output *.o lexer compiler

distclean: clean
	$(RM) compiler

