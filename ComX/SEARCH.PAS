  uses Dos;
var
  S: PathStr;
begin
  S := FSearch('windos.tpu','');
  if S = '' then
    WriteLn('TURBO.EXE not found')
  else
    { Show full path }
   WriteLn('Found as ',FExpand(S));
    readln
end.
