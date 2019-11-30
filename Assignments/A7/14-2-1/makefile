lower: lowerCase.o toLower.o
	gcc -o fibonacci lowerCase.o toLower.o

lowerCase.o: lowerCase.s
	gcc -c -g lowerCase.s

toLower.o: toLower.s
	gcc -c -g toLower.s

clean:
	rm *.o
