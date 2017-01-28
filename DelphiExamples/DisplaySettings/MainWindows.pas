unit MainWindows;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  dmOrigin, dmNew: DEVMODE;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var ScreenDC: HDC;
begin
  Memo1.Clear;
  ScreenDC := GetDC(0);

  dmOrigin.dmSize := sizeof(DEVMODE);
  dmOrigin.dmFields := DM_PELSWIDTH or DM_PELSHEIGHT or DM_BITSPERPEL or DM_DISPLAYFREQUENCY;
  dmOrigin.dmDeviceName := '';
  dmOrigin.dmPelsWidth := GetDeviceCaps(ScreenDC, HORZRES);
  Memo1.Lines.Add('HORZRES: '+IntToStr(dmOrigin.dmPelsWidth));
  dmOrigin.dmPelsHeight := GetDeviceCaps(ScreenDC, VERTRES);
  Memo1.Lines.Add('VERTRES: '+IntToStr(dmOrigin.dmPelsHeight));
  dmOrigin.dmBitsPerPel := GetDeviceCaps(ScreenDC, BITSPIXEL);
  Memo1.Lines.Add('BITSPIXEL: '+IntToStr(dmOrigin.dmBitsPerPel));
  dmOrigin.dmDisplayFrequency := GetDeviceCaps(ScreenDC, VREFRESH);
  Memo1.Lines.Add('VREFRESH: '+IntToStr(dmOrigin.dmDisplayFrequency));

  ReleaseDC(0, ScreenDC);
end;

procedure TForm1.Button3Click(Sender: TObject);
var Res: longint;
begin
  Res := ChangeDisplaySettings(dmOrigin, 0);
  if Res = DISP_CHANGE_SUCCESSFUL then ShowMessage('Ok');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  dmNew.dmSize := sizeof(DEVMODE);
  dmNew.dmFields := DM_PELSWIDTH or DM_PELSHEIGHT or DM_BITSPERPEL or DM_DISPLAYFREQUENCY;
  dmNew.dmPelsWidth := StrToInt(Edit1.Text);
  dmNew.dmPelsHeight := StrToInt(Edit2.Text);
  dmNew.dmBitsPerPel := StrToInt(Edit3.Text);
  dmNew.dmDisplayFrequency := StrToInt(Edit4.Text);


  if ChangeDisplaySettings(dmNew, 0) = DISP_CHANGE_SUCCESSFUL then ShowMessage('Ok');
end;

end.
