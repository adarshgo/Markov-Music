function [index] = rando(pmf)
%  function [index] = rando(pmf)
%  generates a random variable in 1, 2, ..., n given a PMF. 
% ------------------------------
% Input
%   pmf - A vector of probabilities for a random variable defined on 1, 2,
%   ..., n
%
% Output
%   index - Value randomly drawn from the PMF

if ~(sum(pmf) + 1E-12 > 1 & 1 > sum(pmf) - 1E-12)
    error('pdf is does not sum to 1');  
end

cdf = cumsum(pmf);
index = min(find(cdf >= rand));

