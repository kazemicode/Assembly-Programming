reverseArray: reverseArray.o getDecInt.o newLine.o putDecInt.o writeStr.o uDecToInt.o uIntToDec.o
	gcc -g -o reverseArray reverseArray.o getDecInt.o newLine.o putDecInt.o writeStr.o uDecToInt.o uIntToDec.o

uDecToInt.o: uDecToInt.s
	gcc -c -g uDecToInt.s

uIntToDec.o: uIntToDec.s
	gcc -c -g uIntToDec.s

getDecInt.o: getDecInt.s
	gcc -c -g getDecInt.s

putDecInt.o: putDecInt.s
	gcc -c -g putDecInt.s

newLine.o: newLine.s
	gcc -c -g newLine.s

writeStr.o: writeStr.s
	gcc -c -g writeStr.s

reverseArray.o: reverseArray.s
	gcc -c -g reverseArray.s

clean:
	rm *.o
