unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  WinSock, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

procedure GetHostInfo(var Name, Address: string);

implementation
{$R *.DFM}

procedure GetHostInfo(var Name, Address: string);
var
  WSAData: TWSAData;
  HostEnt: PHostEnt;
begin
  { no error checking...}
  WSAStartup(2, WSAData);
  SetLength(Name, 255);
  Gethostname(PChar(Name), 255);
  SetLength(Name, StrLen(PChar(Name)));
  HostEnt := gethostbyname(PChar(Name));
  with HostEnt^  do
    Address := Format('%d.%d.%d.%d',[
      Byte(h_addr^[0]),
      Byte(h_addr^[1]),
      Byte(h_addr^[2]),
      Byte(h_addr^[3])]);
  WSACleanup;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  Name, Address: string;
begin
  GetHostInfo(Name, Address);
  ShowMessage(Name+'     '+Address);
end;

end.
 