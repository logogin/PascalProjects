{$M 16384,0,65536}
uses crt,dos;
label m1;
const
	 Send: array[1..6] of byte = ($FF, $12, $34, $56, $78, $19);
	 ComReg: Array[1..2, 1..7] of Word =
(($3F8, $3F9, $3FA, $3FB, $3FC, $3FD, $3FE),
 ($2F8, $2F9, $2FA, $2FB, $2FC, $2FD, $2FE));

var
         f:text;
         ch:char;
	 com:byte;
	 f3,f_n,f_t,gend,flag:boolean;
	 koma,size:byte;
         resul:real;
	 m:integer;
	 st:string[6];
         i,l:longint;

{procedure help;
 var i,y:byte;
 begin
 y:=wherey;
 window(1,y,80,y+8);
 writeln(' - Помощь -' :30);
 highvideo; write(' F1 ');normvideo;
 writeln(' - Помощь.');
 highvideo; write(' F3 ');normvideo;
 writeln(' - Начать измерения с занесением данных в протокол.');
 highvideo; write(' F4 ');normvideo;
 writeln(' - Начать измерения без занесения данных в протокол.');
 highvideo; write(' F5 ');normvideo;
 writeln(' - Вывод протокола на печать.');
 highvideo; write(' F10 ');normvideo;
 writeln('- Прекратить измерения начатые по нажатию клавиши <F3> или <F4>.');
 highvideo; write(' Esc ');normvideo;
 writeln('- Выход из программы или прекращение ожидания последней');
 writeln('       информации с порта ( Возможна её ПОТЕРЯ ).');
 write('               Нажмите любую клавишу.');
 readkey;
 clrscr;
  window(1,1,80,25);
  gotoxy(1,y)
 end; }
procedure printing;
 begin
    writeln;
    write('Хотите ли Вы вывести на печать файл DOK'+st+'.TXT ? (');highvideo;write('Y');normvideo;write('/');
    highvideo;write('N');
    normvideo;write(') : ');
    if upcase(readkey)='Y' then
    begin writeln('Y');
     writeln('Вывод на печать файла DOK'+st+'.TXT');
      writeln('Пожалуйста ждите . . .');
      Exec(GetEnv('COMSPEC'), '/c copy DOK'+st+'.TXT prn');
    end else writeln('N');
 end;

