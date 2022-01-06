using PyPlot
using LinearAlgebra
include("ellipse.jl")

# Example sum of two quadratic functions.

a = [-1; 0];
b = [1; 1];
A = [1.25000 0.75000; 0.75000 1.25000];
B = [1.50000 -0.50000; -0.50000 1.50000];

# add the two quadratics
H = A + B;
h = H\(A*a + B*b);
d = -(A*a + B*b)'*h + a'*A*a + b'*B*b;

# plot resulting ellipse for combining two ellipses
# V(x) = V_1(x) + V_2(x)
level = 0.5;
npts = 50;
xA, yA = ellipse(A, level, npts, a);

xB, yB = ellipse(B, level, npts, b);

level = (2 - d/2)*2;
xH, yH = ellipse(H, level, npts, h);

# Make plot.
PyPlot.plot(xA, yA, linestyle="-", marker="o", c="r")
PyPlot.plot(a[1], a[2], marker="o", c="r", label="a")
PyPlot.plot(xB, yB, linestyle="-", marker="o", c="b")
PyPlot.plot(b[1], b[2], marker="o", c="b", label="b")
PyPlot.plot(xH, yH, linestyle="-", marker="o", c="g")
PyPlot.plot(h[1], h[2], marker="o", c="g", label="h")
PyPlot.xlabel("x1")
PyPlot.ylabel("x2")
PyPlot.legend();
PyPlot.show()