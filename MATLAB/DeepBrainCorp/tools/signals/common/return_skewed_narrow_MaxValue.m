%__________________________________________________________________________
%
%   Skewed_MaxValue = return_skewed_narrow_MaxValue(numberOuts)
%
%   returns an array  Skewed_MaxValue[numberOuts] of max values 
%   with skewed distribution
%   NCMU_Req_1:  
%   (as signal produced by phototransducers) 
%   which requires a signal generated on each ion channel
%   with such kind of distribution on its peak amplitude as a first
%   overly simplistic representation approach to ion channels workings.
%   Realistic approach to be defined by Paul. (next model approach)
%
%        -           Skewed distribution truncated above 0.
%       - -          Mean value 10, std 0.3. Scale/move as needed.
%      -  -
%   -     -
%
%__________________________________________________________________________
function Skewed_MaxValue = return_skewed_narrow_MaxValue(numberOuts)

  for i=1:1:numberOuts
    Skewed_MaxValue(i) = max([0 random('Extreme Value',10,0.3)]);
  end
  
     histogram(Skewed_MaxValue,20);
end
  
    