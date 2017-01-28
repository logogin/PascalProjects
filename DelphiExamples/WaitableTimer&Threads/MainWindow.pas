unit MainWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const nTimerUnitsPerSecond: int64 = 10000000;
var
  hWATimer: THANDLE;
  WATimerName: PChar;
  li: TLargeInteger;
  hThread: THANDLE;
  idThread: DWORD;

procedure CreateAndInitWaitableTimer(const Sec: int64);
function ThreadFunc(pvParam: Pointer): integer;
procedure ExecuteThread(const Sec: int64);

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure CreateAndInitWaitableTimer(const Sec: int64);
  begin
    WATimerName := 'WATimer For Closing Client Session';
    hWATimer := CreateWaitableTimer(nil, FALSE, nil);
    li := -1 * nTimerUnitsPerSecond * Sec;
    if not SetWaitableTimer(hWATimer, li, 0, nil, nil, FALSE) then ShowMessage(':(');
  end;

function ThreadFunc(pvParam: Pointer): integer;
  var dw: DWORD;
  begin
    dw := WaitForSingleObject(hWATimer, INFINITE);
    CancelWaitableTimer(hWATimer);
    CloseHandle(hWATimer);
    case dw of
      WAIT_OBJECT_0: Form1.Edit1.Text := DateTimeToStr(now);//'WATimer works';
      WAIT_TIMEOUT: Form1.Edit1.Text := 'Time OUT';
      WAIT_FAILED: Form1.Edit1.Text := 'Wrong procedure call';
    end;
  end;

procedure ExecuteThread(const Sec: int64);
  begin
    CreateAndInitWaitableTimer(Sec);
    hThread := CreateThread(nil, 0, @ThreadFunc, nil, 0, idThread);
  end;
procedure TForm1.Button1Click(Sender: TObject);
begin
  ExecuteThread(StrToInt(Edit1.Text));
end;

end.
 