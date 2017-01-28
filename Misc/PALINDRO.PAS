var  s:string;
     flag:boolean;
     i:byte;
 BEGIN
  write('Введите строку  : '); readln(s);
  repeat
   inc(i);
   if s[i]<>s[byte(s[0])-i+1] then flag:=true;
  until flag or (i=byte(s[0]) div 2);
    if flag then write('Не палиндром') else write('Палиндром');
    readln
 END.





