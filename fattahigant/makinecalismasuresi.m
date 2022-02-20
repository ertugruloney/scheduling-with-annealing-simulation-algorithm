function [makinecalisma]=makinecalismasuresi(ilkcozum3)
global a;
global makine;
makinecalisma=[];
makineoperasyon=zeros(makine,length(a));
for k=1:makine
         sayac=0;
         for i=1:length(a)
if ilkcozum3(i,2)==k
    sayac=sayac+1;
    makineoperasyon(k,sayac)=a(i);
end
         end
makinecalisma=sum(makineoperasyon');
     end