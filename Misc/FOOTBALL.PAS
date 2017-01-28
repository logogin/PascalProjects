program football;
uses crt,graph;
var x,y,r1,r2,r3,r4:integer;
      sm:char;
      p,h:byte;

{$i c:pp.pas }
procedure readpic(x,y:word;m:string;var xl,yl:byte);
var ix,iy,rec:byte;i:word;f:file of byte;
 begin
   assign(f,m);
   reset(f);
   seek(f,1);
   read(f,xl);
   seek(f,2);
   read(f,yl);
   close(f);
   reset(f);
   seek(f,5);i:=5;
   for i:=x to (x+xl) do
     begin
       for iy:=y to (y+yl) do
         begin
           read(f,rec);
           putpixel(ix,iy,rec);
           i:=i+1;
           seek(f,i);
         end;
     end;
   close(f);
 end;
BEGIN
  clrscr;
  initgraph_2;
  clearviewport;
  {rectangle(0,0,719,347);
  setviewport(1,1,719,347,clipOn);
  repeat until keypressed;
  circle(10,10,5);
  setcolor(white);
  floodfill(10,10,white);
  repeat until readkey=#27;
  getmem(p,imagesize(4,4,17,17));getmem(clr,imagesize(104,104,117,117));
  getimage(4,4,17,17,p^);putimage(3,3,p^,xorput);
  getimage(104,104,117,117,clr^);

  repeat until keypressed;x:=100;y:=100;sm:=#15;
  repeat
    if keypressed then sm:=readkey;
    case sm of
     #72:begin
           putimage(x,y,clr^,normalput);
           y:=y-7;
           putimage(x,y,p^,normalput)
         end;
     #80:begin
           putimage(x,y,clr^,normalput);
           y:=y+6;
           putimage(x,y,p^,normalput)
         end;
     #75:begin
           putimage(x,y,clr^,normalput);
           x:=x-6;
           putimage(x,y,p^,normalput)
         end;
     #77:begin
           putimage(x,y,clr^,normalput);
           x:=x+7;
           putimage(x,y,p^,normalput)
         end
    end;
   setcolor(black);
   circle_2(r1,r2,r3-100,7);
   setcolor(white);
   r1:=random(700);r2:=random(320);r3:=random(700);r4:=random(320);
   circle_2(r1,r2,r3-100,0);
  until sm=#13;
  freemem(p,imagesize(4,4,17,17));
  freemem(clr,imagesize(4,4,17,17));}
  readpic(200,200,'picture.pic',p,h);
  readln;
  closegraph
END.