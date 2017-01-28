PROGRAM PAS;
 uses Crt;
var dt,v,c,dt0:real;
 BEGIN
clrscr;
write('Введите знач. переменной dt0  '); readln(dt0);
write('Введите знач. переменной v    '); readln(v);
write('Введите знач. переменной c    '); readln(c);
if v=c then writeln('Функция не имеeт решения')
   else begin dt:=dt0/SQRT(1-SQR(v)/SQR(c));writeln('dt=',dt); end;
readln
 END.
