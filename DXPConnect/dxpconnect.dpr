program dxpconnect;

uses
  Forms,
  dxpcmain in 'dxpcmain.pas' {TestForm},
  spythr in 'spythr.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TTestForm, TestForm);
  Application.HintPause := 0;
  Application.Run;
end.
