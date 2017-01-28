Program GRAF MODUL;
Uses Graph,crt;
Var GraphDriver:integer;
    GraphMode  :integer;
    ErrorCode  :integer;
    x,i        :integer;
BEGIN
  GraphDriver:=Detect;
  InitGraph(GraphDriver,GraphMode,'C:\Pas\Bgi');
  ErrorCode:=GraphResult;
  if ErrorCode<>grOK then
 begin
    writeln('Ошибка графики:',GraphErrorMsg(ErrorCode));
    Halt(1);
 end;

  CloseGraf;
  ReadLn;
END.

  rectangle(50,60,70,80);
  rectangle(70,60,90,80);FloodFill(80,70,7);
  rectangle(90,60,110,80);
  rectangle(110,60,130,80);FloodFill(120,70,7);
  rectangle(130,60,150,80);
  rectangle(150,60,170,80);FloodFill(160,90,7);
  rectangle(170,60,190,80);
   ReadLn;
  CloseGraph;
 end.
