{$M 16384,0,65536}
uses crt,dos;
const
	 Send: array[1..6] of byte = ($FF, $12, $34, $56, $78, $19);
	 ComReg: Array[1..2, 1..7] of Word =
(($3F8, $3F9, $3FA, $3FB, $3FC, $3FD, $3FE),
 ($2F8, $2F9, $2FA, $2FB, $2FC, $2FD, $2FE));

var
         f1,f2:text;
         k,ch:char;
	 com,n:byte;
	 flag,ff,f4,f3:boolean;
	 koma,size:byte;
	 m:integer;
	 st:string[6];
         i:longint;
procedure printing;
 begin
    writeln;
    write('Do you want to print file DOK'+st+'.TXT ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');
    normvideo;write(') : ');
    if upcase(readkey)='Y' then
    begin writeln('Y');
     writeln('Вывод на печать файла DOK'+st+'.TXT');
      writeln('Please wait . . .');
      Exec(GetEnv('COMSPEC'), '/c copy DOK'+st+'.TXT prn');
    end else writeln('N');
 end;
procedure help;
 var i,y:byte;
 begin
 if wherey<=14 then
 begin
 writeln;
 y:=wherey;
 window(1,wherey,80,25);
 writeln(' - Help -' :30);
 highvideo; write(' F1 ');normvideo;
 writeln(' - Помощь.');
 highvideo; write(' F3 ');normvideo;
 writeln(' - Начать измерения с занесением данных протокол.');
 highvideo; write(' F4 ');normvideo;
 writeln(' - Форматирование протокола (разбивка на страницы).');
 highvideo; write(' F5 ');normvideo;
 writeln(' - Вывод протокола на печать.');
 highvideo; write(' F6 ');normvideo;
 writeln(' - Прекратить измерения начатые по нажатию клавиши <F3> или <F10>.');
 highvideo; write(' F10 ');normvideo;
 writeln('- Начать измерения без занесения данных в протокол.');
 highvideo; write(' Esc ');normvideo;
 writeln('- Выход из программы.');
 write('Press any key.':21);
 readkey;
 clrscr;
 window(1,1,80,25);
 gotoxy(1,y-1);
 end else begin
 y:=wherey;
 for i:=1 to (wherey-16)+1 do writeln;
 window(1,15,80,25);
 writeln(' - Help -' :30);
 highvideo; write(' F1 ');normvideo;
 writeln(' - Помощь.');
 highvideo; write(' F3 ');normvideo;
 writeln(' - Начать измерения с занесением данных протокол.');
 highvideo; write(' F4 ');normvideo;
 writeln(' - Форматирование протокола (разбивка на страницы).');
 highvideo; write(' F5 ');normvideo;
 writeln(' - Вывод протокола на печать.');
 highvideo; write(' F6 ');normvideo;
 writeln(' - Прекратить измерения начатые по нажатию клавиши <F3> или <F10>.');
 highvideo; write(' F10 ');normvideo;
 writeln('- Начать измерения без занесения данных в протокол.');
 highvideo; write(' Esc ');normvideo;
 writeln('- Выход из программы.');
 write('Press any key.':21);
 readkey;
 clrscr;
 window(1,1,80,25);
 gotoxy(1,y);
 end;
 end;
procedure instal_com;
 var
 x: byte;
 begin
  port[ComReg[com, 4]]:=$bf;
  delay(100);
  port[ComReg[com, 1]]:=12;
  port[ComReg[com, 2]]:=0;
  port[ComReg[com, 4]]:=$3f;
  delay(100);
  port[ComReg[com, 2]]:=$0;
  delay(100);
  while ((port[ComReg[com, 6]] and $01) <> 0) do
	 x := Port[ComReg[com, 1]];
 end;

 {function readingport(var kom,siz:byte):longint;
  var result:longint;
		dat:byte;
	begin
	  result:=0;
 	  dat:=0;
    	  while ((port[ComReg[com, 6]] and $01) = 0)
			or (port[ComReg[com, 1]]<>$00) do;
	  while ((port[ComReg[com, 6]] and $01) = 0) do;
	  dat:= not port[ComReg[com, 1]];
	  result:=result+ (byte(dat shr 4)*longint(10)) + ((byte(dat shl 4)) shr 4);
	  while ((port[ComReg[com, 6]] and $01) = 0) do;
	  dat:= not port[ComReg[com, 1]];
	  result:=result+ (byte(dat shr 4)*longint(1000)) + ((byte(dat shl 4)) shr 4)*longint(100);
	  while ((port[ComReg[com, 6]] and $01) = 0) do;
	  dat:= not port[ComReg[com, 1]];
	  result:=result+ (byte(dat shr 4)*longint(100000)) + ((byte(dat shl 4)) shr 4)*longint(10000);
	  while ((port[ComReg[com, 6]] and $01) = 0) do;
	  dat:= not port[ComReg[com, 1]];
	  result:=result+ (byte(dat shr 4)*longint(10000000)) + ((byte(dat shl 4)) shr 4)*longint(1000000);
	  while ((port[ComReg[com, 6]] and $01) = 0) do;
	  dat:= not port[ComReg[com, 1]];
	  kom:=byte(dat shr 3);
	  siz:=((byte(dat shl 5)) shr 5);
	  readingport := result;
	 end; }

