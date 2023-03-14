clear;
clc;
format short;
f=sym('[x1^2+x2+(x3+0.5)^2-cos(x4-x2)+abs(x3-x1)-x5^5+0.5*(x4-0.2)^2-x6^2-x1*x3-2*x7]')

g(1)=sym('[x1-x2+x3-x7-1]')
g(2)=sym('[0.5*x3-x5+x6-1]')
g(3)=sym('[-x1+x2-1]')
g(4)=sym('[x4^2-x5-1]')
g(5)=sym('[x1^2+x2^2+x3^2-0.5]')
g(6)=sym('[x4^2+x5^2+x6^2+x7^2-0.5]')
g(7)=sym('[x7-1]')
g(8)=sym('[0.2*x6+x3-1]')
h1=sym('[x1+x2+x3+x4+x5+x6+x7]')

A=[1,1,1,1,1,1,1]
I=[1,0,0,0,0,0,0;
    0,1,0,0,0,0,0;
    0,0,1,0,0,0,0;
    0,0,0,1,0,0,0;
    0,0,0,0,1,0,0;
    0,0,0,0,0,1,0;
    0,0,0,0,0,0,1]


P=A'*inv((A*A'))*A

j=1; 
l=0.002;

x1=-4;
x2=3;
x3=1;
x4=-3;
x5=3;
x6=-1;
x7=-2;

e0=35;


for t=0:0.002:5
 z(1,j)=x1 
 z(2,j)=x2
 z(3,j)=x3
 z(4,j)=x4
 z(5,j)=x5
 z(6,j)=x6
 z(7,j)=x7
 
 
 for i=1:8
     a(i)=subs(g(i));
 end;
 
b1=subs(h1);

 m(1)=subs(diff(f,['x',num2str(1)]));
 m(2)=subs(diff(f,['x',num2str(2)]));
 m(3)=subs(diff(f,['x',num2str(3)]));
 m(4)=subs(diff(f,['x',num2str(4)]));
 m(5)=subs(diff(f,['x',num2str(5)]));
 m(6)=subs(diff(f,['x',num2str(6)]));
 m(7)=subs(diff(f,['x',num2str(7)]));
 m=[m(1);m(2);m(3);m(4);m(5);m(6);m(7)];

p1=0;
p2=0;
p3=0;
p4=0;
p5=0;
p6=0;
p7=0;

for i=1:8
if (a(i)>0)
    n(i)=subs(diff(g(i),['x',num2str(1)]));
    nn(i)=subs(diff(g(i),['x',num2str(2)]));
    nnn(i)=subs(diff(g(i),['x',num2str(3)]));
    nnnn(i)=subs(diff(g(i),['x',num2str(4)]));
    nnnnn(i)=subs(diff(g(i),['x',num2str(5)]));
    nnnnnn(i)=subs(diff(g(i),['x',num2str(6)]));
    nnnnnnn(i)=subs(diff(g(i),['x',num2str(7)]));
    
elseif(a(i)==0)
    n(i)=0.5*subs(diff(g(i),['x',num2str(1)]));
    nn(i)=0.5*subs(diff(g(i),['x',num2str(2)]));
    nnn(i)=0.5*subs(diff(g(i),['x',num2str(3)]));
    nnnn(i)=0.5*subs(diff(g(i),['x',num2str(4)]));
    nnnnn(i)=0.5*subs(diff(g(i),['x',num2str(5)]));
    nnnnnn(i)=0.5*subs(diff(g(i),['x',num2str(6)]));
    nnnnnnn(i)=0.5*subs(diff(g(i),['x',num2str(7)]));
    
    
else
    n(i)=0;
    nn(i)=0;
    nnn(i)=0;
    nnnn(i)=0;
    nnnnn(i)=0;
    nnnnnn(i)=0;
    nnnnnnn(i)=0;
end;
p1=n(i)+p1;
p2=nn(i)+p2;
p3=nnn(i)+p3;
p4=nnnn(i)+p4;
p5=nnnnn(i)+p5;
p6=nnnnnn(i)+p6;
p7=nnnnnnn(i)+p7;
end

p=[p1;p2;p3;p4;p5;p6;p7];

 E=(A'*inv((A*A'))*(x1+x2+x3+x4+x5+x6+x7))
 if(b1==0)
    e=11*[0.5;0.5;0.5;0.5;0.5;0.5;0.5]

 else
   e=(P*(18*E))/(norm(E))
 end
s=-m-e0*(p+e)


  x1=x1+l*s(1);
  x2=x2+l*s(2); 
  x3=x3+l*s(3); 
  x4=x4+l*s(4);
  x5=x5+l*s(5);
  x6=x6+l*s(6);
  x7=x7+l*s(7);
 
 
 j=j+1


end;

t=0:0.002:5;
plot(t,z(1,:),t,z(2,:),t,z(3,:),t,z(4,:),t,z(5,:),t,z(6,:),t,z(7,:))

xlabel('time��sec��');
ylabel('state variables');
ylim([-10,10])
%title('״̬����x(t)���˶��켣ͼ��');
set(get(gca,'xlabel'),'FontSize',10);
set(get(gca,'ylabel'),'FontSize',10);
%set(get(gca,'title'),'FontSize',10);
hold on;
h=legend('x1','x2','x3','x4','x5','x6','x7',1);
hold off;