function [pop] = competition(pop)

%competition: benefit = y^B / sum (all y^B)
%y = trait size
%B = decisiveness of trait in competition (B>1 = disproportionate
%advantage)

Beta_large = 2; %advantage of large individuals disproportionate
Beta_small = 1.5; %adv of small individuals disproportionate but much smaller

pop_size = nnz(pop(:,1));

%THIS HERE speeds up the code so much. No need to sum up the sizes 1000x in
%each generation, once is enough
denom_large = sum(pop(1:pop_size,4).^Beta_large);
denom_small = sum((1-pop(1:pop_size,4)).^Beta_small); %smallness = 1-largeness

% VECTORIZED CODE
pop(1:pop_size, 5) = ((pop(1:pop_size, 4).^ Beta_large)./denom_large + ...
    ((1-pop(1:pop_size, 4)).^ Beta_small)./denom_small);

% COMPARE the old version
%
% for i = 1:pop_size %for each living individual
%     
%     benefit_if_large = pop(i,4)^Beta_large / denom_large;
% 
%     %smallness is the opposite of largeness
%     benefit_if_small = (1 - pop(i,4)) ^ Beta_small / denom_small;
%     
%     %fitness of individual = sum of advantages
%     pop(i,5) = (benefit_if_large + benefit_if_small);  
% 
% end