function leadingzero(w:word):string;
var s:string;
begin
  Str(w,s);
  if Length(s) = 1 then
	 s := '0' + s;
  LeadingZero := s;
end;
procedure time;
var h, m, s, hund : Word;
 begin
	GetTime(h,m,s,hund);
	Write(f1,LeadingZero(h),':',LeadingZero(m),':',LeadingZero(s),
			 '.',LeadingZero(hund));
 end;
  function search:boolean;
  var s,st:string;
   begin
    getdir(0,st);
    S := FSearch('ADAPTER2.CFG',st);
    if S = '' then
    begin
    search:=false;
    writeln;
    WriteLn('File ADAPTER2.CFG not found') end
    else begin search:=true; writeln;
  WriteLn('File ADAPTER2.CFG found as ',FExpand(S));
  writeln; end;
  end;
 procedure free;
 var f: file of char;
  begin
  assign(f,'dok'+st+'.txt');
  reset(f);
  if filesize(f)>=(DISKFREE(0) div 2) then begin
  writeln('File DOK'+st+'.TXT is more than ',diskfree(0) div 2,' bytes.');
  writeln('If you do not move file DOK'+st+'.TXT in other directory,');
  writeln('you can LOST file DOK'+st+'.TXT ,');
  end;
  close(f);
  end;

 procedure change;
 var f:file of integer;
 s:string;
 n,c:integer;
 flag:boolean;
  begin
 flag:=false;
 repeat
  writeln;
  write('Enter new number of the last dokument : ');readln(s);
  if byte(s[0])>5 then  begin flag:=false; writeln; writeln('Invalid number.'); end
  else begin
  val(s,n,c);
  if c<>0 then begin flag:=false;writeln('Invalid number.'); writeln end else
  begin
  writeln(' Ok');
  writeln;
  assign(f,'adapter2.cfg');
  rewrite(f);
  write(f,n);
  close(f);
  flag:=true;
   end;
   end;
   until flag;
  end;
 procedure new_number;
  var flag:boolean;
 begin
 flag:=false;

  repeat
    if search then exit else
                          begin
                            writeln('ВНИМАНИЕ : При вводе номера последнего документа');
writeln('             данные могут быть ПОТЕРЯНЫ !!!');
writeln('Поэтому проверьте правильность номера и предварительно');
writeln('сохраните файлы с протоколами в другом каталоге или диске');

                            writeln;
                            write('Do you want to change the number of the last dokument ? (');highvideo;write('Y');normvideo;
                            write('/');highvideo;
                            write('N');normvideo;write(') : ');
                            if upcase(readkey)='Y' then
                                                      begin
                                                        writeln('Y');
                                                        change;
                                                        flag:=true
                                                       end
                                                    else
                                                      begin
                                                        writeln('N');
                                                        flag:=false
                                                      end;
                          end;
  until flag;
 end;



procedure date;
var
	y, m, d, dow : Word;
begin
	GetDate(y,m,d,dow);
	Write(f1,leadingzero(m),'/',leadingzero(d),'/',leadingzero(y));
end;

 procedure end_protokol1;
 begin
 writeln(f1,'└──────────┴─────────────┴───────────┴───────────┴──────────┘');
 writeln(f1);
 writeln(f1,'                     Испытатель');
 writeln(f1,'                     Представитель ОТК');
 writeln(f1);
 writeln(f1,'              имя файла в базе данных DOK'+st+'.TXT');
 writeln(f1);
 end;
