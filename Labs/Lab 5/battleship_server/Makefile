battleship_server: battleship.o init.o mapij.o displayBoard.o placeShip.o isGameOver.o reset_packet.o makeMove.o encode.o decode.o startClient.o startServer.o check_move.o check_sunk.o
	gcc -o battleship_server makeMove.o reset_packet.o isGameOver.o placeShip.o battleship.o init.o mapij.o displayBoard.o encode.o decode.o startClient.o startServer.o check_move.o check_sunk.o -lwiringPi -lm 

check_sunk.o: check_sunk.s
	gcc -g -c check_sunk.s

check_move.o: check_move.s
	gcc -g -c check_move.s

battleship.o: battleship.s
	gcc -g -c battleship.s

init.o: init.s
	gcc -g -c init.s

mapij.o: mapij.s
	gcc -g -c mapij.s

displayBoard.o: displayBoard.s
	gcc -g -c displayBoard.s

placeShip.o: placeShip.s
	gcc -g -c placeShip.s

isGameOver.o: isGameOver.s
	gcc -g -c isGameOver.s

reset_packet.o: reset_packet.s
	gcc -g -c reset_packet.s

makeMove.o: makeMove.s
	gcc -g -c makeMove.s

encode.o: encode.s
	gcc -g -c encode.s

decode.o: decode.s
	gcc -g -c decode.s

startClient.o: startClient.c
	gcc -g -c startClient.c

startServer.o: startServer.c
	gcc -g -c startServer.c

clean:
	rm *.o
