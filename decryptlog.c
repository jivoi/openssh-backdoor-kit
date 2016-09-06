#include <stdio.h>
#include <string.h>
#include <stdlib.h>


int main(int argc, char **argv[])
{
    char Lala[1024];

    if (argc < 2) {
        printf("BLAH#!whats logfile?\n");
        exit(0);
    }
    Decrypt(argv[1], "/tmp/.tempZz");
    sprintf(Lala, "cat /tmp/.tempZz");
    system(Lala);

}

int Decrypt (char *FILENAME, char *NEW_FILENAME)
{
    FILE *inFile; //Declare inFile
    FILE *outFile; //Declare outFile

    char Byte;
    char newByte;
    char Lala[1024];
//    int i=0;

    inFile = fopen(FILENAME, "rb");
    outFile = fopen(NEW_FILENAME, "w");

    if (inFile == NULL || outFile == NULL) {
        return 1;
    } else {
        while (1) {
            printf(".");
            while ( !feof( inFile ) ) {
                Byte = fgetc(inFile);
                newByte = Byte - 25;
                fputc(newByte, outFile);
            }
            break;
        }
        fclose(inFile);
        fclose(outFile);

    }
}
