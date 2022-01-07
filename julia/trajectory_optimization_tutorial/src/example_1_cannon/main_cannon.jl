#MAIN_cannon.m
#
# This script is used to find the optimal initial state for the cannon
# example problem, as described below:
#
###########################################################################
#
# Cannon Example:
#
# Find the optimal initial velocity for a projectile such that the
# resulting trajectory passes through a desired target. 
#
# States:
#   x = horizontal position
#   y = vertical position
#   dx = horizontal speed
#   dy = vertical speed
#   ddx = horizontal acceleration
#   ddy = vertical acceleration
#
# Parameters:
#   c = quadratic drag coefficient
#   T = final simulation time
#
# Boundary Conditions:
#   x(0) = 0;
#   y(0) = 0;
#   x(T) = xf;
#   y(T) = yf;
#
# Objective Function:
#   J = dx(0)^2 + dy(0)^2;
#
# Dynamics Constraint:
#   ddx = -c*dx*sqrt(dx.*dx + dy.*dy);
#   ddy = -c*dy*sqrt(dx.*dx + dy.*dy) - 1; 
#
###########################################################################

#### Adjust the following parameters and see what happens.
#
# 1) The problem becomes trivial if the drag coefficient (c) is small, but
# numerically stiff if c is large (>0.4). Which methods can handle large
# values of c the best?
#
#
# 2) What do you think happens if you use more (or fewer) grid points?
#
# 3) What happens if you move the target away? 
# Open:  TEST_cannonFeasibility.m   to see the answer. 
#
# 4) For either large range or large damping, the problem becomes stiff. As
# a result, the integration methods (either implicit or explicit) start to
# fail near the beginning of the trajectory where the speed is very high.
# If you use a log spaced grid (rather than uniform), then all methods
# perform better.
#
# 5) You can speed up the optimizations by disabling diagnostics or making
# each animation shorter.
#


#Provide an initial guess for the solver
guess.initSpeed = 9.0;
guess.initAngle = (pi/180)*45;

# Set the target (assuming that the trajectory starts at x=0, y=0)
target.x = 6.0;  
target.y = 0;

# Set up the parameters for the dynamics function:
param.dynamics.c = 0.4;  #Quadratic drag coefficient

###########################################################################

### Set up the grid discretization for each method:
param.singleShooting.nGrid = 100; 
param.multipleShooting.nSegment = 10;
param.multipleShooting.nSubStep = 5;
param.collocation.nSegment = 50;
param.gpops.nSegment = 10;

### Parameters for diagnostics (visualization only)
param.diagnostics.enable = true;   #Enable plotting and log iterations?
param.diagnostics.animationDuration = 5;  #(seconds) How long is the animation?
param.diagnostics.writeGif = true;   #Save animation to a gif?
param.diagnostics.gifPixelDim = [800,400];  #How big of a gif to make?
param.diagnostics.figNum.singleShooting = 10;
param.diagnostics.figNum.multipleShooting = 11;
param.diagnostics.figNum.collocation = 12;
param.diagnostics.figNum.gpops = 13;

# Use single shooting to find the solution:
soln.singleShooting = cannon_singleShooting(guess,target,param);

# Use multiple shooting to find the solution:
#soln.multipleShooting = cannon_multipleShooting(guess,target,param);

# Use collocation to find the solution:
#soln.collocation = cannon_collocation(guess,target,param);

# # Use NLOptControl to solve the problem
# # - adaptive high-order collocation
# soln.nloptcontrol = cannon_nloptcontrol(guess,target,param);