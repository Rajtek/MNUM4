function [Y,time] = rk4( x, lenght, step )
%Metoda RK4
time = zeros(ceil(lenght/step),1); %wektor chwil czasu
Y = zeros(ceil(lenght/step),2);
 iteracje=0;
for i=1:ceil(lenght/step)
    time(i)=i*step; %zapisanie czasu po kojenym kroku
    k1 = newx(x); %pochodna w punkcie y(xn)
    k2 = newx(x+(step/2)*k1); %pochodna w punkcie y(xn+step/2*k1)
    k3 = newx(x+(step/2)*k2); %pochodna w punkcie y(xn+step/2*k2)
    k4 = newx(x+step*k3); %pochodna w punkcie y(xn+step*k3)
    x=x+(1/6)*step*(k1+2*k2+2*k3+k4); %obliczenie nastêpnego punktu
    Y(i,:) = x;
%     iteracje=iteracje+1;
end
%  plot(time,Y);
plot3(time,Y(:,1),Y(:,2));
%  iteracje
end