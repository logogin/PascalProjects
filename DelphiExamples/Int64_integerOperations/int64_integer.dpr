program int64_integer;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var t: Int64;
      a, b: integer;
begin
  a := 300; b := 10000000;
  write(a*b);
  readln;
  readln;
end.
 