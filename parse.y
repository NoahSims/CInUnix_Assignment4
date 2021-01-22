/*
 * Filename:            parse.y
 * Date:                04/05/2020
 * Author:              Noah Sims
 * Email:               ngs170000@utdallas.edu
 * Version:             1.0
 * Copyright:           2020, All Rights Reserved
 *
 * Description:
 *
 *      Bison source file for program4
 */

%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(char*);

  extern char* yytext;
%}

%union
{
   int value;
   char* str;
}

%type   <value> INTTOKEN
%type   <str>   ROMANTOKEN
%type   <str>   IDENTIFIERTOKEN
%type   <str>   NAMETOKEN
%type   <str>   NAME_INITIAL_TOKEN

%token  SRTOKEN
%token  JRTOKEN
%token  ROMANTOKEN
%token  IDENTIFIERTOKEN
%token  NAMETOKEN
%token  NAME_INITIAL_TOKEN
%token  INTTOKEN
%token  EOLTOKEN
%token  COMMATOKEN
%token  DASHTOKEN
%token  HASHTOKEN

%type   <str>   personal_part
%type   <str>   last_name
%type   <str>   suffix_part

%start  postal_addresses

%%

postal_addresses:
                      address_block EOLTOKEN {fprintf(stderr, "\n"); } postal_addresses
                      |  address_block
		      ;

address_block:
	              name_part street_address location_part
		      ;

name_part:           
personal_part last_name suffix_part EOLTOKEN
                      |  personal_part last_name EOLTOKEN
|  error EOLTOKEN {yyerror(": Bad name-part ... skipping to newline\n");}
                      ;

personal_part:
NAMETOKEN {fprintf(stderr, "<FirstName>%s</FirstName>\n", $1);}
|  NAME_INITIAL_TOKEN {fprintf(stderr, "<FirstName>%s</FirstName>\n", $1);}
		      ;

last_name:
NAMETOKEN {fprintf(stderr, "<LastName>%s</LastName>\n", $1);}
		      ;

suffix_part:          
SRTOKEN {fprintf(stderr, "<Suffix>Sr.</Suffix>\n");}
|  JRTOKEN {fprintf(stderr, "<Suffix>Jr.</Suffix>\n");}
|  ROMANTOKEN {fprintf(stderr, "<Suffix>%s</Suffix>\n", $1);}
                      ;

street_address:      
                      street_number street_name apt_number EOLTOKEN
                      |  street_number street_name HASHTOKEN apt_number EOLTOKEN
                      |  street_number street_name EOLTOKEN
                      |  error EOLTOKEN {yyerror(": Bad address_line ... skipping to newline\n");}
                      ;

street_number:       
INTTOKEN {fprintf(stderr, "<HouseNumber>%s</HouseNumber>\n", $1);}
|  IDENTIFIERTOKEN {fprintf(stderr, "<HouseNumber>%s</HouseNumber>\n", $1);}
                      ;

street_name:          
NAMETOKEN {fprintf(stderr, "<StreetName>%s</StreetName>\n", $1);}
                      ;

apt_number:
INTTOKEN {fprintf(stderr, "<AptNum>%s</AptNum>\n", $1);}
;

location_part:        
                      town_name COMMATOKEN state_code zip_code EOLTOKEN
                      |  error EOLTOKEN {yyerror(": Bad location_line ... skipping to newline\n");}
                      ;

town_name:
NAMETOKEN {fprintf(stderr, "<City>%s</City>\n", $1);}
		      ;

state_code:
NAMETOKEN {fprintf(stderr, "<State>%s</State>\n", $1);}
		      ;
zip_code:
                      zip5_number DASHTOKEN zip4_number
                      |  zip5_number
		      ;

zip5_number:
INTTOKEN {fprintf(stderr, "<Zip5>%s</Zip5>\n", $1);}
;

zip4_number:
INTTOKEN {fprintf(stderr, "<Zip4>%s</Zip4>\n", $1);}
;


%%


void yyerror(char* s)
{
  printf(s);
}
