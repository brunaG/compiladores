flexmake: parser.y scanner.l
	bison -v -d parser.y
	flex -o lex.yy.c scanner.l
	gcc -o etapa2 parser.tab.c main.c lex.yy.c -ll

clean:
	rm -f *.tab.c *.tab.h *.yy.c *.o *.output etapa2