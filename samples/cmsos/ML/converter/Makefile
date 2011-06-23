
OBJECTS = ml.tab.o lex.yy.o

ml: $(OBJECTS) ml.tab.h
	gcc -o ml $(OBJECTS)

lex.yy.c: ml.l ml.tab.h
	flex ml.l

ml.tab.c ml.tab.h: ml.y
	~/bison-2.0/src/bison -d ml.y

clean:
	-rm -f ml.tab.{c,h} lex.yy.c *.o

cleantmp:
	-if [ -e tests/*~ ]; then rm -v tests/*~; fi

