unit PropFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, RxGrdCpt;

type
  TFPropFile = class(TForm)
    PPropFile: TPanel;
    BApply: TSpeedButton;
    BCancel: TSpeedButton;
    LFileName: TLabel;
    EFileName: TEdit;
    LDest: TLabel;
    EDest: TEdit;
    RxGradientCaption1: TRxGradientCaption;
    procedure BApplyClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPropFile: TFPropFile;

implementation

{$R *.DFM}

procedure TFPropFile.BApplyClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFPropFile.BCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
