fibonacci: main.o checkPrimeNumber.o
	gcc -o fibonacci main.o checkPrimeNumber.o

main.o: main.s
	gcc -c -g main.s

checkPrimeNumber.o: checkPrimeNumber.s
	gcc -c -g checkPrimeNumber.s

clean:
	rm *.o
