function [ time,Y] = zmienny_krok(x,x0, length, step )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    time=[x0];
    Y=x;
    en=0.000001;
    eb=0.000001;
    s=0.9;
    stepmin=10^-10;
    beta=5;
    n=1;
    while time(end)<=length
        x1=Y(n,:);
        x2=Y(n,:);
        k1 = newx(x1); %pochodna w punkcie y(xn)
        k2 = newx(x1+(step/2)*k1); %pochodna w punkcie y(xn+step/2*k1)
        k3 = newx(x1+(step/2)*k2); %pochodna w punkcie y(xn+step/2*k2)
        k4 = newx(x1+step*k3); %pochodna w punkcie y(xn+step*k3)
        x1=x1+(1/6)*step*(k1+2*k2+2*k3+k4); %obliczenie nastêpnego punktu
        step2=step/2; %pol kroku
        for i=1:2
            k1 = newx(x2); %pochodna w punkcie y(xn)
            k2 = newx(x2+(step2/2)*k1); %pochodna w punkcie y(xn+step/2*k1)
            k3 = newx(x2+(step2/2)*k2); %pochodna w punkcie y(xn+step/2*k2)
            k4 = newx(x2+step2*k3); %pochodna w punkcie y(xn+step*k3)
            x2=x2+(1/6)*step2*(k1+2*k2+2*k3+k4); %obliczenie nastêpnego punktu
        end
       d1=(x2(1)-x1(1))/15;
       d2=(x2(2)-x1(2))/15;
       e1=abs(x2(1))*en+eb;
       e2=abs(x2(2))*en+eb;
       alfa=min((e1/abs(d1))^(1/5),(e2/abs(d2))^(1/5));
       nextstep=s*alfa*step;
       Y(n+1,1:2)=x1;
       if(s*alfa<1)
           if(nextstep<stepmin)
              error('Niemo¿liwe rozwi¹zanie z zadan¹ dok³adnoœci¹'); 
           else
              step=nextstep; 
           end
       else
           if(time(end)+step==length)
              break; 
           else
               time=[time; time(end)+step];
               step=min([nextstep,beta*step,length-time(end)]);
               n=n+1;
           end
           
       end
    end
    time=[time; length];
end

