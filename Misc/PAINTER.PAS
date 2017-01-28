program painter;
uses graph,crt;
var ch:char;
    ix,iy,sx,sy,color,delta:word;
    flag,k:boolean;

{$I a:PP.PAS}

procedure menuline;
begin
 sound(700);delay(100);nosound
end;

procedure exproc;
begin
 sound(500);delay(100);nosound;
 closegraph;
 halt
end;

procedure checkbt;
begin
 if (ix<2) and (ix>2) and (iy<2) and (iy>2)
   then menuline;
 if (ix<37) and (ix>2) and (iy<20) and (iy>2)
   then exproc;
end;
procedure my_case;
begin
  if (ix<42) and (ix>2) and (iy<34) and (iy>14)
   then k:=true;

end;
procedure cursor(x,y,r,color:word);
begin
 setcolor(color);
 line(x-r,y,x+r,y);
 line(x,y-r,x,y+r);
end;
procedure case_speed;
begin
 line(400,2,400,14);
 line(415,2,415,14);
 line(430,2,430,14);
 line(445,2,445,14);
 line(460,2,460,14);
 line(475,2,475,14)
end;

procedure rectbtn(a,b:word);
begin
 rectangle(a,b,a+40,b+20)
end;

procedure screenpntr;
begin
 setactivepage(1);
 clearviewport;
 setcolor(cyan);
 rectangle(2,2,718,14);
 outtextxy(5,5,'Exit');
 line(37,14,37,2);
 outtextXY(80,4,'painter1.0');
 outtextxy(401,5,'1 2 3 4 5');
 rectbtn(2,14);
  line(6,20,34,30);
  line(8,28,35,16);
 rectbtn(2,34);
  rectangle(6,38,30,48);
  rectangle(20,43,38,51);
 rectbtn(2,54);
  ellipse(13,63,0,360,8,5);
  circle(20,68,6);
  circle(28,65,10);
 rectbtn(2,74);
  putpixel(random(40),random(70),7);
 rectbtn(2,94);
 rectbtn(2,114);
 setlinestyle(solidln,0,thickwidth);
 rectangle(43,15,717,310);
 setlinestyle(solidln,0,normwidth);
 case_speed;
 rectbtn(100,310);
 setfillstyle(0,white);
 floodfill(110,320,white);
 rectbtn(141,310);
 setfillstyle(1,white);
 floodfill(151,320,white);
 rectbtn(182,310);
 setfillstyle(2,white);
 floodfill(192,320,white);
 rectbtn(223,310);
 setfillstyle(3,white);
 floodfill(233,320,white);
 rectbtn(264,310);
 setfillstyle(4,white);
 floodfill(274,320,white);
 rectbtn(305,310);
 setfillstyle(5,white);
 floodfill(315,320,white);
 rectbtn(346,310);
 setfillstyle(6,white);
 floodfill(356,320,white);
 rectbtn(387,310);
 setfillstyle(7,white);
 floodfill(397,320,white);
 rectbtn(428,310);
 setfillstyle(8,white);
 floodfill(438,320,white);
 rectbtn(469,310);
 setfillstyle(9,white);
 floodfill(479,320,white);
 rectbtn(510,310);
 setfillstyle(10,white);
 floodfill(520,320,white);
 rectbtn(551,310);
 setfillstyle(11,white);
 floodfill(561,320,white);
 setvisualpage(1);
end;

begin
 k:=false;
 initgraph_2;
 screenpntr;
 ix:=350;iy:=100;
 delta:=5;
 repeat
  repeat until keypressed;
  ch:=readkey;
  if ch=#0 then ch:=readkey;
  case ch of
   #13:begin
         checkbt;
         {floodfill(ix+1,iy+1,white);}
         my_case;
       end;
   #82:color:=white;
   #32:begin
       if k=true then begin
       if flag then
         begin
           line(sx,sy,ix,iy);
           flag:=false
         end else begin flag:=true;sx:=ix;sy:=iy end;
        {line(ix,iy,delta,delta);}
        if delta=1 then delta:=5 else delta:=1;
       end;
       end;
   #72:begin
         cursor(ix,iy,2,color);
         dec(iy,delta);
         color:=getpixel(ix,iy);
         cursor(ix,iy,2,white)
       end;
   #75:begin {circle_2}cursor(ix,iy,2,color);
         dec(ix,delta);
         color:=getpixel(ix,iy);
         {circle_2}cursor(ix,iy,2,white)
       end;
   #77:begin {circle_2}cursor(ix,iy,2,color);
         inc(ix,delta);
         color:=getpixel(ix,iy);
         {circle_2}cursor(ix,iy,2,white)
       end;
   #80:begin {circle_2}cursor(ix,iy,2,color);
         inc(iy,delta);
         color:=getpixel(ix,iy);
         {circle_2}cursor(ix,iy,2,white)
       end;
   #13:checkbt;
  end
 until ch=#27;
 closegraph
end.