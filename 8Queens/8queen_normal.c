#pragma warning (disable: 4996)

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//int *Site;
int Site[8];
int Queen(int n, int QUEENS, int);
int Valid(int n);

void main()
{
	int m;
	int QUEENS;
	printf("Eight Queen problems, entering the number of queens:");
	scanf("%d", &QUEENS);
//	Site = (int*)malloc(QUEENS * sizeof(int));
	m = Queen(0, QUEENS, 0);
	printf("%d\n", m);
//	free(Site);
	return;
}

/*-----------------Queen：递归放置第n 个皇后---------------*/
int Queen(int n, int QUEENS, int iCount)
{
	int i;
	if (n == QUEENS)
	{
		iCount = iCount + 1;
		return iCount;
	}
	for (i = 1; i <= QUEENS; i++)
	{
		Site[n] = i;
		/*---------------Valid：判断放置第n 个皇后时是否无冲突---------------*/
		if (Valid(n))
			iCount = Queen(n + 1, QUEENS, iCount);
	}
	return iCount;
}

/*------Valid：判断第n 个皇后放上去之后，是否合法，即是否无冲突。------*/
int Valid(int n)
{
	int i;
	for (i = 0; i < n; i++)
	{
		if (Site[i] == Site[n]) //同一竖线
			return 0;
		if (abs(Site[i] - Site[n]) == (n - i)) //同一斜线
			return 0;
	}
	return 1;
}
