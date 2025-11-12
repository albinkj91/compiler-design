%{
#define T_id
#define T_atom
#define T_integer
#define T_string
#define T_keyword

void ERROR (const char msg[]);
%}

KEYWORD     case|of|end                                                     /* keywords */
INTEGER     ^(([2-9]|([12][0-9]?))|(3[0-6]))#[0-9a-zA-Z]+$|^(-?[0-9]+)$     /* integers */
ATOM        ^[a-z][a-zA-Z0-9_]*?$                                           /* atoms */
STRING      ^\"([^\"]|\\")*\"$                                              /* strings */
VAR         ^[A-Z_][a-zA-Z0-9]*$                                            /* variables */
%%

%%
