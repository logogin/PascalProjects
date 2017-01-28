PROGRAM PAKETA;
USES CRT;
VAR A,B,D,F,G,C,E,H:REAL;
 BEGIN
  CLRSCR;
  WRITELN('                  PAKETA     ');
  WRITELN('Программа для вычисления длительности полета,дальности полета ');
  WRITELN('и тяги двигателя.');
  WRITELN('Введите кол-во топлива,т:');
  READ(A);
  WRITELN('Введите скорость сжигания топлива,кг/с:');
  READ(B);
  WRITELN('Введите скорость полета корабля,км/с:');
  READ(D);
  F:=A/B;G:=F*D;C:=B*D;
  WRITELN('Введите массу корабля,т');
  READ(E);
  IF H<=C THEN WRITELN('МАССА НОРМАЛЬНАЯ');
  WRITELN('Длительность полета-мин.',F);
  WRITELN('Дальность полета-',g);
  WRITELN('Тяга двигателя,т-',C);
  WRITELN('Масса,т-',e);
  WRITELN('конец программы');
  REPEAT UNTIL KEYPRESSED
 END.


