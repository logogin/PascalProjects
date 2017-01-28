uses Crt; const n = 7;         {antar}
var st:array[1..n] of byte; mas:array[1..n,1..n] of boolean;
    i,j,point:byte;
function fax(i,j:byte):boolean; var k,l:byte;flag,fl:boolean;
begin flag:=false;
if not(mas[i,j]) then begin
st[point]:=i; inc(point); k:=1;
While (k<=n) and not(flag) do begin
if mas[i,k] then begin l:=1; fl:=true;
   While fl and (l<point) do begin      { perevirka   }
   if k=st[l] then fl:=false; inc(l) end;
   if fl then flag:=fax(k,j) end;
inc(k) end;
dec(point) end else flag:=true;
fax:=flag; end;
begin randomize;
for i:=1 to n-1 do    for j:=i+1 to n do begin
if random(3) = 1 then begin mas[i,j]:=true;mas[j,i]:=true;end
else begin mas[i,j]:=false;mas[j,i]:=false; end;
Writeln(i,'   ','   ',j,'  ',mas[i,j]);end; readln;
for i:=1 to n-1 do for j:=i+1 to n do begin point:=1;
if fax(i,j) then Writeln('Між ',i,' та ',j,' станцією встановлено звязок')
            else Writeln('Між ',i,' та ',j,' станцією відсутній звязок') end;
readln; end.
const n = 3; p = 12;            {p = p + 1}    {babka}
const cost:array[1..n] of byte = (5,11,20);
      mass:array[1..n] of byte = (2,4,7);
var things:array[1..p,0..n,1..2] of word;
     i,j,k:word; max:word;
begin
for i:=1 to p do things[i,0,1]:=0;
for i:=1 to n do
for j:=1 to p do begin max:=0;
for k:=0 to (j div mass[i]) do begin
if (j>k*mass[i]) and (max < ( k*cost[i] ) +
    ( things[ j-k*mass[i],i-1 ,1] )) then begin
things[j,i,1]:=(k*cost[i]) + (things[ j-k*mass[i],i-1,1]); things[j,i,2]:=k;
max:=(k*cost[i]) + (things[ j-k*mass[i],i-1,1]);end;
end; end;
writeln('Item cost = ',things[p,n,1]); j:=p;
for i:=n downto 1 do begin
writeln(i,' предмет взятий ',things[j,i,2],' раз.');
j:=j - things[j,i,2]*mass[i];
end; readln; end.
var s: string;         {change}
procedure swap(i,n:byte); var c:char;begin
c:=s[n];s[n]:=s[i];s[i]:=c; end;
procedure exchange(n:byte); var i:byte; begin
for i:=1 to n do begin swap(i,n); exchange(n-1); swap(i,n); end;
if n=0 then writeln(s); end;
begin  readln(s); exchange(ord(s[0])); readln;  end.
uses Crt; const n=3000; {sort}
var a:array[1..n] of integer; i,j,k:word;
procedure mover(start,fin:word); var i,j,number,n:word;
begin number:=start;
for i:=start to fin do begin
if a[i]<a[number] then begin n:=a[i];
for j:=i downto number do
a[j]:=a[j-1];a[number]:=n;inc(number); end; end;
if number-start>1 then mover(start,number-1);
if fin-number>1 then mover(number+1,fin); end;
begin for i:=1 to n do a[i]:=random(22256);
mover(1,n);
  for i:=1 to n do write(a[i]:5);readln;
  { for i := 1 to n-1 do for j := i+1 to n do
  if a[i] > a[j] then begin k := a[i]; a[i] := a[j]; a[j] := k; end;
for i:=1 to n do write(a[i]:5);  }  readln; end.
