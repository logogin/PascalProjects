var
 con:array[1..80,1..25,1..2] of byte absolute $B000:$0000;
 x,y:byte;
begin
 for y:=1 to 80 do
  for x:=1 to 25 do
 if con[y,x,1]=32 then con[y,x,1]:=19;

   readln;
end.