function [T2,sure2,ilkcozum2]=isatama6()
global stemel;
global makine;
global operasyon;
global is;
global isop3;
global opma;
global sure;
global ilkcozum;

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



indis3=randi(length(atanabilecekmakineler));

ilkcozum2=ilkcozum;
ilkcozum2(n2,2)=atanabilecekmakineler(indis3);

[T2,sure2]=dizilim(ilkcozum2);
 

end




