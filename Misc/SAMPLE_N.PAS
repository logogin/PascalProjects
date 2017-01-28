 var
 n,del:integer;
    flag:boolean;
 BEGIN
  write('Введите число : '); readln(n);
  del:=1;
   while flag=false or (del=n-1) do
    begin
    inc(del);
    if n mod del=0 then flag:=true;
   end;
  if flag=false then write('Простое') else write('Непростое');
  readln;
 END.








