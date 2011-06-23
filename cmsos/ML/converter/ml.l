%{
#include <string.h>

#include "ml.tab.h"
%}

DIGIT      [0-9]
UC         [A-Z]
LC         [a-z]
LETTER     {UC}|{LC}
NORMALID   {LETTER}({LETTER}|{DIGIT})*
SYMBOL     [-%&$#+<=>?@\\~^|*:/]
SYMBOLICID {SYMBOL}+

/* there symbols are not commonly used as infix operators, so we define them by hand !-` */

%option noyywrap

%%


ref             return REF;

let             return LET;
in              return IN;
end             return END;
val             return VAL;
rec             return REC;
fun             return FUN;
if              return IF;
then            return THEN;
else            return ELSE;
while           return WHILE;
do              return DO;
and             return AND;
andalso         return ANDALSO;
orelse          return ORELSE;
raise           return RAISE;
handle          return HANDLE;
case            return CASE;
of              return OF;
fn              return FN;
exception       return EXCEPTION;
nil             return NIL;
cml             return CML;
spawn           return SPAWN;
send            return SEND;
receive         return RECEIVE;
chan            return CHAN;
before          return BEFORE;

"!"             return BANG;
"="             return EQUALS;
"=>"            return DARROW;
":="            return ASSIGN;

"|"             return '|';
"("             return '(';
")"             return ')';
"{"             return '{';
"}"             return '}';
"["             return '[';
"]"             return ']';
"_"             return '_';

","             return ',';
";"             return ';';
":"             return ':';

"..."           return DOTDOTDOT;


{SYMBOLICID}    { yylval = (YYSTYPE) strdup(yytext); return SYMBOLICID; }
{NORMALID}      { yylval = (YYSTYPE) strdup(yytext); return ID; }
{DIGIT}+        { yylval = (YYSTYPE) strdup(yytext); return NUMBER; }

[ \t\n]+        

.               printf ("unknown char: %s\n", yytext);

%%
