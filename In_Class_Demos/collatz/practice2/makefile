midterm: main.o
  .gcc -o midterm main.o reverse.o -lwiringPi

main.o: main.s
  gcc -c -g main.s

reverse.o: reverse.s
	gcc -c -g reverse.s

clean:
	rm *.o
