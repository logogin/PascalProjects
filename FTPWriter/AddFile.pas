unit AddFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Mask, ToolEdit, ExtCtrls, Buttons,
  RxGrdCpt;

type
  TFAddFile = class(TForm)
    FEFile: TFilenameEdit;
    LFileName: TLabel;
    LDest: TLabel;
    EDest: TEdit;
    PAddFile: TPanel;
    BAddFile: TSpeedButton;
    BCancel: TSpeedButton;
    RxGradientCaption1: TRxGradientCaption;
    procedure FormShow(Sender: TObject);
    procedure FEFileAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure FEFileChange(Sender: TObject);
    procedure BAddFileClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAddFile: TFAddFile;

implementation

{$R *.DFM}

procedure TFAddFile.FormShow(Sender: TObject);
begin
  if not FileExists (FEFile.FileName) then BAddFile.Enabled := False
    else BAddFile.Enabled := True;
end;

procedure TFAddFile.FEFileAfterDialog(Sender: TObject; var Name: String;
  var Action: Boolean);
begin
  if not FileExists (Name) then BAddFile.Enabled := False
    else BAddFile.Enabled := True;
end;

procedure TFAddFile.FEFileChange(Sender: TObject);
begin
  if not FileExists (FEFile.FileName) then BAddFile.Enabled := False
    else BAddFile.Enabled := True;
end;

procedure TFAddFile.BAddFileClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFAddFile.BCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
