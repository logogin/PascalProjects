 uses Graph,Crt;
  VAR x,y:word;
Procedure Init;
 var
   grDriver: Integer;
   grMode: Integer;
   ErrCode: Integer;
 begin
   grdriver:=installuserdriver('svga16',nil);
   GrMode:=0;
   InitGraph(grDriver, grMode,'');
   ErrCode := GraphResult;
   if ErrCode <> grOk then
    begin
     Writeln('Graphics error:', GraphErrorMsg(ErrCode));
     Halt(1);
   end;
   randomize;
  end;
 Procedure Move;
  Const vector:array[1..2,0..2] of shortint =((1,0,-1),
                                             (1,0,-1));

  begin

    x:=x+vector[1,random(2)];
    y:=y+vector[2,random(2)];
    if (x=0) then x:=x+1;
    if (x=3119) then x:=x-1;
    if (y=0) then y:=y+1;
    if (y=199) then y:=y-1;
  end;
 Function zaliplo:boolean;
  begin
   if( getpixel(x,y+1)<>0 ) or
     ( getpixel(x+1,y)<>0 ) or
     (getpixel(x+1,y+1)<>0) or
     (getpixel(x-1,y-1)<>0) or
     ( getpixel(x-1,y)<>0 ) or
     ( getpixel(x,y-1)<>0 ) or
     (getpixel(x-1,y+1)<>0) or
     (getpixel(x+1,y-1)<>0) then zaliplo:=true else zaliplo:=false;
   end;
  Procedure  Moving;
   begin
   repeat
   putpixel(x,y,0);
   move;
   putpixel(x,y,7);
   until zaliplo or keypressed;
   putpixel(x,y,red);
   end;
 BEGIN
  init;
  putpixel(110,100,red);
  repeat
   moving;
  until keypressed;

 END.