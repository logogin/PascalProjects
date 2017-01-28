program kartgr1;
 uses graph,crt;
 var gd,gm:integer;
     p:pointer;
     size:word;
     file1:file of byte;
     i:integer;
     A,B,data:word;
     p1:^byte;
     bitmap:array[1..1000] of byte;

 Begin
   gd:=detect;
   initgraph(gd,gm,'');
   if graphresult<>grok then halt(1);
  { bar(0,0,getmaxx,getmaxy);size:=imagesize(10,20,30,40);}
  { getmem(p,size)-выделить память в динамически распределяемой области}
        {getimage(10,20,30,40,p^);readln;}
   assign(file1,'rdata.dta');reset(file1);
    { A:=seg(p);B:=ofs(p);}
   i:=1;
   while not eof(file1) do
    begin
     read(file1,bitmap[i]);i:=i+1;
    end;

   cleardevice;
   putimage(100,100,bitmap,normalput);readln;
   close(file1);readln;
   closegraph;
 End
 .
