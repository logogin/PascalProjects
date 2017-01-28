program MouseKillerPrj;

uses
  Forms,
  MainWindow in 'MainWindow.pas' {Form1},
  MouseHook in 'MouseHook.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
