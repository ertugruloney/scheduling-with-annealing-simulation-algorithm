function [T2,sure2,ilkcozum2,iptal]=opdegisim()
global stemel;
global makine;
global opma;
global sure;
global ilkcozum;

iptal=0;
matris(:,1)=sure(:,1);
matris(:,2)=sure(:,6);
for i=1:length(matris(:,1))
[~,m(i)]=find(stemel==matris(i,1));
end

for i=1:length(matris(:,1))
    sayac3=2;
    if sum(opma(m(i),:))>1
  
    for j=1:makine
        
        if opma(m(i),j)>0
            sayac3=sayac3+1;
     matris(i,sayac3)=j;
        end
    end
    end
end
sayac4=0;
silinecekop=[];
for i=1:length(matris(:,1))
    if matris(i,3)==0
        sayac4=sayac4+1;
    silinecekop(sayac4)=i;
    end
end
if length(silinecekop)>0
matris(silinecekop,:)=[];

for i=1:length(matris(:,1))
    for j=3:length(matris(1,:))
        if matris(i,2)==matris(i,j)
            matris(i,j)=0;
        end
    end
end

kmaxxx=1;

matris2=matris;
while kmaxxx==1
    
degisken=randi(length(matris2(:,1)));
[n1,~]=find(matris(:,1)==matris2(degisken,1));
matris2(degisken,:)=[];
sayac4=0;
aynioperasyonlar=[];
for i=1:length(matris(:,1))
    for j=3:length(matris(1,:))
        if matris(i,j)==matris(n1,2)
            sayac4=sayac4+1;
           aynioperasyonlar(sayac4)=i;
        end
    end
end
if length(aynioperasyonlar)>0
    
    break
    
end

if length(matris2)==0
    iptal=1;
    break
end
end

if iptal==0
    
aynioperasyonlar2=[];
sayac6=0;
 
for i=1:length(aynioperasyonlar)
    for j=3:length(matris(1,:))
        if matris(n1,j)>0
        if matris(aynioperasyonlar(i),2)==matris(n1,j)
              sayac6=sayac6+1;
           aynioperasyonlar2(sayac6)=matris(aynioperasyonlar(i));
        end
        end
    end
end
if length(aynioperasyonlar2)>0
    degisken2=randi(length(aynioperasyonlar2));
    ilkcozum2=ilkcozum;
    [n2,~]=find(ilkcozum2(:,1)==matris(n1,1));
    [n3,~]=find(ilkcozum2(:,1)==aynioperasyonlar2(degisken2));
depo11=ilkcozum2(n2,2);
ilkcozum2(n2,2)=ilkcozum2(n3,2);
ilkcozum2(n3,2)=depo11;
else
  ilkcozum2=ilkcozum;  
end
else
     ilkcozum2=ilkcozum;
end
else
    ilkcozum2=ilkcozum;
end

  [T2,sure2]=dizilim(ilkcozum2);
end