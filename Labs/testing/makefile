final: main.o bar.o
	gcc -o final main.o bar.o

main.o: main.s
	gcc -c -g main.s

reverse.o: bar.s
	gcc -c -g bar.s

clean:
	rm *.o
