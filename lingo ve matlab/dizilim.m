function [T2,sure3]=dizilim(ilkcozum2)
global stemel;
global a;
global makine;
global operasyon;
global is

t2=zeros(1,length(a));
t3=zeros(1,length(a));
T2=zeros(1,makine);
ss2=stemel;
for i=1:length(a)
T2(ilkcozum2(i,2))=t2(ilkcozum2(i,1))+a(ilkcozum2(i,1));
depo=t2(ilkcozum2(i,1));
depo1=a(ilkcozum2(i,1));
[n, m]=find(ss2==ilkcozum2(i,1));
sure3(i,1)=ss2(n,m);
sure3(i,2)=n;
sure3(i,3)=m;
sure3(i,4)=depo;
sure3(i,5)=depo+depo1;
sure3(i,6)=ilkcozum2(i,2);
ss2(n,m)=0;

for ii=1:length(a)
t2(ilkcozum2(ii))=T2(ilkcozum2(ii,2));
       end
sonrasindagelenop=[];
for j=1:operasyon-m
    if ss2(n,m+j)>0
        sonrasindagelenop=ss2(n,m+j);
        break
    else 
         sonrasindagelenop=0;
    end
end
% bu kısımda atanan operasyonun i işi için öncelik durumuna göre sonrasında
% gelen işi belirliyoruz
if sonrasindagelenop>0
t3(sonrasindagelenop)=depo+depo1;
end
for iii=1:is
    for jj=1:operasyon
        if ss2(iii,jj)>0
            if t3(ss2(iii,jj))>0
                if t3(ss2(iii,jj))>=t2(ss2(iii,jj))
  t2(ss2(iii,jj))=t3(ss2(iii,jj));
                end
            end
        end
    end
end
end
end