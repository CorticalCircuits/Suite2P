function redraw_tuning(h)
% break
% return
axes(h.axes6)
hold off

ichosen = h.dat.F.ichosen;
F = [];
Fneu = [];
for j = 1:numel(h.dat.Fcell)

    F = cat(1, F, h.dat.Fcell{j}(ichosen, :));
    Fneu = cat(1, Fneu, h.dat.FcellNeu{j}(ichosen, :));
%     F = cat(2, F, h.dat.Fcell{j}(ichosen, :));
%     Fneu = cat(2, Fneu, h.dat.FcellNeu{j}(ichosen, :));
end

theta = 0:360/length(h.dat.stat(ichosen).TC(2:end)):359;

hold off
plot(theta,h.dat.stat(ichosen).TC(2:end),'o')
hold on
plot(h.dat.stat(ichosen).TCfit,'k')

% plot(F','color',[.5 .5 .5])
axis tight
hold on

% plot(median(F,1),'k','linewidth',2);
% plot(double(F))
% plot(my_conv_local(medfilt1(double(F), 3), 3))
coefNeu = 1;
if isfield(h.dat.stat, 'neuropilCoefficient')
    coefNeu = h.dat.stat(ichosen).neuropilCoefficient;
end

baseline = 0;
if isfield(h.dat.stat, 'baseline')
    baseline = h.dat.stat(ichosen).baseline;
end

% if isfield(h.dat, 'FcellNeu')
% %     plot(baseline + coefNeu * my_conv_local(medfilt1(double(Fneu), 3), 3))
% %     plot(baseline + coefNeu * double(Fneu))
%     plot(baseline + coefNeu * median(double(Fneu)),'r','linewidth',2)
% end
NT = length(F);
% box off
% axis off
set(gca, 'xcolor', 'w')
% plot([0 NT], [baseline baseline], 'k', 'Linewidth', 2)
% axis off
hold off

