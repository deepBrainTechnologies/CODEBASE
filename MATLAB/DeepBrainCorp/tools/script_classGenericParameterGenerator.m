%script_classGenericParameterGenerator

% TEST GENERIC PARAMETERS(VARIABLES) GENERATOR

%settings.default;    % [nParams x 1] default parameters
%settings.typeGen;    % 1:lin 2:exp 3:rand 4:extFunc
%settings.limits;     % [nParams x 2] - Boundary/Limits of each parameter
%settings.linGridStep;    % [nParams x 1] 
%settings.expGridFactor;    % [nParams x 1] 
%settings.randomOn;       % [nParams x 1]
%settings.nRandPoint;     % [nParams x 1]


settings.default = [10; 20 ];
settings.limits = [0 20; 10 30];
settings.linGridStep = 3;
settings.expGridFactor = 2;
settings.nRandPoint =10;
settings.randomOn = 0;
settings.handleFuncGenerator = 0;

settings.typeGen =1;
generator = classGenericParametersGenerator;
parameters = generator.execute(settings);
figure;
plot(parameters(:,1),parameters(:,2));

settings.typeGen =2;
generator = classGenericParametersGenerator;
parameters = generator.execute(settings);
figure;
plot(parameters(:,1),parameters(:,2));

settings.typeGen =3;
generator = classGenericParametersGenerator;
parameters = generator.execute(settings);
figure;
plot(parameters(:,1),parameters(:,2));
