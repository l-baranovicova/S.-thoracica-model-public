function [melanism, size] = logistic(slope, switch_point, resources)



x = rand * resources; %0-18: random amount of res. invested into melanism

melanism=1/(1+exp(-(slope)*(x-switch_point)));
%melanism is from logistic function, given by stochastic investment x

size = 1 - melanism;    %for now like this
                        %if we change it we need to update competition()