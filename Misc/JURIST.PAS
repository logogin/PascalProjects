Program Jurist;
  uses Crt;
  label 1,2;
  Type
    Num_Glava =byte;
    Num_State =byte;
    Txt_stroka=string[70];
    Rec_File=record      {запись для файла}
             Glava:Num_Glava;
             State:Num_State;
             Txt  :Txt_stroka;
            end;
    RecPtr=^Rec_Spiska;
    Rec_Spiska=record    {запись для связанного списка }
                 RecFile:Rec_File;
                 next:RecPtr;
                 prev:RecPtr;
               end;
  Var
    ZakonFile:file of Rec_File; {переменная для файла с записями Rec_Str}
    Work:Rec_File; {переменная для доступа к записи}
    FirstRec,Previos,Current,NextRec:RecPtr;
    Ind:integer;
    str:string;
    CH:char;

  procedure EnterStroka; { вводит данные для формирования записи }
    begin
      With Current^ do with RecFile do
        begin
          ClrScr;
          write('введите номер главы ');readln(Glava);
          write('  Введите номер статьи: ');readln(State);{ ввод номера статьи}
          write('Введите текст строки: ');readln(Txt);{ ввод текста строки}
        end;
    end;
  procedure NewStroka; { добавить новую запись в список }
    begin
      if FirstRec= Nil
       then begin New(Current);EnterStroka;
                  FirstRec:=Current;  { установка начальной записи }
                  Previos:=Current;
                  Current^.prev:=FirstRec;
                  Current^.next:=Nil end { следующей записи нет }
       else begin Previos:=Current;
                  New(Current);EnterStroka;
                  Previos^.next:=Current;{ установка следования записей }
                  Current^.prev:=Previos;
                  Current^.next:=Nil end; { следующей записи нет }
    end;
  Procedure Write_Rec(Nom_Rec:integer);    {вывод записи Nom_Rec на экран}
    var i:integer;
    begin
      Current:=FirstRec;
      for i:=1 to Nom_Rec-1 do Current:=Current^.next;
      with Current^ do with RecFile do
        begin
          writeln('глава- ',Glava,'статья- ',State);
          writeln(Txt)
        end;
    end;
  Procedure Write_All_Rec;    {вывод всех записей на экран}
    var i:integer;
    begin
      clrscr;
      Current:=FirstRec;i:=1;
      while Current<>Nil do
        begin
          writeln(i,' ',Current^.RecFile.Txt);
          Current:=Current^.next;
          i:=i+1
        end;
        CH:=readkey;
    end;

  procedure Add_FileRec_Spisok; { добавить новую запись из файла в список }
    begin
          Previos:=Current;
          new(Current);
          read(ZakonFile,Current^.RecFile);
          Previos^.next:=Current;
          Current^.next:=Nil;
    end;

  procedure Load_File;
    begin
     Assign(ZakonFile,'Zakon.dat');{ файлу Zakon.dat назначается ZakonFile }
     reset(ZakonFile);             { открывает существующий файл }
      Seek(ZakonFile,0); { установка на первую логическую запись файла}
      new(Current);
      read(ZakonFile,Current^.RecFile);
      FirstRec:=Current;
      Previos:=Current;
      Current^.next:=Nil;
      while (not Eof(ZakonFile)) do Add_FileRec_Spisok;
     close(ZakonFile)
    end;
  procedure Save_File;
    begin
      Assign(ZakonFile,'Zakon.dat');{ назначается файловая переменная }
                                    { ZakonFile файлу с именем Zakon.dat}
      rewrite(ZakonFile); { создает и открывает новый файл }
      Current:=FirstRec;
      while Current<>Nil do
        begin
          with Current^ do
          write(ZakonFile,RecFile);
          Current:=Current^.next
        end;
      close(ZakonFile); { закрыть файл }
    end;
  procedure Ins_Rec(Nom_Rec:integer);
    var i:integer;
    begin
      Current:=FirstRec;
      if Nom_Rec>1 then for i:=1 to Nom_Rec-1 do Current:=Current^.next;
      Previos:=Current^.prev;
      NextRec:=Current;
      new(Current);EnterStroka;
      Current^.prev:=Previos;
      Current^.next:=NextRec;
      Previos^.next:=Current;
      NextRec^.prev:=Current;
    end;
  procedure Zam_Rec(Nom_Rec:integer);
    var i:integer;
    begin
      Current:=FirstRec;
      if Nom_Rec>1 then for i:=1 to Nom_Rec-1 do Current:=Current^.next;
      EnterStroka
    end;
  procedure Del_Rec(Nom_Rec:integer);
    var i:integer;
    begin
      Current:=FirstRec;
      if Nom_Rec>1 then for i:=1 to Nom_Rec-1 do Current:=Current^.next;
      Previos:=Current^.prev;
      NextRec:=Current^.next;
      NextRec^.prev:=Previos;
      Previos^.next:=NextRec;
    end;

  BEGIN
    FirstRec:=Nil;
    repeat
      ClrScr;gotoXY(1,24);
      writeln('(С)ледующая строка,(Ч)итать строки,(В)ыход');
      writeln('L-считать файл с диска');
      writeln('S-сохранить файл на диске');
      writeln('I-вставить строку');
      writeln('Z-заменить строку');
      writeln('D-удалить строку');
      repeat
        CH:=readkey; { чтение нужного символа с клавиатуры }
      until CH in ['С','с','Ч','ч','В','в','L','S','I','Z','D'];
      case CH of
        'С','с': NewStroka;
        'Ч','ч': Write_All_Rec;
        'L'    : Load_File;
        'S'    : Save_File;
        'I'    : begin Write_All_Rec;
                       Write('номер строки ? ');readln(Ind);
                       Ins_Rec(Ind)
                 end;
        'Z'    : begin Write_All_Rec;
                       Write('номер строки ? ');readln(Ind);
                       Zam_Rec(Ind)
                 end;
        'D'    : begin Write_All_Rec;
                       Write('номер строки ? ');readln(Ind);
                       Del_Rec(Ind)
                 end;
      end;
    until CH in ['В','в'];
    clrscr;
  END.  { Jurist }


