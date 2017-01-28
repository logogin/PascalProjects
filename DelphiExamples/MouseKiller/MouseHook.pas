unit MouseHook;

interface

uses Wintypes,Winprocs,Messages;

function SetHook:Boolean; stdcall; export;
function UnHookHook:Boolean; stdcall; export;
function MouseProc(Code:integer; wParam: Word; lParam: Longint): Longint; stdcall; export;

procedure CompName(var Name: OleVariant); stdcall; export;

var HookedAlready:Boolean;

implementation

var

ourHook:HHook;
ServerWnd: hWND;


function SetHook:Boolean;
begin
if HookedAlready then exit;
ourHook:=SetWindowsHookEx(WH_keyboard ,@MouseProc,HInstance,0);
HookedAlready:=True;
end;

function UnHookHook:Boolean;
begin
UnHookWindowsHookEx(ourHook);
HookedAlready:=False;
end;

function MouseProc(Code:integer; wParam: Word; lParam: Longint): Longint;
begin
{ if (wParam=WM_LBUTTONDOWN) then
  begin
   MessageBeep(0);
   PostMessage(ServerWnd, UWM_MOUSEMOVE, )
  end;}
 //Code := HC_SKIP;
 result:= -1;//CallNextHookEx(ourHook,Code,wParam,lParam);
end;


procedure CompName(var Name: OleVariant); stdcall; export;
var
 A: dword;
 N: array [0..10] of char;
 PName: PChar;
begin
 A := 10;
 GetComputerName(N, A);
 PName := N;
 Name := String(PName);
end;

end.
