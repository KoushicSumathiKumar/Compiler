grammar SimpleLang;

prog : dec+ EOF;

dec
    : typed_idfr LParen (vardec+=typed_idfr(Comma vardec+=typed_idfr)*)? RParen body
;

typed_idfr
    : type Idfr
;

type
    : IntType | BoolType | UnitType
;

body
    : LBrace ene+=exp (Semicolon ene += exp)* RBrace
;

block
    : LBrace ene+=exp (Semicolon ene+=exp)* RBrace
;

exp
    : typed_idfr Assign exp                                 #AssignExpr
    | Idfr Assign exp                                       #ReassignExpr
    | LParen exp binop exp RParen                           #BinOpExpr
    | Idfr LParen (args+=exp (Comma args+=exp)*)? RParen    #InvokeExpr
    | block                                                 #BlockExpr
    | If exp Then block Else block                          #IfExpr
    | While exp Do block                                    #WhileExpr
    | Print exp                                             #PrintExpr
    | Space                                                 #SpaceExpr
    | Idfr                                                  #IdfrExpr
    | IntLit                                                #IntExpr
    | BoolLit                                               #BoolExpr
    | Repeat block Until exp                                #RepeatExpr
    | NewLine                                               #NewLineExpr
    | Skip                                                  #SkipExpr
;


binop
    : Eq              #EqBinop
    | Less            #LessBinop
    | LessEq          #LessEqBinop
    | More            #MoreBinop
    | MoreEq          #MoreEqBinop
    | Plus            #PlusBinop
    | Minus           #MinusBinop
    | Times           #TimesBinop
    | Divide          #DivideBinop
    | And             #AndBinop
    | Or              #OrBinop
    | Xor             #XorBinop
;

LParen : '(' ;
Comma : ',' ;
RParen : ')' ;
LBrace : '{' ;
Semicolon : ';' ;
RBrace : '}' ;
QMark : '?' ;

Eq : '==' ;
Less : '<' ;
LessEq : '<=' ;
More : '>';
MoreEq : '>=';

Plus : '+' ;
Times : '*' ;
Minus : '-' ;
Divide : '/';
And : '&';
Or : '|';
Xor : '^';


Assign : ':=' ;

Print : 'print' ;
Space : 'space' ;
NewLine : 'newline' ;
If : 'if' ;
Then : 'then' ;
Else : 'else' ;
Repeat : 'repeat';
Until : 'until';
Skip : 'skip';
Do : 'do';
While : 'while';

IntType : 'int' ;
BoolType : 'bool' ;
UnitType : 'unit' ;

BoolLit : 'true' | 'false' ;
IntLit : '0' | ('-'? [1-9][0-9]*) ;
Idfr : [a-z][A-Za-z0-9_]* ;
WS : [ \n\r\t]+ -> skip ;