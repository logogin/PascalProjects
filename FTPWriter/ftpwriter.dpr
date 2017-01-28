program ftpwriter;

uses
  Forms,
  Main in 'Main.pas' {FMain},
  AddFile in 'AddFile.pas' {FAddFile},
  DelFile in 'DelFile.pas' {FDelFile},
  PropFile in 'PropFile.pas' {FPropFile};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFAddFile, FAddFile);
  Application.CreateForm(TFDelFile, FDelFile);
  Application.CreateForm(TFPropFile, FPropFile);
  Application.Run;
end.
