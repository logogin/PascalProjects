uses graph,crt;

const
  stars: array [0..3,0..3] of byte =
   ((1,2,3,3),(2,3,4,4),(3,4,3,8),(3,4,8,8));
  size=32;
var
  cx: array [0..size] of integer;
  cy: array [0..size] of integer;
  ss: array [0..size] of byte;
  cs: array [0..size] of byte;
  i: byte;

procedure putstar(x,y:integer;p,c:byte);
var
 dx,dy:byte;                                        {  1233     }
begin                                               {  2344     }
  for dx:=0 to 3 do                                 {  343      }
    for dy:=0 to 3 do                               {  34       }
    if stars[dx,dy]<=p then
    begin
    putpixel(x+dx,y+dy,c);
    putpixel(x+dx,y-dy,c);
    putpixel(x-dx,y+dy,c);
    putpixel(x-dx,y-dy,c);
    end;
end;

procedure init;
var g,m:integer; var i:byte;
begin
  randomize;
 detectgraph(g,m);
 initgraph(g,m,'c:\bp\bgi');
 for i:=0 to size do begin

   cx[i]:=random(639);
   cy[i]:=1;
   ss[i]:=4;
   cs[i]:=random(15);
 end;
end;

procedure movestar;
begin
  putstar(cx[i],cy[i],ss[i],0);
  if random(500)<10 then
  begin
    if ss[i]>1 then dec(ss[i])
      else begin ss[i]:=4; cy[i]:=1;end;
  end;
  inc(cy[i],ss[i]);
  putstar(cx[i],cy[i],ss[i],cs[i]);
end;

begin
  init;
  repeat
  for i:=1 to size do
   movestar;
  until keypressed;
  closegraph;
end.
