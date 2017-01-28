unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExeImage, ExtCtrls, rxtypes, ImgList;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FileOpenDialog: TOpenDialog;
    ImageViewer: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    FExeFile: TExeImage;
    procedure LoadResources(ResList: TResourceList);

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.LoadResources(ResList: TResourceList);
var
  I: Integer;
  Data: Pointer;
Begin
  for I := 0 to ResList.Count - 1 do
    with ResList[I] do begin
      if IsList then LoadResources(List)
      else
        if ResList[I].ResType = rtIconEntry then begin
          Data := ResList[I];
          ImageViewer.Picture.Assign(Data);
        end;
    end;
End;

procedure TForm1.Button1Click(Sender: TObject);
var
  TmpExeFile: TExeImage;
  Data: Pointer;
begin
  with FileOpenDialog do
  begin
    if not Execute then Exit;
    try
      TmpExeFile := TExeImage.CreateImage(Self, FileName);
      if Assigned(FExeFile) then FExeFile.Destroy;
      FExeFile := TmpExeFile;
      //LoadResources(TmpExeFile.Resources);
      Data := FExeFile.GetFirstIcon;
      ImageViewer.Picture.Assign(Data);
    except end;  
  end;
end;



end.
