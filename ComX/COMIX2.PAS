uses crt;
var n:byte;
begin
clrscr;
port[$2fb]:=$bf;
port[$2f8]:=12;
port[$2f9]:=0;
port[$2fb]:=$3f;
port[$2f9]:=0;
repeat
n:=port[$2fd];
if (n and $01) <> 0 then writeln(port[$2f8]);
if (n and $20) <> 0 then port[$2f8]:=15;

until keypressed;
end.