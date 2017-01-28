program Osadki;
  uses Crt;
  var
     i,N : integer;
     sneg,dogd : real;
     osad,tem  : array[1..31] of real;

  BEGIN
    ClrScr;
    write('введите количество дней в месяце ');readln(N);
    for i:=1 to N do
      begin
        write('введите осадки за ',i,'-й день ');readln(osad[i]);
        write('                   температура ');readln(tem[i]);
      end;
    sneg:=0;dogd:=0;
    for i:=1 to N do if tem[i]>0 then dogd:=dogd+osad[i]
                                 else sneg:=sneg+osad[i];
    writeln('дождя ',dogd,' мм');
    writeln('снега ',sneg,' мм');
    readln
  END.