hexConvert: main.o hexToInt.o
	gcc -g -Wall -o hexConvert main.o hexToInt.o

main.o: main.c
	gcc -g -Wall -c -o main.o main.c

hexToInt.o: hexToInt.s
	gcc -c -g hexToInt.s

clean:
	rm *.o