procedure end_protokol2;
 begin
 writeln(f2,'└──────────┴─────────────┴───────────┴───────────┴──────────┘');
 writeln(f2);
 writeln(f2,'     Испытатель');
 writeln(f2,'     Представитель ОТК');
 writeln(f2);
 writeln(f2,'     имя файла в базе данных DOK'+st+'.TXT');
 writeln(f2);
 end;
  function readingport(var kom,siz:byte):longint;
  begin
  readingport:=87654321;
  kom:=98;
  siz:=78;
  end;
  procedure ending(stors:longint);
  begin
 writeln(f2,'└──────────┴─────────────┴───────────┴───────────┴──────────┘');
 writeln(f2);
 writeln(f2);
 writeln(f2,'-':30,stors,'-');
 writeln(f2,'┌──────────┬─────────────┬───────────┬───────────┬──────────┐');
 writeln(f2,'│     1    │      2      │     3     │     4     │     5    │');
 writeln(f2,'├──────────┼─────────────┼───────────┼───────────┼──────────┤');
 end;
procedure head;
 begin
 writeln(f1);
 writeln(f1);
 writeln(f1,'                     Протокол № ',st);
 writeln(f1);
 writeln(f1,'                     Испытания изедлия ___________________');
 writeln(f1);
 write(f1,'                     Дата испытаний ');date;
 writeln(f1);
 writeln(f1,'┌──────────┬─────────────┬───────────┬───────────┬──────────┐');
 writeln(f1,'│    №     │    Время    │ Показания │ Значение  │ Примеча- │');
 writeln(f1,'│          │             │  частото- │ параметра │          │');
 writeln(f1,'│ проверки │  испытания  │ мера, сек │   м/сек   │   ния    │');
 writeln(f1,'├──────────┼─────────────┼───────────┼───────────┼──────────┤');
 writeln(f1,'│     1    │      2      │     3     │     4     │     5    │');
 writeln(f1,'├──────────┼─────────────┼───────────┼───────────┼──────────┤');
 end;
 procedure telo;

begin

if f4=false then begin
   i:=0;
   assign(f1,'dok'+st+'.txt'); rewrite(f1); head; f4:=true;
   i:=i+1;
  write(f1,'│ ');write(f1,i:8,' │');write(f1,' ');time;write(f1,' │');write(f1,' ',readingport(koma,size):9,' │');
  write(f1,' ',koma:9,' │');
  writeln(f1,size:9,' │');  end else begin
  i:=i+1;
  write(f1,'│ ');write(f1,i:8,' │');write(f1,' ');time;write(f1,' │');write(f1,' ',readingport(koma,size):9,' │');
  write(f1,' ',koma:9,' │');
  writeln(f1,size:9,' │'); end;
