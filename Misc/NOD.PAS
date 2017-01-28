var n,m:integer;
    nod:integer;
    flag:boolean;
 BEGIN
   write('Введите n и m : ');readln(n,m);
   if n>=m then nod:=m else nod:=n;
   repeat
       if (n mod (nod)=0) and (m mod (nod)=0) then flag:=true else nod:=nod-1;
  until (nod=1) or flag;

   write(' НОД = ',nod);
   readln

 END.
