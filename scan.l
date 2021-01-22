/*
 * Filename:            scan.l
 * Date:                04/05/2020
 * Author:              Noah Sims
 * Email:               ngs170000@utdallas.edu
 * Version:             1.0
 * Copyright:           2020, All Rights Reserved
 *
 * Description:
 *
 *      Flex source file for program4
 */



%option noyywrap
%option nounput
%option noinput

%{
  #include <stdlib.h>
  #include "y.tab.h"
%}

%%

[ \t\r]+                                                  { /* eat up whitespcae */ }
"Sr."                                                     { yylval.str = "Sr."; return SRTOKEN; }
"Jr."                                                     { yylval.str = "Jr."; return JRTOKEN; }
[IVX][IVX]+                                               { yylval.str = strdup(yytext); return ROMANTOKEN; }
[a-zA-Z]+[0-9]+[a-zA-Z0-9]*|[0-9]+[a-zA-Z]+[a-zA-Z0-9]*   { yylval.str = strdup(yytext); return IDENTIFIERTOKEN; }
[a-zA-Z][a-zA-Z]+                                         { yylval.str = strdup(yytext); return NAMETOKEN; }
[A-Z]"."?                                                 { yylval.str = strdup(yytext); return NAME_INITIAL_TOKEN; }
[0-9]+                                                    { yylval.str = strdup(yytext); return INTTOKEN; }
[\n]                                                      { return EOLTOKEN; }
","                                                       { return COMMATOKEN; }
"-"                                                       { return DASHTOKEN; }
"#"                                                       { return HASHTOKEN; }

%%
