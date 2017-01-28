program demoframe;
uses crt;
var x1,x2,y1,r1,r2:integer;
       ch:char;

procedure clear(x1,y1,x2,y2:integer);
Begin
  window(x1,y1,x2,y2);
  clrscr;
  window(1,1,80,25)
End;

procedure frame(x1,y1,x2,y2:integer;st:string);
var i:integer;
Begin
 gotoxy(x1,y1);write(#201,st);
 for i:=(x1+length(st)) to (x2-2) do  write(#205);
 write(#187);
 for i:=(y1+1) to (y2-1) do
   begin
     gotoxy(x1,i);write(#186);
     gotoxy(x2,i);write(#186)
   end;
 gotoxy(x1,y2);write(#200);
 for i:=(x1+1) to (x2-1) do write(#205);
 write(#188);
 for i:=(x1+1) to (x2-1) do
   begin
     gotoxy(i,y1+1);write(#176);
     gotoxy(i,y2-1);write(#176)
   end;
 end;
 BEGIN
   clrscr;
   frame(10,10,15,20,'demoframe');x1:=10;y1:=10;
   repeat
    ch:=readkey;if ch=#0 then ch:=readkey;
    if ch=#72 then
     begin
    clear(r1+1,r2+2,r1+14,r2+8);
    r1:=random(50)+1;r2:=random(10)+1;
    frame(r1,r2,r1+15,r2+10,'demoframe');
    clear(r1+1,r2+2,r1+14,r2+8)
     end;
   until readkey=#27
 END.