
% - figure params
fs = 15;
tkl = .02;
lw = 1.5;

% - number of neurons to show
N_neurons = 20;
% - sorting the sample neurons wrt the ref. neuron (set in default params)
[a,b] = sort(cc_rfs(nids_smpl, nids(1:N_neurons)), 'descend');

if ~exist('Figures'); mkdir('./Figures'); end

%%
    
x = cc_resp(nids,1:NE);

x_avg = linspace(nanmin(x(:)),nanmax(x(:)),40);
dx = diff(x_avg(1:2));

y = influence_r(:,1:NE);
[y_avg, y_std, y_sem] = calAvg(x, y, x_avg, dx);

yw = influence_w(:,1:NE);        
[yw_avg, yw_std, yw_sem] = calAvg(x, yw, x_avg, dx);

figure('Position',[100,100,400,350])
subplot(111)
hold on

plot(x, y, '.', 'markersize', .5, 'color', [.7,.7,.7])

plot(x_avg, zeros(size(x_avg)), 'k--', 'LineWidth',2)

ym = 1.2*max(y(:));
ylim([-.02,.04]/2)

ylabel('Influence (single cell)')

yyaxis right
hold on
plot(x_avg, y_avg, 'r-', 'LineWidth',2)
patch([x_avg fliplr(x_avg)], [y_avg-y_sem fliplr(y_avg+y_sem)], 'r','FaceAlpha',.3)

xticks([-1,-.5,0,.5,1])
xlim([-1.01,1.01])
ylim([-.02,.04]/12)

xlabel('Signal corr.')
ylabel('Influence (avg.)')

set(gca, 'LineWidth', lw, 'FontSize', fs, 'Box', 'off', 'TickDir', 'out', ...
    'TickLength', [tkl tkl], 'YDir', 'normal', 'YColor', 'r')

print('./Figures/rate_based_pert_1', '-dpng', '-r300')

% --

figure('Position',[100,100,400,350])
subplot(111)

hold on
plot(x_avg, y_avg / max(abs(y_avg)), 'k-o', 'LineWidth',2, 'MarkerSize',7)

ylabel('Influence (norm.)')

plot(x_avg, yw_avg/max(abs(yw_avg)), 'r-', 'LineWidth',2)
plot(x_avg, zeros(size(x_avg)), 'k--')

legend({'Neuronal networks', 'Pred. from weights'}, ...
'Location', 'northwest', 'FontSize',17.5)
legend boxoff

xlabel('Signal corr.')

xticks([-1,-.5,0,.5,1])
xlim([-.5,1])

set(gca, 'LineWidth', lw, 'FontSize', fs, 'Box', 'off', 'TickDir', 'out', ...
    'TickLength', [tkl tkl], 'YDir', 'normal')

print('./Figures/rate_based_pert_2', '-dpng', '-r300')

% --

zz = influence_r(b,nids(b));
zz(eye(length(zz))==1)=0;

figure('Position', [100,100,400,400])
title('Influence'); hold on

zzmx = max(max(zz(:)), max(abs(zz(:))));

imagesc(zz, [-zzmx,zzmx]);
colormap('redblue');
axis image;
colorbar()

xl = xlabel('Influencee', 'Position', [N_neurons/2,-1/2,1]);
yl = ylabel('Influencer', 'Position', [-1/2,N_neurons/2,1]);

xticks([1,N_neurons])
yticks([1,N_neurons])

set(gca, 'LineWidth', lw, 'FontSize', fs, 'Box', 'off', 'TickDir', 'out', ...
    'TickLength', [tkl tkl], 'YDir', 'normal')

print('./Figures/sample_influence_matrix_rate_based', '-dpng', '-r300');

%% - functions

function [y_avg, y_std, y_sem] = calAvg(x, y, x_avg, dx, num_th)
if nargin == 4; num_th = 20; end

    y_avg = nan*zeros(size(x_avg));
    y_std = nan*zeros(size(x_avg));
    y_sem = nan*zeros(size(x_avg));
    
    for i = 1:length(x_avg)
        xids = logical((x>(x_avg(i)-dx/2)) .* (x<(x_avg(i)+dx/2)));
        if sum(xids(:)) >= num_th
            y_avg(i) = nanmean(y(xids));
            y_std(i) = nanstd(y(xids));
            y_sem(i) = nanstd(y(xids)) / sqrt(length(xids));
        end
    end
end