program music;
 uses crt;
 var m:integer;
procedure bird;
begin
 m:=2000;
 while m<3800 do
 begin
  sound(m+1);
  inc(m)
 end;
 nosound
end;
BEGIN
 clrscr;
 repeat
  for m:=1 to 20 do
  begin
   sound(random(100)+random(500)+3100);
   delay(random(8)+8);
   nosound;
   delay(30)
  end;
  bird;
  randomize;
  delay(random(600));
 until keypressed;
 nosound;
END.