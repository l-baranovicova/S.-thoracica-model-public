function [new_pop] = reproduction_randsample(pop, mutation_deviation, max_pop)
%PARENT MATRIX now has 5 columns only - no need to store decimals in #6!

new_pop = zeros(max_pop, 5);    %empty matrix for next population

%randsample(population,k,true,w, replacement) uses weights, w, to determine
%the prob that population(i) is selected max_pop = # of generated values

indices = nnz(pop(:,1)); %number of live individuals
offspring_indices = randsample(indices, max_pop, true, pop(1:indices,5));
%samples the indices of selected parents based on w, with repetitions

new_pop(:,1:2) = pop(offspring_indices,1:2) + randn(max_pop,2) .* mutation_deviation;
%new slope & switch pt = old values from selected index, each + randn *
%mutation_deviation

%return the new generation