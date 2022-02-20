function [makinecalisma,fitness4]=makineyogunluk2(ilkcozum3)

global makine;
[makinecalisma]=makinecalismasuresi(ilkcozum3);
    degisken3=max(makinecalisma);
    makinecalisma=makinecalisma;
    fitness4=0;
        for k=1:makine
      degisken2=makinecalisma(k)^2;
  fitness4=fitness4+degisken2;
        end
end