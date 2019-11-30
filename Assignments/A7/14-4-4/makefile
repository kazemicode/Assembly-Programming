addHex: addHex.o newLine.o readLn.o writeStr.o
	gcc -o addHex addHex.o newLine.o readLn.o writeStr.o

newLine.o: newLine.s
	gcc -c -g newLine.s

readLn.o: readLn.s
	gcc -c -g readLn.s

writeStr.o: writeStr.s
	gcc -c -g writeStr.s

addHex.o: addHex.s
	gcc -c -g addHex.s

clean:
	rm *.o
