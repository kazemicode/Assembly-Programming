fibonacci: main.o fibonacci.o
	gcc -o fibonacci main.o fibonacci.o

main.o: main.s
	gcc -c -g main.s

fibonacci.o: fibonacci.s
	gcc -c -g fibonacci.s

clean:
	rm *.o
