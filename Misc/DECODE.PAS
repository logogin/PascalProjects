const s_l:string='QWERTYUIOPASDFGHJKLZXCVBNM\^[qwertyuiopasdfghjklzxcvbnm]~|}{';
      s_r:string='ЙЦУКЕНГШЩЗФЫВАПРОЛДЯЧСМИТЬЖБХйцукенгшщзфывапролдячсмитьюЭбжэх';

var f,f1:file of char;
    ch:char;
 Begin
  Assign(f,'paedia.mt');
  reset(f);
  Assign(f1,'paedia.mtm');
  rewrite(f1);
  While not eof(f) do
   begin
   read(f,ch);
   if POS(ch,s_l)<>0 then ch:=s_r[pos(ch,s_l)];
   write(f1,ch);
  end;
  close(f);
  close(f1);
 End.
