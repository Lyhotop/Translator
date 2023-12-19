#pragma once
#pragma once
//using namespace dataStaructure;
static int isStringConst{ -1 };
static bool isDivOrModPresent{ false };
const char* registerList[4]{ "r8", "r9", "r10", "r11" };
bool registerState[4]{ false, false, false, false };

inline void checkZeroDivOrMod(FILE* f, const int& regIndex)
{
	isDivOrModPresent = true;
	fprintf(f, "\ttest %s , %s\n", registerList[regIndex], registerList[regIndex]);
	fprintf(f, "\tjz __DivZero\n");
}

inline void printIncludeAndProto(FILE* fout)
{
	fprintf(fout, "include masm64\\include64\\masm64rt.inc\n");
	fprintf(fout, "printf proto\n");
	fprintf(fout, "scanf proto\n");
	fprintf(fout, "_getch proto\n");
	fprintf(fout, "\n.data\n");
}

inline void printProlog(FILE* fout)
{
	fprintf(fout, "\n.code\n");
	fprintf(fout, "mainCRTStartup proc\n");
	fprintf(fout, "sub rsp, 28h\n");
}

inline void printGlobalVariables(FILE* f)
{
	for (int i = 0; i < Data.IdNum; ++i)
	{
		fprintf(f, "\t%s\tdq\t0%lldh\n", Data.IdTable[i].name, Data.LexTable[i].value);
	}
	fputs("\tbuf\tdq\t0\n", f);
}

inline void printEpilog(FILE* f)
{
	fprintf(f, "\tjmp __end\n");
	fprintf(f, "\t__end200:\n");
	fputs("\tinvoke printf, cfm$(\"\\nVariable that doesn't belong to the Integer16\\n\") \n ", f);
	fprintf(f, "\tjmp __end\n");
	fprintf(f, "\t__end201:\n");
	fputs("\tinvoke printf, cfm$(\"\\nPut var that doesn't belong to the Integer16\\n\") \n ", f);
	fprintf(f, "\t__end:\n");
	if (isDivOrModPresent)
	{
		fputs("jmp __exit\n", f);
		fputs("__DivZero:\n", f);
		fputs("\tinvoke printf, cfm$(\"\\nExeption! divide or modulos by zero\\n\") \n ", f);
		fputs("__exit:\n", f);
	}
	fputs("invoke _getch\n", f);
	fputs("invoke ExitProcess, 0\n", f);
	fputs("add rsp, 28h\n", f);
	fputs("mainCRTStartup endp\n", f);
	fputs("end\n", f);
}

inline bool Prioritet(TypeOfLex t, StackType s)
{
	const bool r = (
		((t == Div) && (Data.LexTable[s.stack[s.top]].type == Add))
		||
		((t == Div) && (Data.LexTable[s.stack[s.top]].type == Sub))
		||
		((t == Div) && (Data.LexTable[s.stack[s.top]].type == Or))
		||
		((t == Div) && (Data.LexTable[s.stack[s.top]].type == And))
		||
		((t == Div) && (Data.LexTable[s.stack[s.top]].type ==
			Equ)) ||
		((t == Div) && (Data.LexTable[s.stack[s.top]].type == NotEqu)) ||
		((t == Div) && (Data.LexTable[s.stack[s.top]].type ==
			Lt)) ||
		((t == Div) && (Data.LexTable[s.stack[s.top]].type ==
			Gt)) ||
		((t == Mul) && (Data.LexTable[s.stack[s.top]].type == Add))
		||
		((t == Mul) && (Data.LexTable[s.stack[s.top]].type == Sub))
		||
		((t == Mul) && (Data.LexTable[s.stack[s.top]].type == Or))
		||
		((t == Mul) && (Data.LexTable[s.stack[s.top]].type == And))
		||
		((t == Mul) && (Data.LexTable[s.stack[s.top]].type ==
			Equ)) ||
		((t == Mul) && (Data.LexTable[s.stack[s.top]].type == NotEqu)) ||
		((t == Mul) && (Data.LexTable[s.stack[s.top]].type ==
			Lt)) ||
		((t == Mul) && (Data.LexTable[s.stack[s.top]].type ==
			Gt)) ||
		((t == Mod) && (Data.LexTable[s.stack[s.top]].type == Add))
		||
		((t == Mod) && (Data.LexTable[s.stack[s.top]].type == Sub))
		||
		((t == Mod) && (Data.LexTable[s.stack[s.top]].type == Or))
		||
		((t == Mod) && (Data.LexTable[s.stack[s.top]].type == And))
		||
		((t == Mod) && (Data.LexTable[s.stack[s.top]].type ==
			Equ)) ||
		((t == Mod) && (Data.LexTable[s.stack[s.top]].type == NotEqu)) ||
		((t == Mod) && (Data.LexTable[s.stack[s.top]].type ==
			Lt)) ||
		((t == Mod) && (Data.LexTable[s.stack[s.top]].type ==
			Gt)) ||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type == Add))
		||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type == Sub))
		||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type == Div))
		||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type == Mul))
		||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type == Mod))
		||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type == Or))
		||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type == And))
		||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type ==
			Equ)) ||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type == NotEqu)) ||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type ==
			Lt)) ||
		((t == Not) && (Data.LexTable[s.stack[s.top]].type ==
			Gt))
		);
	return r;
}

