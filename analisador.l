%option noyywrap

%{
#include <stdio.h>
#include<string.h>

#define MAX_SYMBOLS 100

char *table[MAX_SYMBOLS];
int count = 1;

int get_position(const char *id) {
    for (int i = 1; i < count; i++) {
        if (strcmp(table[i], id) == 0) {
            return i;
        }
    }
    table[count] = strdup(id);
    return count++;
}

%}
id [a-zA-Z][a-zA-Z0-9]*
digit           [0-9]
flt     {digit}+\.{digit}+
integer         {digit}+
%%

"integer"      {printf("<integer> ");}
"flt"          {printf("<flt> ");}
"return"   {printf("<return> ");}
"function" {printf("<function> ");}
"vector"   {printf("<vector> ");}
"repeatuntil"  {printf("<repeatuntil> ");}
"readinput"     {printf("<readinput> ");}
"writeoutput"   {printf("<writeoutput> ");}
"loop"      {printf("<loop> ");}
"if"       {printf("<if> ");}
"else"     {printf("<else> ");}
"none"     {printf("<none> ");}
{id}	{ int position = get_position(yytext);
    printf("<id, %d> ", position);}
{integer}    { printf("<num, %s> ", yytext);}
{flt}        { printf("<num, %s> ", yytext);}
"<"|"<="|">"|">="|"=="|"!=" {printf("<relop, %s> ", yytext);}
"+"|"-"|"*"|"/"|"="|";"|","|"("|")"|"["|"]"|"{"|"}"|"%"|"++"|"--"|"and"|"or"|"not"|"+="|"-="|":"|"."    {printf("<%s> ", yytext);}


\"[^\"]*\"   { printf("<string, %s> ", yytext); }
'[^']'       { printf("<char, %s> ", yytext); }

[ \t\r\n]   {/*ignora*/}
.       {printf("erro: %s",yytext);}

%%

int main(){
   yylex();
   printf("\n\nTabela de Símbolos:\n");
   for (int i = 1; i < count; i++) {
    printf("Posição %d: %s\n", i, table[i]);
    free(table[i]);
}
   return 0;
}