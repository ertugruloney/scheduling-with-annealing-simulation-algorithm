clc;
clear all;
tic;
global stemel;
global makine ;
global operasyon;
global isop;
global opma;
global is;
global a;
global isop3;
global ilkcozum;
global sure;
global T;
global cmaxx;
iptal=0;
sayac8=0;
isatama6iy=0;
ilterasyon=0;
 Best_solution=[];
 Best_T=[];
 Best_ilkcozum=[];
    best_fitness2=0;
maxtoplamoperasyon=1;
Tmaxderece=0;
Tminderece=1;
cmaxx=1;
cooling=0.1;
sayacs=0;
  opdegisimiy=0;
  issiralamaiy=0;
opma=[1	1
1	1
1	1
1	1



];
isop=[1	1	0	0
0	0	1	1



];
a= [25	32	45	21

					
									
];
[is,operasyon]=size(isop);

[operasyon,makine]=size(opma);

T=zeros(1,makine);
sayac589=0;
 degisken257=0;
 
for i=1:is
    
         
    for j=1:operasyon

       if isop(i,j)>0
            degisken257=degisken257+1; 
          degisken256=1;
           while degisken256<=sum(opma(j,:))
                   sayac589=sayac589+1;
  
                   a2(sayac589)=a(degisken257);
                   degisken256=degisken256+1;
           end
      
       end
           
        end
end

t=zeros(1,length(a));
t1=zeros(1,length(a));
l=1;
isop3=isop;
for i=1:is
    for j=1:operasyon
        if isop(i,j)>0
          ss(i,j)=l;
          l=l+1;
        end
    end
end
% isop matrisinde 1 den b�y�k her de�er i�in oij operasyonuna matristeki dizime g�re numaranland�r�p� ss matrsine yaz�yoruz.
l=1;
i=1;
while i<is+1
    for j=1:operasyon
          if isop(i,j)>0
             s(l)= ss(i,j);
        break
      end
      end
     i=i+1;
      l=l+1;
end
% her i�in ilk operasyonun numar�sn� s dizisine tan�ml�yoruz.
ss1=s;
stemel=ss;
ss2=stemel;
sayac446=1;
sayac=0;
     while sayac<length(a)
boyut=length(s);
d=[];
for ii=1:boyut
    d(ii)=t(s(ii))+a(s(ii));
end
% bu k�s�mda operasyonlar�n en erken bitme s�resini tan�ml�yoruz
if sayac==0
 for i=1:is
    l=0;
    for j=1:operasyon
        if isop(i,j)>0
            l=l+1;
            toplamoperasyon(i)=l;
        else 
            toplamoperasyon(i)=l;
        end
    end
end
end
% bu k�s�mda i�lerin yap�lmam�� operasyon say�lar�n� buluyoruz.
if sayac>1
for i=1:is
    l=0;
    for j=1:operasyon
        if isop(i,j)>0
            l=l+1;
            toplamoperasyon(i)=l;
         else 
            toplamoperasyon(i)=l;
        end
    end
end
end
if sayac>=1
toplamoperasyon(maxtoplamoperasyon)=0;
end

enbuyuk1=toplamoperasyon(maxtoplamoperasyon);
for i=1:is
    if enbuyuk1<toplamoperasyon(i)
        enbuyuk1=toplamoperasyon(i);
    maxtoplamoperasyon=i;
    end
end
 
for j=1:operasyon
          if isop(maxtoplamoperasyon,j)>0
         degisken=ss(maxtoplamoperasyon,j);
        break
      end
end
secilenoperasyon=s(1);
enkucuk=d(1);
for ii=2:boyut
    if d(ii)<enkucuk
        enkucuk=d(ii);
        secilenoperasyon=s(ii);
    end
end

if t(degisken)<=enkucuk
    secilenoperasyon=degisken;
end

 [n, m]=find(ss==secilenoperasyon);
 atanabilecekmakineler=[];
 l=1;
