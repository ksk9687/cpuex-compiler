%{
(* parserが利用する変数、関数、型などの定義 *)
open Syntax
open Lexing
let addtyp x = (x, Type.gentyp ())
let rec log2 x =
  if x = 1 then 0
  else (assert (x mod 2 = 0); (log2 (x / 2)) + 1)
%}

/* 字句を表すデータ型の定義 (caml2html: parser_token) */
%token <bool> BOOL
%token <int> INT
%token <float> FLOAT
%token NOT
%token MINUS
%token PLUS
%token AST
%token SLASH
%token MINUS_DOT
%token PLUS_DOT
%token AST_DOT
%token SLASH_DOT
%token EQUAL
%token LESS_GREATER
%token LESS_EQUAL
%token GREATER_EQUAL
%token LESS
%token GREATER
%token IF
%token THEN
%token ELSE
%token <Id.t> IDENT
%token LET
%token IN
%token REC
%token COMMA
%token ARRAY_CREATE
%token <Id.t> FUNC
%token DOT
%token LESS_MINUS
%token SEMICOLON
%token LPAREN
%token RPAREN
%token EOF

/* 優先順位とassociativityの定義（低い方から高い方へ） */
%right prec_let
%right SEMICOLON
%right prec_if
%right LESS_MINUS
%left COMMA
%left EQUAL LESS_GREATER LESS GREATER LESS_EQUAL GREATER_EQUAL
%left PLUS MINUS PLUS_DOT MINUS_DOT
%left AST SLASH AST_DOT SLASH_DOT
%right prec_unary_minus
%left prec_app
%left DOT

/* 開始記号の定義 */
%type <Syntax.t> exp
%start exp

%%

simple_exp: /* 括弧をつけなくても関数の引数になれる式 */
| LPAREN exp RPAREN
    { $2 }
| LPAREN RPAREN
    { Unit }
| BOOL
    { Bool($1) }
| INT
    { Int($1) }
| FLOAT
    { Float($1) }
| IDENT
    { Var($1) }
| simple_exp DOT LPAREN exp RPAREN
    { Get($1, $4) }

exp: /* 一般の式 */
| simple_exp
    { $1 }
| NOT exp
    %prec prec_app
    { Not($2) }
| MINUS exp
    %prec prec_unary_minus
    { match $2 with
    | Float(f) -> Float(-.f) (* -1.23などは型エラーではないので別扱い *)
    | e -> Neg(e) }
| exp PLUS exp /* 足し算を構文解析するルール  */
    { Add($1, $3) }
| exp MINUS exp
    { Sub($1, $3) }
| exp AST INT
    { SLL($1, log2 $3) }
| exp SLASH INT
    { SLL($1, -(log2 $3)) }
| exp EQUAL exp
    { Eq($1, $3) }
| exp LESS_GREATER exp
    { Not(Eq($1, $3)) }
| exp LESS exp
    { Not(LE($3, $1)) }
| exp GREATER exp
    { Not(LE($1, $3)) }
| exp LESS_EQUAL exp
    { LE($1, $3) }
| exp GREATER_EQUAL exp
    { LE($3, $1) }
| IF exp THEN exp ELSE exp
    %prec prec_if
    { If($2, $4, $6) }
| MINUS_DOT exp
    %prec prec_unary_minus
    { FNeg($2) }
| exp PLUS_DOT exp
    { FAdd($1, $3) }
| exp MINUS_DOT exp
    { FSub($1, $3) }
| exp AST_DOT exp
    { FMul($1, $3) }
| exp SLASH_DOT exp
    { FMul($1, FInv($3)) }
| LET IDENT EQUAL exp IN exp
    %prec prec_let
    { Let(addtyp $2, $4, $6) }
| LET REC fundef IN exp
    %prec prec_let
    { LetRec($3, $5) }
| exp actual_args
    %prec prec_app
    { App($1, $2) }
| elems
    { Tuple($1) }
| LET LPAREN pat RPAREN EQUAL exp IN exp
    { LetTuple($3, $6, $8) }
| simple_exp DOT LPAREN exp RPAREN LESS_MINUS exp
    { Put($1, $4, $7) }
| exp SEMICOLON exp
    { Let((Id.gentmp Type.Unit, Type.Unit), $1, $3) }
| exp SEMICOLON
    { $1 }
| ARRAY_CREATE simple_exp simple_exp
    %prec prec_app
    { Array($2, $3) }
| FUNC actual_args
    %prec prec_app
    { App(Var($1), $2) }
| error
    { failwith
        (Printf.sprintf "parse error from l:%d c:%d to l:%d c:%d "
           (Parsing.symbol_start_pos ()).pos_lnum 
           (Parsing.symbol_start_pos ()).pos_cnum 
           (Parsing.symbol_end_pos ()).pos_lnum 
           (Parsing.symbol_end_pos ()).pos_cnum 
        )}

fundef:
| IDENT formal_args EQUAL exp
    { { name = addtyp $1; args = $2; body = $4 } }

formal_args:
| IDENT formal_args
    { addtyp $1 :: $2 }
| IDENT
    { [addtyp $1] }

actual_args:
| actual_args simple_exp
    %prec prec_app
    { $1 @ [$2] }
| simple_exp
    %prec prec_app
    { [$1] }

elems:
| elems COMMA exp
    { $1 @ [$3] }
| exp COMMA exp
    { [$1; $3] }

pat:
| pat COMMA IDENT
    { $1 @ [addtyp $3] }
| IDENT COMMA IDENT
    { [addtyp $1; addtyp $3] }
