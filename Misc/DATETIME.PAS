{$S-,R-,I-,B-}
{$M $400,0,0}
Program DataTime;
 Uses Crt,Dos;
 Const
 Attr=$70;
 Esc=#27;
 BodyIntD6:word=$CF90;
 CopyPrefixSeg:word=0;
 OldIntD6:pointer=Nil;
 OldInt09:pointer=Nil;
 OldInt28:pointer=Nil;
 MaskaTsr:byte=$0A;
 ActStr:string[94]=
  'Нажмите [ALT+LeftShift] для показания даты и времени ,'#13#10+
  'нажатие клавиши [ESC] возвращает управление.';
 OptStr:string[43]=
  'Я в коммандной строке, выгружаю резидент';
 SizeBuf=17;
 Type
 St8=string[8];
 BufArr=array[1..SizeBuf] of word;
 PtrArr=array[1..6] of pointer;
 Bptr=^PtrArr;
 BufPtr=^BufArr;
 Var
 KeyFlag:byte absolute $0:$417;
 TsrSS,TsrSP:word;
 OldSS,oldSP:word;
 Bufer:BufArr;
 XYcurs:word;
 ScanCurs:word;
 FlagBusy:boolean;
StDate:St8;
CH:char;
I,Parms:word;
 Function CheckResident:boolean;
   begin
     GetIntVec($D6,OldIntD6);
     CheckResident:=((OldIntD6<>Nil) and (Word(OldIntD6^)=BodyIntD6));
   end;
 Procedure SetData;
   begin
     CheckBreak:=False;
     FlagBusy:=False;
     CopyPrefixSeg:=PrefixSeg;
     TsrSS:=Sseg;
     TsrSp:=Sptr;
     GetIntVec($09,OldInt09);
     GetIntVec($28,OldInt28);
   end;
 Function IntTextMode:Boolean;
   begin
     case Lo(LastMode) of
       BW80,CO80,Mono:IntTextMode:=True
       else IntTextMode:=False;
     end;
   end;
 Function MyGetTime:St8;
  Var St:St8;
      Hour,Mins,Sec,Sec100:word;
      S1:string[2];
   begin
     GetTime(Hour,Mins,Sec,Sec100);
     Str(Hour,S1);
     If Hour<10 then S1:='0'+S1;
     st:=s1;
     Str(Mins,S1);
     If Mins<10 then S1:='0'+S1;
     St:=St+':'+S1;
     Str(Sec,S1);
     If Sec<10 then s1:='0'+S1;
     St:=St+':'+S1;
     MyGetTime:=St;
   end;
 Function MyGetDate:St8;
  Var St:St8;
      Year,Month,Day,DayWeek:word;
      S1:string[4];
   begin
     GetDate(Year,Month,Day,DayWeek);
     Str(Day,S1);
     If Day<10 then S1:='0'+S1;
     St:=s1;
     Str(Month,S1);
     If Month<10 then S1:='0'+S1;
     St:=St+'/'+S1;
     Str(Year,S1);
     Delete(S1,1,2);
     St:=St+'/'+S1;
     MyGetDate:=St;
   end;
 Procedure Unload;
  Var OldPSP:word;
      P:Pointer;
      Regs:registers;
   begin
     writeln('DataTime выгружается из памяти ...');
     OldPSP:=BufPtr(OldIntD6)^[2];
     P:=Bptr(OldIntD6)^[2];
     SetIntVec($09,P);
     P:=Bptr(OldIntD6)^[3];
     SetIntVec($09,P);
     p:=Bptr(OldIntD6)^[4];
     SetIntVec($28,P);
     FillChar(Regs,SizeOf(Regs),0);
     With Regs do
      begin
       AH:=$49;
       ES:=MemW[OldPSP:$2C];
       MsDos(Regs);
       AH:=$49;
       ES:=OldPSP;
       MsDos(Regs);
      end;
   end;
 Procedure Cli;
  InLine($FA);
 Procedure Sti;
  InLine($FB);
 Procedure CallInt09;
  InLine($9C/$3E/$FF/$1E/OldInt09);
 Procedure CallInt28;
  InLine($9C/$3E/$FF/$1E/OldInt28);
 Procedure SaveStackRegs;
  InLine($3E/$8C/$16/OLdSS/$3E/$89/$26/OldSP/$3E/$8E/$16/TsrSS/$3E/$8B/$26/TsrSP);
 Procedure RestoreStackRegs;
  InLine($3E/$8E/$16/OldSS/$3E/$8E/$26/OldSP);
 Procedure BodyInt;
  Label ExLn;
   begin
     Cli;
     FlagBusy:=True;
     SaveStackRegs;
     Sti;
     If not IntTextMode then GoTo ExLn;
     StDate:=MyGetDate;
     CH:=#1;
     repeat
       writeln(StDate +' '+ MyGetTime);
       If KeyPressed Then
         begin
           CH:=ReadKey;
           If CH=#0 Then
             begin
               CH:=ReadKey;
               CH:=#1;
             end;
         end;
     until CH=ESC;
     ExLn:
     Cli;
     RestoreStackRegs;
     FlagBusy:=False;
     Sti;
   end;
 Procedure IntHand28(Flags,CS,IP,AX,BX,CX,DX,SI,DI,DS,BP:word);
  InTerrupt;
   begin
     Cli;
     CallInt28;
     if ((KeyFlag and MaskaTsr=MaskaTsr) and not Flagbusy) then BodyInt;
     Sti;
   end;
 Procedure IntHand09(Flags,CS,IP,AX,BX,CX,DX,SI,DI,DS,ES,BP:word);
  Interrupt;
   begin
     Cli;
     CallInt09;
     if ((KeyFlag and MaskaTsr=MaskaTsr) and not Flagbusy) then BodyInt;
   end;
BEGIN
 SwapVectors;
 if CheckResident then
   begin
     Parms:=ParamCount;
     if Parms<>0 then
       begin
         for i:=1 to Parms do
           if (ParamStr(i)='-R') or (ParamStr(i)='-r') then Unload;
       end else write('djchdjsfgcdjjggcccccccccccccsudghach',#$0D#$0A,ActStr);
       Halt(0);
   end;
 if not IntTextMode Then begin
 writeln('сворамсопрпырм');
 Halt(ExitCode);
 end;
 write('jhghghg',#$0D#$0A,ActStr,#$0D#$0A,OptStr);
 SetDaTa;
 SetIntVeC($D6,@BodyIntD6);
 SetIntVec($009,@IntHand09);
 SetIntVec($28,@IntHand28);
 writeln('gvdhgfdhgfhdgf',DosExitCode);
END.



























