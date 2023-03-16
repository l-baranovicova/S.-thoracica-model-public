function [pop] = competition(pop)

%based on size
%2 competitions

%competition: benefit = y^B / sum (all y^B)
%where y = trait size
%and B = decisiveness of trait in competition (B>1 = disproportionate
%advantage)

Beta_large = 2; %advantage of large individuals disproportionate
Beta_small = 1.5; %adv of small individuals disproportionate but much smaller

pop_size = nnz(pop(:,1));

for i = 1:pop_size %for each living individual
    
    benefit_if_large = pop(i,4)^Beta_large / sum(pop(1:pop_size,4).^Beta_large);

    %smallness is the opposite of largeness
    benefit_if_small = (1 - pop(i,4)) ^ Beta_small / sum((1-pop(1:pop_size,4)).^Beta_small);
    
    %fitness of individual = sum of advantages
    pop(i,5) = (benefit_if_large + benefit_if_small);  

end