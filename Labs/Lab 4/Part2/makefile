checkPrimeNumber: main.o checkPrimeNumber.o
	gcc -g -Wall -o checkPrimeNumber main.o checkPrimeNumber.o

main.o: main.s
	gcc -c -g main.s

checkPrimeNumber.o: checkPrimeNumber.c
	gcc -g -Wall -c -o checkPrimeNumber.o checkPrimeNumber.c

clean:
	rm *.o
