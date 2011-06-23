%{
#define YYSTYPE char const *

#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>

int yylex (void);
void yyerror (char const *);
char * format (const char *fmt, ...);
%}

/*
%token ABSTYPE AND ANDALSO AS CASE DO DATATYPE ELSE
%token END EXCEPTION FN FUN HANDLE IF IN INFIX
%token INFIXR LET LOCAL NONFIX OF OP OPEN ORELSE
%token RAISE REC THEN TYPE VAL WITH WITHTYPE WHILE
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE
%token COMMA COLON SEMICOLON DOTDOTDOT UNDERBAR BAR
%token DARROW ARROW HASH
*/

%token NUMBER DIGIT ID UNDERSCORE LBRACKET RBRACKET LPAREN RPAREN
%token FN FUN IF THEN ELSE WHILE DO AND ANDALSO ORELSE RAISE HANDLE CASE OF
%token LET IN END VAL REC ARROW DARROW EXCEPTION DOTDOTDOT NIL EQUALS
%token DOTDOTDOT ASSIGN BANG REF BEFORE
%token SEND CML RECEIVE SPAWN CHAN 
%token SYMBOLICID

%start topdec

%error-verbose

%glr-parser

%% /* grammar */

/* expressions and matches */

scon: NUMBER { $$ = format ("%s", $1); }
    ;

/* INOP's are a simplification of the Standard ML, which deals with
   user-defined infixed operators.  The INOP operators are operators
   that are commonly used infixed (as in 1 = 1, 1 < 1, x := 20).

   Ordinary functions in SML can be declared as infixed, so that a function f
   defined as an infixed operator can be used such in a f b.
 */

inop: EQUALS { $$ = format ("op('=)"); }
    | SYMBOLICID { $$ = format ("op('%s)", $1); }
    ;

vid: ID { $$ = format ("ide('%s)", $1); }
   ;

atexp: scon
     | vid
     | '(' ')' { $$ = format ("tup-seq"); }
     | '(' exp ')' { $$ = format ("%s", $2); }
     | '(' expcomma_seq2 ')' { $$ = format ("tup (%s)", $2); }
     | '[' expcomma_seq0 ']' { $$ = format ("(app list %s)", $2); }
     | LET dec IN exp END { $$ = format ("(local %s %s)", $2, $4); }
     | '(' exp ';' exp ')' {
         $$ = format ("(seq (effect %s) %s)", $2, $4);
       }
     | '(' expseq2 ';' exp ')' {
         $$ = format ("(seq (seq (%s)) %s)", $2, $4);
       }
     | BANG exp { $$ = format("(assigned (deref %s))", $2); }
     ;

expseq: exp { $$ = format ("(effect %s)", $1); }
      | exp ';' expseq { $$ = format("(effect %s), %s", $1, $3); };

expseq2: exp ';' expseq { $$ = format ("(effect %s), %s", $1, $3); };

expcomma_seq0: expcomma_seq1;

expcomma_seq1: exp ',' expcomma_seq1 { $$ = format ("%s, %s", $1, $3); }
             | exp
             ;

expcomma_seq2: exp ',' expcomma_seq1 { $$ = format ("%s, %s", $1, $3); }
             ;

appexp: atexp
      | appexp atexp { $$ = format ("(app %s %s)", $1, $2); }
      | SEND '(' exp ',' exp ')' { 
          $$ = format("(seq (send-chan-seq %s %s) (tup ()))", $3, $5);  
        }
      | RECEIVE atexp { $$ = format ("(recv-chan %s)", $2); }
      | SPAWN exp { $$ = format ("(seq (start %s) (tup ()))", $2); }
      | REF exp { $$ = format("(ref (alloc %s))", $2); }
      ;

infexp: appexp
      | infexp inop infexp { $$ = format ("(app %s tup-seq (%s, %s))", $2, $1, $3); }
      | atexp BEFORE atexp { $$ = format ("(seq %s (effect %s))", $1, $3); }
      | atexp ASSIGN atexp { 
          $$ = format 
                 ("(seq (effect (assign-seq (deref %s) %s)) (tup ()))", 
                  $1, $3); 
        }
      ;