for k=1:makine
   
  if opma(m,k)>0
      atanabilecekmakineler(l)=k;
      l=l+1;
  end
end
% bu k�s�mda se�ilen operasyon i�in atanabilecekmakineleri belirliyoruz.
atananmakine=atanabilecekmakineler(1);
makinesuresi=T(atananmakine);
boyut1=length( atanabilecekmakineler);
for iii=2:boyut1
    if makinesuresi>T( atanabilecekmakineler(iii))
        atananmakine= atanabilecekmakineler(iii);
        makinesuresi=T(atananmakine);
    end
end
T(atananmakine)=t(ss(n,m))+a(ss(n,m));
% bu k�s�mda at�ycam�z makineyi belirleyip onun kullan�labilirlik s�resini
% g�ncelliyoruz at�ycam�z makineyide en erken bo�a ��kan makine olarak
% belirliyoruz
for ii=1:boyut
   if s(ii)==ss(n,m)
      indis=ii;
   end
end
% bu k�s�mda atad���m�z operasyonun ss matrindeki indislerini buluyoruz.
depo=t(ss(n,m));
depo1=a(ss(n,m));
% k�s�mda atad���m�z i�in ba�lag�� ve i�lem s�resini depo de�i�kenlerine
% yazd�r�yoruz.
sayacs=sayacs+1;
sure(sayacs,1)=ss(n,m);
sure(sayacs,2)=n;
sure(sayacs,3)=m;
sure(sayacs,4)=depo;
sure(sayacs,5)=depo+depo1;
sure(sayacs,6)=atananmakine;
ilkcozum(sayacs,1)=ss(n,m);
ilkcozum(sayacs,2)=atananmakine;
% bu k�s�mda atad���m�z operasyonlar�n ba�lang�� ve biti� s�relerini sure
% matrisine yaz�yoruz.
ss(n,m)=0;
isop(n,m)=0;
% bu k�s�mda i�leme soktu�umuz operasyonu ss ve isop matrislerinden
% ��kart�yoruz
 t=[];
for i=1:is
          atanabilecekmakineler1=[];
    for j=1:operasyon
         l=1;
    if isop(i,j)>0
            for k=1:makine
             if opma(j,k)>0
 atanabilecekmakineler1(l)=k;
l=l+1;
end
     end
            atananmakine1=atanabilecekmakineler1(1);
makinesuresi=T(atananmakine1);
boyut1=length( atanabilecekmakineler1);
for iii=2:boyut1
    if makinesuresi>T( atanabilecekmakineler1(iii))
        atananmakine1= atanabilecekmakineler1(iii);
        makinesuresi=T(atananmakine1);
       end
end
t(ss(i,j))=makinesuresi;
         end
    end
end
% bu k�s�mda atama yapt�ktan sonra t matrsinindeki de�erleri g�ncelliyoruz.
sonrasindagelenop=[];
for j=1:operasyon
    if ss(n,j)>0
        sonrasindagelenop=ss(n,j);
        break
    end
end
% bu k�s�mda atanan operasyonun i i�i i�in �ncelik durumuna g�re sonras�nda
% gelen i�i belirliyoruz

if length(sonrasindagelenop)>0
t1(sonrasindagelenop)=depo+depo1;
end
for i=1:is
    for j=1:operasyon
        if ss(i,j)>0
            if t1(ss(i,j))>0
                if t1(ss(i,j))>t(ss(i,j))
  t(ss(i,j))=t1(ss(i,j));
                end
            end
        end
    end
end

% bu k�s�mda e�er sonras�nda gelen i� varsa algoritmam�zdaki d�rd�nc�
% ad�mda bulunan ba�lang�� zaman� se�imi kriterlerine g�re ba�lang��
% se�imini g�ncelliyoruz. burda t1 matrisi ise �ncelik durumuna g�re
% �ncesinde gelen i�in biti�- zaman�n� kaydediyoruz.

