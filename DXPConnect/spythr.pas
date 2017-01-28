unit spythr;
interface
uses Classes, Windows, Messages, Dialogs;

type
  TSpyThread = class(TThread)
  private
  { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

{ SpyThread }
procedure TSpyThread.Execute;
label M1;
var WinHandle, BtnHandle : HWND;
begin
M1:
  WinHandle := FindWindow (nil, 'Подключение через модем');
  if WinHandle <> 0 then begin
    BtnHandle := FindWindowEx (WinHandle, 0, nil, PChar('Ответить...'));
    if BtnHandle <> 0 then begin
      SendMessage (BtnHandle, BM_Click, 0, 0);
    end
    else goto M1
  end
  else goto M1;
end;

end.
