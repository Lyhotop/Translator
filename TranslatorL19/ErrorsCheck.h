#pragma once

#include "LexicalAnalizer.h"
#include <iostream>
#include <stack>
#include <vector>
#include <stdlib.h>
#include "StructData.h"
std::stack<int> iFElsePresent{};
static char isElseExist{};
static bool isIFExist{ false };
static char isStringConstantExist{};
static int lastRBracketPos{ 0 };

enum class Error : int8_t
{
	ETooMuchBegin,
	ETooMuchEnd,
	EEndExpected,
	EBeginExpected,
	NOError
};

inline Error beginEndCheck(std::vector<int>& mas, TypeOfLex ends, TypeOfLex ltStart, TypeOfLex ltFinish)
{
	std::stack<int> stack{};
	int j = 0;
	int cnt_begin{};
	int cnt_end{};
	int i = mas[0];
	mas.clear();
	std::vector<int> begin{};
	std::vector<int> end{};
	for (; Data.LexTable[i].type != ends; i++)
	{
		if (Data.LexTable[i].type == ltStart)
		{
			begin.push_back(i);
			if (!end.empty())
				end.pop_back();
			stack.push(i);
			cnt_begin++;
		}
		if (Data.LexTable[i].type == ltFinish)
		{
			end.push_back(i);
			if (!begin.empty() && Data.LexTable[i + 1].type != LEOF)
				begin.pop_back();
			if (!stack.empty())
				stack.pop();
			cnt_end++;
		}
	}
	if (cnt_begin > cnt_end)
	{
		if (!begin.empty())
		{
			begin.erase(begin.begin(), begin.begin() + 1);
			mas = begin;
		}
		if (!mas.empty()) {
			if (stack.size() > 1)
			{
				return Error::ETooMuchBegin;
			}
			return Error::EEndExpected;
		}
	}
	if (cnt_end > cnt_begin)
	{
		if (!end.empty())
		{
			end.pop_back();
			mas = end;
		}
		if (stack.size() > 1)
		{
			return Error::ETooMuchEnd;
		}
		return Error::EBeginExpected;
	}
	return Error::NOError;
}

inline bool checkIsOperation(TypeOfLex checkToken)
{
	bool r = ((checkToken == Add) || (checkToken == Sub) || (checkToken == Mul) ||
		(checkToken == Div) || (checkToken ==
			Mod) || (checkToken == Not) ||
		(checkToken == And) || (checkToken == Or) || (checkToken == Equ) ||
		(checkToken == NotEqu) || (
			checkToken == Lt) || (checkToken == Gt));
	return r;
}