if length(sonrasindagelenop)>0
s(indis)=sonrasindagelenop;
else
  s(indis)=[];
end
% bu k�s�mda S dizisi i�in gerekli g�ncellemeleri yap�yoruz.
sayac=sayac+1;
% bu k�s�mda atanan operasyon say�s� toplam operasyon say�s�na ola��nca
% program� sonland�r�yoruz bu kontrol�de sayas de�i�keyile sa�l�yoruz
     end
[makineoperasyon1,fitness2]=makineyogunluk2(ilkcozum);

    
    Best_solution=sure;
    best_fitness2=fitness2;
    Best_T=T;
    Best_ma=makineoperasyon1;
    Best_ilkcozum=ilkcozum;

sayac6=0;
 sayac7=0;
 sayac3=0;
 zmatrisi=[];
for j=1:operasyon
  if sum(opma(j,:))>1
                  sayac3=sayac3+1;
zmatrisi(sayac3)=j;
  end
end

Tderece=Tmaxderece;
while Tderece>Tminderece
sayac2=1;
if max(T)>cmaxx
    sayac2=sayac2+1;
end
while sayac2==1||sayac2==5||sayac2==9||sayac2==13
    if length(zmatrisi)>0
[T2,sure2,ilkcozum2]=isatama5();
fitness3= makspenhesaplama(T2);
 [makineoperasyon1,fitness4]=makineyogunluk2(ilkcozum2);
 r2=rand();
 r1=rand();
if fitness4>best_fitness2
                Best_solution=sure2;
                best_fitness2=fitness4;
                Best_T=T2;
                 Best_ma=makineoperasyon1;
              
            Best_ilkcozum=ilkcozum2;
elseif fitness4==best_fitness2
    if max(T2)<max(Best_T)
         Best_solution=sure2;
                best_fitness2=fitness4;
                Best_T=T2;
                 Best_ma=makineoperasyon1;
               
            Best_ilkcozum=ilkcozum2;
    end
            end

            if fitness4>fitness2
                sayac2=sayac2+1;
                sure=sure2;
                fitness2=fitness4;
                T=T2;
                
                 ilkcozum=ilkcozum2;
                
            elseif fitness4<fitness2
                sayac2=sayac2+1;
              prob2=exp(-((((fitness2)-(fitness4))^(1/2))/Tderece))
                
            if r2<=prob2
                sure=sure2;
                    fitness2=fitness4;
                    T=T2;
                  
                 ilkcozum=ilkcozum2;
            end
            elseif fitness4==fitness2 
                sayac2=sayac2+1;
                if max(T2)<max(T)
                sure=sure2;
                fitness2=fitness4;
                T=T2;
             
                 ilkcozum=ilkcozum2;
                elseif max(T2)>max(T)
                 
                prob=exp(-(((max(T2))-(max(T)))/Tderece))
                
            if r1<=prob
             
                    sure=sure2;
                fitness2=fitness4;
                T=T2;
                
                 ilkcozum=ilkcozum2;
            end
            elseif max(T2)==max(T) 
               
                 if r1<0.5
                 sure=sure2;
                fitness2=fitness4;
                T=T2;
              
                 ilkcozum=ilkcozum2;
                 end
  end
  
            end
    else 
        sayac2=sayac2+1;
    end
end  

sayac10=0;
while sayac2==2||sayac2==6||sayac2==10||sayac2==14

