 {ЗАДАЧА МНОЖЕСТВО}
PROGRAM MNOJG;
 Uses Crt;
 TYPE charset= set of 'A'..'Z';
 VAR {n:integer; }
 c:array[1..40] of char;
     a:string[200];
     s:charset;
     d:char;
     n,i,x:integer;
BEGIN
 ClrScr;
 writeln('Введите 10 слов записаных лат. алфавит ');
 for i:=1 to 10 do
  begin
  readln(c[i]);
  end;
 x:=0;
 for i:=1 to length(c[i]) do
  begin
  if c[i] in ['A','E','I','O','U'] then x:=x+1;
  end;
 writeln('cvbc=',x);
 readln
END.