procedure readconst;
var c:word;
    s1:string;
    flag:boolean;
 begin
 flag:=false;
 repeat
  write('Введите константу L (в метрах) : ');readln(s1);
  val(s1,l,c);
  if c<> 0 then begin writeln('Неверная константа.');writeln;flag:=false end else
  begin
   writeln(' Ok');
   flag:=true;
  end;
 until flag;
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
  repeat
  {while ((port[ComReg[com, 6]] and $01) <> 0) do
	 x := Port[ComReg[com, 1]];}
  until ((port[ComReg[com, 6]] and $01) <> 0) or (readkey=#27);
 end;
{  function readingport(var kom,siz:byte):real;
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
	  siz:=byte(dat shr 3);
	  kom:=((byte(dat shl 5)) shr 5);
	  readingport := result;
	 end; }





 {#########proba###########}
  function readingport(var kom,siz:byte;var res:real):real;
  var result:longint;
            dat:byte;
	begin
	  result:=0;
 	  dat:=0;
          repeat until ((port[ComReg[com, 6]] and $01) <> 0) and (port[ComReg[com, 1]]<>$00)
             or (readkey=#27);
	  repeat until ((port[ComReg[com, 6]] and $01)<>0) or (readkey=#27);
	  dat:= not port[ComReg[com, 1]];
	  result:=result+ (byte(dat shr 4)*longint(10)) + ((byte(dat shl 4)) shr 4);
	  repeat until ((port[ComReg[com, 6]] and $01)<>0) or (readkey=#27);
          dat:= not port[ComReg[com, 1]];
	  result:=result+ (byte(dat shr 4)*longint(1000)) + ((byte(dat shl 4)) shr 4)*longint(100);
	  repeat until ((port[ComReg[com, 6]] and $01)<>0) or (readkey=#27);
	  dat:= not port[ComReg[com, 1]];
	  result:=result+ (byte(dat shr 4)*longint(100000)) + ((byte(dat shl 4)) shr 4)*longint(10000);
	  repeat until ((port[ComReg[com, 6]] and $01)<>0) or (readkey=#27);
	  dat:= not port[ComReg[com, 1]];
	  result:=result+ (byte(dat shr 4)*longint(10000000)) + ((byte(dat shl 4)) shr 4)*longint(1000000);
	  repeat until ((port[ComReg[com, 6]] and $01)<>0) or (readkey=#27);
	  dat:= not port[ComReg[com, 1]];
	  siz:=byte(dat shr 3);
	  kom:=((byte(dat shl 5)) shr 5);
	  res:=(result*exp((-kom)*ln(1)));
          if siz=0 then res:=res*exp((-6)*ln(10)) else
          res:=res*exp((-3)*ln(10));
          readingport:=l/res;
	 end;

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
	Write(f,LeadingZero(h),':',LeadingZero(m),':',LeadingZero(s),
			 '.',LeadingZero(hund));
 end;

  function search:boolean;
  var s,st:string;
   begin
    getdir(0,st);
    S := FSearch('ADAPTER3.CFG',st);
    if S = '' then
    begin
    search:=false;
    writeln;
    WriteLn('Файл ADAPTER3.CFG не найден') end
    else begin search:=true; writeln;
  WriteLn('Файл ADAPTER3.CFG найден как ',FExpand(S));
  writeln; end;
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
  write('Ведите новый номер последнего документа : ');readln(s);
  if byte(s[0])>5 then  begin flag:=false; writeln; writeln('Неверный номер.'); end
  else begin
  val(s,n,c);
  if c<>0 then begin flag:=false;writeln('Неверный номер.'); writeln end else
  begin
  writeln(' Ok');
  writeln;
  assign(f,'adapter3.cfg');
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
                            write('Хотите ли Вы изменить номер последнего документа ? (');highvideo;write('Y');normvideo;
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
                                                         writeln;
   write('Хотите ли Вы выйти из программы ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');
   normvideo;write(') : ');
   if upcase(readkey)='Y' then
    begin writeln('Y'); gend:=true;flag:=true end else
    begin
    writeln('N'); flag:=false  end;
   end;
                                                      end;
  until flag;
 end;

procedure date;
var
	y, m, d, dow : Word;
begin
	GetDate(y,m,d,dow);
	Write(f,leadingzero(m),'/',leadingzero(d),'/',leadingzero(y));
end;

 procedure end_protokol;
 begin
 writeln(f,'└──────────┴─────────────┴───────────┴───────────┴────────────────────┘');
 writeln(f);
 writeln(f,'                     Испытатель');
 writeln(f,'                     Представитель ОТК');
 writeln(f);
 writeln(f,'              имя файла в базе данных DOK'+st+'.TXT');
 writeln(f);
 end;
{   function readingport(var kom,siz:byte;var RES:real):real;
  begin
  readingport:=6321E-3;
  kom:=3;
  siz:=6;
  res:=12345E-2
  end;  }
procedure head;
 begin
 writeln(f);
 writeln(f);
 writeln(f,'                     Протокол номер ',st);
 writeln(f);
 writeln(f,'                     Испытания изедлия ___________________');
 writeln(f);
 write(f,'                     Дата испытаний ');date;
 writeln(f);
 writeln(f,'┌──────────┬─────────────┬───────────┬───────────┬────────────────────┐');
 writeln(f,'│  Номер   │    Время    │ Показания │ Значение  │                    │');
 writeln(f,'│          │             │  частото- │ параметра │     Примечания     │');
 writeln(f,'│ проверки │  испытания  │ мера, сек │   м/сек   │                    │');
 writeln(f,'├──────────┼─────────────┼───────────┼───────────┼────────────────────┤');
 writeln(f,'│     1    │      2      │     3     │     4     │          5         │');
 writeln(f,'├──────────┼─────────────┼───────────┼───────────┼────────────────────┤');
 end;

 procedure telo;

  begin

  if f_t=false then begin
   i:=0;
   assign(f,'dok'+st+'.txt'); rewrite(f); head; f_t:=true;
   i:=i+1;
  write(f,'│ ');write(f,i:8,' │');write(f,' ');time;write(f,' │');write(f,' ',resul:9:3,' │');
  write(f,' ',readingport(koma,size,resul):9:3,' │');
  writeln(f,' │':21);  end else begin
  i:=i+1;
  write(f,'│ ');write(f,i:8,' │');write(f,' ');time;write(f,' │');write(f,' ',resul:9:3,' │');
  write(f,' ',readingport(koma,size,resul):9:3,' │');
  writeln(f,' │':21); end;
end;
 procedure readnumber;
 var
  f: file of integer;
    n:integer;
  begin
  assign(f,'adapter3.cfg');
  reset(f);
  read(f,n);
  close(f);
  str(n,st);
  assign(f,'adapter3.cfg');
  rewrite(f);
  inc(n);
  WRITE(f,n);
  close(f);
  end;


 procedure write_f;
  var  flag:boolean;
  begin
    flag:=true;
    writeln;
    write('Хотите ли Вы начать измерения ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');normvideo;
    write(') : ');
    if upcase(readkey)='Y' then
       begin
         writeln('Y');
         flag:=true;
         writeln('Измерение с записью в протокол');
          f3:=true;
          if f_n=false then begin readnumber; f_n:=true end;
           repeat
             if not keypressed then
                begin
                  writeln('Время : ',resul:8:6,' сек.         Скорость : ',readingport(koma,size,resul):8:6,' м/сек.');
                  telo;
                 end
                               else
                                 if readkey=#68 then
                                    begin
                                      writeln;
                                      write('Хотите ли Вы прервать измерения ? (');
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
 procedure write1;
  var  flag:boolean;
   begin
     flag:=true;
     writeln;
     write('Хотите ли Вы начать измерения ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');
     normvideo;write(') : ');
     if upcase(readkey)='Y' then
       begin
         writeln('Y');
         flag:=true;
         writeln('Измерение без записи в протокол');
         repeat
           if not keypressed then
             writeln('Время : ',resul:8:6,' сек.          Скорость : ',readingport(koma,size,resul):8:6,' м/сек.')
                             else
                               if readkey=#68 then
                                  begin
                                    writeln;
                                    write('Хотите ли Вы прервать измерения ? (');highvideo;write('Y');
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
  write('Порт COM1 ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');normvideo;write(') : ');
   if upcase(readkey)='Y' then
	 begin
         Writeln('Y');
	 com := 1;
	 instal_com;
	 com_f:=true;
         writeln(' Ok');
	 end
  else
	 begin  writeln('N');
		write('Порт COM2 ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');normvideo;write(') : ');
		if upcase(readkey)='Y' then
		  begin
                  writeln('Y');
		  com := 2;
		  instal_com;
		  com_f:=true;
                  writeln(' Ok');
		  end
		else
		  begin writeln('N'); writeln('Неверный адресс порта.Повторите.'); writeln;
                  com_f:=false end;
	 end;
 until com_f;
end;

 procedure quit;
  begin
    writeln;
   write('Хотите ли Вы выйти из программы ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');
   normvideo;write(') : ');
   if upcase(readkey)='Y' then
    begin writeln('Y'); flag:=true; if f3=true then begin end_protokol; close(f) end
        end  else
    begin
    writeln('N'); flag:=false  end;
   end;

BEGIN
 clrscr;
 gend:=false;
 init;
 date_time;
 new_number;  
 readconst;
 if gend=true then goto m1;
 f3:=false;
 f_n:=false;
 f_t:=false;
 repeat
  ch:=readkey;
  if ch=#0 then ch:=readkey;
  case ch of
   #27       : quit;
   #61 {f3}  : write_f;
   #62 {f4}  : write1;
   #63 {f5}  : printing;

  end;
until flag;
m1: clrscr;
 gotoxy(1,25);
 highvideo;
 writeln('Copyright (c) 1997,98 by D&D Company.');
 normvideo;
 writeln(' ');
 delay(1000);
END.

