uses graph,crt;

var
  px: array [0..128] of integer;
  py: array [0..128] of integer;
  ps: array [0..128] of byte;
  pc: array [0..128] of byte;
  i: byte;

procedure put(x,y:integer;c:byte);
 begin
    putpixel(x,y,c);
end;

procedure init;
var g,m:integer; var i:byte;
begin
 randomize;
 detectgraph(g,m);
 initgraph(g,m,'c:\bp\bgi');
 for i:=0 to 128 do begin

   py[i]:=random(439);
   px[i]:=random(639);
   ps[i]:=1+random(14);
   pc[i]:=random(4)+1; {color}
 end;
end;

procedure star;
begin
  put(px[i],py[i],0);

  if px[i]<5 then begin
  px[i]:=639;py[i]:=random(439);ps[i]:=random(15);pc[i]:=random(4)+1;end;

  dec(px[i],pc[i]);
  put(px[i],py[i],ps[i]);

end;

begin
  init;
  repeat
  for i:=0 to 128 do star;
  until keypressed;
  closegraph;
end.





