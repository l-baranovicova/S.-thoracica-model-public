function[pop] = initialization(max_pop)

pop = zeros(max_pop,5);
%indices: slope, switch point, melanism, size, fitness, decimal for

pop(:,1:2) = rand(max_pop,2) .* [1,6] + [0.5,6];
%slope = 0.5-1.5
%switch pt = 6-12