end;
 procedure formating;
 var i1,l:longint;
  s:string;
  begin
 close(f1);
 assign(f1,'dok'+st+'.txt');
 reset(f1);
 assign(f2,'dok'+st+'.bak');
 rewrite(f2);
 if ff=true then ff:=false;
 i1:=1;
 l := 0;
 while not eof(f1) do
 begin
 readln(f1,s);
 writeln(f2,s);
 l:=l+1;
 if l=60 then begin  i1:=i1+1; ending(i1); l:=0  end;
  end;
 close(f1);
 erase(f1);
 end_protokol2;
 close(f2);
 rename(f2,'dok'+st+'.txt');
 end;
 procedure format;
  begin
    writeln;
    write('Do you want to format file DOK'+st+'.TXT ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');
    normvideo;write(') : ');
    if upcase(readkey)='Y' then
    begin writeln('Y');
     writeln('Форматирование файла DOK'+st+'.TXT');
      writeln('Please wait . . .');
      formating;
      writeln(' Ok');
    end else writeln('N');
 end;
 procedure write_f;
  var  flag:boolean;
  begin
    flag:=true;
    writeln;
    write('Do you want to start ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');normvideo;write(') : ');
    if upcase(readkey)='Y' then
       begin
         writeln('Y');
         flag:=true;
         writeln('Измерение с записью в протокол');
           repeat
             if not keypressed then
                begin
                  writeln('Частота : ',readingport(koma,size), '  Запятая : ',koma:6,'   Размерность : ',size:4);
                  telo;
                 end
                               else
                                 if readkey=#64 then
                                    begin
                                      writeln;
                                      write('Do you want to interrupt ? (');
                                      highvideo;write('Y');normvideo;write('/');
                                      highvideo;write('N');normvideo;write(') : ');
                                      if upcase(readkey)='Y' then
                                         begin
                                           writeln('Y');
                                           flag:=false;
                                           writeln('Измерение прервано'); writeln;
                                          end                else
                                                               begin
                                                                 writeln('N');
                                                                 flag:=true
                                                               end;
                                    end;
           until flag=false;
        end                else
                             begin
                               writeln('N');
                               EXIT
                              end;
   end;
 procedure readnumber;
 var
  f: file of integer;
    n:integer;
  begin
  assign(f,'adapter2.cfg');
  reset(f);
  read(f,n);
  close(f);
  str(n,st);
  assign(f,'adapter2.cfg');
  rewrite(f);
  inc(n);
  WRITE(f,n);
  close(f);
  end;
 procedure write1;
  var  flag:boolean;
   begin
     flag:=true;
     writeln;
     write('Do you want to start ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');normvideo;write(') : ');
     if upcase(readkey)='Y' then
       begin
         writeln('Y');
         flag:=true;
         writeln('Измерение без записи в протокол');
         repeat
           if not keypressed then
             writeln('Частота : ',readingport(koma,size), '  Запятая : ',koma:6,'   Размерность : ',size:4)
                             else
                               if readkey=#64 then
                                  begin
                                    writeln;
                                    write('Do you want to interrupt ? (');highvideo;write('Y');
                                    normvideo;write('/');highvideo;write('N');
                                    normvideo;write(') : ');
                                    if upcase(readkey)='Y' then
                                       begin
                                         writeln('Y');
                                         flag:=false;
                                         writeln('Измерение прервано');
                                         writeln;
                                       end                 else
                                                             begin
                                                               writeln('N');
                                                               flag:=true;
                                                             end;
                                  end;
         until flag=false;
       end                 else
                             begin
                               writeln('N');
                               EXIT
                             end;
   end;
 procedure date_time;
  begin
        Exec(GetEnv('COMSPEC'), '/c date');
        Exec(GetEnv('COMSPEC'), '/c time');
  end;

procedure init;
var com_f:boolean;

 begin
 repeat
  write('Port COM1 ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');normvideo;write(') : ');
   if upcase(readkey)='Y' then
	 begin
         Writeln('Y');
	 com := 1;
	 instal_com;
	 com_f:=true
	 end
  else
	 begin  writeln('N');
		write('Port COM2 ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');normvideo;write(') : ');
		if upcase(readkey)='Y' then
		  begin
                  writeln('Y');
		  com := 2;
		  instal_com;
		  com_f:=true
		  end
		else
		  begin writeln('N'); writeln('Error of reading port.Repeat.'); writeln;
                  com_f:=false end;
	 end;
 until com_f;
end;

 procedure quit;
  begin
    writeln;
   write('Do you want to quit ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');normvideo;write(') : ');
   if upcase(readkey)='Y' then
    begin writeln('Y'); flag:=true; if f3=true then if ff=true then begin end_protokol1; close(f1) end    end  else
    begin
    writeln('N'); flag:=false  end;
   end;
BEGIN
 clrscr;
 ff:=true;
 f4:=false;
 flag:=false;
 init;
 date_time;
 new_number;
 readnumber;
 f3:=false;
 repeat
  ch:=readkey;
  if ch=#0 then ch:=readkey;
  case ch of
   #27       : quit;
   #61 {f3}  : begin f3:=true; if ff then write_f else begin
               writeln('File DOK'+st+'.TXT was formated. You do not change it.');
               writeln end  end;
   #62 {f4}  : begin if f3=true then if ff then format else begin
                 writeln('File DOK'+st+'.TXT was formated.');writeln end end;
   #68 {f10} : write1;
   #63 {f5}  : printing;
   #59 {f1}  : help;

  end;
until flag;
clrscr;
gotoxy(1,25);
highvideo;
writeln('Copyright (c) 1997,98 by D&D Company.');
normvideo;
writeln('Press any key');
readkey
END.
