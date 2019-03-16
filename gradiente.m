 % GRADIENTE
 %
 % X = GRADIENTE(A,B) Aplica el met. del gradiente para
 % la resolucion del sistema AX=B
 %
 % X = GRADIENTE(A,B,ITMAX) ITMAX: numero max. de iteraciones
 %
 % X = GRADIENTE(A,B,ITMAX... TOLREL tolerancia
 % TOL) relativa
 % % X = GRADIENTE(A,B,ITMAX... X0 es el valor inicial
 % TOL, X0)
 %
 %[X,IT] = GRADIENTE(A,B,ITMAX... Devuelve en IT el numero de
 % TOL,XO) iteraciones calculadas

 %[X,IT,R]= GRADIENTE(A,B,ITMAX) R es un historial del metodo:
 % TOL,XO) R(i) es el residuo en el paso i

 function [x,varargout]= gradiente(a,b,varargin);

 n=length(a); x=zeros(n,1); mmax=40;
 tol=1e-6;

 if nargin>2
 mmax=varargin{1};
 end
 if nargin>3
 tol=varargin{2};
 end
 if (nargin>4)
 x=varargin{4};
 end

 r=b-a*x; res(1)=dot(r,r); aux=norm(b);
 for m=1:mmax
 p=a*r;
 xi=res(m)/dot(r,p);
 x=x+xi*r;
 r=r-xi*p;
 res(m+1)=dot(r,r);
 if (sqrt(res(m))<tol*aux);
 break
end
 end

 if (m==mmax)
 disp('numero maximo de iteraciones sobrepasadas')
 end
 if nargout>1
 varargout{1}=m;
 end
 if nargout>2
 varargout{2}=sqrt(res(:));
 end
 return