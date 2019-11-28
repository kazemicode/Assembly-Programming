checkPrimeNumber: main.o checkPrimeNumber.o
	gcc -g -Wall -o checkPrimeNumber main.o checkPrimeNumber.o

main.o: main.c
	gcc -g -Wall -c -o main.o main.c

checkPrimeNumber.o: checkPrimeNumber.s
	gcc -c -g checkPrimeNumber.s

clean:
	rm *.o
