function [Y,time, Err] = predyktor_korektor( x, lenght, step )
%predyktor-korektor

halfstep=step/2;
time=zeros(ceil(lenght/step),1);
% Y=zeros(ceil(lenght/step),2);
iteracje=3;
    for i = 1:3
        time(i) = i*step; %zapisanie czasu próbki
        k1 = newx(x); %pochodna w punkcie y(xn)
        %display (k1);
        k2 = newx(x+halfstep*k1); %pochodna w punkcie y(xn+step/2*k1)
        k3 = newx(x+halfstep*k2); %pochodna w punkcie y(xn+step/2*k2)
        k4 = newx(x+step*k3); %pochodna w punkcie y(xn+step*k3)
        x=x+(1/6)*step*(k1+2*k2+2*k3+k4); %obliczenie nastêpnego punktu
        Y(i,:) = x; %zapisanie punktu do wektora
    end
    for i = 4:ceil(lenght/step)
        time(i) = i*step; %zapisanie czasu próbki
        % predykcja (z ewaluacja)
        temp = x + step/24*(55*newx(x) - 59*newx(Y(i-1,:))+ 37*newx(Y(i-2,:)) - 9*newx(Y(i-3,:)));
        % korekcja (z ewaluacja)
        x = x + step/24*(9*newx(temp) + 19*newx(x) - 5*newx(Y(i-1,:)) + newx(Y(i-2,:)));
        Y(i,:) = x; %zapis wyniku
        iteracje=iteracje+1;
    end
%         iteracje
%      plot(time,Y);
%      plot3(time,Y(:,1),Y(:,2));
end