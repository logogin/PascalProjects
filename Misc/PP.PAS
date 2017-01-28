         { *** drawing circle *** }
procedure circle_2(x,y,r,c:integer);
 begin
  setcolor(c);circle(x,y,r)
 end;
         { *** make sound *** }
procedure sound_2(a,b,c:integer);
 begin
  sound(a);delay(b);nosound;delay(c)
 end;
         { *** initialize GRAPH unit *** }
procedure initgraph_2;
var graphdriver,graphmode,errorcode:integer;
 begin
  GraphDriver:=Detect;InitGraph(GraphDriver,GraphMode,'C:\Pas\Bgi');
  ErrorCode:=GraphResult;
  if ErrorCode<>grOK
      then begin
             writeln('Ошибка графики:',GraphErrorMsg(ErrorCode));Halt(1)
           end
 end;
         { *** returned codes keyboard *** }
function retkey:char;
var ch:char;
 begin
  ch:=readkey;
  if ch=#0 then ch:=readkey;
  retkey:=ch;
 end;
         { *** going image *** }
procedure goImage(x,y,x1,y1,n:integer);
var p:pointer;
 begin
  getmem(p,imagesize(x,y,x1,y1));
  getimage(x,y,x1,y1,p);
  case n of
   1:begin putimage(x-1,y,p,0);
           putimage(x,y,p,0) end;
   2:begin putimage(x+1,y,p,0);
           putimage(x,y,p,0) end;
   3:begin putimage(x,y-1,p,0);
           putimage(x,y,p,0) end;
   4:begin putimage(x,y+1,p,0);
           putimage(x,y,p,0) end;
   5:begin putimage(x-1,y-1,p,0);
           putimage(x,y,p,0) end;
   6:begin putimage(x-1,y+1,p,0);
           putimage(x,y,p,0) end;
   7:begin putimage(x+1,y+1,p,0);
           putimage(x,y,p,0) end;
   8:begin putimage(x+1,y-1,p,0);
           putimage(x,y,p,0) end
  end;
  freemem(p,imagesize(x,y,x1,y1))
 end;












































