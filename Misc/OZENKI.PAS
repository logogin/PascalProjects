PROGRAM OZENKI;
Uses Crt;
 VAR fam:array[1..8] of string[30];
      oz:array[1..8] of integer;
       a,n,i:integer;
BEGIN
 ClrScr;
 writeln('Введите кол-во учеников ');readln(n);
 writeln('Введите фамилии и оценки учеников:');
FOR i:=1 to n do
  begin
   write('Фамилия ? '); read(fam[i]);
   write('Оценка - '); readln(oz[i]);
   writeln(n,'-ый  ');
  end;
 for i:=1 to n do
  begin
   if oz[i]=5 then writeln('Фамилия ученика имеющего 5 - ',fam[i]);
  end;
 readln;
END.

























