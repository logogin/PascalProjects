unit DelFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, RxGrdCpt;

type
  TFDelFile = class(TForm)
    PDelFile: TPanel;
    BDelFile: TSpeedButton;
    PMsg: TPanel;
    BCancel: TSpeedButton;
    LMsg1: TLabel;
    LMsg2: TLabel;
    LMsg3: TLabel;
    RxGradientCaption1: TRxGradientCaption;
    procedure BDelFileClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDelFile: TFDelFile;

implementation

{$R *.DFM}

procedure TFDelFile.BDelFileClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFDelFile.BCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
