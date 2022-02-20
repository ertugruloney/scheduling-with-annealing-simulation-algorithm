function [T2,sure2,ilkcozum2]=issiralama6()
global a;
global ilkcozum;
global isop3;
global sure;
atanmayanoperasyon=[];
sayac=0;
  atanmayanoperasyonindis=[];
  isop2=isop3;
degisken2=0;

degisken12=0;
if length(atanmayanoperasyon)>0
    degisken12=1;
end


while degisken2==0||secilenoperasyon2==0
secilenoperasyon=randi(length(a));
while secilenoperasyon==ilkcozum(1,1) || secilenoperasyon==ilkcozum(length(a),1)||degisken12==1
secilenoperasyon=randi(length(a));
if length(atanmayanoperasyon)>0
for iiii=length(atanmayanoperasyon)
    if secilenoperasyon==atanmayanoperasyon(iiii)
        break
        degisken12=1;
    else 
        degisken12=0;
    end
end
end
        
end
for i=1:length(a)
 if ilkcozum(i,1)==secilenoperasyon
      ismakinee=i;
      break
   end
end
secilenmakinee=ilkcozum(ismakinee,2);
   for iiii=ismakinee-1:-1:1
    if ilkcozum(iiii,2)==secilenmakinee
        secilenoperasyon2=ilkcozum(iiii,1);
        ismakinee2=iiii;
        degisken2=1;
       break
    else
       secilenoperasyon2=0 ;    
    end
   end

 if degisken2==1
     if sure(ismakinee2,2)==sure(ismakinee,2)
         degisken2=0;
      end
   for i=ismakinee2:1:ismakinee-1
    if sure(i,2)==sure(ismakinee,2)
        degisken2=0;
        secilenoperasyon2=0 ;  
        break
   end
   end
    for i=ismakinee2+1:1:ismakinee
    if sure(i,2)==sure(ismakinee2,2)
        degisken2=0;
        secilenoperasyon2=0 ;  
        break
    end
   end
end

if secilenoperasyon2==0
    for iiii=ismakinee+1:1:length(a)
    if ilkcozum(iiii,2)==secilenmakinee    
        secilenoperasyon2=ilkcozum(iiii,1);
        ismakinee2=iiii;
        degisken2=2;
        break
    else
        secilenoperasyon2=0;
    end
    end
end

 if degisken2==2
     if sure(ismakinee2,2)==sure(ismakinee,2)
         degisken2=0;
      end
  for i=ismakinee+1:1:ismakinee2
       if sure(i,2)==sure(ismakinee,2)
           degisken2=0;
           secilenoperasyon2=0;
           break
       end
  end
  for i=ismakinee:1:ismakinee2-1
       if sure(i,2)==sure(ismakinee2,2)
           degisken2=0;
           secilenoperasyon2=0;
           break
       end
  end
 end
 if degisken2==0
     sayac=sayac+1;
     atanmayanoperasyon(sayac)=secilenoperasyon;
 end

degisken856=0;
if length(atanmayanoperasyon)>500
    degisken856=1;
break
end
end

if degisken856==0
ilkcozum2=ilkcozum;


ilkcozum2(ismakinee,1)=secilenoperasyon2;
ilkcozum2(ismakinee2,1)=secilenoperasyon;



else
ilkcozum2=ilkcozum;
end
[T2,sure2]=dizilim(ilkcozum2);
end


