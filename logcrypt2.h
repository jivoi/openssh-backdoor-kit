void Encrypt0r_(char * FILENAME, char * NEW_FILENAME)
{
    FILE *inFile;   //Declare inFile
    FILE *outFile;  //Declare outFile
    char Byte;
    char newByte;
//    int n;
//    int i=0;

    inFile = fopen(FILENAME, "rb");
    outFile = fopen(NEW_FILENAME, "w");

    if (inFile == NULL || outFile == NULL) {
        printf("Error in opening file to encrypt");
        return 1;
    } else {
        while (1) {
            while ( !feof( inFile ) ) {
                Byte = fgetc(inFile);
                newByte = Byte + 25;
                fputc(newByte, outFile);
            }
            break;
        }
        fclose(inFile);
        fclose(outFile);
    }
}
void Decrypt0r_ (char *FILENAME, char *NEW_FILENAME)
{
    FILE *inFile; //Declare inFile
    FILE *outFile; //Declare outFile

    char Byte;
    char newByte;
//    int i=0;

    inFile = fopen(FILENAME, "rb");
    outFile = fopen(NEW_FILENAME, "w");

    if (inFile == NULL || outFile == NULL) {
        printf("Error in opening file to decrypt");
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
