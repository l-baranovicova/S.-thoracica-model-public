function[pop] = initialization(max_pop)

pop = zeros(max_pop,5);
%indices: slope, switch point, melanism, size, fitness, decimal for
%reproduction

for i = 1:max_pop
    pop(i,1) = 0.5 + rand; %0.5 - 1.5 slope. Slope must be low to get many intermediates
    pop(i,2) = 6 + rand * 6;     %6-12 switch point
end