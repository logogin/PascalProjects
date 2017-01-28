Program BookPhone;
  uses Crt;
  label 1,2,3,4,5;
  Type
    maswind=array[1..25] of string[160];
    StFio =string;
    StPhone=string;
    StAdress=string;
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
    ch:char;
    n:integer;
    p:pointer;
  { Процедура считывания области экрана }
  Procedure Readwind(xw1,yw1,xw2,yw2:byte;var source:pointer);
   var i:byte;
     offs:word;
   begin
    offs:=(yw1-1)*160+xw1*2-2;
    for i:=1 to (yw2-yw1+1) do
      begin
        move(memw[$b000:offs],maswind(source^)[i],(xw2-xw1)*2+2);
        offs:=offs+160
      end;
   end;
  { Процедура востоновки области экрана }
  Procedure Retwind(xw1,yw1,xw2,yw2:byte;var source:pointer);
   var i:byte;
      offs:word;
   begin
    offs:=(yw1-1)*160+xw1*2-2;
    for i:=1 to (yw2-yw1+1) do
     begin
       move(maswind(source^)[i], memw[$b000:offs],(xw2-xw1)*2+2);
       offs:=offs+160
     end
   end;
  { Процедура рисования рамки }
  Procedure Frame(x1,y1,x2,y2:integer;st:string);
   var i:integer;
   begin
    gotoxy(x1,y1);write(#201,st);
    for i:=(x1+length(st)) to (x2-2) do write(#205);
    write(#187);
   for i:=(y1+1) to (y2-1) do
    begin
      gotoxy(x1,i);write(#186);
      gotoxy(x2,i);write(#186)
    end;
   gotoxy(x1,y2);write(#200);
    for i:=(x1+1) to (x2-1) do write(#205);
      write(#188);
    for i:=(x1+1) to (x2-1) do
      begin
       gotoxy(i,y1+1);write(#176);
       gotoxy(i,y2-1);write(#176)
      end;
   end;
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
  Procedure View_Proc;
    var count:word;
    begin
      ClrScr;reset(TextFile);
      count:=1;
      repeat
         seek(TextFile,count);
         read(TextFile,Work);
         with Work do
           begin
            writeln(Fio);writeln(Phone);writeln
           end;
         delay(1000);
         count:=count+1
      until EOF(TextFile);
      close(TextFile)
    end;
BEGIN
    Assign(TextFile,'Phone.txt');
    ClrScr;
    frame(1,1,80,24,'Phone.DAT');
    gotoxy(1,25);
    write('    F1-Help     F2-View     F3-Save     F5-Edit     F10-Quit  ');
    window(2,3,79,22);
    writeln('                    ПРОГРАММА СОЗДАНИЯ ЗАПИСЕЙ ФАЙЛА Phone.dat');
    writeln('                   --------------------------------------------');
    repeat
      ch:=readkey;if ch=#0 then ch:=readkey;
      case ch of
       #60: View_Proc;
       #64: begin
                  writeln(' ');write('Введите количество записей  ');readln(n);
                  rewrite(TextFile);
                  for Ind:=1 to n do Add_Rec;{создаются записи с клавиатуры}
            end;
      end;
    until ch=#68;

    ClrScr;
    writeln('                           ВВОД ЗАПИСЕЙ');
    writeln('                          --------------');

    write('Создание записей завершено .Нажмите клавишу <Enter>');readln;
    ClrScr;
 1:   Output_All_Rec;
 5: write('редактировать записи (Y-да,N-нет) ?  ');readln(k);
    if ((k='Y') or (k='y')) then goto 3;
    if ((k='N') or (k='n')) then goto 4;
    if (((k<>'Y') or (k<>'y')) and ((k<>'N') or (k<>'n'))) then goto 5;
 3: write('введите номер изменяемой записи ');readln(Ind);
    if Ind<=0 then goto 1;
    Ind:=Ind-1; { нумерация логических записей файла начинается с нуля}
    Update_Rec(Ind);
 4: write('Для продолжения нажмите клавишу <Enter>');readln;
    ClrScr;
      Output_All_Rec; { вывод измененного файла на екран }
 2: write('продолжить изменения (Y-да,N-нет) ?  ');readln(str);
    if ((str='Y') or (str='y')) then goto 1;
    if ((str<>'N') and (str<>'n')) then goto 2;
    close(Textfile); { закрыть файл }
END. { BookPhone }
