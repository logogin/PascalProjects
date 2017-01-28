unit dxpcmain;
interface

uses Windows, SysUtils, DXPlay, DirectX, StdCtrls, Controls,
     Buttons, Classes, ExtCtrls, Forms, SpyThr, Dialogs, DXClass;

type TTestForm = class (TForm)
       DXPlay : TDXPlay;
       MainPanel : TPanel;
       Connect : TSpeedButton;
       PhoneNumber : TEdit;
       DialMode : TComboBox;
       Modem : TComboBox;
       ExitButton : TSpeedButton;
       WaitForConnect : TSpeedButton;
       StartTimer: TTimer;
    AllowWaiting: TCheckBox;
       procedure FormDestroy (Sender : TObject);
       procedure FormCreate (Sender : TObject);
       procedure ExitButtonClick (Sender : TObject);
       procedure ConnectClick (Sender : TObject);
       procedure WaitForConnectClick (Sender : TObject);
       procedure StartTimerTimer(Sender: TObject);
     private
       SpyThread : TSpyThread;
       Waiting : Boolean;
     end;

var TestForm : TTestForm;

implementation

const MainCaption = 'Тестовая программа связи через DirectPlay';
      mcWaitingForUser = ' - [ожидание команды пользователя]';
      mcPhone = ' - [набор номера]';
      mcCallWaiting = ' - [ожидание входящего звонка]';
      dmPulse = 'ATDP';
      dmTone='ATDT';

{$R *.DFM}

procedure TTestForm.FormDestroy (Sender : TObject);
begin
  if SpyThread <> nil then SpyThread.Free;
  DXPlay.Close;
end;

procedure TTestForm.FormCreate (Sender : TObject);
begin
  Caption := MainCaption + mcWaitingForUser;
  DialMode.ItemIndex := 0;
  try
    Screen.Cursor := crHourGlass;
    Modem.Items := DXPlay.ModemSetting.ModemNames;
    Modem.ItemIndex := 0;
  finally
    Screen.Cursor := crDefault;
  end;
  Waiting := False;
  StartTimer.Enabled := True;
end;

procedure TTestForm.ExitButtonClick (Sender : TObject);
begin
  Close;
end;

procedure TTestForm.ConnectClick (Sender : TObject);
var I : Integer;
begin
  case DialMode.ItemIndex of
    0 : DXPlay.ModemSetting.PhoneNumber := dmPulse + PhoneNumber.Text;
    1 : DXPlay.ModemSetting.PhoneNumber := dmTone + PhoneNumber.Text;
  end;
  DXPlay.ModemSetting.ModemName := Modem.Items [Modem.ItemIndex];
  DXPlay.ModemSetting.Enabled := True;
  for I := 0 to DXPlay.Providers.Count - 1 do begin
    if CompareMem (PGUID (DXPlay.Providers.Objects [I]), @DPSPGUID_MODEM, SizeOf (TGUID))then begin
      DXPlay.ProviderName := DXPlay.Providers [I];
    end;
  end;
  try
    Screen.Cursor := crHourGlass;
    Caption := MainCaption + mcPhone;
    DXPlay.GetSessions;
  finally
    Screen.Cursor := crDefault;
    Caption := MainCaption + mcWaitingForUser;
  end;
end;

procedure TTestForm.WaitForConnectClick (Sender : TObject);
var ProvGUID : TGUID;
    X : IDirectPlay;
    I : Integer;

  procedure InitDirectPlay;
  begin
    DXDirectPlayCreate(ProvGUID, X, nil); { <> 0 then
      raise EDXPlayError.CreateFmt (SCannotInitialized, [SDirectPlay]);}
    DXPlay.FDPlay := X as IDirectPlay4A;
  end;

begin
  Caption := MainCaption + mcCallWaiting;
  try
    DXPlay.ModemSetting.ModemName := Modem.Items [Modem.ItemIndex];
    DXPlay.ModemSetting.Enabled := True;
    for I := 0 to DXPlay.Providers.Count - 1 do begin
      if CompareMem (PGUID (DXPlay.Providers.Objects [I]), @DPSPGUID_MODEM, SizeOf (TGUID))then begin
        ProvGUID := PGUID (DXPlay.Providers.Objects [I])^;
      end;
    end;
    InitDirectPlay;
    SpyThread := TSpyThread.Create (False);
    DXPlay.Open2 (True, 'NewSession', 'User');
    if DXPlay.IsHost then ShowMessage ('Host is present');
    SpyThread.Free;
  finally
    Caption := MainCaption + mcWaitingForUser;
    Waiting := False;
  end;
end;

procedure TTestForm.StartTimerTimer(Sender: TObject);
begin
  if (not Waiting) and AllowWaiting.Checked then begin
    Waiting := True;
    WaitForConnectClick (nil);
  end;
end;

end.
