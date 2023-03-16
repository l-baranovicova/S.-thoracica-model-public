function [pop] = logistic2(pop, resources)

x = rand(size(pop,1),1) .* resources;
%we need x to be the same for the size & melanism of one individual

pop(:,3:4) = [transpose(1/(1+exp(-(pop(:,1).*(x-pop(:,2)))))), transpose(1-(1/(1+exp(-(pop(:,1).*(x-pop(:,2)))))))];

%WHY is e.g. 1/(1+exp(-(pop(:,1).*(x-pop(:,2))))) HORIZONTAL?
%WHY did I have to transpose them to make them into columns that I can then
%join into an (x,2) sized matrix??


%OLD CODE (same but not vectorised:)
% x = rand * resources; %0-18: random amount of res. invested into melanism
% 
% melanism=1/(1+exp(-(slope)*(x-switch_point)));
% %melanism is from logistic function, given by stochastic investment x
% 
% size = 1 - melanism;    %for now like this
%                         %if we change it we need to update competition()