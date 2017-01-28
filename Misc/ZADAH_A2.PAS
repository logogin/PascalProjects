Program ZADAHA_A2;
 Uses Graph,crt;
 label m1;
 Var
    GraphDriver:integer;
    GraphMode  :integer;
    ErrorCode  :integer;
{1} x,y,r,h1,h,a1,a:integer;
{2} q,q1,s,s1,x1,y1:integer;
{3} c,c1,v,v1,x2,y2:integer;
{4} b,b1,n,n1,x3,y3:integer;
{5} k,k1,l,l1,x4,y4:integer;
{6} d,d1,f,f1,x5,y5:integer;
{7} w,w1,e,e1,x6,y6:integer;
{8} p,p1,o,o1,x7,y7:integer;
{$i a:pp.pas}
BEGIN
  initgraph_2;
  ClearViewPort;
   rectangle(20,20,600,300);
{1} h:=5; a:=h;h1:=h;a1:=h1;x:=30;r:=5;y:=30;
{2} q:=15;s:=q;q1:=q;s1:=q1;x1:=500;y1:=30;
{3} c:=12;v:=c;c1:=c;v1:=c1;x2:=400;y2:=30;
{4} b:=2;n:=b;b1:=b;n1:=b1;x3:=300;y3:=30;
{5} k:=14;l:=k;k1:=k;l1:=k1;x4:=200;y4:=30;
{6} d:=7;f:=d;d1:=d;f1:=d1;x5:=100;y5:=30;
{7} w:=10;e:=w;w1:=w;e1:=w1;x6:=50;y6:=30;
{8} p:=9;o:=p;p1:=p;o1:=p1;x7:=60;y7:=30;
repeat
      { 1-ый шар }
     circle_2(x,y,r,7);
    { delay(5); }
     circle_2(x,y,r,7);
     x:=x+h; y:=y+h1;
     if x>=600-r-a  then h:=-h;
     if x<=20+r+a then h:=-h;
     if y<=300-r-a1 then h1:=-h1;
     if y>=20+r+a1 then h1:=-h1;
      { 2-oй шар }
     circle_2(x1,y1,r,7);
    { delay(5);}
     circle_2(x1,y1,r,7);
     x1:=x1+q; y1:=y1+q1;
     if x1>=600-r-s  then q:=-q;
     if x1<=20+r+s then q:=-q;
     if y1<=300-r-s1 then q1:=-q1;
     if y1>=20+r+s1 then q1:=-q1;
      { 3-ий шар }
     circle_2(x2,y2,r,7);
    { delay(5);}
     circle_2(x2,y2,r,7);
     x2:=x2+c; y2:=y2+c1;
     if x2>=600-r-v  then c:=-c;
     if x2<=20+r+v then c:=-c;
     if y2<=300-r-v1 then c1:=-c1;
     if y2>=20+r+v1 then c1:=-c1;
      { 4-ый шар }
     circle_2(x3,y3,r,7);
     {delay(5);}
     circle_2(x3,y3,r,7);
     x3:=x3+b; y3:=y3+b1;
     if x3>=600-r-n  then b:=-b;
     if x3<=20+r+n then b:=-b;
     if y3<=300-r-n1 then b1:=-b1;
     if y3>=20+r+n1 then b1:=-b1;
      { 5-ый шар }
     circle_2(x4,y4,r,0);floodfill(x4,y4,0);
     delay(0);
     circle_2(x4,y4,r,0);floodfill(x4,y4,0);
     x4:=x4+k; y4:=y4+k1;
     if x4>=600-r-l  then k:=-k;
     if x4<=20+r+l then k:=-k;
     if y4<=300-r-l1 then k1:=-k1;
     if y4>=20+r+l1 then k1:=-k1;
      { 6-ой шар }
     circle_2(x5,y5,r,7);
     delay(0);
     circle_2(x5,y5,r,0);
     x5:=x5+d; y5:=y5+d1;
     if x5>=600-r-f  then d:=-d;
     if x5<=20+r+f then d:=-d;
     if y5<=300-r-f1 then d1:=-d1;
     if y5>=20+r+f1 then d1:=-d1;
      { 7-ой шар }
     circle_2(x6,y6,r,7);
     {delay(5)}
     circle_2(x6,y6,r,7);
     x6:=x6+w; y6:=y6+w1;
     if x6>=600-r-e  then w:=-w;
     if x6<=20+r+e then w:=-w;
     if y6<=300-r-e1 then w1:=-w1;
     if y6>=20+r+e1 then w1:=-w1;
      { 8-ой шар }
     circle_2(x7,y7,r,7);
     {delay(5);}
     circle_2(x7,y7,r,7);
     x7:=x7+p; y7:=y7+p1;
     if x7>=600-r-o  then p:=-p;
     if x7<=20+r+o then p:=-p;
     if y7<=300-r-o1 then p1:=-p1;
     if y7>=20+r+o1 then p1:=-p1;
      { 9-ый шар }
   until keypressed;
   CloseGraph
END.
























