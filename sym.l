%{

#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "def.h"

struct Tnode* TreeCreate(int TYPE, int NODETYPE, int VALUE, char* NAME, struct Tnode *Ptr1, struct Tnode *Ptr2, struct Tnode *Ptr3) {
	struct Tnode* temp=malloc(sizeof(struct Tnode));
	temp->TYPE		=	TYPE;
	temp->NODETYPE	=	NODETYPE;
	temp->VALUE		=	VALUE;
	temp->Ptr1		=	Ptr1; // unk
	temp->Ptr2		=	Ptr2; // left
	temp->Ptr2		=	Ptr3; // right
	return temp;
}

int yywrap(void) {
	return 1;
}

%}


%%

[0-9]+		{	yylval.n = TreeCreate(1, 0, atoi(yytext), NULL, NULL, NULL, NULL);
			return INTEGER; }

true {
					char *s = malloc(yyleng);
					strcpy(s, yytext);
					yylval.n = TreeCreate(2, 0, 0, s, NULL, NULL, NULL);
					return BOOLEAN; }

false {
					char *s = malloc(yyleng);
					strcpy(s, yytext);
					yylval.n = TreeCreate(2, 0, 0, s, NULL, NULL, NULL);
					return BOOLEAN; }


"+"		{	yylval.n = TreeCreate(1, 1, 0, NULL, NULL, NULL, NULL);
			return OP1; }

"-"		{	yylval.n = TreeCreate(1, 2, 0, NULL, NULL, NULL, NULL);
			return OP2; }

"*"		{	yylval.n = TreeCreate(1, 3, 0, NULL, NULL, NULL, NULL);
			return OP3; }

"/"		{	yylval.n = TreeCreate(1, 4, 0, NULL, NULL, NULL, NULL);
			return OP4; }

"read"		{	yylval.n = TreeCreate(3,'r', 0, NULL, NULL, NULL, NULL);
				return READ;}

"write"		{	yylval.n = TreeCreate(3,'w', 0, NULL, NULL, NULL, NULL);
				return WRITE;}

"decl"		{	return DECL;}

"enddecl"	{	return ENDDECL;}

"integer"	{	return INTEGER;}

"boolean"	{	return BOOLEAN;}

"main"		{	return MAIN;}

"begin"		{	return BEG;}

"end"		{	return END;}

"="			{
				yylval.n = TreeCreate(3, '=', 0, NULL, NULL, NULL, NULL);
				return EQ;
			}

[a-zA-Z][a-zA-Z0-9]*	{
					char *s = malloc(yyleng);
					strcpy(s, yytext);
					yylval.n = TreeCreate(3, 0, 0, s, NULL, NULL, NULL);
					return VAR;
				}

"["			{	return *yytext;}

"]"			{	return *yytext;}

"("			{	return LP;}

")"			{	return RP;}

";"			{	return SC;}

","			{	return CM;}

[\n]		{	return *yytext;}

.			{
				yyerror("Invalid character");
				exit(0); 
			}


%%
