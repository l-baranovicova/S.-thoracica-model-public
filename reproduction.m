function [new_pop] = reproduction(pop, max_pop, mutation_deviation, mutation_prob)

new_pop = zeros(max_pop, 5);    
indices = nnz(pop(:,1)); %number of live individuals

%randsample(population,k,true,w, replacement) uses weights, w, to determine
%the prob that population(i) is selected max_pop = # of generated values

%sample the indices of selected parents based on w, with repetitions
offspring_indices = randsample(indices, max_pop, true, pop(1:indices,5));

%vertex of {0,1} for which offspring mutate
does_it_mutate = rand(max_pop,1)<mutation_prob;

new_pop(:,1:2) = pop(offspring_indices,1:2) + ...
    [does_it_mutate, does_it_mutate] .* randn(max_pop,2) .* mutation_deviation;

%if there is mutation, both slope and switch pt of that offspring mutate