unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
     VolumeName, 
     FileSystemName     : array [0..MAX_PATH-1] of Char;
     VolumeSerialNo     : DWord;
     MaxComponentLength,
     FileSystemFlags    : DWORD;
   begin
     GetVolumeInformation(PChar(Edit1.Text),VolumeName,MAX_PATH,@VolumeSerialNo,
                          MaxComponentLength,FileSystemFlags,
                          FileSystemName,MAX_PATH);
     Memo1.Lines.Add('VName = '+VolumeName);
     Memo1.Lines.Add('SerialNo = $'+IntToHex(VolumeSerialNo,8));
     Memo1.Lines.Add('CompLen = '+IntToStr(MaxComponentLength));
     Memo1.Lines.Add('Flags = $'+IntToHex(FileSystemFlags,4));
     Memo1.Lines.Add('FSName = '+FileSystemName);
   end;


end.
