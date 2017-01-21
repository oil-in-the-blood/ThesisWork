a = 1;
b = sig + rho + 1;
c = rho*(sig+beta);
d = 2*sig*rho*(beta-1);

eigroots = roots([a b c d])

dis = 18*a*b*c*d - 4*b*b*b*d + b*b*c*c - 4*a*c*c*c - 27*a*a*d*d