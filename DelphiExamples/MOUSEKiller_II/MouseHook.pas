unit MouseHook;

interface

uses Wintypes,Winprocs,Messages;

function SetHook:Boolean; stdcall; export;
function UnHookHook:Boolean; stdcall; export;
function MsgDlgProc(Code:integer; wParam: Word; lParam: Longint): Longint; stdcall; export;

procedure SetBlockFlag; stdcall; export;
procedure ClearBlockFlag; stdcall; export;

procedure CompName(var Name: OleVariant); stdcall; export;

var HookedAlready:Boolean;
    BlockFlag: boolean;
implementation

var
ourHook:HHook;


procedure SetBlockFlag;
begin
  BlockFlag := TRUE;
end;

procedure ClearBlockFlag;
begin
  BlockFlag := FALSE;
end;

function SetHook:Boolean;
begin
if HookedAlready then exit;
ourHook:=SetWindowsHookEx(WH_MOUSE,@MsgDlgProc,HInstance,0);
HookedAlready:=True;
end;

function UnHookHook:Boolean;
begin
UnHookWindowsHookEx(ourHook);
HookedAlready:=False;
end;

function MsgDlgProc(Code:integer; wParam: Word; lParam: Longint): Longint;
begin
 if BlockFlag then result:= -1
   else result := CallNextHookEx(ourHook,Code,wParam,lParam);
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
