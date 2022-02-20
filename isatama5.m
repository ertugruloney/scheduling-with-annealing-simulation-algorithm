function [T2,sure3,ilkcozum2]=isatama5()
global stemel;
global makine;
global operasyon;
global is;
global isop3;
global opma;
global sure;
global ilkcozum;

global cmaxx;
zmatrisi=[];
sayac2=0;
isop2=isop3;

for j=1:operasyon
  if sum(opma(j,:))>1
                  sayac2=sayac2+1;
zmatrisi(sayac2)=j;
  end
end
zmatrisi2=[];
sayac3=0;
   for j=1:length(zmatrisi)
        for i=1:is
     if isop2(i,zmatrisi(j))==1
                sayac3=sayac3+1;
                zmatrisi2(sayac3)=stemel(i,zmatrisi(j));
            end
        end
   end

degisken6=1;
        while degisken6==1
            if length(zmatrisi2)>1
 rastgelesayi=randi(length(zmatrisi2));
            else
                rastgelesayi=1;
            end
         
[~,m]=find(stemel==zmatrisi2(rastgelesayi));
sayac4=0;
atanabilecekmakineler=[];
for k=1:makine
             if opma(m,k)>0
                 sayac4=sayac4+1;
 atanabilecekmakineler(sayac4)=k;
             end
end
[n2]=find(sure(:,1)==zmatrisi2(rastgelesayi));
indis2=atanabilecekmakineler==sure(n2,6);
atanabilecekmakineler(indis2)=[];
[makinecalisma]=makinecalismasuresi(ilkcozum);
degisken5=1;
T4=[];
T4(1,:)=makinecalisma(atanabilecekmakineler);
T4(2,:)=atanabilecekmakineler;
while degisken5==1

dboyut=length(T4(2,:));
if dboyut>1
   for i= 1:dboyut-1
       for j= dboyut:-1:i+1
           if T4(1,j)>T4(1,j-1)
               gecici=T4(1,j-1);
               gecici2=T4(2,j-1);
               T4(1,j-1)=T4(1,j);
               T4(2,j-1)=T4(2,j);
               T4(1,j)=gecici;
               T4(2,j)=gecici2;
           end
       end
   end
end
indis3=T4(2,1);

ilkcozum2=ilkcozum;
ilkcozum2(n2,2)=indis3;

[T2,sure3]=dizilim(ilkcozum2);

if max(T2)<=cmaxx 
    degisken6=0;
    break
else

T4(:,1)=[];

end
if length(T4(1,:))==0 
    zmatrisi2(rastgelesayi)=[];
    degisken5=0;
end
    if length(zmatrisi2)==0
        degisken6=0;
    break
end
end
            end 
        end




