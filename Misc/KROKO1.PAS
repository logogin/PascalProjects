Program Super1;
Uses Graph,crt;
Var GraphDriver:integer;
    GraphMode  :integer;
    ErrorCode  :integer;
    I,C          :integer;
    P            :pointer;

 begin
  GraphDriver:=Detect;
  InitGraph(GraphDriver,GraphMode,'C:\Pas\Bgi');
  ErrorCode:=GraphResult;
  if ErrorCode<>grOK then
   begin
    writeln('Ошибка графики:',GraphErrorMsg(ErrorCode));
    Halt(1);
   end;
  SetViewPort(0,0,GetMaxX,GetMaxY,ClipOn);
  GetMem(P,IMageSize(30,100,50,120));
  Circle(40,110,9);
  FloodFill(40,110,7);
  GetIMage(30,100,50,120,P^);
  ClearDevice;
  C:=30;
  For I:=31 to 610 do
   begin
    PutIMage(I,90,P^,NormalPut);
    PutIMage(C,90,P^,NormalPut);
    C:=C+1;
   end;
  ReadLn;
  CloseGraph;
 end.
