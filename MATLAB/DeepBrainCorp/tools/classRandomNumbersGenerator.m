%______________________________________________________________
%     classRandomNumbersGenerator.method  CALL AS FUNCTIONS
%             %PDFs ONLY
%             numbers = uniform(N,min,max)   [double]
%             numbers = exponential(N,rate)  [double]
%             numbers = gaussian(N,mu,std)   [double]
%______________________________________________________________
classdef classRandomNumbersGenerator
  
  methods (Static)
    %__________________________________________________________________
    % function numbers = uniform(N, min, max)
    %  we ask a larger pool and choose randomly N (flatter for small N)
    %__________________________________________________________________
    function numbers = uniform(PLOT_ON,N, min, max)
      assert(max>min,'numbers = uniform(N, min, max). error: min>max');
      maanynumbers = 10000000; %random works better on large pools
                           %then we choose randomly from the pool
                           % it should be uniform distributed even
                           % for small N ... using equations deforms
                           % the distribution (such used in mu-law)
      numpool = rand(maanynumbers,1); %[0,1]
      keepN   = ceil(maanynumbers*rand(1,N));
      numbers = numpool(keepN);
      
      numbers = min + (max-min)*numbers;
      
      if (PLOT_ON)
        plot(hist(numbers,20)/sum(hist(numbers,20)));
      end
    end
    
    %____________________________________________________________________
    % function numbers = exponential(N,rate) %used for spike generation
    %   lambda: rate >1 . timescale must be chosen accordingly
    %    in order to have a PDF of probability of an event occuring
    %
    % lambda: sec,ms,um,mt of e^(-t/lambda) must be greater than 1
    % as defining pdf when searching for something that happens
    % almost certeanly before t=1 (lambda<1) doesnt make a PDF
    % as lambda ->0 we approach a delta(t) and would be a PDF.
    % seen as: it would occur the event at time near 0 with probability 1
    % see the lecture on this topic.
    %____________________________________________________________________
    function numbers = exponential(PLOT_ON, N,rate) %used for spike generation
      
      assert(rate>1, 'Exponential Probability Distribution, Lambda >1');
      % y = (1/rate)*exp(-x/rate);    (x or t)   rate>1
      % -1*(rate*ln(y*rate))  = -rate*log(y*rate)/log(exp(1)) = x
      
      % to avoid getting numbers that have tiiiny probability, but
      % are still possible. we twickit and avoid p_x=y too small
      %      y_max*exp(-3) = y_min to include otherwise we might
      %      have a x huuuge (an enormous time between spikes for instance)
      y_min = 1/rate* exp(-1*3); %to avoid numbers unlikely and huuuge
      y_max = 1/rate;            %normalize exp function. as valid PDF
      y = classRandomNumbersGenerator.uniform(false,N, y_min, y_max);
      numbers = -1*rate*log(y*rate)./log(exp(1));
      
      if (PLOT_ON)
        plot(hist(numbers,20)/sum(hist(numbers,20)));
      end
      
    end
    
    %___________________________________________________________
    %     function numbers = gaussian(N,mu,std)  %PDF
    %
    %   y = 1/(sigma*sqrt(2pi))*exp(-(x-mu)^2/(2sigma^2))
    %   x = mu +/- i*sqrt(*2sigma^2*ln(y*sigma*sqrt(2pi)) )
    %   we would need to do for both sides (x>mu (+) and x<mu (-))
    %   see paper 2. model 2 (simple ion channel model)
    %    and my lecture on this paper 2, model 2. (similar to 
    %    the exponential case (delta), but on unitary circle (complex nums)
    %___________________________________________________________
    function numbers = gaussian(PLOT_ON, N,mu,sigma)
      MU = mu;
      
      %assert to have a gaussian, not a "delta like sharp peaked distribution"
      % neither a flatter flatter not gaussian boa
      %assert((sigma>(mu/sqrt(2*pi))), ...
      %  'Gaussian Probability Distribution, sigma>(1/sqrt(2*pi)'); 
      
      %   y = 1/(sigma*sqrt(2pi))*exp(-(x-mu)^2/(2sigma^2))
      %   x = mu +/- sqrt(*2sigma^2*ln(y*sigma*sqrt(2pi)) )
      %   we could use this after some math gym. but we could get
      %   an infinitely large number on x (numbers) although it
      %   has a tiiiny tiiiny probabilityassert(max>min,'numbers = uniform(N, min, max). error: min>max');
      y_max = 1/sqrt(2*pi*sigma^2);            %normalize exp function. as valid PDF
      y_min = 1/sqrt(2*pi*sigma^2)*exp(-10);%to avoid numbers very unlikely , yet huuuuuge
      YY = classRandomNumbersGenerator.uniform(false,N, y_min, y_max);
      coin = classRandomNumbersGenerator.coin(false,N);
      numbers_i = sqrt(-2*sigma^2*(log(YY*sqrt(2*pi*sigma^2))/log(exp(1))));
      
      %numbers = MU + coin.*numbers_i;
      numbers = [(MU*ones(1,N/2) + randn(1,N/2)*sigma)  (MU*ones(1,N/2) - randn(1,N/2)*sigma)];
      
      if (PLOT_ON)
        figure; hist(YY,50);
        figure; hist(numbers,50);
      end
      
      
    end %function GAUSSIAN
    
      %N numbers drawn from a "binary distribution: 0.5 0.5 coin"
   function numbers = coin(PLOT_ON,N)
      maanynumbers = 10000000; %random works better on large pools
                           %then we choose randomly from the pool
                           % to get N coin experiments
                           
      numpool = rand(maanynumbers,1); %[0,1]
      keepN   = ceil(maanynumbers*rand(1,N));
      numbers = numpool(keepN);
      
      numbers = round(numbers);
      numbers(numbers==0) = -1;
      
      if (PLOT_ON)
        plot(hist(numbers,20)/sum(hist(numbers,20)));
      end
   end %function COIN
    
   
  end
  
end
    
    