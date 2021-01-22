/*
 * Filename      program4.c
 * Date          4/5/2020
 * Author        Noah Sims
 * Email         ngs170000@utdallas.edu
 * Course        CS 3377.501 Spring 2020
 * Version       1.0
 * Copyright 2020, All Rights Reserved
 *
 * Description
 *
 *     This program utilizes flex and bison to create a compliler that parses an imput file of postal addresses
 *     and outputs the address in XML format
 */


#include <stdio.h>
#include "y.tab.h"

int yylex(void);
extern char *yytext;

int yyparse(void);

void scannerMode(void);

int main(int argc, char** argv)
{
  if(strcmp(argv[0], "./parser") == 0)
    {
      fprintf(stdout, "\nOperating in parse mode\n\n");

      int parse = yyparse();

      if(parse == 0)
	fprintf(stdout, "\nParse Successful!\n");
      else
	fprintf(stdout, "\nParse failed\n");

      return 0;
    }
  else if(strcmp(argv[0], "./scanner") == 0)
    {
      fprintf(stdout, "\nOperating in scan mode\n\n");

      scannerMode();

      printf("\nDone\n");

      return 0;
    }

  return 0;
}

void scannerMode()
{
  int token;

  token = yylex();

  while(token != 0)
    {
      printf("yylex returned ");

      switch(token)
        {
        case NAMETOKEN:
          printf("NAMETOKEN token (%s)\n", yytext);
          break;
        case NAME_INITIAL_TOKEN:
          printf("NAME_INITIAL_TOKEN token (%s)\n", yytext);
          break;
        case ROMANTOKEN:
          printf("ROMANTOKEN token (%s)\n", yytext);
          break;
        case SRTOKEN:
          printf("SRTOKEN token (%s)\n", yytext);
          break;
        case JRTOKEN:
          printf("JRTOKEN token (%s)\n", yytext);
          break;
        case INTTOKEN:
          printf("INTTOKEN token (%s)\n", yytext);
          break;
        case EOLTOKEN:
          printf("EOLTOKEN token (267)\n");
          break;
        case COMMATOKEN:
          printf("COMMATOKEN token (%s)\n", yytext);
          break;
        case DASHTOKEN:
          printf("DASHTOKEN token (%s)\n", yytext);
          break;
        case HASHTOKEN:
          printf("HASHTOKEN token (%s)\n", yytext);
          break;
        case IDENTIFIERTOKEN:
          printf("IDENTIFIERTOKEN token (%s)\n", yytext);
          break;
        default:
          printf("UNKNOWN\n");
        }

      token = yylex();
    }
}
