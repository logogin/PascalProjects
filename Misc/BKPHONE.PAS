Program BookPhone;
  uses Crt;
  label 1,2;
  Type
    StFio =string[10];
    StPhone=string[10];
    Rec_Book=record      {запись для файла}
               Fio:StFio;
               Phone:StPhone;
             end;
  Var
    BookFile:file of Rec_Book; {переменная для файла с записями Rec_Book}
    Work:Rec_Book;             {переменная для доступа к записи}
    Ind:integer;str:string;
  Procedure Output_Rec;        {вывод текущей записи на экран}
    begin
      read(BookFile,Work);
      with Work do
        writeln('ФИО:',Fio,' телефон: ',Phone);
    end;
  Procedure Output_All_Rec;    {вывод всех записей на экран}
    begin
      Seek(BookFile,0); { установка на первую логическую запись файла}
      writeln('*** Вывод телефонного справочника на экран');
      while (not Eof(BookFile)) do Output_Rec;
    end;
  Procedure Add_Rec;           {считывает с клавиатуры и добавляет запись в }
    begin                      { файл}
      writeln('*** ввод новой записи ***');
      with Work do begin
        write('Введите фамилию: ');readln(Fio);{ ввод фамилии}
        write('Введите номер телефона: ');readln(Phone);{ ввод номера телефона}
        write(BookFile,Work);
      end;
    end;
  Procedure Update_Rec(Nom_Rec : Longint);
    begin                      {изменяет запись файла по номеру}
      Seek(BookFile,Nom_Rec);{установка файловой позиции по номеру}
      writeln('-- старое значение записи --');
      Output_Rec;            {вывод записи и перевод файловой позиции на}
                             {следующую запись}
      Seek(BookFile,Nom_Rec);{возврат на прежнюю позицию}
      writeln('-- новое значение --');Add_Rec;{ввод измененного значения записи}
    end;
  BEGIN
    Assign(BookFile,'Phone.dat');{ создается новый файл с именем Phone.dat}
    rewrite(BookFile); { создает и открывает новый файл }
    ClrScr;writeln('Создание 5 записей файла Phone.dat ');
    for Ind:=1 to 5 do Add_Rec;{создаются 5 записей с клавиатуры}
    write('Создание записей завершено .Нажмите клавишу <Enter>');readln;
1:    Output_All_Rec;
    write('введите номер изменяемой записи ');readln(Ind);
    if Ind<=0 then goto 1;
    Ind:=Ind-1; { нумерация логических записей файла начинается с нуля}
    Update_Rec(Ind);
    write('Для продолжения нажмите клавишу <Enter>');readln;
2:    Output_All_Rec; { вывод измененного файла на екран }
    write('продолжить изменения (Y-да,N-нет) ? ');readln(str);
    if ((str='Y') or (str='y')) then goto 1;
    if ((str<>'N') and (str<>'n')) then goto 2;
    close(Bookfile); { закрыть файл }
  END. { BookPhone }

