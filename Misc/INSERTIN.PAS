var a:array[1..10] of integer;
    i,j:integer;
    n:integer;

 BEGIN
   for i:=1 to 10  do
   begin
   write('Введите  ',i,'-ый элемент  : ');
   readln(a[i]);
   end;
    for i:=1 to 9  do
      for j:=i+1 to 10 do
      if a[i]>a[j] then
      begin
       a[j]:=a[j]+a[i];
       a[i]:=a[j]-a[i];
       a[j]:=a[j]-a[i]
      end;

   for i:=1 to 10 do writeln(a[i]);
   readln;
 END.

