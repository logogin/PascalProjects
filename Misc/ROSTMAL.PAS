program RostMal;
  uses Crt;
  var
     i,N : byte;
     Rost : array[1..40] of real;
     Kod  : array[1..40] of char;
     Summa,SrRost_Mal: real;
     Chislo_Mal: byte;

  BEGIN
    ClrScr;
    write('введите количество учащихся ');readln(N);
    for i:=1 to N do
      begin
        write('введите рост ',i,'-го учащегося (см) ');readln(Rost[i]);
        write(' код (+.. девочка, -.. мальчик) ');readln(Kod[i]);
      end;
    Summa:=0;
    for i:=1 to N do if Kod[i]='-' then begin Summa:=Summa+Rost[i];
                                              Chislo_Mal:=Chislo_Mal+1 end;
    SrRost_Mal:=Summa/Chislo_Mal;
    writeln('средний рост мальчиков = ',SrRost_Mal,' см');
    readln
  END.