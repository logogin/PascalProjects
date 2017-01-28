program CodKey;
  uses Crt;
  Const
   ESC=#27;                   {код клавиши КЛЮЧ}
  Label 1,2;
  Var
   i : integer;
   Ch : char;
  Begin
   ClrScr;
   for i:=1 to 20 do
    begin
    write(i);
  1: if KeyPressed then begin Ch:=ReadKey;end else goto 1;
    writeln('  ',ord(Ch));
    end;
  2: if KeyPressed then begin Ch:=ReadKey end else goto 2;
     if ord(Ch)<>77 then goto 2;
  End.