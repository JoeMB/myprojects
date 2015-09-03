*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
  if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
    YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */

%}

%option noyywrap

/*
 * Define names for regular expressions here.
 */

digit		[0-9]
int_const	digit+
class		(C|c)(L|l)(A|a)(S|s)(S|s)
else		(E|e)(L|l)(S|s)(E|e)
fi		(F|f)(I|i)
if		(I|i)(F|f)
in		(I|i)(N|n)
inherits	(I|i)(N|n)(H|h)(E|e)(R|r)(I|i)(T|t)(S|s)
isvoid		(I|i)(S|s)(V|v)(O|o)(I|i)(D|d)
let		(L|l)(E|e)(T|t)
loop		(L|l)(O|o)(O|o)(P|p)
pool		(P|p)(O|o)(O|o)(L|l)
then		(T|t)(H|h)(E|e)(N|n)
while		(W|w)(H|h)(I|i)(L|l)(E|e)
case		(C|c)(A|a)(S|s)(E|e)
esac		(E|e)(S|s)(A|a)(C|c)
new		(N|n)(E|e)(W|w)
of		(O|o)(F|f)
not		(N|n)(O|o)(T|t)
true		't'+(R|r)(U|u)(E|e)
false		'f'+(A|a)(L|l)(S|s)(E|e)
whitespace	(' '|'\n'|'\f'|'\r'|'\t'|'\v')+
letter		[a-zA-Z]
charidentifier	letter|'_'|digit
typeid		[A-Z]charidentifier*
objectid	[a-z]charidentifier*
self		'self'
self_type	'SELF_TYPE'
oparenthesis	'('
cparenthesis	')'
colon		':'
semicolon	';'
ocbracket	'{'
ccbracket	'}'
obracket	'['
cbracket	']'
assign		'<='
operator	'='+'<'+'>'		
str_const		'"'  '"'
comment		('--' anything '\n')+('(*' anything '*)')




%%

 /*
  * Define regular expressions for the tokens of COOL here. Make sure, you
  * handle correctly special cases, like:
  *   - Nested comments
  *   - String constants: They use C like systax and can contain escape
  *     sequences. Escape sequence \c is accepted for all characters c. Except
  *     for \n \t \b \f, the result is c.
  *   - Keywords: They are case-insensitive except for the values true and
  *     false, which must begin with a lower-case letter.
  *   - Multiple-character operators (like <-): The scanner should produce a
  *     single token for every such operator.
  *   - Line counting: You should keep the global variable curr_lineno updated
  *     with the correct line number
  */

//0            	return(EOF);        
class		return(CLASS);     
else       	return(ELSE);       
fi	     	return(FI);         
if       	return(IF);         
in        	return(IN);         
inherits   	return(INHERITS);   
let       	return(LET);        
loop       	return(LOOP);       
pool       	return(POOL);       
then       	return(THEN);       
while      	return(WHILE);      
assign     	return(ASSIGN);     
case    	return(CASE);       
esac       	return(ESAC);       
of         	return(OF);         
//darrow     	return(DARROW);     
new        	return(NEW);        
str_const  	return(STR_CONST);  
int_const  	return(INT_CONST);  
//bool_const 	return(BOOL_CONST); 
typeid     	return(TYPEID);     
objectid   	return(OBJECTID);   
//error      	return(ERROR);      
//le         	return(LE);         
not        	return(NOT);        
isvoid     	return(ISVOID);     
'+' 		return('+'); 
'/' 		return('/'); 
'-' 		return('-'); 
'*' 		return('*'); 
'=' 		return('='); 
'<' 		return('<'); 
'.' 		return('.'); 
'~' 		return('~'); 
',' 		return(','); 
';' 		return(';'); 
':' 		return(':'); 
'(' 		return('('); 
')' 		return(')'); 
'@' 		return('@'); 
'{' 		return('{'); 
'}' 		return('}'); 

%%
