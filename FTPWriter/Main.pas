unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls,
  Psock, NMFtp, AddFile, IniFiles, DelFile, PropFile, RxGrdCpt;

type
  TFWStatus = (Disconnected, Connected, Written);

  TFMain = class(TForm)
    PTools: TPanel;
    BConnect: TSpeedButton;
    BDisconnect: TSpeedButton;
    BWrite: TSpeedButton;
    BClose: TSpeedButton;
    Bvl1: TBevel;
    SBStatus: TStatusBar;
    PCPages: TPageControl;
    TSConnection: TTabSheet;
    EUserName: TEdit;
    LUserName: TLabel;
    LPassword: TLabel;
    EPassword: TEdit;
    LHostName: TLabel;
    EHostName: TEdit;
    Bvl2: TBevel;
    FTP: TNMFTP;
    LPort: TLabel;
    EPort: TEdit;
    TSWriting: TTabSheet;
    PCommands: TPanel;
    LWFiles: TListView;
    BAddFile: TSpeedButton;
    BDelFile: TSpeedButton;
    TSNone: TTabSheet;
    BPropFile: TSpeedButton;
    RxGradientCaption1: TRxGradientCaption;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure BConnectClick(Sender: TObject);
    procedure BWriteClick(Sender: TObject);
    procedure BDisconnectClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure BAddFileClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure BDelFileClick(Sender: TObject);
    procedure LWFilesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure BPropFileClick(Sender: TObject);
  private
    { Private declarations }
    Status : TFWStatus;
    Files, Dests : TStringList;
    procedure UpdateSBStatus;
    procedure UpdateLWFiles;
    procedure InitConfig;
    procedure SaveConfig;
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.DFM}

procedure TFMain.SaveConfig;
var I : TIniFile;
    K : Integer;
    F : file;
begin
  I := TIniFile.Create (ExtractFilePath (Application.ExeName) +
    'config.ini');
  I.WriteString ('FTP Defaults', 'HostName', FTP.Host);
  I.WriteInteger ('FTP Defaults', 'Port', FTP.Port);
  I.WriteString ('FTP Defaults', 'UserName', FTP.UserID);
  I.Free;
  AssignFile (F, ExtractFilePath (Application.ExeName) + 'files.ini');
  Erase (F);
  I := TIniFile.Create (ExtractFilePath (Application.ExeName) +
    'files.ini');
  if Files.Count > 0 then
    for K := 0 to Files.Count - 1 do
      I.WriteString (Files.Strings [K], 'Dest', Dests.Strings [K]);
  I.Free;
end;

procedure TFMain.InitConfig;
var I : TIniFile;
    K : Integer;
begin
  Files := TStringList.Create;
  Dests := TStringList.Create;
  if ParamCount = 2 then begin
    if FileExists (ParamStr (1)) then I := TIniFile.Create (ParamStr (1))
      else begin
        ShowMessage ('Файл с настройками FTP не найден по указанному пути');
        Exit;
      end;
  end
  else
    I := TIniFile.Create (ExtractFilePath (Application.ExeName) +
      'config.ini');
  EHostName.Text := I.ReadString ('FTP Defaults', 'HostName', '');
  EPort.Text := I.ReadString ('FTP Defaults', 'Port', '');
  EUserName.Text := I.ReadString ('FTP Defaults', 'UserName', '');
  I.Free;
  if ParamCount = 2 then begin
    if not FileExists (ParamStr (2)) then begin
      ShowMessage ('Не найден указанный в командной строке список файлов');
      Exit;
    end;
    I := TIniFile.Create (ParamStr (2));
  end
  else I := TIniFile.Create (ExtractFilePath (Application.ExeName) +
    'files.ini');
  I.ReadSections (Files);
  if Files.Count <> 0 then begin
    for K := 0 to Files.Count - 1 do
      Dests.Add (I.ReadString (Files.Strings [K], 'Dest', ''));
  end;
  I.Free;
end;

procedure TFMain.UpdateLWFiles;
var K : Integer;
    F : file;
begin
  LWFiles.Items.Clear;
  if Files.Count = 0 then Exit;
  for K := 0 to Files.Count - 1 do begin
    LWFiles.Items.Add;
    LWFiles.Items.Item [LWFiles.Items.Count - 1].Caption := Files.Strings [K];
    if not FileExists (Files.Strings [K]) then begin
      ShowMessage ('Файл ' + Files.Strings [K] + ' не найден');
      LWFiles.Items.Delete (LWFiles.Items.Count - 1);
      Continue;
    end;
    AssignFile (F, Files.Strings [K]);
    Reset (F, 1024);
    LWFiles.Items.Item [LWFiles.Items.Count - 1].SubItems.Add (IntToStr
      (FileSize (F)) + ' K');
    CloseFile (F);
    LWFiles.Items.Item [LWFiles.Items.Count - 1].SubItems.Add
      (Dests.Strings [K]);
  end;
end;

