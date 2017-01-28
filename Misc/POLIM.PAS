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
 for i:=1 to 320000000 do
   begin
  str(i*9,st);str(i,k);
  if polimendrom(st)=k then writeln(i,' = ',st);
  end;
  readln
end.