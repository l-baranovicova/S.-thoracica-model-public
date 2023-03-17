clear, clc

survival_min = 0.4;     % survival at 0 melanism
survival_max = 0.9;     % at 1 melanism
generations = 1000;
max_pop = 1000;           
resources = 18;         % this works well with my switch point setting
mutation_deviation = 0.05;
mutation_prob = 0.05;

% keep track of slope, switch point, melanism, size
evolution_matrix = zeros(generations,4);

% INITIALIZATION
[pop] = initialization(max_pop);

for gen = 1:generations-1

    % TRAIT EVALUATION
    % melanism and size generation in whole population, VECTORISED
    pop=logistic(pop, resources);

    % RECORD AVERAGE STATS
    evolution_matrix(gen, :) = [mean(pop(:,1)),mean(pop(:,2)) mean(pop(:,3)), mean(pop(:,4))];

    % MORTALITY
    pop(:,:) = pop(:,:) .* (rand(max_pop,1) < (survival_min+(survival_max-survival_min).*pop(:,3)));
    % if rand is larger than survival - condition on right = false = 0,
    % individual is multiplied by zeroes - dies (unlikely if survival high)

    pop = sortrows(pop, -1); % dead individualss are at the end

    % COMPETITION
    % get fitness for each individual
    pop = competition(pop);

    % NEW GENERATION
    pop = reproduction(pop, max_pop, mutation_deviation, mutation_prob);

end

% TRAIT EVALUATION
pop=logistic(pop, resources);

% RECORD AVERAGE STATS
evolution_matrix(generations, :) = [mean(pop(:,1)),mean(pop(:,2)) mean(pop(:,3)), mean(pop(:,4))];

% figure(1)
% scatter(pop(:,1), pop(:,2))
% title("Final population")
% xlabel("slope")
% ylabel("switch point")
%
% figure(2)
% scatter(pop(:,3), pop(:,4))
% title("Final population")
% xlabel("melanism")
% ylabel("size")

figure(3)
plot(1:generations, evolution_matrix(:,1), ...
    1:generations, evolution_matrix(:,2))
title("Trait evolution")
xlabel("Generations")
legend("slope","switch point")

figure(4)
plot(1:generations, evolution_matrix(:,3), ...
    1:generations, evolution_matrix(:,4))
title("Trait evolution")
xlabel("Generations")
legend("melanism","size")
