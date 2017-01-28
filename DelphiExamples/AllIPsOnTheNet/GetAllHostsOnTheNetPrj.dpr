program GetAllHostsOnTheNetPrj;
{$APPTYPE CONSOLE}
uses
  SysUtils,
  classes,
  NetUtils in 'NetUtils.pas';

var
 List:TList;
 i: integer;
begin
 List:=TList.Create;
 List:=GetContainerList(nil); // Получили список сетей.
                             //  Как правило первая - сеть Microsoft
 List:=GetContainerList(List[0]); //Получаем список доменов сети
 for i:=0 to List.Count-1 do
   if PNetRes(List[i])^.RemoteName='OCA' then
     begin
     List:=GetContainerList(List[i]);
     Break;
     end;
 // теперь в List - список включённых компьютеров
 // в домене/рабочей группе YourDomain. Каждый элемент списка имеет
 // тип PNetRes. Само имя компьютера можно получить List[i])^.RemoteName
 for i := 0 to List.Count-1 do writeln(PNetRes(List[i])^.RemoteName);
end.
