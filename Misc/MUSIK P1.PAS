PROGRAM  musik;
uses crt;
Const
M:array[1..15] of integer=(262,294,
     330,349,392,440,494,523,567,625,678,657,795,23,59);
Var
  I:integer;
    ch:char;
Begin
clrscr ;
  while True do
 begin
  ch:=readkey;
  case ch of
  #49:I:=1;
  #50:I:=2;
  #51:I:=3;
  #52:I:=4;
  #53:I:=5;
  #54:I:=6;
  #55:I:=7;
  #56:I:=8;
  #57:I:=9;
  #58:I:=56;
  #59:I:=43;
  #60:I:=45;
  #61:I:=34;
  #48:Halt;
  else write('К.зв.не наз.Пов.')
 end;
  sound(M[I]);
  delay(200);
  nosound
 end
END.






































































































