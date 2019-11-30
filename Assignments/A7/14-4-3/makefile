hexConvert: main.o hexToInt.o writeStr.o readLn.o
	gcc -g -Wall -o hexConvert main.o hexToInt.o writeStr.o readLn.o

writeStr.o: writeStr.s
	gcc -c -g writeStr.s

readLn.o: readLn.s
	gcc -c -g readLn.s

hexToInt.o: hexToInt.s
	gcc -c -g hexToInt.s

main.o: main.c
	gcc -g -Wall -c -o main.o main.c

clean:
	rm *.o
