program zadaha4m;
uses crt,graph;
 var xfor,yfor:integer;
     x,y:integer;
     errorcode:integer;
     graphdriver:integer;
     graphmode:integer;
procedure beep(a,b:integer);
begin
sound(a);delay(3);nosound;delay(2);
sound(b);delay(5);nosound;
end;
BEGIN
  GraphDriver:=Detect;
  InitGraph(GraphDriver,GraphMode,'C:\Pas\Bgi');
  ErrorCode:=GraphResult;
  if ErrorCode<>grOK then
        begin
          writeln('Ошибка графики:',GraphErrorMsg(ErrorCode));
          Halt(1);
        end;
 clearviewport;
 x:=10;
 y:=20;
 line(10,71,640,71);
 for yfor:=1 to 50 do
  begin
   for xfor:=1 to 10 do
    begin
     putpixel(x,y,white);
     putpixel(x-1,y,black);
     x:=x+1;
     beep(yfor*10+100,xfor*10+100)
    end;
   putpixel(x-1,y,black);
   y:=y+1
  end;
 for yfor:=1 to 10 do
  begin
   for xfor:=1 to 10 do
    begin
     beep(700,500);
     putpixel(x,y,white);
     putpixel(x-1,y,black);
     x:=x+1;
     sound(x*10);delay(3);nosound;delay(5)
    end;
   putpixel(x-1,y,black);
   y:=y-1
  end;
 delay(70);
 circle(600,60,20);
 floodfill(600,63,white);
 sound(300);delay(10);nosound;
 clearviewport;
 line(10,70,640,70);
 readln;
 closegraph
END.

























