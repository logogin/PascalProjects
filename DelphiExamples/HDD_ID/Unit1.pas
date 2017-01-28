unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, winsock;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function GetCPUSpeed: Double;
function GetHDDID: string;
function my_ip_address:longint;

implementation

function GetCPUSpeed: Double;
const

DelayTime = 500;
var

TimerHi : DWORD;
TimerLo : DWORD;
PriorityClass : Integer;
Priority : Integer;
begin

PriorityClass := GetPriorityClass(GetCurrentProcess);
Priority := GetThreadPriority(GetCurrentThread);
SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);


Sleep(10);


asm
DW 310Fh // rdtsc
MOV TimerLo, EAX
MOV TimerHi, EDX
end;


Sleep(DelayTime);


asm
DW 310Fh // rdtsc
SUB EAX, TimerLo
SBB EDX, TimerHi
MOV TimerLo, EAX
MOV TimerHi, EDX
end;


SetThreadPriority(GetCurrentThread, Priority);
SetPriorityClass(GetCurrentProcess, PriorityClass);


Result := TimerLo / (1000.0 * DelayTime);
end;


function GetHDDID: string;
var
SerialNum : pdword;
a, b : dword;
i: integer;
Buffer  : array [0..255] of char;
begin

if GetVolumeInformation('c:\', Buffer, SizeOf(Buffer), SerialNum, a, b, nil, 0) then
 i := SerialNum^;
Result := IntToStr(i);

end;

function my_ip_address:longint;
const

bufsize=20;
var

buf: pointer;
RemoteHost : PHostEnt; (* Не освобождайте это! *)
begin

buf:=NIL;
//try
getmem(buf,bufsize);
gethostname(buf,bufsize);   (* это может работать и без сети *)
ShowMessage(String(buf));
//RemoteHost:=Winsock.GetHostByName(buf);
//if RemoteHost=NIL then
//my_ip_address:=winsock.htonl($07000001)  (* 172.16.152.7 *)
//else
//my_ip_address:=longint(pointer(RemoteHost^.h_addr_list^)^);
//finally
//if buf<>NIL then  freemem(buf,bufsize);
//end;
//result:=winsock.ntohl(result);
freemem(buf,bufsize);
end;


{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
 ShowMessage(FloatToStr(GetCPUSpeed));
end;

procedure TForm1.Button2Click(Sender: TObject);
var

SerialNum : pdword;
a, b : dword;
Buffer  : array [0..255] of char;
begin

if GetVolumeInformation('c:\', Buffer, SizeOf(Buffer), SerialNum, a, b, nil, 0) then
Label1.Caption := IntToStr(SerialNum^);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 ShowMessage(IntToStr(my_ip_address));
end;

end.
