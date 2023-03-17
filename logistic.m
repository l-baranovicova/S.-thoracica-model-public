function [pop] = logistic(pop, resources)

x = rand(size(pop,1),1) .* resources;
%we need x to be the same for the size & melanism of one individual

pop(:,3:4) = [1./(1+exp(-(pop(:,1).*(x-pop(:,2))))), 1-(1./(1+exp(-(pop(:,1).*(x-pop(:,2))))))];


