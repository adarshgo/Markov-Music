function [sample] = mydatasample(data)
%  function [sample] = mydatasample(data)
%  Selects one sample randomly and uniformly from the data vector

n = length(data);
sample = data( randi(n) );
