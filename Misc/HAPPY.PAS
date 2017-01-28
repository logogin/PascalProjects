var n:longint;
    left,right:integer;
    l,r,k:longint;
 BEGIN
  write('Введите номер билета : ');
  readln(n);
  l:=1;
  r:=1;
  while k<>3 do
    begin
    inc(k);
    l:=l*10;
    left:=left + (n mod l) div r;
    right:=right + ((n mod (l*1000)) div (r*1000));
    r:=r*10;
   end;
  if right=left then write('Щасливый') else write('Не щасливый');
  readln
 END.


