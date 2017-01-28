uses crt;
var
   n:integer;
  s1,s:string;
BEGIN
  clrscr;
  s1:='';
  s:='';
  port[$2fb]:=191;
  port[$2f8]:=12;
  port[$2f9]:=0;
  port[$2fb]:=63;
  port[$2f9]:=0;
 repeat
  n:=port[$2fd];
   repeat
    str(n mod 2,s);
    s1:=s+s1;
    n:=n div 2;
   until n=0;
  if s1[1]='1' then writeln(port[$2f8]);
  if s1[6]='1' then port[$2f8]:=15;
  s1:='';
 until keypressed;
  readln
END.
