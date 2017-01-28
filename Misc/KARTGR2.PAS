program kartgr2;
 uses graph,crt;
 var gd,gm:integer;
     p:pointer;
     size:word;
     file1:file of byte;
     i:integer;
     A,B,data:word;
     p1:^byte;
     k:byte;
 Begin
   gd:=detect;
   initgraph(gd,gm,'');
   if graphresult<>grok then halt(1);
   assign(file1,'b:proba.mve');reset(file1);{вместо proba.mve поставить rdata.dta}
   i:=1;
   while not eof(file1) do
    begin
     read(file1,k);i:=i+1;
    end;
   size:=i;getmem(p,size);A:=seg(p^);B:=ofs(p^);
   reset(file1);
    while not eof(file1) do
      begin
        p1:=ptr(A,B);read(file1,p1^);b:=b+1
      end;
   cleardevice;
   putimage(100,100,p^,normalput);
   close(file1);readln;
   closegraph;
 End.

