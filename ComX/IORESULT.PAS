  uses Crt;

var F: file of Byte;
var I: Word;
begin
  { Get file name command line }
  Assign(F, ParamStr(1));
  {$I-}
  Reset(F);
  {$I+}
  if IOResult = 0 then
	 Writeln('File size in bytes: ', FileSize(F))
  else
	 Writeln('File not found');
	 readln;
	 
  for I := 1 to ParamCount do
	 Writeln(ParamStr(I));
	 readln
end.

