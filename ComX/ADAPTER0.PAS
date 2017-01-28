{$M 16384,0,65536}
uses crt,dos;
var
         f1,f2:text;
         k,ch:char;
	 com,n:byte;
	 com_f,flag,ff,f4:boolean;
	 koma,size:byte;
	 m:integer;
	 st:string[6];

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
 writeln(f2,'                     Испытатель');
 writeln(f2,'                     Представитель ОТК');
 writeln(f2);
 writeln(f2,'              имя файла в базе данных DOK'+st+'.TXT');
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
 writeln(f2,'-':37,stors,'-');
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
  var i:LONGINT;

begin

if f4=false then begin
   i:=0;
   assign(f1,'dok'+st+'.txt'); rewrite(f1); head; f4:=true;
   i:=i+1;
  write(f1,'│ ');write(f1,i:8,' │');write(f1,' ');time;write(f1,' │');write(f1,' ',readingport(koma,size):12,' │');
  write(f1,' ',koma:13,' │');
  writeln(f1,size:8,' │');  end else begin
  i:=i+1;
  write(f1,'│ ');write(f1,i:8,' │');write(f1,' ');time;write(f1,' │');write(f1,' ',readingport(koma,size):12,' │');
  write(f1,' ',koma:13,' │');
  writeln(f1,size:8,'  │'); end;
end;
 procedure format;
 var i1,l:longint;
  s:string;
  begin
 end_protokol1;
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
 {close
 reset(f2);     }
 close (f2);
 rename(f2,'dok'+st+'.txt');
 append (f2);
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
 procedure quit;
  begin
    writeln;
   write('Do you want to quit ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');normvideo;write(') : ');
   if upcase(readkey)='Y' then
    begin writeln('Y');flag:=true; if ff=true then begin end_protokol1; close(f1) end else close(f2);   end  else
    begin
    writeln('N'); flag:=false  end;
   end;
BEGIN
 clrscr;
 ff:=true;
 f4:=false;
 flag:=false;
 repeat
  ch:=readkey;
  if ch=#0 then ch:=readkey;
  case ch of
   #27       : quit;
   #61 {f3}  : begin if ff then write_f else begin
               writeln('File DOK'+st+'.TXT was formated. You do not change it.');
               writeln end  end;
   #62 {f4}  : begin if ff then format else begin
               writeln('File DOK'+st+'.TXT was formated.');writeln end end;
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
