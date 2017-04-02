function [fitresult, gof] = createFit(x, y)
[xData, yData] = prepareCurveData( x, y);              % Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0];
opts.StartPoint = [y(ceil(length(x)/2)) x(ceil(length(x)/2)) 0.1];                    % Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );                               % Plot fit with data.
h = plot( fitresult, xData, yData);
xlabel( '¦Â' );
ylabel( 'R' );
legend off
grid on;hold on;
plot(fitresult.b1,fitresult.a1,'^','markersize',6)
