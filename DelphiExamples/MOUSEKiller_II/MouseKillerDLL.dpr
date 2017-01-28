library MouseKillerDLL;

uses
 // SysUtils,
  //Windows,
  MouseHook in 'MouseHook.pas';

exports

SetHook index 1,
UnHookHook index 2,
MsgDlgProc index 3,
CompName index 4,

SetBlockFlag index 5,
ClearBlockFlag index 6;

{const
 UWM_MOUSEMOVE_MSG = 'UWM_MOUSEMOVE_MSG-44E531B1_14D3_11d5_A025_006067718D04';
var
 UWM_MOUSEMOVE: integer;}
begin
 HookedAlready:=False;
// UWM_MOUSEMOVE := RegisterWindowMessage(UWM_MOUSEMOVE_MSG);
end.
