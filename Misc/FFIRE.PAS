function DetectVGA256 : integer;
{ Detects VGA or MCGA video cards }
var
  DetectedDriver : integer;
  SuggestedMode  : integer;
begin
  DetectGraph(DetectedDriver, SuggestedMode);
  if (DetectedDriver = EGA) or (DetectedDriver = VGA) then
  begin
    Writeln('Which video mode would you like to use?');
    Writeln('  0) 320x200x16');
    Writeln('  1) 640x200x16');
    Writeln('  2) 640x350x16');
    Writeln('  3) 640x480x16');
    Writeln('  4) 800x600x16');
    Writeln('  5) 1024x768x16');
    Writeln('  6) 1280x1024x16');
    Write('> ');
    Readln(SuggestedMode);
    DetectVGA16 := SuggestedMode;
  end
  else
    DetectVGA16 := grError; { Couldn't detect hardware }
end; { DetectVGA256 }

begin
 AutoDetectPointer := @DetectVGA256;   { Point to detection routine }
      GraphDriver := InstallUserDriver('SVGA256', AutoDetectPointer);

      GraphDriver := Detect;
    InitGraph(GraphDriver, GraphMode, PathToDriver);
    ErrorCode := GraphResult;             { preserve error return }
    if ErrorCode AND $80 = $80 then
       ErrorCode := ErrorCode OR $ff00;
    if ErrorCode <> grOK then             { error? }
    begin
      Writeln('Graphics error: ', GraphErrorMsg(ErrorCode));
      if ErrorCode = grFileNotFound then  { Can't find driver file }
      begin
        Writeln('Enter full path to BGI driver or type <Ctrl-Break> to quit:');
        Readln(PathToDriver);
        Writeln;
      end
      else
        Halt(1);                          { Some other error: terminate }
    end;