hexConvert: main.o hexToInt.o

main.o: main.s
	gcc -c -g main.s

hexToInt.o: hexToInt.s
	gcc -c -g hexToInt.s

clean:
	rm *.o
