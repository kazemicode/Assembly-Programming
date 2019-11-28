checkPrimeNumber: main.o checkPrimeNumber.o
	gcc -o checkPrimeNumber main.o checkPrimeNumber.o

main.o: main.c
	gcc -g -Wall -c main.o main.c

checkPrimeNumber.o: checkPrimeNumber.s
	gcc -c -g checkPrimeNumber.s

clean:
	rm *.o
