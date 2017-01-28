{$M 16384,0,65536}
uses crt,dos,printer;
const
	 Send: array[1..6] of byte = ($FF, $12, $34, $56, $78, $19);
	 SendPos: byte = 1;
	 ComReg: Array[1..2, 1..7] of Word =
(($3F8, $3F9, $3FA, $3FB, $3FC, $3FD, $3FE),
 ($2F8, $2F9, $2FA, $2FB, $2FC, $2FD, $2FE));

var
         f1,f2:text;
         f3:file of integer;
         k,ch:char;
	 com,n:byte;
	 com_f,flag:boolean;
	 koma,size:byte;
	 m:integer;
	 st:string[5];
{procedure printing;
 begin  }

procedure head;
 begin
 writeln(f1);
 writeln(f1);
 writeln(f1,'                                Протокол № ');
 writeln(f1);
 writeln(f1,'                                Испытания изедлия ___________________');
 writeln(f1);
 write(f1,'                                Дата испытаний ');{date; }
 writeln(f1);
 writeln(f1,'   ┌──────────┬─────────────┬──────────────┬───────────────┬───────────────────────┐');
 writeln(f1,'   │    №     │    Время    │   Показания  │   Значение    │                       │');
 writeln(f1,'   │          │             │  частотомера │   параметра   │      Примечания       │');
 writeln(f1,'   │ проверки │  испытания  │      сек     │     м/сек     │                       │');
 writeln(f1,'   ├──────────┼─────────────┼──────────────┼───────────────┼───────────────────────┤');
 writeln(f1,'   │     1    │      2      │       3      │       4       │           5           │');
 writeln(f1,'   ├──────────┼─────────────┼──────────────┼───────────────┼───────────────────────┤');
 end;
{ procedure format;
  begin
 close(f1);
 assign(f1,'dok'+s+'.txt');
 reset(f1);
 assign(f2,'dok'+s+'.bak');
 rewrite(f2);
 i1:=1;
 while not eof(f1) do
 begin
 readln(f1,st);
 writeln(f2,st);
 l:=l+1;
 if l=60 then begin ending1;i1:=i1+1; list; l:=0  end;
  end;
 erase(f1);
 close(f1);
 reset(f2);
 rename(f2,'dok'+s+'.txt');
 close(f2);
 end;}
{ procedure telo;
  var i:LONGINT;
  begin

begin
 i:=0;

  repeat
  i:=i+1;
  write(f1,'      │ ');write(f1,i:8,' │');write(f1,' ');time_f;write(f1,' │');write(f1,' ',i:12,' │');
  write(f1,' ',i*100:13,' │');
  writeln(f1,'    Ok                 │');
 until keypressed;
end;}
 procedure end_protokol;
 begin
 writeln(f1,'      └──────────┴─────────────┴──────────────┴───────────────┴───────────────────────┘');
 writeln(f1);
 writeln(f1,'                      Испытатель');
 writeln(f1,'                      Представитель ОТК');
 writeln(f1);
 str(m,st);
 writeln(f1,'               имя файла в базе данных DOK'+st+'.TXT');
 writeln(f1);
 end;
{ procedure ending;
  begin
  writeln(f2,'      └──────────┴─────────────┴──────────────┴───────────────┴───────────────────────┘');
  writeln(f2,'-':37,stors,'-');
  writeln(f2,'     ┌──────────┬─────────────┬──────────────┬───────────────┬───────────────────────┐');
  writeln(f2,'     │     1    │      2      │       3      │       4       │           5           │');
  writeln(f2,'     ├──────────┼─────────────┼──────────────┼───────────────┼───────────────────────┤');
 end;}
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
	Write(f1,LeadingZero(h),':',LeadingZero(m),':',LeadingZero(s),
			 '.',LeadingZero(hund));
 end;
procedure date;
var
	y, m, d, dow : Word;
begin
	GetDate(y,m,d,dow);
	Write(f1,leadingzero(m),'/',leadingzero(d),'/',leadingzero(y));
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

 function readingport(var kom,siz:byte):longint;
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
	 end;

begin
 com_f:=false;
 clrscr;
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
 Exec(GetEnv('COMSPEC'), '/c date');
 Exec(GetEnv('COMSPEC'), '/c time');
 Exec(GetEnv('COMSPEC'), '/c copy stars.pas prn');
 flag:=false;
 repeat
 if not keypressed then writeln('Частота : ',readingport(koma,size), '  Запятая : ',koma:6,'   Размерность : ',size:4)
 else begin
  ch:=readkey;
  if ch=#27 then begin
   writeln;
   write('Do you want quit ? (');highvideo;write('Y');normvideo;write('/');highvideo;write('N');normvideo;write(') : ');
   if upcase(readkey)='Y' then
    begin writeln('Y');flag:=true end else
   begin
   writeln('N');flag:=false
   end;
  end;end;

until flag;
clrscr;
highvideo;
writeln('Copyright (c) 1997 by D&D Company.');
normvideo;
write('Press any key');
repeat until keypressed;
end.