exp: infexp
   | exp ANDALSO exp { $$ = format ("(cond %s %s ff)", $1, $3); } 
   | exp ORELSE exp { $$ = format ("(cond %s tt %s)", $1, $3); } 
   | exp HANDLE match
   | RAISE exp { $$ = format ("NYI (%s)", $1); } 
   | IF exp THEN exp ELSE exp { $$ = format ("(cond %s %s %s)", $2, $4, $6); }
   | CASE exp OF match { $$ = format ("NYI (%s, %s)", $2, $4); }
   | FN match { $$ = format ("(close %s)", $2); }
   | WHILE exp DO exp { 
      $$ = format ("(seq (while %s (effect %s)) (tup ()))", $2, $4); 
     }
   ;

match: mrule 
   | mrule '|' match
   ;

mrule: pat DARROW exp { $$ = format ("(abs (bind %s) %s)", $1, $3); }

/* declarations and bindings */

dec: VAL valbind { $$ = format ("(%s)", $2); }
   | CHAN vid { $$ = format ("(bind %s alloc-chan)", $2); }
   | FUN fvalbind { $$ = format ("(rec %s)", $2); }
   | dec ';' dec { $$ = format ("(accum %s %s)", $1, $3); }
   ;

valbind1: pat EQUALS exp { $$ = format ("(bind %s %s)", $1, $3); };

valbind: valbind1 { $$ = format ("%s", $1); }

valbind: valbind1 AND valbind { $$ = format ("(simult-seq %s %s)", $1, $3); }
       | REC valbind
       ;

fvalbind: fclause { $$ = format ("%s", $1); }
        | fclause AND fvalbind
        ;

fclause: atpat atpat EQUALS exp { $$ = format ("(bind %s (close (abs (bind %s) %s)))", $1, $2, $4); }
       ;

atpat_seq: atpat atpat_seq { $$ = format ("(bind %s (close %s))", $1, $2); }
         | atpat
         ;

/* patterns */

atpat: '_' { $$ = format ("_"); }
     | scon { $$ = format ("(%s)", $1); }
     | vid { $$ = format ("(%s)", $1); }
     | '(' ')' { $$ = format ("tup-seq"); }
     | '(' patcomma_seq2 ')' { $$ = format ("tup-seq (%s)", $2); }
     | '[' patcomma_seq0 ']' { $$ = format ("list (%s)", $2); }
     | '(' pat ')' { $$ = format ("(%s)", $1); }
     ;

patcomma_seq0: patcomma_seq1;

patcomma_seq1: pat ',' patcomma_seq1 { $$ = format ("%s, %s", $1, $3); }
             | pat
             ;

patcomma_seq2: pat ',' patcomma_seq1 { $$ = format ("%s, %s", $1, $3); }
             ;


pat: DOTDOTDOT
   | atpat
   ;

prog: CML exp { $$ = format ("(quiet (effect %s))", $2); }
    ;

topdec: prog { $$ = format ("%s", $1);
               printf ("\n\
(mod PARSED is                     \n\
 including CML-INTERPRETER .       \n\
                                   \n\
 op AST : -> Sys .                 \n\
 eq AST = %s .                     \n\
endm)                              \n\
                                   \n\
(rew exec (AST) .)                 \n\
---(search exec (AST) =>! C:Conf .)\n", $$); }

      ;

%%

int
main (void)
{
  return yyparse ();
}

void yyerror (char const *s)
{
  printf ("[error] %s\n", s);
}

/* this almost verbatim from sprintf(3) */
char * format (const char *fmt, ...)
{
  int n, size = 100;

  char *p; 

  va_list ap;

  if ((p = malloc (size)) == NULL)
    return NULL;

  while (1)
    {
      va_start (ap, fmt);
      n = vsnprintf (p, size, fmt, ap);
      va_end (ap);
      
      if (n > -1 && n < size) return p;

      size = n + 1;
      
      if ((p = realloc (p, size)) == NULL)
        return NULL;
    }
}