// Generate sequence number of tokens in massive Reverse Polish Notation.
inline  int ConvertToReversePolishNotation(int i)
{
	myStack.init(&myStack.stackType);
	int z;
	int n = 0;
	if ((Data.LexTable[i - 1].type != If))
		for (; ((Data.LexTable[i + n].type != Separator)); ++n);
	else
	{
		for (; ((Data.LexTable[i + n].type != StartBlock)); ++n);
		--n;
	}
	const  int k = i + n;
	for (z = 0; i < k; ++i)
	{
		const TypeOfLex in = Data.LexTable[i].type;
		if ((in == Identifier) || (in == Number))
		{
			Data.exprInReversePolishNotation[z] = i;
			++z;
		}
		else if (checkIsOperation(in))
		{
			if (myStack.is_empty(&myStack.stackType) || Prioritet(in, myStack.stackType))
			{
				myStack.push(i, &myStack.stackType);
			}
			else
			{
				if (Data.LexTable[myStack.stackType.stack[myStack.stackType.top]].type != LBraket)
				{
					do
					{
						Data.exprInReversePolishNotation[z]
							= myStack.pop(&myStack.stackType);
						++z;
					} while ((!(Prioritet(in, myStack.stackType)))
						&& (!(myStack.is_empty(&myStack.stackType)))
						&& (Data.LexTable[myStack.stackType.stack[myStack.stackType.top]].type != LBraket));
				}
				myStack.push(i, &myStack.stackType);
			}
		}
		if (in == LBraket)
		{
			myStack.push(i, &myStack.stackType);
			Data.exprInReversePolishNotation[z] = i;
			++z;
		}
		if (in == RBraket)
		{
			while ((Data.LexTable[myStack.stackType.stack[myStack.stackType.top]].type != LBraket))
			{
				Data.exprInReversePolishNotation[z] = myStack.pop(&myStack.stackType);
				++z;
			}
			myStack.pop(&myStack.stackType);
			Data.exprInReversePolishNotation[z] = i;
			++z;
		}
		if (in == Str)
		{
			isStringConst = i;
		}
	}
	while (!(myStack.is_empty(&myStack.stackType)))
	{
		Data.exprInReversePolishNotation[z] = myStack.pop(&myStack.stackType);
		++z;
	}
	Data.exprInReversePolishNotation[z] = 3000;
	z++;
	return k;
}

inline const char* getNameOfFreeRegister()
{
	int index{ -1 };
	for (int i = 0; i < 4; i++)
	{
		if (registerState[i] == false)
		{
			index = i;
			registerState[i] = true;
			break;
		}
	}
	return registerList[index];
}

inline int getLastBussyIndexForResister()
{
	int index = -1;
	for (int i = 0; i < 4; i++)
	{
		if (registerState[i] == true)
		{
			index = i;
		}
	}
	return index;
}

inline void freeRegistersByIndex(const int index)
{
	registerState[index] = false;
}

inline void generateAdd(FILE* f)
{
	const int index = getLastBussyIndexForResister();
	fprintf(f, "\tadd %s, %s\n", registerList[index - 1], registerList[index]);
	freeRegistersByIndex(index);
}

inline void generateSub(FILE* f)
{
	const int index = getLastBussyIndexForResister();
	fprintf(f, "\tsub %s, %s\n", registerList[index - 1], registerList[index]);
	freeRegistersByIndex(index);
}

inline void generateMul(FILE* f)
{
	const int index = getLastBussyIndexForResister();
	fprintf(f, "\timul %s, %s\n", registerList[index - 1], registerList[index]);
	freeRegistersByIndex(index);
}

inline void generateDiv(FILE* f)
{
	int index = getLastBussyIndexForResister();
	fprintf(f, "\txor rdx, rdx\n");
	fprintf(f, "\tmov rax, %s\n", registerList[index - 1]);
	checkZeroDivOrMod(f, index);
	fprintf(f, "\tidiv %s\n", registerList[index]);
	fprintf(f, "\tmov %s, rax\n", registerList[index - 1]);
	freeRegistersByIndex(index);
}

