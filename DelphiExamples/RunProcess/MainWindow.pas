unit MainWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ShellAPI,
  ComCtrls, ImgList, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    odlgProcess: TOpenDialog;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ilAppIcons: TImageList;
    Panel1: TPanel;
    ListView1: TListView;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure RunApplication(const Caption: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  si: STARTUPINFO;
  pi: PROCESS_INFORMATION;
  szCommandLine: PChar;

implementation

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if odlgProcess.Execute then Edit1.Text := odlgProcess.FileName;
end;

procedure TForm1.RunApplication(const Caption: string);
var Pic: TPicture;
    ListItem: TListItem;
    i, iconindex: integer;
    flag: boolean;
    ico: HICON;
    im: TImage;
Begin
  si.cb :=sizeof(si);
  si.lpReserved := nil;
  si.lpDesktop := nil;
  si.lpTitle := nil;
  si.dwX := 0;
  si.dwY := 0;
  si.dwXSize := 200;
  si.dwYSize := 200;
  si.dwXCountChars := 0;
  si.dwYCountChars := 0;
  si.dwFillAttribute := 0;
  si.dwFlags := 0;
  si.wShowWindow := 1;
  si.cbReserved2 := 0;
  si.lpReserved2 := 0;
  si.hStdInput := 0;
  si.hStdOutput := 0;
  si.hStdError := 0;
  if Caption = '' then szCommandLine := PChar(Edit1.text) else szCommandLine := PChar(Caption);
  if CreateProcess(nil, szCommandLine, nil, nil, FALSE, 0, nil, nil, si, pi) then begin
    flag := FALSE;
    for i := 0 to ListView1.Items.Count-1 do
      if ListView1.Items[i].Caption = szCommandLine then begin flag := TRUE; break; end;
    if not flag then begin
      ico := 0;
      ico :=  ExtractIcon( HINSTANCE, szCommandLine, 0);
      Pic := TPicture.Create;
      Pic.Icon.Handle := ico;
      ilAppIcons.AddIcon(Pic.Icon);
      ListItem := ListView1.Items.Add;
      ListItem.Caption := szCommandLine;
      ListItem.ImageIndex := ilAppIcons.Count-1;
    end;
  end;
End;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  TerminateProcess(pi.hProcess, 0);
  CloseHandle(pi.hThread);
  CloseHandle(pi.hProcess);
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  SuspendThread(pi.hThread);
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  ResumeThread(pi.hThread);
end;

procedure TForm1.ListView1DblClick(Sender: TObject);
begin
  RunApplication(ListView1.Items[ListView1.ItemIndex].Caption);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  RunApplication('');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  TerminateProcess(pi.hProcess, 0);
//  CloseHandle(pi.hThread);
//  CloseHandle(pi.hProcess);
end;

end.
