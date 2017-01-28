program DrawOnDC;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  windows;

var ScreenDC: HDC;
    Text: PChar;
    flag: BOOL;
begin
  ScreenDC := GetDC(0);
  Text := 'Hell';
  while true do
  flag := TextOut(ScreenDC,           // handle to DC
          100,       // x-coordinate of starting position
          100,       // y-coordinate of starting position
          Text,  // character string
          4       // number of characters
          );
 DeleteDC(ScreenDC);
 write(BOOLToStr(flag));
 readln;
end.
