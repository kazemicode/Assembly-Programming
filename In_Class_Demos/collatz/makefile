collatz: main.o collatz.o
	gcc -o collatz main.o collatz.o

main.o: main.s
	gcc -c main.s

collatz.o: collatz.s
	gcc -c collatz.s

clean:
	rm *.o
	
