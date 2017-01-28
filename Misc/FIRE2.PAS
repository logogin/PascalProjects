
 uses Graph,Crt;

var
  Driver, Mode,
  TestDriver,
  ErrCode,i,j,x,y: Integer;
 {$F+}
 function TestDetect: Integer;
{ Autodetect function: assume hardware is always present; return value =
   recommended default mode }
 begin
   TestDetect := 1;   { Default mode = 1 }
  end;
 {$F-}
begin
  Driver:=InstallUserDriver('svga256',nil);
  if Driver = grError then
    begin
     Writeln('Error');
     Halt(1);
    end;
  Mode:=0;
 { driver:=detect;}
  InitGraph(Driver, Mode, '');
  ErrCode := GraphResult;

  if ErrCode <> grOk then
  begin
    Writeln('Error during Init: ',ErrCode);
    Halt(1);
 end;
  for i:=1 to 15 do
   begin
    for j:=1 to 15 do
     begin
     setfillstyle(1,i+j);
     bar((i-1)*20,(j-1)*20,i*20 ,j*20);
   end;
end;
  readkey;
  CloseGraph;
end.

            `