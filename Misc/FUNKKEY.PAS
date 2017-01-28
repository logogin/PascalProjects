program FunkKey;
 uses Crt,Graph;
 var
   Driver,Mode:integer;
   ch:char;
Begin
  Driver:=HercMono;
  Mode:=HercMonoHi;
  InitGraph(Driver,Mode,'');
  repeat
    repeat until KeyPressed;
    ch:=ReadKey;
    if ch=#0 then ch:=ReadKey;
    OutText(ch);
  until ch=#13;
  CloseGraph
End.