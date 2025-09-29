
%% - make the weight matrix
    
wEE = JEE* exp(exp_pwr* cc_rfs(1:NE,1:NE));
wEI = JEI* exp(exp_pwr* cc_rfs(1:NE,NE+1:end));
wIE = JIE* exp(exp_pwr* cc_rfs(NE+1:end,1:NE));
wII = JII* exp(exp_pwr* cc_rfs(NE+1:end,NE+1:end));

w = [wEE, wEI
     wIE, wII];

w = w + 0.1/20*(rand(N,N)-.5);
w(eye(N)==1) = 0;

zz = w(1:NE,:); zz(zz<0) = 0; w(1:NE,:) = zz;
zz = w(1+NE:end,:); zz(zz>0) = 0; w(1+NE:end,:) = zz;
  
