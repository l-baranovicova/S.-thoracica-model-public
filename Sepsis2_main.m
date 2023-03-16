clear, clc

survival_min = 0.1;     %survival at 0 melanism
survival_max = 1;    %at 1 melanism
generations = 1000;
max_pop = 300;      %huge impact on time complexity due to competition
resources = 18;     %this works well with my switch point setting
mutation_deviation = 0.05;

evolution_matrix = zeros(generations,4); %keeps track of slope, switch point, melanism, size

%INITIALIZATION
[pop] = initialization(max_pop);

% figure(1)
% scatter(pop(:,1), pop(:,2))
% title("initial population")
% xlabel("slope")
% ylabel("switch point")

for gen = 1:generations-1
    
    %melanism and size generation in whole population, VECTORISED
    pop=logistic2(pop, resources);

    %TRAIT EVALUATION
    for i = 1:max_pop %for each individual
        %melanism and size are functions of slope and switch point 
        [pop(i,3), pop(i,4)] = logistic(pop(i,1), pop(i,2), resources); 
    end
    
    %average slope, switch point, melanism and size
    evolution_matrix(gen, :) = [mean(pop(:,1)),mean(pop(:,2)) mean(pop(:,3)), mean(pop(:,4))]; 
    
%   MORTALITY
    for i = 1:max_pop %for all individuals
        %survival increases with melanism
        survival=survival_min+(survival_max-survival_min).*pop(i,3);
        if rand > survival %the bigger the survival, the harder to meet this condition
            pop(i,:) = zeros(1,5); %individual dies
        end
    end
    
    %sort population so that dead individuals are at the end
    pop = sortrows(pop, -1);
   
    %COMPETITION
    %get fitness for each individual
    pop = competition(pop);
    pop(1:10,4:5);
    %NEW GENERATION
    pop = reproduction_randsample(pop, mutation_deviation, max_pop);
end

%one last trait evaluation for the last generation
for i = 1:max_pop %for each individual
      [pop(i,3), pop(i,4)] = logistic(pop(i,1), pop(i,2), resources); 
end

%TO GET THE LAST GENERATION STATS   (we have initial gen + 999)
evolution_matrix(generations, :) = [mean(pop(:,1)),mean(pop(:,2)) mean(pop(:,3)), mean(pop(:,4))]; 
 
% figure(2)
% scatter(pop(:,1), pop(:,2))
% title("Final population")
% xlabel("slope")
% ylabel("switch point")
% 
% figure(3)
% scatter(pop(:,3), pop(:,4))
% title("Final population")
% xlabel("melanism")
% ylabel("size")


figure(4)
plot(linspace(1, generations, generations), evolution_matrix(:,1), ...
    linspace(1, generations, generations), evolution_matrix(:,2))
title("Trait evolution")
xlabel("Generations")
legend("slope","switch point")

figure(5)
plot(linspace(1, generations, generations), evolution_matrix(:,3), ...
    linspace(1, generations, generations), evolution_matrix(:,4))
title("Trait evolution")
xlabel("Generations")
legend("melanism","size")
