g_array = [];


g = struct;
g.filename = 'rezistance_odpor_5_nadoba__L.png';
g.title = 'délka 3, nádoba 54 L';
g.range = 'B50:H52';
g.x1 = 'data.Var3';
g.y1 = 'data.Var2';
g.x2 = 'data.Var5';
g.y2 = 'data.Var4';
g.x3 = 'data.Var7';
g.y3 = 'data.Var6';
g.xlabel = 'Rp'; 
g.ylabel = 'R5 [cm H2O s/L]';
g.xlim = [0 55];
g.legend = {'odpor 5','odpor 20', 'odpor 50'};
g_array = [g_array, g];
%%%%%%%%%%%
g = struct;
g.filename = 'reaktance_odpor_5_nadoba__L.png';
g.title = 'délka 3, nádoba 54 L';
g.range = 'B53:H53';
g.x1 = 'data.Var3';
g.y1 = 'data.Var2';
g.x2 = 'data.Var5';
g.y2 = 'data.Var4';
g.x3 = 'data.Var7';
g.y3 = 'data.Var6';
g.xlabel = 'Rp'; 
g.ylabel = 'X5 [cm H2O s/L]';
g.xlim = [0 55];
g.legend = {'odpor 5','odpor 20', 'odpor 50'};
g_array = [g_array, g];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5555


% loop over array
for i=1:length(g_array)
  
    g = g_array(i);
    data = readtable('data-FOT_hotovo.xlsx','Range', g.range);

    figure
    hold on
    plot(eval(g.x1), eval(g.y1), 'o', 'LineStyle', 'none',  ...
         'MarkerEdgeColor','#0072BD','MarkerFaceColor','#0072BD',...
        'MarkerSize',15);

    plot(eval(g.x2), eval(g.y2), 'o', 'LineStyle', 'none',  ...
         'MarkerEdgeColor','#A2142F','MarkerFaceColor','#A2142F',...
        'MarkerSize',15);

    plot(eval(g.x3), eval(g.y3), 'o', 'LineStyle', 'none',  ...
         'MarkerEdgeColor','#77AC30','MarkerFaceColor','#77AC30',...
        'MarkerSize',15);

    lx =  [eval(g.x1);eval(g.x2);eval(g.x3)];
    ly = [eval(g.y1);eval(g.y2);eval(g.y3)];
    mdl = fitlm(lx, ly);
    
    lower_y = min(ly) - 0.1;   
    upper_y = max(ly) + 0.1;
        
           
    
   
    lra = mdl.Coefficients{'x1','Estimate'};
    lrb = mdl.Coefficients{'(Intercept)','Estimate'};
    plot(mdl, 'Marker', 'none')
    
    g.legend(end+1) = {''};
    g.legend(end+1) = {strcat('lineární regrese y=', string(round(lra, 2, 'significant')), 'x+', string(round(lrb, 2, 'significant')))};
    g.legend(end+1) = {'95% konfideční interval'};
    
    title(g.title);
    xlabel(g.xlabel);
    ylabel(g.ylabel);
    xlim(g.xlim);
    ylim([lower_y, upper_y]);
    legend(g.legend);
    saveas(gcf,strcat('pic\', g.filename));
    close;
end
