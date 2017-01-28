program smallALTTAB;

{автор Richard Leigh, Deakin Univesity 1997}

uses
  WinProcs;

{$R *.RES}

var

Dummy : integer;

begin

Dummy := 0;
{Отключаем ALT-TAB}
SystemParametersInfo( SPI_SETFASTTASKSWITCH, 1, @Dummy, 1);
end.