inline int checkExpression(const int lexemIndex, FILE* ef)
{
	int error = 0;
	int nom = lexemIndex;
	if ((Data.LexTable[nom].type != LBraket)
		&& (Data.LexTable[nom].type != Identifier)
		&& (Data.LexTable[nom].type != Number)
		&& (Data.LexTable[nom].type != Str)
		&& (Data.LexTable[nom].type != Not))
	{
		fprintf(ef, "line %d: \tExpression must begin from identifier, number or '('!\n", Data.LexTable[nom].line);
		error++;
	}
	for (; (Data.LexTable[nom].type != Separator) && ((Data.LexTable[nom + 1].type != StartBlock) && (Data.LexTable[nom].type != LEOF)); nom++)
	{
		if (Data.LexTable[nom].type == Str)
		{
			if (isStringConstantExist == 1)
			{
				fprintf(ef, "line %d: \tAssignment of a character constant to an integer data type is not supported\n", Data.LexTable[nom].line);
				isStringConstantExist = 2;
				error++;
			}
		}
		if (Data.LexTable[nom].type == RBraket)
		{
			lastRBracketPos = nom;
			if (!(checkIsOperation(Data.LexTable[nom + 1].type))
				&& (Data.LexTable[nom + 1].type != Separator)
				&& (Data.LexTable[nom + 1].type != RBraket)
				&& isIFExist != true)
			{
				fprintf(ef, "line %d: \tAfter ')' must be ')', operation or ';'!\n", Data.LexTable[nom].line);
				error++;
			}
		}
		if (Data.LexTable[nom].type == LBraket)
		{
			if ((Data.LexTable[nom + 1].type != Identifier)
				&& (Data.LexTable[nom + 1].type != LBraket)
				&& (Data.LexTable[nom + 1].type != Number)
				&& (Data.LexTable[nom + 1].type != Not)
				&& Data.LexTable[nom + 1].type != Str)
			{
				fprintf(ef, "line %d: \tAfter '(' must be '(' or identifier!\n", Data.LexTable[nom].line);
				error++;
			}
		}
		if (checkIsOperation(Data.LexTable[nom].type) && Data.LexTable[nom].type != Not)
		{
			if ((Data.LexTable[nom + 1].type != Identifier)
				&& (Data.LexTable[nom + 1].type != LBraket)
				&& (Data.LexTable[nom + 1].type != Number)
				&& (Data.LexTable[nom + 1].type != Not))
			{
				if (Data.LexTable[nom + 1].type == Str || (Data.LexTable[nom - 1].type == Str))
				{
					fprintf(ef, "line %d: \tIncorrect using of string constant\n", Data.LexTable[nom].line);
					error++;
				}
				fprintf(ef, "line %d: \tAfter operation must be '(' or idetifier!\n", Data.LexTable[nom].line);
				error++;
			}
		}
		if ((Data.LexTable[nom].type == Identifier) || (Data.LexTable[nom].type == Number))
		{
			lastRBracketPos = nom;
			if (!(checkIsOperation(Data.LexTable[nom + 1].type))
				&& (Data.LexTable[nom + 1].type != RBraket)
				&& (Data.LexTable[nom + 1].type != Separator))
			{
				fprintf(ef, "line %d: \tAfter identifier or number must be ')' or ';' or operation!\n",
					Data.LexTable[nom].line);
				error++;
			}
		}
		if (Data.LexTable[nom].type == Str)
		{
			if ((Data.LexTable[nom + 1].type != RBraket)
				&& (Data.LexTable[nom + 1].type != Separator))
			{
				fprintf(ef, "line %d: \tAfter \'string const\' must be ')' or ';'\n",
					Data.LexTable[nom].line);
				error++;
			}
		}
	}
	return error;
}

inline int checkBalance(int& nom, const TypeOfLex ends, const TypeOfLex ltStart, const TypeOfLex ltFinish)
{
	std::stack<int> stack{};
	Stack ss;
	int j = 0;
	int i = nom;
	int cnt_begin{};
	int cnt_end{};
	ss.init(&ss.stackType);
	for (; Data.LexTable[i].type != ends && Data.LexTable[i].type != LEOF; i++)
	{
		if (Data.LexTable[i].type == ltStart)
		{
			ss.push(i, &ss.stackType);
			stack.push(i);
			cnt_begin++;
		}
		if (Data.LexTable[i].type == ltFinish)
		{
			if (ss.is_empty(&ss.stackType))
			{
				j = 1;
				break;
			}
			stack.pop();
			nom = ss.pop(&ss.stackType);
			cnt_end++;
		}
	}
	if (!(ss.is_empty(&ss.stackType)))
	{
		j = 2;
	}
	return j;
}

