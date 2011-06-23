/* A Bison parser, made by GNU Bison 2.0.  */

/* Skeleton parser for GLR parsing with Bison,
   Copyright (C) 2002, 2003, 2004 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUMBER = 258,
     DIGIT = 259,
     ID = 260,
     UNDERSCORE = 261,
     LBRACKET = 262,
     RBRACKET = 263,
     LPAREN = 264,
     RPAREN = 265,
     FN = 266,
     FUN = 267,
     IF = 268,
     THEN = 269,
     ELSE = 270,
     WHILE = 271,
     DO = 272,
     AND = 273,
     ANDALSO = 274,
     ORELSE = 275,
     RAISE = 276,
     HANDLE = 277,
     CASE = 278,
     OF = 279,
     LET = 280,
     IN = 281,
     END = 282,
     VAL = 283,
     REC = 284,
     ARROW = 285,
     DARROW = 286,
     EXCEPTION = 287,
     DOTDOTDOT = 288,
     NIL = 289,
     EQUALS = 290,
     ASSIGN = 291,
     BANG = 292,
     REF = 293,
     BEFORE = 294,
     SEND = 295,
     CML = 296,
     RECEIVE = 297,
     SPAWN = 298,
     CHAN = 299,
     SYMBOLICID = 300
   };
#endif
#define NUMBER 258
#define DIGIT 259
#define ID 260
#define UNDERSCORE 261
#define LBRACKET 262
#define RBRACKET 263
#define LPAREN 264
#define RPAREN 265
#define FN 266
#define FUN 267
#define IF 268
#define THEN 269
#define ELSE 270
#define WHILE 271
#define DO 272
#define AND 273
#define ANDALSO 274
#define ORELSE 275
#define RAISE 276
#define HANDLE 277
#define CASE 278
#define OF 279
#define LET 280
#define IN 281
#define END 282
#define VAL 283
#define REC 284
#define ARROW 285
#define DARROW 286
#define EXCEPTION 287
#define DOTDOTDOT 288
#define NIL 289
#define EQUALS 290
#define ASSIGN 291
#define BANG 292
#define REF 293
#define BEFORE 294
#define SEND 295
#define CML 296
#define RECEIVE 297
#define SPAWN 298
#define CHAN 299
#define SYMBOLICID 300




#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
typedef int YYSTYPE;
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

#if ! defined (YYLTYPE) && ! defined (YYLTYPE_IS_DECLARED)
typedef struct YYLTYPE
{

  char yydummy;

} YYLTYPE;
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif



