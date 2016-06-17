function [ x2 ] = newx(x)
%funkcja obliczaj¹ca pochodne wg wzoru
    x2(1)=x(2)+x(1)*(0.9-x(1)^2-x(2)^2);
    x2(2)=-x(1)+x(2)*(0.9-x(1)^2-x(2)^2);

end

