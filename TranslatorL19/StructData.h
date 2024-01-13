#pragma once
#define _CRT_SECURE_NO_WARNINGS
#include "stdio.h"
#include "malloc.h"
#include <string>
#include "stdlib.h"
#include "ctype.h"
#define MAX_TOKENS 1000
#define MAX_LEXEMS 1000
#define MAX_IDENT 100
#define MAX_BUF_SIZE 100
#define STACK_SIZE 200
#define MAX_LENGTH_TYPES 20

enum TypeOfLex {
	StartProgram,		// StartProgram
	StartBlock,			// StartBlock
	Variable,			// Variable
	VarType,			// Integer16
	Identifier,			// Identifier
	EndBlock,			// EndBLock

	Get,				// Get
	Put,				// Put

	If,					// If
	Else,				// Else
	Goto,				// Goto
	Label,
	LabelName,

	Assign,				// >>
	Add,				// ++
	Sub,				// --
	Mul,				// **
	Div,				// Div
	Mod,				// Mod
	Equ,				// =
	NotEqu,				// <>
	Lt,					// Lt
	Gt,					// Gt
	Not,				// Not
	And,				// And
	Or,					// Or

	Str,				//String
	LBraket,			// (
	RBraket,			// )
	Number,				// number
	Separator,			// ;
	Colon,				// :
	Comma,				// ,
	LEOF,				// EndFile
	Unknown,

	Comentar
};

extern enum FSMStates
{
	Start,
	Finish,
	Command,
	Digit,
	Separators,
	Another,
	Identificator,
};

//DATA
typedef struct Lexem
{
	char name[50];
	char* str = nullptr;
	char point[8];
	long int value;
	int line;
	TypeOfLex type;
}Lexema;

typedef struct ID
{
	std::string str;
	char name[50];
	int value;
	int line;
}IdentificatorR;

typedef struct L
{
	Lexema LexTable[MAX_LEXEMS];			// Table of lexem.
	int LexNum;

	IdentificatorR IdTable[MAX_IDENT];		//Table of Identificator.
	IdentificatorR TabelLabel[MAX_IDENT];
	IdentificatorR TabelLabelName[MAX_IDENT];
	int IdNum;

	bool IsPresentInput,					//Signs of the presence of operators.
		IsPresentOutput,
		IsPresentMod,
		IsPresentAnd,
		IsPresentOr,
		IsPresentNot,
		IsPresentEqu,
		IsPresentGreate,
		IsPresentLess,
		IsPresentDiv;
	int numberErrors;
	std::string InputFileName;
	char OutputFileName[50];
	int exprInReversePolishNotation[MAX_BUF_SIZE];
}	DataType;

using StackType = struct Stacks {
	long long int stack[STACK_SIZE];
	long long int top;
};
using Stack = class myStack {
public:
	StackType stackType{};
	void init(StackType* s) { s->top = -1; }
	void push(const long long int i, StackType* s) {
		if (is_full(s)) {
			puts("Stack is full!\n");
			exit(0);
		}
		++s->top;
		s->stack[s->top] = i;
	}
	long long int pop(StackType* s) {
		if (is_empty(s)) {
			puts("Stack is empty!\n");
			exit(0);
		}
		const long long int i = s->stack[s->top];
		--s->top;
		return i;
	}
	bool is_empty(const StackType* s) {
		if (s->top == -1) {
			return true;
		}
		return false;
	}
	bool is_full(const StackType* s) {
		if (s->top == 199)
			return true;
		return false;
	}
};

 static Stack myStack, stackiF;
 static DataType Data;
 static FILE* InF, * OutF, * ErrorF;