program Gurtojitok;
  uses Crt;
  label 1;
  var
     i,N : integer;
     A:string[20];
     Komnata: array[1..500] of string[3];
     Fio : array[1..500] of string[40];
     Name:string[40];

  BEGIN
    ClrScr;
    write('введите количество жильцов ');readln(N);
    for i:=1 to N do
      begin
        write('введите Ф.И.О. ',i,'-го жильца ');readln(Fio[i]);
        write('                 номер комнаты ');readln(Komnata[i])
      end;
 1:   write('введите Ф.И.О. ');readln(Name);
    A:='такого жильца нет';
    for i:=1 to N do if Name=Fio[i] then
                                        begin A:='номер комнаты '+Komnata[i];
                                              i:=N end;
    writeln(A);
    readln;goto 1
  END.