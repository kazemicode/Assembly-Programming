hexConvert: main.o hexToInt.o
	gcc -g -Wall -o hexConvert main.o hexToInt.o writeStr.o readLn.o

main.o: main.c
	gcc -g -Wall -c -o main.o main.c

hexToInt.o: hexToInt.s
	gcc -c -g hexToInt.s

writeStr.o: writeStr.s
	gcc -c -g writeStr.s

readLn.o: readLn.s
	gcc -c -g readLn.s

clean:
	rm *.o
