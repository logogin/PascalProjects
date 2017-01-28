var
 flag          : boolean;
 a             : array[1..10000] of integer;
 n,i,g,k,l,m,r : word;
begin
 write('Введтіь кількість кучок : ');readln(n);
 for i:=1 to n do begin
  write('Введіть кількість сірників в ',i,'-ій кучці : ');readln(a[i]);
 end;
 for i:=1 to n do writeln('Кількість сірників в ',i,'-ій кучці : ',a[i]);
 while not flag do begin
  k:=a[1];
  for g:=2 to n do if a[g]<>0 then k:=k xor a[g];
  if k<>0 then begin
   flag:=true;l:=1;
   while k xor a[l]>a[l] do inc(l);
   writeln('Я візьму з ',l,'-ої кучки ',a[l]-(k xor a[l]),' сірників');
   a[l]:=k xor a[l];
   for i:=1 to n do writeln('Кількість сірників в ',i,'-ій кучці : ',a[i]);
   for i:=1 to n do if a[i]<>0 then flag:=false;
  end;
  if not flag then begin
   writeln('Ваш хід.Введіть з якої кучки і скільки сірників хочете взяти Ви?');
   readln(m,r);a[m]:=a[m]-r;
   for i:=1 to n do writeln('Кількість сірників в ',i,'-ій кучці : ',a[i]);
  end;flag:=true;
  for i:=1 to n do if a[i]<>0 then flag:=false;
 end;
 write('Ну не виграєте Ви, не виграєте.');readln;
end.