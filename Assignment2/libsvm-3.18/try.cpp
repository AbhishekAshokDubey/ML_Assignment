#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


#include "mex.h"


void main()
{
int i =5;
int j =6;
mexPrintf("the value for y is %d",i+j);
}




void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[] )
{
main();
return;
}