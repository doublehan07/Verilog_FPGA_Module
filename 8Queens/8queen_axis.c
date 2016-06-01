/*
	Backdate & Recurision
	Use axis to reduce time complexity
	By haldak
	2016.5.5
*/

#pragma warning (disable: 4996)

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int *Column, *MainDiag, *SubDiag;
int Queen(int, int);
int N;

int main(void)
{
	int i;

	printf("Eight Queen problems, entering the number of N:");
	scanf("%d", &N);

	Column = (int*)malloc(N * sizeof(int));
	MainDiag = (int*)malloc((2 * N - 1) * sizeof(int));
	SubDiag = (int*)malloc((2 * N - 1) * sizeof(int));
	
	for (i = 0; i < N; i++)
	{
		Column[i] = 0;
		MainDiag[i] = 0;
		SubDiag[i] = 0;
	}
	for (i = N; i < 2 * N - 1; i++)
	{
		MainDiag[i] = 0;
		SubDiag[i] = 0;
	}

	printf("%d\n", Queen(0, 0));

	free(Column);
	free(MainDiag);
	free(SubDiag);

	return 0;
}

//Recurision algorithm for putting queens
int Queen(int n, int iCount)
{
	int i;
	if (n == N)
	{
		iCount = iCount + 1;
		return iCount;
	}
	for (i = 0; i < N; i++)
	{
		//Try Set [n , i]
		//Test if the n-th queen is conflict with others before
		if (Column[i] == 0 && MainDiag[N - 1 - n + i] == 0 && SubDiag[n + i] == 0)
		{
			//Update Col, Diag
			Column[i] = 1;
			MainDiag[N - 1 - n + i] = 1;	//left lower is 0, right upper is 2N - 2
			SubDiag[n + i] = 1;				//left upper is 0, right lower is 2N - 2
			iCount = Queen(n + 1, iCount);

			//Backdate Col, Diag
			Column[i] = 0;
			MainDiag[N - 1 - n + i] = 0;
			SubDiag[n + i] = 0;
		}
	}
	return iCount;
}
