%{
#include <stdio.h>
#include <stdlib.h>
#include "lexer.h"
%}

%token T_begin "begin"
%token T_do    "do"
%token T_else  "else"
%token T_end   "end"
%token T_for   "for"
%token T_if    "if"
%token T_let   "let"
%token T_print "print"
%token T_then  "then"

%token T_identifier
%token T_integer

%left '+' '-'
%left '*' '/' '%'

%expect 1
%%

program : stmt_list
        ;

stmt_list : /* nothing */
          | stmt_list stmt
          ;

stmt : "begin" stmt_list "end"
     | "for" expr "do" stmt
     | "if" expr "then" stmt
     | "if" expr "then" stmt "else" stmt
     | "let" T_identifier '=' expr
     | "print" expr
     ;

expr : T_integer
     | T_identifier
     | '(' expr ')'
     | expr '+' expr
     | expr '-' expr
     | expr '*' expr
     | expr '/' expr
     | expr '%' expr
     ;

%%

void yyerror(const char *msg) {
  fprintf(stderr, "Syntax error: %s\n", msg);
  exit(42);
}

int main() {
  int result = yyparse();
  if (result == 0) printf("Parsing successful!\n");
  return result;
}
