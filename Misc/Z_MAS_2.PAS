program ocenki;
uses crt;
var fam:array[1..30] of string;
    oz:array[1..30] of integer;
    s,k,i,n:integer;
    c:real;
BEGIN
  clrscr;
  write('Введите кол-во учащихся ');readln(n);
  for i:=1 to n do
  begin
   write('Введите оценку и фамилию ',i,'-го учащегося ');
   readln(oz[i],fam[i]);
  end;
  for i:=1 to n do s:=s+oz[i];
  c:=s/n;
  k:=0;
  for i:=1 to n do
   if oz[i]>c then
    begin
     writeln(fam[i]);
     k:=k+1;
     end;
      writeln('Кол-во ',k);
  readln
  END.
