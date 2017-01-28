 const alf_l:string[11]='ABCEHKMOPTX';
       alf_r:string[11]='АВСЕНКМОРТХ';
       alf:string[22]= 'ABCEHKMOPTXАВСЕНКМОРТХ';
       pow:array[1..5] of integer =(16,8,4,2,1);
 var
     f1,f2,f3:text;
     gover:boolean;

     procedure writechar(n:integer);
      begin
       case n of
       0: write(f2,' ');
       26..31: write(f2,char(128+n));
       else write(f2,char(127+n));
      end;
      end;
     function alfpos(c:char):byte;
      begin
       case c of
       ' ':alfpos:=0;
       'Я':alfpos:=31;
       else alfpos:=byte(c)-127;
       end;
      end;
    function replace(c,a:char):char;
     begin
      if a='l' then replace:=alf_l[pos(c,alf_r)] else
       replace:=alf_r[pos(c,alf_l)];
     end;

    procedure check;
     var ch:char;
    begin
     assign(f2,paramstr(2)); reset(f2);
     while not eof(f2) do
       begin
        read(f2,ch);
        if not (ch in ['А'..'Я']) then begin
         gover:=true;close(f2); end;
       end;
      if gover=false then reset(f2);
     end;

  procedure show;
   var ch:char;
       bit,result,num:integer;
   begin
    {assign(f1,paramstr(1)); reset(f1);
    assign(f2,paramstr(2)); rewrite(f2);}
    assign(f1,'alica1'); reset(f1);
    assign(f2,'res.pas'); rewrite(f2);
      while not eof(f1) do
       begin
         read(f1,ch);
         if pos(ch,alf)>0 then
          begin
            if byte(ch) in [65..90] then bit:=0 else bit:=1;
            inc(num); result:=result+bit*pow[num];
            if num=5 then begin
               num:=0;
               writechar(result);
               result:=0;
               end;
          end;
       end;
       close(f1);
       close(f2);
      end;

 procedure hide;
  var  ch:char;
       i,n:integer;
       bits:array[1..5] of integer;
  begin
   check;
   if gover=true then
     begin
      assign(f3,paramstr(3));
      rewrite(f3);
      writeln(f3,'NO SOLUTION');
      close(f3);
     end else
      begin
        assign(f1,paramstr(1));
        reset(f1);
        assign(f3,paramstr(3));
        rewrite(f3);
         while not eof(f2) do
          begin
            read(f2,ch);
            n:=alfpos(ch);
            for i:=5 downto 1 do
             begin
              bits[i]:=n mod 2;
              n:=n shr 1;
             end;
           for i:=1 to 5 do
            begin
             read(f1,ch);
             while (not eof(f1)) and (pos(ch,alf)=0) do
             begin
              write(f3,ch); read(f1,ch); end;
             if eof(f1) then gover:=true else
             if bits[i]=0 then ch:= replace(ch,'l') else ch:= replace(ch,'r');
             if gover=true then begin close(f3);rewrite(f3);
              writeln(f3,'NO SOLUTION'); close(f3); close(f1); close(f2);
               end
                else write(f3,ch);
             end;
            end;
        if gover =false then
        begin
         while not eof(f1) do
          begin
           read(f1,ch);
           if pos(ch,alf)>0  then write(f3,replace(ch,'l')) else
            write(f3,ch);
           end;
        close(f1);
         close(f3);
        close(f2);
        end;
    end;
   end;

BEGIN
gover:=false;
show;
{  case paramcount of
   2: show;
   3: hide;
  end; }


END.