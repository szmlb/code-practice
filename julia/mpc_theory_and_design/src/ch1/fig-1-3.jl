using PyPlot
using Random
Random.seed!(1234)

# Example noisy dataset.
a = 1
c = 1
r = 1
q = 1

x0 = 1
q0 = 1

nsim = 201
x = zeros(nsim)
y = zeros(nsim)
t = collect(0:1:nsim-1)    
x[1] = x0 + q0^1/2*randn()
for i in 1:nsim
    y[i] = c*x[i] + r^1/2*randn()
    if i != nsim
        x[i + 1] = a*x[i] + q^1/2*randn()
    end

end

PyPlot.plot(t, y, linestyle="-",marker="o")
PyPlot.xlabel("time")
PyPlot.ylabel("y")
PyPlot.legend()
PyPlot.show()