inline void generateMod(FILE* f)
{
	int index = getLastBussyIndexForResister();
	fprintf(f, "\txor rdx, rdx\n");
	fprintf(f, "\tmov rax, %s\n", registerList[index - 1]);
	checkZeroDivOrMod(f, index);
	fprintf(f, "\tdiv %s\n", registerList[index]);
	fprintf(f, "\tmov %s, rdx\n", registerList[index - 1]);
	freeRegistersByIndex(index);
}

inline void generateAND(FILE* f)
{
	const int index = getLastBussyIndexForResister();
	fprintf(f, "\tand %s, %s\n", registerList[index - 1], registerList[index]);
	freeRegistersByIndex(index);
}

inline void generateOR(FILE* f)
{
	const int index = getLastBussyIndexForResister();
	fprintf(f, "\tor %s, %s\n", registerList[index - 1], registerList[index]);
	freeRegistersByIndex(index);
}

inline void generateNOT(FILE* f)
{
	const int index = getLastBussyIndexForResister();
	static int labelIndex{};
	labelIndex++;
	fprintf(f, "\tcmp %s, 0\n", registerList[index]);
	fprintf(f, "\tje to_assign_one%d \n", labelIndex);
	fprintf(f, "\tmov %s, 0\n", registerList[index]);
	fprintf(f, "\tjmp finish_assign%d \n", labelIndex);
	fprintf(f, "to_assign_one%d:\n", labelIndex);
	fprintf(f, "\tmov %s, 1\n", registerList[index]);
	fprintf(f, "finish_assign%d:\n", labelIndex);
}

inline void generateCompare(FILE* f, const char* how)
{
	const int index = getLastBussyIndexForResister();
	fprintf(f, "\tcmp %s, %s\n", registerList[index - 1], registerList[index]);
	fprintf(f, "\t%s %sb\n", how, registerList[index]);
	fprintf(f, "\tand \%s, %d\n", registerList[index], 255);
	fprintf(f, "\tmov %s, %s\n", registerList[index - 1], registerList[index]);
	freeRegistersByIndex(index);
}

inline void freeAllRegisters()
{
	for (bool& i : registerState)
	{
		i = false;
	}
}

inline void generateAssemblyCodeRPN(const char* str, FILE* f)
{
	int k = 0;
	for (int n = 0; Data.exprInReversePolishNotation[n] != 3000; ++n)
	{
		myStack.init(&myStack.stackType);
		if (n == 0) k = n; else k = n - 1;
		if ((!checkIsOperation(Data.LexTable[Data.exprInReversePolishNotation[n]].type))
			&& (Data.LexTable[Data.exprInReversePolishNotation[n]].type != Not)
			&& (Data.LexTable[Data.exprInReversePolishNotation[k]].type != Not))
		{
			if (Data.LexTable[Data.exprInReversePolishNotation[n]].type == Identifier)
			{
				fprintf(f, "\tmov %s, %s\n", getNameOfFreeRegister(),
					Data.LexTable[Data.exprInReversePolishNotation[n]].name);
			}
			else if (Data.LexTable[Data.exprInReversePolishNotation[n]].type == Number)
			{
				fprintf(f, "\tmov %s, %lld\n", getNameOfFreeRegister(),
					Data.LexTable[Data.exprInReversePolishNotation[n]].value);

			}
			else if ((Data.LexTable[Data.exprInReversePolishNotation[n]].type == LBraket)
				|| (Data.LexTable[Data.exprInReversePolishNotation[n]].type == RBraket))
			{
			}
		}
		else
		{
			switch (Data.LexTable[Data.exprInReversePolishNotation[n]].type)
			{
			case Add:
				generateAdd(f);
				break;
			case Sub:
				generateSub(f);
				break;
			case Div:
				generateDiv(f);
				break;
			case Mod:
				generateMod(f);
				break;
			case Mul:
				generateMul(f);
				break;
			case And:
				generateAND(f);
				break;
			case Or:
				generateOR(f);
				break;
			case Not:
				generateNOT(f);
				break;
			case Equ:
				generateCompare(f, "sete");
				break;
			case NotEqu:
				generateCompare(f, "setne");
				break;
			case Lt:
				generateCompare(f, "setl");
				break;
			case Gt:
				generateCompare(f, "setg");
				break;
			}
		}
	}
	fprintf(f, "mov %s, %s\n", str, registerList[getLastBussyIndexForResister()]);
	freeRegistersByIndex(getLastBussyIndexForResister());
}