[T2,sure2,ilkcozum2]=issiralama6();
[makineoperasyon1,fitness4]=makineyogunluk2(ilkcozum2);


  r1=rand();
  r2=rand();
    if max(T2)<max(Best_T)
        issiralamaiy=issiralamaiy+1;
        Best_solution=sure2;
                best_fitness2=fitness4;
                Best_T=T2;
                 Best_ma=makineoperasyon1;
              
            Best_ilkcozum=ilkcozum2;
            end

 if max(T2)<max(T)
            
                sure=sure2;
         
                T=T2;
               
                 ilkcozum=ilkcozum2;
 elseif max(T2)>max(T)
     sayac2=sayac2+1;
     prob=exp(-((max(T2)-max(T))/Tderece));
                
            if r2<=prob
                sure=sure2;
                    fitness2=fitness4;
                    T=T2;
                    
                 ilkcozum=ilkcozum2;
            end
                 
 elseif max(T2)==max(T)
 sayac10=sayac10+1;
  if sayac10>15
       sayac2=sayac2+1;
  end
               

            end

end

if iptal==1||length(zmatrisi)==0
    sayac2=sayac2+1;
end
sayac10=0;
while sayac2==3||sayac2==7||sayac2==11||sayac2==15
[T2,sure2,ilkcozum2,iptal]=opdegisim();
[makineoperasyon2,fitness4]=makineyogunluk2(ilkcozum2);


  r1=rand();
   if max(T2)<max(Best_T)
     opdegisimiy=opdegisimiy+1;
                Best_solution=sure2;
                best_fitness2=fitness4;
                Best_T=T2;
                 Best_ma=makineoperasyon2;
                
            Best_ilkcozum=ilkcozum2;

            end

 if max(T2)<max(T)
            
                sure=sure2;
                fitness2=fitness4;
                T=T2;
               
                 ilkcozum=ilkcozum2;
 elseif max(T2)>max(T)
     sayac2=sayac2+1;
     prob=exp(-((max(T2)-max(T))/Tderece));
                
            if r2<=prob
                sure=sure2;
                    fitness2=fitness4;
                    T=T2;
                    
                 ilkcozum=ilkcozum2;
            end
 elseif max(T2)==max(T)
    sayac10=sayac10+1;
  if sayac10>15
       sayac2=sayac2+1;
  end
 if r1<0.5
               sure=sure2;
                fitness2=fitness4;
                T=T2;
                
                 ilkcozum=ilkcozum2;
                 end
              
             
            end

end


if max(T)<cmaxx||length(zmatrisi)==0
    sayac2=sayac2+1;
end
sayac10=0;
while sayac2==4||sayac2==8||sayac2==12||sayac2==16
      
          sayac8=sayac8+1;
[T2,sure2,ilkcozum2]=isatama6();

[makineoperasyon1,fitness4]=makineyogunluk2(ilkcozum2);
 r2=rand();
 if max(T2)<max(Best_T)
    isatama6iy=isatama6iy+1;
                Best_solution=sure2;
                best_fitness2=fitness4;
                Best_T=T2;
                 Best_ma=makineoperasyon2;
           
            Best_ilkcozum=ilkcozum2;

            end

 if max(T2)<max(T)
            
                sure=sure2;
                fitness2=fitness4;
                T=T2;
              
                 ilkcozum=ilkcozum2;
 elseif max(T2)>max(T)
     sayac2=sayac2+1;
     prob=exp(-((max(T2)-max(T))/Tderece));
                
            if r2<=prob
                sure=sure2;
                    fitness2=fitness4;
                    T=T2;
                    
                 ilkcozum=ilkcozum2;
            end
 elseif max(T2)==max(T)
 
  sayac10=sayac10+1;
  if sayac10>15
       sayac2=sayac2+1;
  end
   if r1<0.5
               sure=sure2;
                fitness2=fitness4;
                T=T2;
               
                 ilkcozum=ilkcozum2;
                 end
    
          
            end

end

Tderece=Tderece-cooling
ilterasyon=ilterasyon+1;
end

H=gantsemasi(Best_solution);
 xlswrite('data.xlsx',Best_T,'A1');
  xlswrite('data.xlsx',Best_solution,'E5');
  xlswrite('data.xlsx',Best_ma,'M5');
  sonuc=fix(Best_solution);
  
  toc;