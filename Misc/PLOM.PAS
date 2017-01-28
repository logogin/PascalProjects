uses crt; var i:longint;st,k:string;
function polimendrom(s:string):string;
 var a:array[1..7] of string; i:integer;
   st:string;
 begin
 st:='';
  for i:=1 to length(s) do
    begin
     a[i]:=s[(length(s)-i)+1];
    end;
  for i:=1 to length(s) do  st:=st+a[i];
   polimendrom:=st;
 end;

begin
clrscr;
 for i:=1 to 329954000 do
   begin
     str(i*9,st);str(i,k);
     if polimendrom(st)=k then writeln(i,' = ',st);
     if (i=1000)  or (i=30000) or (i=32000) or (i=40000)
        or (i=80000) or (i=300000000) then writeln('шаг = ',i);
  end;
  readln
end.