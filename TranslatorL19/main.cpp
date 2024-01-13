#pragma once
#include "StructData.h"
#include "LexicalAnalizer.h"
#include "ErrorsCheck.h"
#include "Generator.h"
#include <process.h>
#include <io.h>
#include <iostream>

bool directory_exists(const std::string& directory)
{
	if (!directory.empty())
	{
		if (_access(directory.c_str(), 0) == 0)
		{
			struct stat status;
			stat(directory.c_str(), &status);
			if (status.st_mode & S_IFDIR)
				return true;
		}
	}
	// if any condition fails
	return false;
}

int main(int argc, std::string* argv)
{
	printf("_________________________________________________________________________________________________\n\n");
	printf("                                  TRANSLATOR (l19 -> ASSEMBLER)\n");
	printf("_________________________________________________________________________________________________\n");
	//printf("                                                ");
	// Checking the number of arguments to be passed from the command line
	if (argc != 2)
	{
		printf("\nInput file name:  ");
		std::cin >> Data.InputFileName;
	}
	else
	{
		// Obtaining and formation names of incoming and outgoing files
		Data.InputFileName = argv->c_str();
	}

	if ((InF = fopen(Data.InputFileName.c_str(), "r")) == 0)
	{
		printf("Error: Can not open file: %s\n", Data.InputFileName.c_str());
		system("pause");
		exit(1);
	}

	printf("Start translating file: %s\n", Data.InputFileName.c_str());

	int k = Data.InputFileName.size();
	while (k > 0)
	{
		if (Data.InputFileName[k] == '\\')
		{
			k++;
			break;
		}
		k--;
	}
	Data.InputFileName.copy(Data.OutputFileName, Data.InputFileName.size() - k - 4, k);
	printf("Output file: %s\n", std::string(std::string(Data.OutputFileName) + ".asm").c_str());
	printf("_________________________________________________________________________________________________\n\n");
	char TokenFile[1000];
	char ErrorFile[1000];
	int i = 0;

	while (Data.InputFileName[i] != '.')
	{
		TokenFile[i] = Data.InputFileName[i];
		ErrorFile[i] = Data.InputFileName[i];
		i++;
	}
	TokenFile[i] = '\0';
	ErrorFile[i] = '\0';
	strcat_s(TokenFile, "LexemTable.txt");
	strcat_s(ErrorFile, "_errors.txt");
	// Breaking into tokens and printing into file
	printf("Breaking into lexems are starting...\n");
	Data.LexNum = GetTokens(InF);

	PrintTokensToFile(TokenFile, Data.LexNum);
	printf("Breaking into lexems completed. There are %d lexems.\nReport file: %s\n", Data.LexNum, TokenFile);
	printf("_________________________________________________________________________________________________\n\n");
	i = 0;
	while (Data.InputFileName[i] != '.')
	{
		TokenFile[i] = Data.InputFileName[i];
		i++;
	}
	TokenFile[i] = '\0';
	printf("Error checking are starting...\n");
	printf("Report file: %s", ErrorFile);
	Data.numberErrors = handleError(TokenFile);

	printf("\nError checking is complete. There is(are) %d errors.\n", Data.numberErrors);
	printf("_________________________________________________________________________________________________\n\n");

	if (Data.numberErrors != 0)
	{
		printf("Translation can not be continued. Errors were found. Please correct the errors and try again.\n");
	}
	else
	{
		if ((OutF = fopen(std::string(std::string(Data.OutputFileName) + ".asm").c_str(), "w")) == 0)
		{
			printf("Error: Can not create file: %s\n", std::string(std::string(Data.OutputFileName) + ".asm").c_str());
			system("pause");
			exit(1);
		}
		printf("Code generation is starting...\n");
		generateFullCode(OutF);
		printf("Code generation is finish.\n");
		fclose(OutF);
		printf("_________________________________________________________________________________________________\n\n");
		if (directory_exists("masm64"))
		{
			system(std::string("masm64\\bin64\\ml64.exe /c " + std::string(Data.OutputFileName) + ".asm").c_str());
			system(std::string("masm64\\bin64\\link.exe /SUBSYSTEM:CONSOLE /ENTRY:mainCRTStartup /nologo /LARGEADDRESSAWARE " + std::string(Data.OutputFileName) + ".obj masm64\\lib64\\kernel32.lib").c_str());
		}
		else
		{
			printf("WARNING!\n");
			printf("Can't compile asm file, because masm64 doesn't exist.\n");
		}

		printf("_________________________________________________________________________________________________\n\n");
		printf("Done! Done! Done!\n");
	}
	system("pause");
	return 0;
}