program Postavka;
  uses Crt;
  var
     i,N : integer;
     A : string[17];
     Tmin : array[1..100] of real;

  BEGIN
    ClrScr;
    write('введите количество лет ');readln(N);
    for i:=1 to N do
      begin
        write('введите min.температуру за ',i,'-й год ');readln(Tmin[i]);
      end;
    A:='можно поставлять';
    for i:=1 to N do if Tmin[i]<-39.4 then
                                        begin A:='нельзя поставлять';
                                              i:=N end;
    writeln(A);
    readln
  END.