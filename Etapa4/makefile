flexmake: parser.y scanner.l
	bison -v -d parser.y
	flex -o lex.yy.c scanner.l
	gcc -o etapa4 ast.c parser.tab.c main.c tabela.c errors.c lex.yy.c -ll

clean:
	rm -f *.tab.c *.tab.h *.tabela.o *.errors.o *.yy.c *.o *.output etapa4

submit:
	tar cvzf etapa4.tgz .