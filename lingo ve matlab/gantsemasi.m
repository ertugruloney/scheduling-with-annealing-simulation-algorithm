function H=gantsemasi(Best_solution)
global makine;
global a;

konum=linspace(1,makine,makine);
 duration=zeros(makine,1);
indis=1;
while indis<=makine
    indis2=1;
    for i=1:length(a)
        if Best_solution(i,6)==indis
    
duration(indis,indis2)=Best_solution(i,4);
            duration(indis,indis2+1)=a(Best_solution(i,1));
            indis2=indis2+2;
        end
    end
    indis=indis+1;  
end
duration2=duration;
[indis3,indis4]=size(duration);
for i=1:indis3
    degisken3=1;
    while degisken3<=indis4-2
        duration2(i,degisken3+2)=duration(i,degisken3+2)-duration(i,degisken3+1)-duration(i,degisken3);
        degisken3=degisken3+2;
    end
end
for i=1:indis3
    for j= 1: indis4
        if duration2(i,j)<=0
            duration2(i,j)=0;
        end
    end
end
 
gantttt=linspace(1,indis4-1,indis4/2);
xkonum=zeros(makine,1);
 
    for i=1:indis3
        degisken4=1;
degisken5=length(gantttt);
degisken6=0;
        while degisken4<=degisken5
            
     xkonum(i,degisken4)=duration(i,degisken4+degisken6);
degisken4=degisken4+1;
degisken6=degisken6+1;
end
    end
    indis5=1;
    etiket=zeros(makine,1);
    while indis5<=length(a)
    indis6=1;
    for i=1:length(a)
        if Best_solution(i,6)==indis5
    
            etiket(indis5,indis6)=Best_solution(i,2);
            etiket(indis5,indis6+1)=Best_solution(i,3);
            indis6=indis6+2;
        end
    end
    indis5=indis5+1;  
end
konum2=linspace(1,indis4,indis4);
H=figure('WindowState','maximized');
H = barh(konum,duration2,'stacked','k');
set(H([konum2]),'EdgeColor',[1 1 1]);
set(H([gantttt]),'Visible','off');
ylabel('Makineler');
xlabel('Süre');
grid on;
indis7=1;
while indis7<=indis3
    if sum(etiket(indis7,:))==0
    indis7=indis7+1;
    end
    if indis7==makine+1
        break
    end
    degisken9=1;
    degisken10=0;
    for j=1:degisken5
      deisken10=0;
 if xkonum(indis7,j+degisken9)==0 && sum(xkonum(indis7,:))>0 && xkonum(indis7,2)>0
            break
 elseif sum(etiket(indis7,:))>0 && sum(xkonum(indis7,:))==0
        str=[num2str(etiket(indis7,1)), '-', num2str(etiket(indis7,2))];
         !text(xkonum(indis7,1)+15,konum(indis7),str,'fontsize',5,'color','w');
         
         break 
         indis7=indis7+1;
 elseif sum(xkonum(indis7,:))==xkonum(indis7,1)
     str=[num2str(etiket(indis7,1)), '-', num2str(etiket(indis7,2))];
        !text(xkonum(indis7,1)+15,konum(indis7),str,'fontsize',5,'color','w');
         
         break 
         indis7=indis7+1;
        else   
            str=[num2str(etiket(indis7,j+degisken10)), '-', num2str(etiket(indis7,j+degisken10+1))];
         !text(xkonum(indis7,j)+15,konum(indis7),str,'fontsize',5,'color','w');
 end
 degisken9=0;
    degisken10=degisken10+1;
    end
    indis7=indis7+1;
    end

title('Gant şeması');

 
end


