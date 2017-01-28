 begin
  assign(f,'alica1.pas');
  reset(f);
   while not eof(f) do
    begin
    readln(f,s);
    for i:= 1 to byte(s[0]) do
     begin
      k:=byte(s[i]);
      case  k of

 end.