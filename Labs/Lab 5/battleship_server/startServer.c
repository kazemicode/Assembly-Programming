#include <stdio.h>
#include <netdb.h>
#include <netinet/in.h>
#include <string.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>

#define PORT 1028

int startSever();

int startServer()
{

int sockfd, connfd;
struct sockaddr_in serveraddr, cliaddr;
char buf[2];

sockfd = socket(AF_INET, SOCK_STREAM, 0);

bzero(&serveraddr, sizeof(serveraddr));

serveraddr.sin_family= AF_INET;
serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);
serveraddr.sin_port = htons(PORT);

bind(sockfd, (struct sockaddr *) &serveraddr, sizeof(serveraddr));

listen(sockfd, 5);

int len = sizeof(cliaddr);

connfd = accept(sockfd, (struct sockaddr *) &cliaddr, &len);

//read(connfd, buf, sizeof(buf));

//printf("The first byte is: %x\n", buf[0]);

//printf("The second byte is: %x\n", buf[1]);

//printf("Sever receive: %s\n", buf);

//strcpy(buf, "hello world");

//write(connfd, buf, sizeof(buf));

return connfd;

//close(sockfd);
}
