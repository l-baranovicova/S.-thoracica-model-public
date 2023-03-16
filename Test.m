alpha = 7; %before alpha=5, saturation reaches low levels
M = linspace(0,1,100);

%DEFAULT
melanism = 1-exp(-M .* alpha);

% melanism = 1-exp(-2.*M .* alpha);

%I would like to shorten the x range of this function so it is fully
%saturated at x=0.5

figure(1)
plot(M, melanism)
title("melanism function")
xlabel("investment")
ylabel("melanism level")


beta = 6;
S = 1 - M;

%DEFAULT
% size = S .^ beta;
size = (-0.5 + 1.5 *S) .^ beta;

figure(2)
plot(S, size)
title("size function")
xlabel("investment")
ylabel("size")

figure(3)
plot(size, melanism)
xlabel("size")
ylabel("melanism")



testpop = [1 2 3 4 5 6 7 8 9 10];
indices = numel(testpop);

probs = [0 3 0 0 0 0 0 8 0 0];
choice = randsample(indices, 10, true, probs)

newpop(:) = testpop(choice)
%_____________________________________

clear, clc

pop_size = 9;
n_large = 4;
n_inter = 1;

pop = zeros(pop_size , 2);
pop(1:n_large, 1) = 1;
pop(n_large+1 : n_large+n_inter , 1) = 0.5;

Beta_large = 2;
Beta_small = 2;

for i = 1:pop_size
    
    benefit_if_large = pop(i,1) ^ Beta_large / sum(pop(:,1).^Beta_large);
    %intermediates only benefit from the small competition, why??

    benefit_if_small = (1 - pop(i,1)) ^ Beta_small / sum((1-pop(:,1)).^Beta_small);
   

    
    size_blarge_bsmall = [pop(i,1) benefit_if_large benefit_if_small]
    
    pop(i,2) = (benefit_if_large + benefit_if_small); 
end

w_of_large_ind = pop(1, 2) 
w_of_inter_ind=pop(n_large+1, 2)
w_of_small_ind = pop(pop_size, 2)
w_of_all_large = sum(pop(1:n_large, 2))
w_of_all_inter = sum(pop(n_large+1:n_large+n_inter, 2))
w_of_all_small = sum(pop(n_large+n_inter+1:pop_size,2))

