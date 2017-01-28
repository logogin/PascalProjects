Program BookPhone;
  uses Crt;
  label 1,2,3,4;
  Type
    StFio =string[249];
    StPhone=string[249];
    StAdress=string[249];
    Rec_Book=record      {запись для файла}
               Fio:StFio;
               Phone:StPhone;
               Adress:StAdress;
             end;
  Var
    TextFile:file of Rec_Book; {переменная для файла с записями Rec_Book}
    Work:Rec_Book;             {переменная для доступа к записи}
    Ind:integer;
    str,k:string;
    n:integer;
  Procedure Output_Rec;        {вывод текущей записи на экран}
    begin
      read(TextFile,Work);
      with Work do
        writeln('  Ф.И.О:   ',Fio,'  телефон:   ',Phone);
    end;
  Procedure Output_All_Rec;    {вывод всех записей на экран}
    begin
      Seek(TextFile,0); { установка на первую логическую запись файла}
      writeln(' ');
      writeln(' Вывод телефонного справочника на экран');
      while (not Eof(TextFile)) do Output_Rec;
    end;
  Procedure Add_Rec;      {считывает с клавиатуры и добавляет запись в файл}
    begin
      writeln(' ');
      writeln('*** ввод новой записи ***');{writeln(' ');}
      with Work do begin
        write('Введите Ф.И.О. ');readln(Fio);{ ввод фамилии}
        write('Введите номер телефона: ');readln(Phone);{ ввод номера телефона}
        write(TextFile,Work);
      end;
    end;
  Procedure Update_Rec(Nom_Rec : Longint);
    begin                      {изменяет запись файла по номеру}
      Seek(TextFile,Nom_Rec);{установка файловой позиции по номеру}
      writeln('-- старое значение записи --');
      Output_Rec;            {вывод записи и перевод файловой позиции на}
                             {следующую запись}
      Seek(TextFile,Nom_Rec);{возврат на прежнюю позицию}
      writeln('-- новое значение --');Add_Rec;{ввод измененного значения записи}
    end;
  BEGIN

    Assign(TextFile,'Phone.txt');{ создается новый файл с именем Phone.dat}
    rewrite(TextFile); { создает и открывает новый файл }
    ClrScr;
    gotoxy(1,25);
    write('    F1-Help  F2-View  F3-Save  F5-Edit  F10-Quit  ');
    gotoxy(1,1);
    writeln('                    ПРОГРАММА СОЗДАНИЯ ЗАПИСЕЙ ФАЙЛА Phone.dat');
    writeln('                   --------------------------------------------');
    writeln(' ');write('Введите количество записей  ');readln(n);
    ClrScr;
    writeln('                           ВВОД ЗАПИСЕЙ');
    writeln('                          --------------');
    for Ind:=1 to n do Add_Rec;{создаются записи с клавиатуры}
    write('Создание записей завершено .Нажмите клавишу <Enter>');readln;
    ClrScr;
 1:   Output_All_Rec;
    write('редактировать записи (Y-да,N-нет) ?  ');readln(k);
    if ((k='Y') or (k='y')) then goto 3;
    if ((k='N') or (k='n')) then goto 4;
 3: write('введите номер изменяемой записи ');readln(Ind);
    if Ind<=0 then goto 1;
    Ind:=Ind-1; { нумерация логических записей файла начинается с нуля}
    Update_Rec(Ind);
 4: write('Для продолжения нажмите клавишу <Enter>');readln;
      Output_All_Rec; { вывод измененного файла на екран }
 2: write('продолжить изменения (Y-да,N-нет) ?  ');readln(str);
    if ((str='Y') or (str='y')) then goto 1;
    if ((str<>'N') and (str<>'n')) then goto 2;
    close(Textfile); { закрыть файл }
END. { BookPhone }
