factorial: main.o factorial.o
	gcc -o factorial main.o factorial.o

main.o: main.s
	gcc -c -g main.s

factorial.o: factorial.s
	gcc -c -g factorial.s

clean:
	rm *.o
