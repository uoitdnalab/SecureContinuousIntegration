#include <stdio.h>

int main(int argc, char **argv)
{
	int x;
	int y;
	printf("Value of first argument was %s\n",argv[1]);
	x = atoi(argv[1]);
	
	int *my_buffer = malloc(64 * sizeof(int));
	
	if (x > 400)
	{
		int i;
		for (i = 0; i < 64; i++)
		{
			my_buffer[i] = x + i;
		}
		
		for (i = 0; i < 16; i++)
		{
			my_buffer[i] =  my_buffer[i] + my_buffer[63 - i] * 3;
		}
		
		//Output
		for (i = 0; i < 64; i++)
		{
			printf("-%d-",my_buffer[i]);
		}
		printf("\n");
		
		free(my_buffer);
	}
	
	//Should have been `else if`
	if (x > 200)
	{
		int i;
		for (i = 0; i < 64; i++)
		{
			my_buffer[i] = x - i;
		}
		
		for (i = 0; i < 16; i++)
		{
			my_buffer[i] =  3*my_buffer[i] + my_buffer[63 - i];
		}
		
		//Output
		for (i = 0; i < 64; i++)
		{
			printf("-%d-",my_buffer[i]);
		}
		printf("\n");
		
		free(my_buffer);
	}
	
	return 0;
}
