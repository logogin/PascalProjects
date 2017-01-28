PROGRAM zadaha2;
 uses Crt;
var x,y,y1,y2,a:real;
 BEGIN
clrscr;
writeln('Возведение числа A в степень X: ');
writeln('------------------------------');
write('Введите знач. переменной a '); readln(a);
write('Введите знач. переменной x '); readln(x);
y:=exp(x);
y1:=ln(x);
y2:=exp(x*ln(a));
writeln('y=exp(x)=',y);
writeln('y1=ln(x)=',y1);
writeln('y2=A^X=',y1);
readln
 END.









