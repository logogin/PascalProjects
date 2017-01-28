unit kboard;
interface
  uses crt;

  const
   kbCtrl     :byte=4;
   kbAlt      :byte=8;
   kbRShift   :byte=1;
   kbLShift   :byte=2;
   kbInsert   :byte=128;
   kbCLock    :byte=64;
   kbSLock    :byte=16;
   kbNLock    :byte=32;
  var
   keys:byte absolute $0000:$0417;
  function    returnkey:char;

implementation

  function   returnkey:char;
  var chrkey:char;
  begin
   repeat until keypressed;
   chrkey:=readkey;
   if chrkey=#0 then chrkey:=readkey;
   returnkey:=chrkey
  end;

begin
end.