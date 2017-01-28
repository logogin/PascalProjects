program Biblioteka;
  uses Crt;
  label 1;
  var
     i,N : integer;
     A:string[20];
     Polka: array[1..500] of string[3];
     Nazvanie : array[1..500] of string[100];
     Name:string[100];

  BEGIN
    ClrScr;
    write('введите количество книг ');readln(N);
    for i:=1 to N do
      begin
        write('введите название ',i,'-й книги ');readln(Nazvanie[i]);
        write('                   номер полки ');readln(Polka[i])
      end;
 1:   write('введите название книги ');readln(Name);
    A:='такой книги нет';
    for i:=1 to N do if Name=Nazvanie[i] then
                                         begin A:='номер полки '+Polka[i];
                                              i:=N end;
    writeln(A);
    readln;goto 1
  END.