inline int handleError(const char* filename)
{
	int i = 0;
	int err_num = 0;
	bool is_stop = false;
	int count_of_var_types = 0;
	size_t vector_iterator = 0;
	std::vector<int> var_type_index(10, 150);
	FILE* ef;
	if ((fopen_s(&ef, filename, "wt")) != 0)
	{
		printf("Error: Can not create file: %s\n", filename);
		return 0 ;
	}
	fputs("Error list:\n\n", ef);
	int startIndex{};

	if (Data.LexTable[0].type != StartProgram)
	{
		err_num++;
		fprintf(ef, "%d - line %d: \t'StartProgram' expected!\n", err_num, Data.LexTable[0].line);
	}
	if (Data.LexTable[Data.LexNum - 2].type != EndBlock)
	{
		err_num++;
		fprintf(ef, "line %d: \t'EndBlock' expected!\n", Data.LexTable[1].line);
	}
	if (Data.LexTable[1].type != Variable)
	{
		err_num++;
		fprintf(ef, "line %d: \t'Variable' expected!\n", Data.LexTable[i].line);
	}
	if (Data.LexTable[2].type != VarType)
	{
		err_num++;
		fprintf(ef, "line %d: \t'Integer16' expected!\n", Data.LexTable[i].line);
	}
	if (Data.LexTable[Data.LexNum - 1].type != LEOF)
	{
		err_num++;
		fprintf(ef, "line %d: \tEnd of file expected!\n", Data.LexTable[Data.LexNum - 1].line);
	}

	int countLabel = 0, countlabelName = 0;
	for (int count = 0; Data.LexTable[count].type != LEOF; ++count)
	{

		if (Data.LexTable[count].type == Label) {
			Data.TabelLabel[countLabel].str = Data.LexTable[count].name;
			Data.TabelLabel[countLabel].line = Data.LexTable[count].line;
			countLabel++;

		}
		else if (Data.LexTable[count].type == LabelName) {
			Data.TabelLabelName[countlabelName].str = Data.LexTable[count].name;
			countlabelName++;
		}
		if (Data.LexTable[count].type == VarType)
		{
			count_of_var_types++;
			var_type_index[vector_iterator] = count;
			vector_iterator++;
		}
	}
	for (int k = 0; k < countLabel; ++k) {
		bool found = false;
		for (int t = 0; t < countlabelName; ++t) {
			if (Data.TabelLabel[k].str == Data.TabelLabelName[t].str) {
				found = true;
				break;
			}
		}
		if (!found) {
			err_num++;
			fprintf(ef, "line %d: \tThe '%s' label has no equivalent!\n", Data.TabelLabel[k].line, Data.TabelLabel[k].str);
		}
	}

	vector_iterator = 0;
	while (count_of_var_types)
	{
		if (Data.LexTable[var_type_index[vector_iterator]].type == VarType)
		{
			i = var_type_index[vector_iterator] + 1;
			if (Data.LexTable[i].type != Identifier)
			{
				err_num++;
				fprintf(ef, "line %d: \tIdentifier expected!\n", Data.LexTable[i].line);
			}
			else
			{
				do
				{
					if ((Data.LexTable[i].type == Identifier) && (Data.LexTable[i + 1].type == Comma))
					{
						strcpy(Data.IdTable[Data.IdNum].name, Data.LexTable[i].name);
						for (int i = 0; i < Data.IdNum; i++)
						{
							if (strcmp(Data.IdTable[i].name, Data.IdTable[Data.IdNum].name) == 0)
							{
								err_num++;
								fprintf(ef, "%d - line %d: \tThe identifier must be specified only once!\n", err_num, Data.LexTable[Data.IdNum].line);
							}
						}
						Data.IdNum++;
						i = i + 2;
					}
				} while ((Data.LexTable[i].type == Identifier) && (Data.LexTable[i + 1].type == Comma));
				if ((Data.LexTable[i].type == Identifier) && (Data.LexTable[i + 1].type == Separator))
				{
					strcpy(Data.IdTable[Data.IdNum].name, Data.LexTable[i].name);
					for (int i = 0; i < Data.IdNum; i++)
					{
						if (strcmp(Data.IdTable[i].name, Data.IdTable[Data.IdNum].name) == 0)
						{
							err_num++;
							fprintf(ef, "%d - line %d: \tThe identifier must be specified only once!\n", err_num, Data.LexTable[Data.IdNum].line);
						}
					}
					Data.IdNum++;
					i = i + 2;
					goto label1;
				}
				if (Data.LexTable[i].type != Separator)
				{
					if (Data.LexTable[i].type == Comma)
					{
						err_num++;
						fprintf(ef, "line %d: \tToo much commas!\n", Data.LexTable[i].line);
					}
					else
					{
						err_num++;
						fprintf(ef, "line %d: \t';' expected!\n", Data.LexTable[i].line);
					}
				}
				else
				{
					err_num++;
					fprintf(ef, "line %d: \tToo much commas or identifier expected!\n", Data.LexTable[i].line);
				}
			}
			i++;
		}
	label1:;
		count_of_var_types--;
		vector_iterator++;
	}
	if (Data.LexTable[i].type != StartBlock)
	{
		err_num++;
		fprintf(ef, "line %d: \t'StartBlock' expected!\n", Data.LexTable[i].line);
	}
	int beginIndex{};
	for (beginIndex = 0; Data.LexTable[beginIndex].type != StartBlock && Data.LexTable[beginIndex].type != LEOF; ++beginIndex);

	if (Data.LexTable[i + 1].type == EndBlock && Data.LexTable[i + 2].type != LEOF)
	{
		err_num++;
		fprintf(ef, "line %d: \tUnknown declaration after main 'BODY' block!\n", Data.LexTable[i + 2].line);
		is_stop = true;
	}
	if (!is_stop)
	{
		int j = 1;
		std::vector<int> tmp{ 0 };
		switch (beginEndCheck(tmp, LEOF, StartBlock, EndBlock))
		{
		case Error::ETooMuchBegin:
			fprintf(ef, "Too much 'StartBlock'!\n");
			for (auto& t : tmp)
				fprintf(ef, "\t\t\tline %d: !\n", Data.LexTable[t].line);
			err_num++;
			break;
		case Error::ETooMuchEnd:
			for (auto& t : tmp)
				fprintf(ef, "line %d: \tToo much 'EndBlock'!\n", Data.LexTable[t].line);
			err_num++;
			break;
		case Error::EEndExpected:
			err_num++;
			fprintf(ef, "line %d: \t StartBlock is present but 'EndBlock' expected!\n", Data.LexTable[tmp[tmp.size() - 1]].line);
			break;
		case Error::EBeginExpected:
			err_num++;
			fprintf(ef, "line %d: \t EndBlock is present but 'StartBlock' expected!\n", Data.LexTable[tmp[tmp.size() - 1]].line);
			break;
		default:;
		}
		for (j = 0;; j++)
		{
			if (Data.LexTable[j].type == Unknown)
			{
				err_num++;
				fprintf(ef, "line %d: \tUndeclared identifier!(%s)\n",
					Data.LexTable[j].line,
					Data.LexTable[j].name);
			}
			if ((Data.LexTable[j].type == Identifier) && (j > i))
			{
				bool available = 0;
				for (int i = 0; i < Data.IdNum; i++)
				{
					if (strcmp(Data.IdTable[i].name, Data.LexTable[j].name) == 0)
					{
						available = 1;
					}
				}
				if (!available)
				{
					err_num++;
					fprintf(ef, "line %d: \tUnknown identifier!(%s)\n", Data.LexTable[j].line, Data.LexTable[j].name);
				}
			}
			if (Data.LexTable[j].type == Assign)
			{
				int buf;
				isStringConstantExist = 1;
				int brak, temp = j;
				brak = checkBalance(temp, Separator, LBraket, RBraket);
				if (brak == 1)
				{
					err_num++;
					fprintf(ef, "line %d: \tToo much ')'!\n", Data.LexTable[temp].line);
				}
				if (brak == 2)
				{
					err_num++;
					fprintf(ef, "line %d: \t')' expected!\n", Data.LexTable[temp].line);
				}
				if (Data.LexTable[j - 1].type == Identifier)
				{
					buf = checkExpression((j + 1), ef);
				}
				else
				{
					buf = 1;
				}
				isStringConstantExist = -1;
				err_num = err_num + buf;
			}

			if (Data.LexTable[j].type == Get)
			{
				int buf, brak;
				if (Data.LexTable[j + 1].type != LBraket)
				{
					err_num++;
					fprintf(ef, "line %d: \t'(' expected!\n", Data.LexTable[j + 1].line);
				}
				buf = checkExpression((j + 1), ef);
				err_num = err_num + buf;
				brak = checkBalance(j, Separator, LBraket, RBraket);
				if (brak == 1)
				{
					err_num++;
					fprintf(ef, "line %d: \tToo much ')'!\n", Data.LexTable[j].line);
				}
				if (brak == 2)
				{
					err_num++;
					fprintf(ef, "line %d: \t')' expected!\n", Data.LexTable[j].line);
				}
			}
			if (Data.LexTable[j].type == Put)
			{
				int cnt{};
				if (Data.LexTable[j + 1].type != LBraket)
				{
					err_num++;
					cnt = 1;
					fprintf(ef, "line %d: \t'(' expected!\n", Data.LexTable[j].line);
				}
				if (Data.LexTable[j + 2].type != Identifier)
				{
					err_num++;
					fprintf(ef, "line %d: \tIdentifier expected!\n", Data.LexTable[j].line);
					cnt = 2;
				}
				if (Data.LexTable[j + 3].type != RBraket)
				{
					err_num++;
					if (cnt == 2)
						fprintf(ef, "line %d: \t')' expected!\n", Data.LexTable[j].line);
					else
						fprintf(ef, "line %d: \t')' expected!\n", Data.LexTable[j + 2].line);
					cnt = 3;
				}
				if (Data.LexTable[j + 4].type != Separator)
				{
					err_num++;
					if (cnt == 3)

						fprintf(ef, "line %d: \t';' expected!\n", Data.LexTable[j].line);
					else
						fprintf(ef, "line %d: \t';' expected!\n", Data.LexTable[j + 3].line);
				}
			}
			if (Data.LexTable[j].type == If)
			{
				iFElsePresent.push(Data.LexTable[j].type);
				int brak{};
				isIFExist = true;
				if (Data.LexTable[j + 1].type != LBraket)
				{
					err_num++;
					fprintf(ef, "line %d: \t'(' expected after 'If'!\n", Data.LexTable[j + 1].line);
				}
				bool startPresent{ false };
				int tmp = j;
				brak = checkBalance(tmp, StartBlock, LBraket, RBraket);
				if (brak == 1)
				{
					err_num++;
					fprintf(ef, "line %d: \tToo much ')'!\n", Data.LexTable[tmp].line);
				}
				if (brak == 2)
				{
					err_num++;
					fprintf(ef, "line %d: \t')' expected!\n", Data.LexTable[tmp].line);
				}
				int buf;
				if (Data.LexTable[j + 1].type == LBraket)
				{
					buf = checkExpression((j + 1), ef);
					err_num += buf;
				}
				if (Data.LexTable[lastRBracketPos + 1].type == Separator) {
					err_num++;
					fprintf(ef, "line %d: \t'If' cannot be followed by ';'!\n", Data.LexTable[lastRBracketPos].line + 1);
				}
				if (Data.LexTable[lastRBracketPos + 2].type != StartBlock)
				{
					err_num++;
					fprintf(ef, "line %d: \t'StartBlock' expected after 'If'!\n", Data.LexTable[lastRBracketPos].line + 1);
					startPresent = true;
				}
				isIFExist = false;
				lastRBracketPos = 0;
			}
			if (Data.LexTable[j].type == Else)
			{

				if (iFElsePresent.empty())
				{
					err_num++;
					fprintf(ef, "line %d: \t'Else' without previous 'If'!\n", Data.LexTable[j].line);
				}
				else
				{
					iFElsePresent.pop();
				}
				if (Data.LexTable[j + 1].type == Separator) {
					err_num++;
					fprintf(ef, "line %d: \t'Else' cannot be followed by ';'!\n", Data.LexTable[lastRBracketPos].line + 1);
				}
				if (Data.LexTable[j + 1].type != StartBlock)
				{
					int buf;
					err_num++;
					fprintf(ef, "line %d: \t'StartBlock' expected after 'Else'!\n", Data.LexTable[j + 1].line);
				}

			}
			if (Data.LexTable[j].type == Number && (Data.LexTable[j].value > 32767 || Data.LexTable[j].value < -32768))
			{
				err_num++;
				fprintf(ef, "line %d: \tNumber exceeds the data type! Only -32769 > Number < 32768!\n", Data.LexTable[j].line);
			}
			if (Data.LexTable[j].type == LabelName && Data.LexTable[j + 1].type != Separator)
			{
				err_num++;
				fprintf(ef, "line %d: \tAfter label '%s' must be use ';'!\n", Data.LexTable[j].line, Data.LexTable[j].name);
			}
			if (Data.LexTable[j].type == Label && Data.LexTable[j + 1].type == Separator)
			{
				err_num++;
				fprintf(ef, "line %d: \tAfter label '%s' should not be used ';'!\n", Data.LexTable[j].line, Data.LexTable[j].name);
			}
			if (Data.LexTable[j].type == LEOF) break;
		}
		if (err_num == 0) {
			fprintf(ef, "No errors found.");
		}
	}
	fclose(ef);
	return err_num;
}