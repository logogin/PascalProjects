unit mainWindow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, mmsystem;

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

implementation

{$R *.DFM}


procedure TForm1.Button1Click(Sender: TObject);
begin
  PlaySound('timefinished.wav', HInstance, SND_FILENAME or SND_ASYNC);
end;

procedure TForm1.Button2Click(Sender: TObject);
var FindHandle, ResHandle: THandle;

ResPtr: Pointer;
begin

FindHandle:=FindResource(HInstance, 'e:\temp\voiceresource.RES', RT_RCDATA);
if FindHandle<>0 then begin
ResHandle:=LoadResource(HInstance, FindHandle);
if ResHandle<>0 then begin
ResPtr:=LockResource(ResHandle);
if ResPtr<>Nil then
SndPlaySound(PChar(ResPtr), snd_ASync or snd_Memory);
UnlockResource(ResHandle);
end;
FreeResource(FindHandle);
end;
end;

end.
