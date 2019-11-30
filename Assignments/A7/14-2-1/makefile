lower: lowerCase.o toLower.o readLn.o writeStr.o
	gcc -o lower lowerCase.o toLower.o readLn.o writeStr.o

writeStr.o: writeStr.s
	gcc -c -g writeStr.s

readLn.o: readLn.s
	gcc -c -g readLn.s

lowerCase.o: lowerCase.s
	gcc -c -g lowerCase.s

toLower.o: toLower.s
	gcc -c -g toLower.s

clean:
	rm *.o
