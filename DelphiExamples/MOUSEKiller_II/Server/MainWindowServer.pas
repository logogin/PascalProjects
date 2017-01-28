unit MainWindowServer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    btSetHook: TButton;
    btUnHook: TButton;
    btBlockMouse: TButton;
    btClearMouse: TButton;
    procedure btSetHookClick(Sender: TObject);
    procedure btUnHookClick(Sender: TObject);
    procedure btBlockMouseClick(Sender: TObject);
    procedure btClearMouseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  function SetHook:Boolean; stdcall; external 'MouseKillerDLL.dll';
  function UnHookHook:Boolean; stdcall; external 'MouseKillerDLL.dll';
  procedure SetBlockFlag; stdcall; external 'MouseKillerDLL.dll';
  procedure ClearBlockFlag; stdcall; external 'MouseKillerDLL.dll';

implementation

{$R *.DFM}

procedure TForm1.btSetHookClick(Sender: TObject);
begin
 SetHook;
end;

procedure TForm1.btUnHookClick(Sender: TObject);
begin
 UnHookHook;
end;

procedure TForm1.btBlockMouseClick(Sender: TObject);
begin
  SetBlockFlag;
end;

procedure TForm1.btClearMouseClick(Sender: TObject);
begin
  ClearBlockFlag;
end;

end.
