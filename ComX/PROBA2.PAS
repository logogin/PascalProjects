{$M 16384,0,65536}
uses crt,dos,printer;
const
    Send: array[1..6] of byte = ($FF, $12, $34, $56, $78, $19);
    SendPos: Integer = 1;
    ComReg: Array[1..2, 1..7] of Word =
       (($3F8, $3F9, $3FA, $3FB, $3FC, $3FD, $3FE), ($2F8, $2F9, $2FA, $2FB, $2FC, $2FD, $2FE));
var f: file of char;
    k,ch:char;
    com,n:byte;
    com_f:boolean;
    i,komi,s:byte;
 function inset(n,min,max:integer):boolean;
  begin
   if n in [min..max] then inset:=true else inset:=false;
  end;
 procedure sett;
 var f:boolean;
     st:string;
     h,m,s,s100:word;
     c:integer;
 begin
  f:=true;
 repeat
 writeln;
   write('Enter new time : '); readln(st);
   if byte(st[0])>11 then begin writeln('Invalid time');f:=false; end else f:=true;
   if f and (st[2]=':')  then st:='0'+st;
   if f and (st[5]=':') then insert('0',st,4);
   if f and (st[8]='.')  then insert('0',st,9);

   if f then begin val((copy(st,1,2)),h,c); if (c<>0) or (not inset(h,0,23)) then begin f:=false;
   writeln('Invalid time'); end
   else f:=true end;
   if f then begin val(copy(st,4,2),m,c); if (c<>0) or (not inset(m,0,59)) then begin f:=false;
   writeln('Inwalid time');end
   else f:=true end;
   if f then begin val(copy(st,7,2),s,c); if (c<>0) or (not inset(s,0,59))then begin f:=false;
   writeln('Invalid time');end
   else f:=true end;
   if f then begin val(copy(st,10,2),s100,c); if (c<>0) or (not inset(s100,0,99))then begin f:=false;
   writeln('Inwalid time'); end
   else f:=true end;
   if f then begin writeln('Ok'); settime(h,m,s,s100) end;
  until f;
 end;
 procedure setd;
  var f:boolean;
     st:string;
     y,day,mon:word;
     c:integer;
   begin
   f:=true;
    repeat
   writeln;
   write('Enter new date (mm-dd-yy) : '); readln(st);
   if byte(st[0])>10 then begin writeln('Invalid date');f:=false; end else f:=true;
   if f and (st[2]='-')  then st:='0'+st;
   if f and (st[5]='-') then insert('0',st,4);

   if f then begin val((copy(st,1,2)),mon,c); if (c<>0) or (not inset(mon,1,12)) then begin f:=false;
   writeln('Invalid date'); end
   else f:=true end;
   if f then begin val(copy(st,4,2),day,c); if (c<>0) or (not inset(day,1,31)) then begin f:=false;
   writeln('Invalid date');end
   else f:=true end;
   if f then begin val(copy(st,7,(byte(st[0])-6)),y,c); if (c<>0) or (y<1980) or (y>2099) then begin f:=false;
   writeln('Invalid date');end
   else f:=true end;

   if f then begin writeln('Ok');setdate(y,mon,day) end;
  until f;
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
var
  h, m, s, hund : Word;
begin
  GetTime(h,m,s,hund);
  Writeln('It is now ',LeadingZero(h),':',
          LeadingZero(m),':',LeadingZero(s),
          '.',LeadingZero(hund));
end;
procedure dokument;
 begin
  assign(f,'result.txt');
  reset(f);
  close(f);
  end;
procedure date;
 const
   days : array [0..6] of String[9] =
     ('Sunday','Monday','Tuesday',
      'Wednesday','Thursday','Friday',
      'Saturday');
 var
   y, m, d, dow : Word;
 begin
   GetDate(y,m,d,dow);
   Writeln('Today is ', days[dow],', ',
          leadingzero(m), '/',leadingzero(d), '/',leadingzero(y));
 end;
function seach:boolean;
var
  S: PathStr;
begin
  S := FSearch('result.txt','');
  if S = '' then
    WriteLn('File RESULT.TXT not found.')
  else
    { Show full path }
   WriteLn('File RESULT.TXT found as ',FExpand(S));
end;

procedure SendPort;
begin
if (port[ComReg[com, 6]] and $20) = 0 then
  exit;
port[ComReg[com, 1]]:=Send[SendPos];
SendPos := SendPos mod 6 + 1
end;

 function readingport(pot:byte;var kom,siz:byte):longint;
  var f:boolean;
      n:byte;
      result:longint;
      dat:byte;
   begin
     f:=false;
     result:=0;
     dat:=0;
     n:=0;
     while ((port[ComReg[com, 6]] and $01) = 0)
         or (port[ComReg[com, 1]]<>$ff) do
       SendPort;
     while ((port[ComReg[com, 6]] and $01) = 0) do
       SendPort;
     dat:=port[ComReg[com, 1]];
     result:=result+ (byte(dat shr 4)*longint(10000000)) + ((byte(dat shl 4)) shr 4)*longint(1000000);
     while ((port[ComReg[com, 6]] and $01) = 0) do
       SendPort;
     dat:=port[ComReg[com, 1]];
     result:=result+ (byte(dat shr 4)*longint(100000)) + ((byte(dat shl 4)) shr 4)*longint(10000);
     while ((port[ComReg[com, 6]] and $01) = 0) do
       SendPort;
     dat:=port[ComReg[com, 1]];
     result:=result+ (byte(dat shr 4)*longint(1000)) + ((byte(dat shl 4)) shr 4)*longint(100);
     while ((port[ComReg[com, 6]] and $01) = 0) do
       SendPort;
     dat:=port[ComReg[com, 1]];
     result:=result+ (byte(dat shr 4)*longint(10)) + ((byte(dat shl 4)) shr 4)*longint(1);
     while ((port[ComReg[com, 6]] and $01) = 0) do
       SendPort;
     dat:=port[ComReg[com, 1]];
     kom:=byte(dat shr 4);
     siz:=((byte(dat shl 4)) shr 4);
     readingport := result;
    end;
{ procedure writeport;
  begin
  if (n and $20) <> 0 then port[ComReg[com, 1]]}

begin
com_f:=false;
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
until com_f;
{
time;
write('Do you want edit time ? (Y/N) : ');readln(k);
if upcase(k)='Y' then sett
else begin date; write('Do you want edit date ? (Y/N) : '); readln(k);
if upcase(k)='Y' then setd; end;
}
Exec(GetEnv('COMSPEC'), '/c date');
Exec(GetEnv('COMSPEC'), '/c time');
{assign(f,'result.txt');
rewrite(f);
dokument;
close(f);
{if not search then
 begin write('Make new file RESULT.TXT ? (Y/N) : ');readln(k);
       if upcase(k)='Y'}
repeat
  writeln(readingport(com,komi,s),komi:6,s:4);
until keypressed;
readln;
end.