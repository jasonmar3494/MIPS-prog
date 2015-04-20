/*  Jason Mar

This program finds George in a crowd. */

#include <stdio.h>
#include <stdlib.h>


			
int main(int argc, char *argv[]) {
	int	          CrowdInts[1024];
	int	          NumInts, HatLoc, ShirtLoc;
	int               Load_Mem(char *, int *);

	if (argc != 2) {
		printf("usage: ./P1-1 valuefile\n");
		exit(1);
	}
	NumInts = Load_Mem(argv[1], CrowdInts);
	if (NumInts != 1024) {
		printf("valuefiles must contain 1024 entries\n");
		exit(1);
	}
	
	unsigned char Cols[4096];
	int j = 0;
	while(j<4096){
		for(int i=0;i<1024;i++){
			unsigned int fourcols = CrowdInts[i];	
			unsigned char a = fourcols & 0x000000FF;
			unsigned int x = fourcols & 0x0000FF00;
			unsigned char b = x >> 8;
			x = fourcols & 0x00FF0000;
			unsigned char c = x >> 16;
			x = fourcols & 0xFF000000;
			unsigned char d = x >> 24;
			Cols[j] = a;	j++;
			Cols[j] = b;	j++;
			Cols[j] = c;	j++;
			Cols[j] = d;	j++;
		}
	}
	for(int k=0;k<4096;k++){
		int colval = Cols[k];
		if(colval==7){ //green eye
			if(Cols[k+4]==7){ //second green eye
				if(Cols[k+1]==5){ //yellow next to eye
					if(Cols[k+64]==5){ //yellow beneath eye
						if(Cols[k+128]==8){ //black smile
							if(Cols[k-64]==2){ //red hat
								if(Cols[k+448]==3){ //blue collar 
									if(Cols[k-127]==1){ //W hat
										HatLoc = k-254;
										ShirtLoc = k+450;
									}
								}  
							}
						}
					}	
					else if(Cols[k+64]==2){ //check upside down by red hat
						if(Cols[k-128]==8){ //black smile up
							if(Cols[k-64]==5){ //yellow above eye
								if(Cols[k-448]==3){ //blue collar
									if(Cols[k+129]==1){ //W hat
										HatLoc = k+258;
										ShirtLoc = k-446;
									}
								}
							}
						}
					}			
				}
			}
			else if(Cols[k+256]==7){ //vertical eye 
				if(Cols[k+1]==2){ //red hat rotate 90
					if(Cols[k+64]==5){ //yellow right of eye
						if(Cols[k-1]==5){ //yellow below eye
							if(Cols[k-2]==8){ //black smile
								if(Cols[k-7]==3){ //blue collar
									if(Cols[k+66]==1){ //W hat
										HatLoc = k+132;
										ShirtLoc = k+121;
									}
								}
							}
						}
					}
				}
				else if(Cols[k-1]==2){ //red hat rotate 270
					if(Cols[k+64]==5){ //yellow left of eye
						if(Cols[k+1]==5){ //yellow below eye
							if(Cols[k+2]==8){ //black smile
								if(Cols[k+7]==3){ //blue collar
									if(Cols[k+62]==1){ //W hat
										HatLoc = k+124;
										ShirtLoc = k+135;
									}
								}
							}
						}
					}
				}
			}			
		}
	}		

	printf("George is located at: hat pixel %4d, shirt pixel %4d.\n", HatLoc, ShirtLoc);
	exit(0);
}




/* This routine loads in up to 1024 newline delimited integers from
a named file in the local directory. The values are placed in the
passed integer array. The number of input integers is returned. */

int Load_Mem(char *InputFileName, int IntArray[]) {
   int	N, Addr, Value, NumVals;
   FILE	*FP;

   FP = fopen(InputFileName, "r");
   if (FP == NULL) {
      printf("%s could not be opened; check the filename\n", InputFileName);
      return 0;
   } else {
      for (N=0; N < 1024; N++) {
         NumVals = fscanf(FP, "%d: %d", &Addr, &Value);
         if (NumVals == 2)
            IntArray[N] = Value;
         else
            break;
      }
      fclose(FP);
      return N;
   }
}