procedure TFMain.UpdateSBStatus;
begin
  case Status of
    Disconnected : begin
      SBStatus.Panels.Items [0].Text := 'Сервер не найден';
      BConnect.Font.Style := BConnect.Font.Style + [fsBold];
      BConnect.Enabled := True;
      BDisconnect.Font.Style := BDisconnect.Font.Style - [fsBold];
      BDisconnect.Enabled := False;
      BWrite.Font.Style := BConnect.Font.Style - [fsBold];
      BWrite.Enabled := False;
      BClose.Enabled := True;
    end;
    Connected : begin
      SBStatus.Panels.Items [0].Text := EHostName.Text;
      BConnect.Font.Style := BConnect.Font.Style - [fsBold];
      BConnect.Enabled := False;
      BDisconnect.Font.Style := BDisconnect.Font.Style - [fsBold];
      BDisconnect.Enabled := True;
      BWrite.Font.Style := BConnect.Font.Style + [fsBold];
      BWrite.Enabled := True;
      BClose.Enabled := False;
    end;
    Written : begin
      BConnect.Font.Style := BConnect.Font.Style - [fsBold];
      BConnect.Enabled := False;
      BDisconnect.Font.Style := BDisconnect.Font.Style + [fsBold];
      BDisconnect.Enabled := True;
      BWrite.Font.Style := BConnect.Font.Style - [fsBold];
      BWrite.Enabled := False;
      BClose.Enabled := False;
    end;
  end;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  PCPages.ActivePage := TSConnection;
  Status := Disconnected;
  UpdateSBStatus;
  InitConfig;
end;

procedure TFMain.BConnectClick(Sender: TObject);
begin
  FTP.Host := EHostName.Text;
  FTP.UserID := EUserName.Text;
  FTP.Password := EPassword.Text;
  try
    FTP.Port := StrToInt (EPort.Text);
  except
    ShowMessage ('Номер порта должен иметь целочисленное значение');
    Exit;
  end;
  Enabled := False;
  Cursor := crHourGlass;
  try
    try
      FTP.Connect;
    except
      ShowMessage ('Сервер не найден. Проверьте правильность указанных параметров');
      Exit;
    end;
  finally
    Cursor := crDefault;
    Enabled := True;
  end;
  PCPages.ActivePage := TSWriting;
  Status := Connected;
  UpdateSBStatus;
  UpdateLWFiles;
end;

procedure TFMain.BWriteClick(Sender: TObject);
var I, S : Integer; F : file;
begin
  Status := Written;
  PCPages.ActivePage := TSNone;
  UpdateSBStatus;
  SaveConfig;
  Enabled := False;
  Cursor := crHourGlass;
  try
    for I := 0 to Files.Count - 1 do begin
      try
        AssignFile (F, Files.Strings [I]);
        Reset (F, 1);
        S := FileSize (F);
        CloseFile (F);
        FTP.Allocate (S);
        FTP.ChangeDir (Dests.Strings [I]);
        FTP.Upload (Files.Strings [I], ExtractFileName (Files.Strings [I]));
      except
        ShowMessage ('Возникла ошибка при отправке файла ' +
          ExtractFileName (Files.Strings [I]) +
          ' в ' + Dests.Strings [I]);
      end;
    end;
  finally
    Cursor := crDefault;
    Enabled := True;
  end;
end;

procedure TFMain.BDisconnectClick(Sender: TObject);
begin
  Enabled := False;
  try
    FTP.Disconnect;
  finally
    Enabled := True;
  end;
  PCPages.ActivePage := TSConnection;
  Status := Disconnected;
  UpdateSBStatus;
end;

procedure TFMain.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFMain.BAddFileClick(Sender: TObject);
begin
  if FAddFile.ShowModal = mrOk then begin
    Files.Add (FAddFile.FEFile.FileName);
    Dests.Add (FAddFile.EDest.Text);
    UpdateLWFiles;
  end;
end;

procedure TFMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Status <> Disconnected then CanClose := False else CanClose := True;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  Files.Free;
  Dests.Free;
end;

procedure TFMain.BDelFileClick(Sender: TObject);
var I : Integer;
begin
  if LWFiles.ItemFocused = nil then begin
    BDelFile.Enabled := True;
    BPropFile.Enabled := True;
    Exit;
  end;
  FDelFile.LMsg2.Caption := LWFiles.Selected.Caption;
  if FDelFile.ShowModal = mrOk then begin
    I := Files.IndexOf (LWFiles.Selected.Caption);
    Files.Delete (I);
    Dests.Delete (I);
    UpdateLWFiles;
  end;
end;

procedure TFMain.LWFilesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then begin
    BDelFile.Enabled := True;
    BPropFile.Enabled := True;
  end
  else begin
    BDelFile.Enabled := False;
    BPropFile.Enabled := False;
  end;
end;

procedure TFMain.BPropFileClick(Sender: TObject);
var I : Integer;
begin
  if LWFiles.ItemFocused = nil then begin
    BDelFile.Enabled := True;
    BPropFile.Enabled := True;
    Exit;
  end;
  I := Files.IndexOf (LWFiles.Selected.Caption);
  FPropFile.EFileName.Text := Files.Strings [I];
  FPropFile.EDest.Text := Dests.Strings [I];
  if FPropFile.ShowModal = mrOk then begin
    Dests.Strings [I] := FPropFile.EDest.Text;
    UpdateLWFiles;
  end;
end;

end.
