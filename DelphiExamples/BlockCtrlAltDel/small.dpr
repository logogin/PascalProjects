program small;

{автор Richard Leigh, Deakin Univesity 1997}

uses
  WinProcs;

{$R *.RES}

var

Dummy : integer;

begin

Dummy := 0;
{Отключаем CTRL-ALT-DEL}
SystemParametersInfo( SPI_SCREENSAVERRUNNING, 1, @Dummy, 0);
end.
