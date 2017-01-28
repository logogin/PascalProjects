program PixelGraph;
uses
  Graph,Crt;
const
  Start   =  25;
  Finish  = 175;
  Step    =   2;
var
  GraphDriver:integer;  {Запоминает номер графического драйвера}
  GraphMode:integer; {Запоминает графический режим для драйвера}
  ErrorCode:word;      {Сообщает об исключительной ситуации}
  X1,Y1,X2,Y2,Y3 : integer;
  vk1,gk1,vk2,gk2: string;
begin
  clrscr;
  GraphDriver := Detect;  {Автообнаружение графической платы}
  InitGraph(GraphDriver, GraphMode, '');
  ErrorCode := GraphResult;
  if ErrorCode <> grOK then
  {Ошибка^}
  begin
     Writeln('Графическая ошибка:',GraphErrorMsg(ErrorCode));
     Writeln('(Возможно отсутствует графическая плата!)');
     Writeln('Выполнение программы прервано...');
     Halt(1);
  end;
  OutText('введите координаты x1 y1 x2 y2 -->');
  readln(x1);Str(x1,vk1);OutTextXY(10,40,vk1);
  readln(y1);Str(y1,gk1);OutTextXY(20,40,gk2);
  readln(x2);Str(x2,vk2);OutTextXY(30,40,vk2);
  readln(y2);Str(y2,gk2);OutTextXY(40,40,gk2);
  Rectangle(x1,y1,x2,y2);
  OutText('нажмите клавишу <enter>');
  Readln;
  CloseGraph;
end.    {  PixelGraph  }

