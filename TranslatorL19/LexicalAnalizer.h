#pragma once
#pragma once
#define _CRT_SECURE_NO_WARNINGS
#include <iostream>


int GetTokens(FILE* in_fileName)
{
	FSMStates state = Start;
	Lexema TempToken;
	// кількість лексем
	unsigned int NumberOfTokens = 0;
	char ch, buf[50];
	bool isProgramName = false;
	int line = 1;
	// читання символів з файлу і пошук лексем
	ch = getc(in_fileName);
	while (TempToken.type != LEOF)
	{
		switch (state)
		{
			// Begin lexeme recognition.
			// If the current character is a lowercase letter, transition to the Letter state.
			// If the current character is a digit, transition to the Digit state.
			// If the current character is a space, tab, or newline, transition to the Separators stat.
			// If the current character is different from the previous ones, transition to the Another state.
		case Start:
		{
			if (feof(in_fileName))
			{
				strcpy_s(TempToken.name, "EndOfFile");
				TempToken.type = LEOF;
				TempToken.value = 0;
				TempToken.line = line;
				Data.LexTable[NumberOfTokens++] = TempToken;
				break;
			}
			if (ch <= 'Z' && ch >= 'A')
				state = Command;
			else if (ch <= '9' && ch >= '0')
				state = Digit;
			else if (ch <= 'z' && ch >= 'a')
				state = Identificator;
			else if (ch == ' ' || ch == '\t' || ch == '\n')
				state = Separators;
			else
				state = Another;
			break;
		}
		// End of lexeme recognition.
		// Record the lexeme in the lexeme table.
		case Finish:
		{
			if (NumberOfTokens < MAX_TOKENS)
			{
				Data.LexTable[NumberOfTokens++] = TempToken;
				ch = getc(in_fileName);
				state = Start;
				TempToken.str = nullptr;
				memset(buf, 0, sizeof(buf));
			}
			else
			{
				printf("\n\t\t\tToo many tokens!!!\n");
				return NumberOfTokens - 1;
			}
			break;
		}
		// The current lexem is an Identificator.
		case Identificator:
		{
			TypeOfLex temp_type = Unknown;
			bool isLabel = false;
			int i = 0;
			buf[0] = ch;
			for (i = 1;; ++i) {
				ch = getc(in_fileName);
				if ((isdigit(ch) != 0) || (isalpha(ch) != 0))
				{
					buf[i] = ch;
				}
				else break;
			}
			int j;
			for (j = 1; j < i; j++)
			{
				if (islower(buf[0])) {
					//!issuper().
					if (islower(buf[j])) break;
				}
			}
			// Check Label.
			if (ch == ':' && (j == i) && (i <= 8) && islower(buf[0])) {
				buf[i++] = '\0';
				temp_type = Label;
				isLabel = true;
				strcpy_s(TempToken.name, buf);
				TempToken.type = temp_type;
				TempToken.value++;
				TempToken.line = line;
				state = Finish;
				break;
			}
			// Check Identifier.
			if (!isLabel && (j == i) && (i <= 8) && islower(buf[0]))
			{
				temp_type = Identifier;
				strcpy_s(TempToken.name, buf);
				TempToken.type = temp_type;
				TempToken.value = 0;
				TempToken.line = line;
				ungetc(ch, in_fileName);
				state = Finish;

			}
			else {
				temp_type = Unknown;
				strcpy_s(TempToken.name, buf);
				TempToken.type = temp_type;
				TempToken.value = 0;
				TempToken.line = line;
				ungetc(ch, in_fileName);
				state = Finish;
			}
			break;
		}
		// The current lexem is an Command.
		case Command:
		{
			int i = 0;
			buf[0] = ch;
			for (i = 1;; ++i)
			{
				ch = getc(in_fileName);
				if ((isdigit(ch) != 0) || (isalpha(ch) != 0)) buf[i] = ch;
				else break;
			}
			buf[i] = '\0';
			ungetc(ch, in_fileName);
			TypeOfLex temp_type = Unknown;
			if (!strcmp(buf, "StartProgram"))
				temp_type = StartProgram;
			else if (!strcmp(buf, "StartBlock"))
				temp_type = StartBlock;
			else if (!strcmp(buf, "Variable"))
				temp_type = Variable;
			else if (!strcmp(buf, "Integer16"))
				temp_type = VarType;
			else if (!strcmp(buf, "EndBlock"))
				temp_type = EndBlock;
			else if (!strcmp(buf, "Get"))
				temp_type = Get;
			else if (!strcmp(buf, "Put"))
				temp_type = Put;
			else if (!strcmp(buf, "If"))
				temp_type = If;
			else if (!strcmp(buf, "Else"))
				temp_type = Else;
			else if (!strcmp(buf, "Div"))
				temp_type = Div;
			else if (!strcmp(buf, "Mod"))
				temp_type = Mod;
			else if (!strcmp(buf, "Not"))
				temp_type = Not;
			else if (!strcmp(buf, "And"))
				temp_type = And;
			else if (!strcmp(buf, "Or"))
				temp_type = Or;
			else if (!strcmp(buf, "Lt"))
				temp_type = Lt;
			else if (!strcmp(buf, "Gt"))
				temp_type = Gt;
			else if (!strcmp(buf, "Goto")) {
				temp_type = Goto;
				strcpy_s(TempToken.name, buf);
				TempToken.type = temp_type;
				TempToken.value = 0;
				TempToken.line = line;
				if (NumberOfTokens < MAX_TOKENS)
				{
					Data.LexTable[NumberOfTokens++] = TempToken;
					ch = getc(in_fileName);
					while (!isalpha(ch))
					{
						ch = getc(in_fileName);
					}
					int i = 0;
					memset(buf, 0, 16);
					buf[0] = ch;
					for (i = 1;; ++i)
					{
						ch = getc(in_fileName);
						if ((isdigit(ch) != 0) || (isalpha(ch) != 0))
							buf[i] = ch;
						else break;
					}
					ungetc(ch, in_fileName);
					buf[i] = '\0';
					temp_type = LabelName;

					if (i <= 8)
					{
						strcpy_s(TempToken.name, buf);
						TempToken.type = temp_type;
						TempToken.value++;
						TempToken.line = line;
						state = Finish;
						break;
					}
					temp_type = Unknown;
				}
				else
				{
					printf("\n\t\t\tToo many tokens!!!\n");
					return NumberOfTokens - 1;
				}
			}
			else if (strlen(buf) < 1)
			{
				temp_type = Identifier;
			}
			strcpy_s(TempToken.name, buf);
			TempToken.type = temp_type;
			TempToken.value = 0;
			TempToken.line = line;
			state = Finish;
			break;
		}
		// The current lexem is an Digit.
		case Digit:
		{
			buf[0] = ch;
			int j = 1;
			ch = getc(in_fileName);
			while ((ch <= '9' && ch >= '0') && j < 49)
			{
				buf[j++] = ch;
				ch = getc(in_fileName);
			}
			buf[j] = '\0';
			ungetc(ch, in_fileName);
			strcpy_s(TempToken.name, buf);
			TempToken.type = Number;
			TempToken.value = atoll(buf);
			TempToken.line = line;
			state = Finish;
			break;
		}
		// The current character is a space, tab, or newline
		case Separators:
		{
			if (ch == '\n')
				line++;
			ch = getc(in_fileName);
			state = Start;
			break;
		}
		// The current character is different from the previous ones.
		case Another:
		{
			switch (ch)
			{
			case '(':
			{
				strcpy_s(TempToken.name, "(");
				TempToken.type = LBraket;
				TempToken.value = 0;
				TempToken.line = line;
				state = Finish;
				break;
			}
			case ')':
			{
				strcpy_s(TempToken.name, ")");
				TempToken.type = RBraket;
				TempToken.value = 0;
				TempToken.line = line;
				state = Finish;
				break;
			}
			case ';':
			{
				strcpy_s(TempToken.name, ";");
				TempToken.type = Separator;
				TempToken.value = 0;
				TempToken.line = line;
				state = Finish;
				break;
			}
			case ',':
			{
				strcpy_s(TempToken.name, ",");
				TempToken.type = Comma;
				TempToken.value = 0;
				TempToken.line = line;
				state = Finish;
				break;
			}

			case '>':
			{
				char c;
				c = getc(in_fileName);
				if (c == '>')
				{
					strcpy_s(TempToken.name, ">>");
					TempToken.type = Assign;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
					break;
				}
				ungetc(c, in_fileName);
				TempToken.name[0] = ch;;
				TempToken.type = Unknown;
				TempToken.value = 0;
				TempToken.line = line;
				state = Finish;
				break;
			}
			case '=':
			{
				strcpy_s(TempToken.name, "=");
				TempToken.type = Equ;
				TempToken.value = 0;
				TempToken.line = line;
				state = Finish;
				break;
			}
			case '<':
			{
				char c;
				c = getc(in_fileName);
				if (c == '>')
				{
					strcpy_s(TempToken.name, "<>");
					TempToken.type = NotEqu;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
					break;
				}
				ungetc(c, in_fileName);
				TempToken.name[0] = ch;;
				TempToken.type = Unknown;
				TempToken.value = 0;
				TempToken.line = line;
				state = Finish;
				break;
			}
			case '/':
			{
				ch = getc(in_fileName);
				if (ch == '/')
				{
					char c;
					int i = 0;
					buf[i++] = '/';
					buf[i++] = '/';
					c = getc(in_fileName);
					while (c != '\n')
					{
						buf[i++] = c;
						c = getc(in_fileName);
						if (i > 49) {
							break;
						}
					}
					buf[i++] = c;
					buf[i] = '\0';
					strcpy_s(TempToken.name, "//");
					TempToken.type = Comentar;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
					line++;
				}
				else {
					ungetc(ch, in_fileName);
					TempToken.name[0] = ch;
					TempToken.name[1] = '\0';
					TempToken.type = Unknown;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
					break;
				}
				break;
			}
			case '+':
			{
				ch = getc(in_fileName);
				if (isdigit(ch))
				{
					state = Digit;
				}
				else if (ch == '+')
				{
					strcpy_s(TempToken.name, "++");
					TempToken.type = Add;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
					break;
				}
				else {
					ungetc(ch, in_fileName);
					TempToken.name[0] = '+';
					TempToken.name[1] = '\0';
					TempToken.type = Unknown;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
				}
				break;
			}
			case '-':
			{
				ch = getc(in_fileName);
				if (isdigit(ch))
				{
					ungetc(ch, in_fileName);
					ch = '-';
					state = Digit;
				}
				else if (ch == '-') {
					strcpy_s(TempToken.name, "--");
					TempToken.type = Sub;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
					break;
				}
				else
				{
					ungetc(ch, in_fileName);
					TempToken.name[0] = '-';
					TempToken.name[1] = '\0';
					TempToken.type = Unknown;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
				}
				break;
			}
			case '*':
			{
				ch = getc(in_fileName);
				if (ch == '*') {
					strcpy_s(TempToken.name, "**");
					TempToken.type = Mul;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
					break;
				}
				else
				{
					ungetc(ch, in_fileName);
					TempToken.name[0] = '-';
					TempToken.name[1] = '\0';
					TempToken.type = Unknown;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
				}
				break;
			}
			case '"':
			{
				int currentPos = ftell(in_fileName);
				TempToken.str = new char[100];
				TempToken.str[0] = ch;
				int i;
				for (i = 1;; ++i)
				{
					ch = getc(in_fileName);
					if (ch != '"')
					{
						if (ch == '\\')
						{
							TempToken.str[i] = ch;
							ch = getc(in_fileName);
							TempToken.str[++i] = ch;
						}
						else if (ch == '\n')
						{
							TempToken.str[i] = ch;
							break;
						}
						else
						{
							TempToken.str[i] = ch;
						}
					}
					else
					{
						TempToken.str[i++] = ch;
						break;
					}
					if (i == 100 || feof(in_fileName)) { break; }
				}
				if (i == 100 || TempToken.str[i - 1] != '"')
				{
					memset(TempToken.str, 0, 100);
					TempToken.str = nullptr;
					TempToken.name[0] = '"';
					TempToken.name[1] = '\0';
					TempToken.type = Unknown;
					TempToken.value = 0;
					TempToken.line = line;
					state = Finish;
					fseek(in_fileName, currentPos, SEEK_SET);
					break;
				}
				strcpy_s(TempToken.name, "String");
				TempToken.str[i] = '\0';
				TempToken.type = Str;
				TempToken.value = 0;
				TempToken.line = line;
				state = Finish;
				break;
			}
			default:
			{
				int cnt = 0;
				TempToken.name[0] = ch;
				ch = getc(InF);
				if (ch != ' ' && ch != ',' && ch != ';' && ch != '\t' && ch != '\n')
				{
					TempToken.name[++cnt] = ch;
					while (ch != ' ' && ch != ',' && ch != ';'
						&& ch != '\t' && ch != '\n')
					{
						ch = getc(InF);
						TempToken.name[++cnt] = ch;
					}
					ungetc(ch, InF);
					TempToken.name[cnt] = '\0';
				}
				else
				{
					ungetc(ch, InF);
					TempToken.name[1] = '\0';
				}
				TempToken.type = Unknown;
				TempToken.value = 0;
				TempToken.line = line;
				state = Finish;
				break;
			}
			}
		}
		}
	}
	return NumberOfTokens;
}
void PrintTokensToFile(char* in_fileName, int TokensNum)
{
	FILE* F;
	if ((fopen_s(&F, in_fileName, "wt")) != 0)
	{
		printf("Error: Can not create file: %s\n", in_fileName);
		return;
	}
	char type_tokens[20];
	fprintf(F, "-------------------------------------------------------------------------------- - \n");
	fprintf(F, "| TOKEN TABLE 	 | \n");
	fprintf(F, "--------------------------------------------------------------------------------\n");
	fprintf(F, "| line number | token | identValue | token code |  type of token | \n");
	fprintf(F, "--------------------------------------------------------------------------------");

	for (unsigned int i = 0; i < TokensNum; i++)
	{
		switch (Data.LexTable[i].type)
		{
		case StartProgram:
			strcpy_s(type_tokens, "StartProgram");
			break;
		case StartBlock:
			strcpy_s(type_tokens, "StartBlock");
			break;
		case VarType:
			strcpy_s(type_tokens, "Integer16");
			break;
		case Variable:
			strcpy_s(type_tokens, "Variable");
			break;
		case Identifier:
			strcpy_s(type_tokens, "Identifier");
			break;

		case EndBlock:
			strcpy_s(type_tokens, "EndBlock");
			break;
		case Put:
			strcpy_s(type_tokens, "Put");
			break;
		case Get:
			strcpy_s(type_tokens, "Get");
			break;
		case If:
			strcpy_s(type_tokens, "If");
			break;
		case Else:
			strcpy_s(type_tokens, "Else");
			break;
		case Assign:
			strcpy_s(type_tokens, ">>");
			break;
		case Add:
			strcpy_s(type_tokens, "Add");
			break;
		case Sub:
			strcpy_s(type_tokens, "Sub");
			break;
		case Mul:
			strcpy_s(type_tokens, "Mul");
			break;
		case Div:
			strcpy_s(type_tokens, "Div");
			break;
		case Equ:
			strcpy_s(type_tokens, "Equality");
			break;
		case NotEqu:
			strcpy_s(type_tokens, "NotEquality");
			break;
		case Gt:
			strcpy_s(type_tokens, "Gt");
			break;
		case Lt:
			strcpy_s(type_tokens, "Lt");
			break;
		case Not:
			strcpy_s(type_tokens, "Not");
			break;
		case And:
			strcpy_s(type_tokens, "And");
			break;
		case Or:
			strcpy_s(type_tokens, "Or");
			break;
		case LBraket:
			strcpy_s(type_tokens, "LBraket");
			break;

		case RBraket:
			strcpy_s(type_tokens, "RBraket");
			break;
		case Number:
			strcpy_s(type_tokens, "Number");
			break;
		case Separator:
			strcpy_s(type_tokens, "Separator");
			break;
		case Comma:
			strcpy_s(type_tokens, "Comma");
			break;
		case Unknown:
			strcpy_s(type_tokens, "Unknown");
			break;
		case LabelName:
			strcpy_s(type_tokens, "Label");
			break;
		case Label:
			strcpy_s(type_tokens, "Label");
			break;
		case Comentar:
			strcpy_s(type_tokens, "Comment");
			break;
		case LEOF:
			strcpy_s(type_tokens, "EndOFile");
			break;
		case Goto:
			strcpy_s(type_tokens, "Goto");
			break;
		case Mod:
			strcpy_s(type_tokens, "Mod");
			break;
		case Str:
			strcpy_s(type_tokens, "StrConst");
			break;
		default:;
		}
		if (Data.LexTable[i].type != Str)
		{
			fprintf(F, "\n|%12d |%16s |%16d |%20d | %-13s |\n",
				Data.LexTable[i].line,
				Data.LexTable[i].name,
				Data.LexTable[i].value,
				Data.LexTable[i].type, type_tokens);
		}
		else
		{
			fprintf(F, "\n|%12d |%16s |%16s |%11d | %-13s |\n",
				Data.LexTable[i].line,
				Data.LexTable[i].name,
				Data.LexTable[i].str,
				Data.LexTable[i].type,
				type_tokens);
		}
		fprintf(F, "-------------------------------------------------------------------------- - ");
	}
	fclose(F);
}