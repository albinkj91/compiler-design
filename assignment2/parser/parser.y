%{
#include <stdio.h>
#include <stdlib.h>
#include "lexer.h"
%}

%token T_begin "begin"
%token T_case  "case"
%token T_do    "do"
%token T_else  "else"
%token T_end   "end"
%token T_for   "for"
%token T_if    "if"
%token T_let   "let"
%token T_of    "of"
%token T_print "print"
%token T_then  "then"
%token T_div   "div"

%token T_identifier
%token T_integer
%token T_atom
%token T_string

%left '<' '>' '='
%left '+' '-'
%left '*' '/' '%' T_div

//%expect 1
%%

program : functions
        ;

functions : %empty
          | functions function
          ;

function : clauses '.'
         ;

clauses : clauses ';' clause | clause
        ;

clause : T_atom pat_args cl_body
       ;

cl_body : '-' '>' exprs
        ;

pat_args : '(' patterns ')' | '(' ')'
         ;

patterns : patterns ',' pat_expr | pat_expr
         ;

pat_expr : T_identifier '=' expr | T_identifier | T_integer | T_atom | T_string | binary
         ;

exprs : exprs ',' expr | expr
      ;

expr : expr '+' expr
     | expr '=' expr | expr '-' expr | expr '*' expr | expr '/' expr | expr T_div expr
     | expr '=' '=' expr | expr '/' '=' expr | expr '=' '<' expr | expr '<' expr | expr '=' '>' expr | expr '>' expr
     | T_identifier | T_integer | T_atom | T_string | binary
     | T_case expr T_of case_cls T_end | T_begin exprs T_end | '(' expr ')'
     ;

case_cls : case_cls ';' case_cl | case_cl
         ;

case_cl : expr cl_body
        ;

binary : '<' '<' segments '>' '>' | '<' '<' '>' '>'
       ;

segments : segments ',' segment | segment
         ;

segment : T_identifier | T_integer | T_string
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
