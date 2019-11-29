#include <stdio.h>
#include <netdb.h>
#include <netinet/in.h>
#include <string.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>

#define PORT 1028

int startClient();

int startClient()
{

int sockfd, connfd;
struct sockaddr_in serveraddr, cliaddr;
char buf[80];

sockfd = socket(AF_INET, SOCK_STREAM, 0);

bzero(&serveraddr, sizeof(serveraddr));

serveraddr.sin_family= AF_INET;
serveraddr.sin_addr.s_addr = inet_addr("10.106.150.27");
serveraddr.sin_port = htons(PORT);

connect(sockfd, (struct sockaddr *) &serveraddr, sizeof(serveraddr));

//strcpy(buf, "eat my dust");

//write(sockfd, buf, sizeof(buf));

//read(sockfd, buf, sizeof(buf));

//printf("From sever: %s\n", buf);

//close(sockfd);

return sockfd;

}