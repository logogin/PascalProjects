unit MainWindowServer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  function SetHook:Boolean; stdcall; external 'MouseKillerDLL.dll';
  function UnHookHook:Boolean; stdcall; external 'MouseKillerDLL.dll';
  function MouseProc(Code:integer; wParam: Word; lParam: Longint): Longint; stdcall; external 'MouseKillerDLL.dll';

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
 SetHook;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 UnHookHook;
end;

end.
