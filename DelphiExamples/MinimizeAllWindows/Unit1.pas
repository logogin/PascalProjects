unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function EnumWindowsProc(wnd: HWND; Param: LPARAM): BOOL; stdcall;

implementation

{$R *.dfm}

function EnumWindowsProc(wnd: HWND; Param: LPARAM): BOOL; stdcall;
var Res: BOOL;
Begin
  if not IsIconic(wnd) then Res := ShowWindow(wnd, SW_MINIMIZE);
//  Res := CloseWindow(wnd);

  Result := true;
End;

procedure TForm1.Button1Click(Sender: TObject);
begin
  EnumWindows(@EnumWindowsProc, 1);
end;

end.
