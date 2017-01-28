 PROGRAM PRIM_A;
   Uses Crt;
 VAR a:ARRAY[1..3,1..4] of real;
     b:array[1..12] of real;
     p:real;
     l,k,i,j:INTEGER;
 BEGIN
   ClrScr;
  for i:=1 to 3 do
  begin
  for j:=1 to 4 do
  begin
   readln(a[i,j]);
   end;
   end;
  for i:=1 to 3 do
    begin
   for j:=1 to 4 do
   begin
    write(a[i,j],' ');
   end;writeln;
   end;
  readln;
  k:=1;
 for i:=1 to 3 do
 begin
 for j:=1 to 4 do
 begin
  b[k]:=a[i,j];
  k:=k+1;
  end;
  end;
  for k:=1 to 11 do
   begin
    for l:=k+1 to 12 do
     begin
     if b[k]>b[l] then
       begin
    p:=b[k];b[k]:=b[l];b[l]:=p;
       end;
     end;
   end;
   writeln('Впорядкований-');
   k:=1;
   for i:=1 to 3 do
   begin
   for j:=1 to 4 do
   begin
   a[i,j]:=b[k];
   k:=k+1;
   end;
   end;
    for i:=1 to 3 do
    begin
   for j:=1 to 4 do
   begin
    write(a[i,j],' ');
   end;writeln;
   end;
   readln
 END.
