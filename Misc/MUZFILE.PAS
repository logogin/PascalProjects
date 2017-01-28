Program muzika4;
Uses crt;
Var i,n,d,p,o :integer;
    dlina:file of integer;
  pauses :file of integer;
  notes  :file of integer;
 begin
  clrscr;
  writeln('Введите кол-во нот:');read(n);
  assign(dlina,'dl.pas'); assign(pauses,'pau.pas'); assign(notes,'ne.pas');
  rewrite(dlina); rewrite(pauses); rewrite(notes);
  For I:=1 to n do
   begin
    writeln('Введите ',i,'-ю частоту,гц:');read(o);notes^:=o;put(notes);
    writeln('Введите ',i,'-ю длину ноты,мс:');read(d);dlina:=d;put(dlina);
    writeln('Введите ',i,'-ю паузу,мс:');read(p);pauses:=p;put(pauses);
   end;
  close(dlina);close(pauses);close(notes);
  reset(dlina);reset(pauses);reset(notes);
  repeat
   get(dlina);d:=dlina^;get(pauses);p:=pauses^;get(notes);o:=notes^;
   sound(o);delay(d);nosound;delay(p);
  until EOF(notes);
  close(dlina);close(pauses);close(notes);
  readln;
 end.