inline void printCode(FILE* f)
{
	int num = 200;
	int ifLabelIndex = 0;
	Lexem currentLexem;
	int lexemIndex = 0;
	do
	{
		++lexemIndex;
	} while (Data.LexTable[lexemIndex].type != VarType);
	++lexemIndex;
	if (Data.LexTable[lexemIndex].type == VarType)
	{
		do
		{
			lexemIndex++;
		} while (Data.LexTable[lexemIndex].type != Separator);
		lexemIndex++;
	}
	stackiF.init(&stackiF.stackType);
	myStack.init(&myStack.stackType);
	for (;; ++lexemIndex)
	{
		currentLexem.type = Data.LexTable[lexemIndex].type;
		strncpy(currentLexem.name, Data.LexTable[lexemIndex].name, 50);
		currentLexem.value = Data.LexTable[lexemIndex].value;
		if (currentLexem.type == Div || currentLexem.type == Mod)
		{
			isDivOrModPresent = true;
		}
		if (currentLexem.type == LEOF)
		{
			break;
		}
		if (currentLexem.type == StartBlock)
		{
			stackiF.push(ifLabelIndex++, &stackiF.stackType);
		}
		if ((currentLexem.type == EndBlock) && (Data.LexTable[lexemIndex + 1].type != LEOF))
		{
			if (stackiF.stackType.top >= 0)
			{
				const int temp1 = stackiF.pop(&stackiF.stackType);
				if (Data.LexTable[lexemIndex + 1].type == Else)

				{
					fprintf(f, "\tjmp __end%d\n", ifLabelIndex);
					fprintf(f, "__end%d:\n", temp1);
					freeAllRegisters();
					continue;
				}
				freeAllRegisters();
				fprintf(f, "__end%d:\n", temp1);
				ifLabelIndex += 2;
			}
			else
			{
				stackiF.pop(&stackiF.stackType);
				stackiF.pop(&stackiF.stackType);
			}
		}
		if (currentLexem.type == If)
		{
			lexemIndex = ConvertToReversePolishNotation(lexemIndex + 1);
			if (lexemIndex < 0)
			{
				lexemIndex = -lexemIndex;
				continue;
			}
			generateAssemblyCodeRPN("buf", f);
			fputs("\tcmp qword ptr buf, 0\n", f);
			fprintf(f, "\tjz __end%d\n", ifLabelIndex);
		}
		if (currentLexem.type == LabelName)
		{
			fprintf(f, "\tjmp %s\n", Data.LexTable[lexemIndex].name);
		}
		if (currentLexem.type == Label)
		{
			fprintf(f, "%s:\n", Data.LexTable[lexemIndex].name);
		}
		if (currentLexem.type == Get)
		{
			lexemIndex = ConvertToReversePolishNotation(lexemIndex + 1);
			if (isStringConst != -1)
			{
				fprintf(f, "\tinvoke printf, cfm$(%s)\n", Data.LexTable[isStringConst].str);
				isStringConst = -1;
			}
			else
			{

				generateAssemblyCodeRPN("buf", f);
				//fprintf(f, "\tinvoke scanf, \"%%lld\", addr %s\n", Data.LexTable[lexemIndex + 2].name);
				fprintf(f, "\tmov r8, buf\n");
				fprintf(f, "\tcmp r8, 32768\n");
				fprintf(f, "\tjge __end201\n");
				fprintf(f, "\tcmp r8, -32768\n");
				fprintf(f, "\tjl __end201\n");
				fprintf(f, "\tinvoke printf, \" %%lld\", buf\n");
			}
		}
		if (currentLexem.type == Put)
		{
			fprintf(f, "\tinvoke scanf, \"%%lld\", addr %s\n", Data.LexTable[lexemIndex + 2].name);
			fprintf(f, "\tmov r8, %s\n", Data.LexTable[lexemIndex + 2].name);
			fprintf(f, "\tcmp r8, 32768\n");
			fprintf(f, "\tjge __end200\n");
			fprintf(f, "\tcmp r8, -32768\n");
			fprintf(f, "\tjl __end200\n");
			lexemIndex += 4;
		}
		if (currentLexem.type == Assign && (Data.LexTable[lexemIndex - 3].type != If))
		{
			int bufi;
			bufi = lexemIndex;
			// Generate Reverse Polish Notation.
			lexemIndex = ConvertToReversePolishNotation(lexemIndex + 1);
			if (lexemIndex < 0)
			{
				lexemIndex = -lexemIndex;
				continue;
			}
			// Generate assemble code from Reverse Polish Notation.
			generateAssemblyCodeRPN(Data.LexTable[bufi - 1].name, f);
		}
	}
}

inline void generateFullCode(FILE* f)
{
	printIncludeAndProto(f);
	printGlobalVariables(f);
	printProlog(f);
	printCode(f);
	printEpilog(f);
}
