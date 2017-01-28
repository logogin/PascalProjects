unit Screen;

interface

procedure SetAttrSymbol(x,y:byte; SymbCol,BackGr: byte);
procedure SetSymbol(x,y:byte; ch:char);
procedure SetFullSymbol(x,y:byte; ch:char; SymbCol,BackGr: byte);

implementation

Var Con: array[1..25,1..80,1..2] of byte absolute $B800:$0000;

procedure SetAttrSymbol(x,y:byte; SymbCol,BackGr: byte);
begin Con[y,x,2] := SymbCol+BackGr*16 end;

procedure SetSymbol(x,y:byte; ch:char);
begin Con[y,x,1] := byte(ch) end;

procedure SetFullSymbol(x,y:byte; ch:char; SymbCo