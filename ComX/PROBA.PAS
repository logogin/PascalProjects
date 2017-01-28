{$M 16384,0,65536}
uses crt,dos,printer;
const
	 Send: array[1..6] of byte = ($FF, $12, $34, $56, $78, $19);
	 SendPos: byte = 1;
	 ComReg: Array[1..2, 1..7] of Word =
(($3F8, $3F9, $3FA, $3FB, $3FC, $3FD, $3FE),
 ($2F8, $2F9, $2FA, $2FB, $2FC, $2FD, $2FE));

var f: file of integer;
	 f1:text;
	 k,ch:char;
	 com,n:byte;
	 com_f,flag:boolean;
	 koma,size:byte;
	 m:integer;
	 st:string[5];
 procedure printing;
 var st:string;
  begin


	readln(f1,st);
	{$i-}
	writeln(lst,st);
	{$i+}
	if ioresult=0 then while not eof(f1) do begin
	readln(f1,st);
	writeln(lst,st);
	end
	 e|se begin writeln('Error of printer');exit end;
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
function LeadingZero(w : Word) : String;
var
  s : String;
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
function search:boolean;
var
  S: PathStr;
  s1:string;

begin
  getdir(0,s1);
  S := FSearch('protokol.dat',s1);
  if S = '' then begin search:=false;
	 WriteLn('File PROTOKOL.DAT not found.') end
  else
	begin
	WriteLn('File PROKOL.DAT found as ',FExpand(S)); search:=true end;
end;
procedure head;
 begin
 writeln(f1);
 writeln(f1,'                                                 Протокол № ',m);
 writeln(f1);
 writeln(f1,'                                            Испытания изедлия ___________________');
 writeln(f1);
 write(f1,'                                Дата испытаний ');date_f;
 writeln(f1);
 writeln(f1,'   ┌──────────┬─────────────┬──────────────┬───────────────┬───────────────────────┐');
 writeln(f1,'   │    №     │    Время    │   Показания  │   Значение    │                       │');
 writeln(f1,'   │          │             │  частотомера │   параметра   │      Примечания       │');
 writeln(f1,'   │ проверки │  испытания  │      мсек    │     м/сек     │                       │');
 writeln(f1,'   ├──────────┼─────────────┼──────────────┼───────────────┼───────────────────────┤');
 writeln(f1,'   │     1    │      2      │       3      │       4       │           5           │');
 writeln(f1,'   ├──────────┼─────────────┼──────────────┼───────────────┼───────────────────────┤');
end;
procedure frame;
var i:LONGINT;
begin
 i:=0;
 writeln(f1,'     ┌──────────┬─────────────┬──────────────┬───────────────┬───────────────────────┐');
 writeln(f1,'     │     1    │      2      │       3      │       4       │           5           │');
 writeln(f1,'     ├──────────┼─────────────┼──────────────┼───────────────┼───────────────────────┤');
{*********for datas***********}
 repeat
 i:=i+1;
 write(f1,'      │ ');write(f1,i:8,' │');write(f1,' ');time_f;write(f1,' │');write(f1,' ',i:12,' │');
 write(f1,' ',i*100:13,' │');
 writeln(f1,'    Ok                 │');
 until keypressed;
end;
procedure ending;
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
{com_f:=false;
repeat
write('Port COM1 ? (Y/N) : ');readln(k);
if (upcase(k)='N') or (upcase(k)='Y') then
 begin
  if upcase(k)='Y' then
	 begin
	 com := 1;
	 instal_com;
	 com_f:=true
	 end
  else
	 begin
		write('Port COM2 ? (Y/N) : '); readln(k);
		if upcase(k)='Y' then
		  begin
		  com := 2;
		  instal_com;
		  com_f:=true
		  end
		else
		  begin writeln('Error of reading port.Repeat.'); com_f:=false end;
	 end;
 end;
until com_f;     }

{time;
write('Do you want edit time ? (Y/N) : ');readln(k);
if upcase(k)='Y' then sett
else begin date; write('Do you want edit date ? (Y/N) : '); readln(k);
if upcase(k)='Y' then setd; end;
 flag:=false;
{ repeat
 if not search then
 begin write('Make a new file PROTOKOL.DAT (Y/N) ? : ');readln(k);
 if (upcase(k)='N') or (upcase(k)='Y') then
 begin
  if upcase(k)='Y' then
	 begin         }
	 { assign(f,'protokol.dat');
	  rewrite(f);    }
	  write('Enter namber of new protokol ? : ');readln(m);
	  {$i-}
 {	  readln(m);
	  {$i+}
 { 	  if ioresult<> 0 then
		begin
		 writeln('Error');
		 flag:=false
		end
	  else
		begin
		 write(f,m);
		 flag:=true;
		end
	 end
	 else flag:=false
	end
	 else begin
			flag:=false;
			writeln('Error');
		  end;
 until flag;  }
{ read(f,m);
 close(f);}
 str(m,st);

 assign(f1,'dok'+st+'.txt');
 rewrite(f1);
 head;
 frame;
 ending;
 close(f1);
{Exec(GetEnv('COMSPEC'), '/c date');
Exec(GetEnv('COMSPEC'), '/c time');
{writeln(maxlongint);}
{assign(f,'result.txt');
rewrite(f);
dokument;
close(f);
{if not search then
 begin write('Make new file RESULT.TXT ? (Y/N) : ');readln(k);
		 if upcase(k)='Y'}
{repeat
  writeln(readingport(koma,size),koma:6,size:4);
until keypressed;
readln;     }
end.
