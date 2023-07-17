clear all
close all
data = readtable('FOTdata.csv');


dily_arr = [20, 40, 60];
odpor_arr = [5,20,50];
nadoba_arr = [35, 54];

y_r_lim = [2 4];
y_x_lim = [-0.4 0.6];

x_font_size = 13;
y_font_size = 13;
t_font_size = 13;


barvy = ["#0072BD", "#A2142F", "#77AC30"];

% zafixuji 2 veliciny a jednu menim -> 1 graf
% smycka pro nadoby
for i_dily=1:length(dily_arr)
    for i_odpor=1:length(odpor_arr)
        figure
        hr=axes;
        hold on
        
        figure
        hx=axes;
        hold on
        
        minx = 99999;
        maxx = -99999;
        miny_r = 99999;
        miny_x = 99999;
        maxy_r = -99999;
        maxy_x = -99999;
        lx = [];
        ly_r = [];
        ly_x = [];
        legenda = [];
        
        
        for i_nadoba=1:length(nadoba_arr)
            dil = dily_arr(i_dily);
            odpor = odpor_arr(i_odpor);
            nadoba = nadoba_arr(i_nadoba);
            ix = (data.dily == dil) &(data.odpor == odpor) &(data.nadoba == nadoba);
            plot_data = data(ix,:);
            plot(hr, plot_data.nadoba, plot_data.R5, 'o', 'LineStyle', 'none',  ...
                 'MarkerEdgeColor',barvy(i_nadoba),'MarkerFaceColor',barvy(i_nadoba),...
                'MarkerSize',15);
            
            plot(hx, plot_data.nadoba, plot_data.X5, 'o', 'LineStyle', 'none',  ...
                 'MarkerEdgeColor',barvy(i_nadoba),'MarkerFaceColor',barvy(i_nadoba),...
                'MarkerSize',15);
            
            minx = min(minx, min(plot_data.nadoba));
            maxx = max(maxx, max(plot_data.nadoba));
            
            miny_r = min(miny_r, min(plot_data.R5));
            maxy_r = max(maxy_r, max(plot_data.R5));
            
            miny_x = min(miny_x, min(plot_data.X5));
            maxy_x = max(maxy_x, max(plot_data.X5));
                       
            % lin reag
            lx =  [lx; plot_data.nadoba];
            ly_r = [ly_r; plot_data.R5];
            ly_x = [ly_x; plot_data.X5];
            
            % legend
            legenda = [legenda, strcat("Nádoba ", string(nadoba), " L")];

        end
        
       % dopocitej linreg
       if min(lx) < max(lx)    
           mdl_r = fitlm(lx, ly_r);
           mdl_x = fitlm(lx, ly_x);
           
           lr_ra = mdl_r.Coefficients{'x1','Estimate'};
           lr_rb = mdl_r.Coefficients{'(Intercept)','Estimate'};
           lr_xa = mdl_x.Coefficients{'x1','Estimate'};
           lr_xb = mdl_x.Coefficients{'(Intercept)','Estimate'};
       end
               
       % uprav graf po konci vnitrni smycky
      
       axes(hr);
       if min(lx) < max(lx) 
           plot(mdl_r, "Marker", "none")
           xlim([minx-5 maxx+5]);
           %ylim([miny_r-0.2 maxy_r+0.2]);
           ylim(y_r_lim);
       end 
       
       if lr_rb>0
           znaminko = "+";
       else
            znaminko = "";
       end
       
       legenda1_r = [legenda, "", ...
           strcat('Lineární regrese y=', string(round(lr_ra, 2, "significant")), "x", znaminko, string(round(lr_rb, 2, "significant"))), ...
           "95% konfidenční interval"];
       
     
       
       legend(legenda1_r);
       xlabel("Nádoba [L]", "FontSize", x_font_size);
       ylabel("R5 [cm H2O s/L]", "FontSize", y_font_size);
       title (strcat("Rezistance: délka trubice ",string(dil), " cm, Rp ", string(odpor) ), "FontSize", t_font_size);
       saveas(gcf,strcat("pic\", "rezistance_dily_", string(dil), "_odpor_", string(odpor), ".png"));
       close;
       
       axes(hx);
       if min(lx) < max(lx) 
           plot(mdl_x, "Marker", "none")
           xlim([minx-5 maxx+5]);
           %ylim([miny_x-0.2 maxy_x+0.2]);
           ylim(y_x_lim);
       end
       
       if lr_xb>0
           znaminko = "+";
       else
            znaminko = "";
       end
       
       legenda_x = [legenda, "", ...
           strcat('Lineární regrese y=', string(round(lr_xa, 2, "significant")), "x",znaminko, string(round(lr_xb, 2, "significant"))), ...
           "95% konfidenční interval"];
       legend(legenda_x);
       xlabel("Nádoba [L]", "FontSize", x_font_size);
       ylabel("X5 [cm H2O s/L]", "FontSize", y_font_size);
       title (strcat("Reaktance: délka trubice ", string(dil), " cm, Rp ", string(odpor) ), "FontSize", t_font_size);
       saveas(gcf,strcat("pic\", "reaktance_dily_", string(dil), "_odpor_", string(odpor), ".png"));
       close;
    end 
end


%%%%%%%%%%%%%%%%%%%%%%%%5
%
% smycka pro odpor
for i_dily=1:length(dily_arr)
    for i_nadoba=1:length(nadoba_arr)
    

        %i_dily = 3
        %i_nadoba = 1
        
        figure
        hr=axes;
        hold on
        
        figure
        hx=axes;
        hold on
        
        minx = 99999;
        maxx = -99999;
        miny_r = 99999;
        miny_x = 99999;
        maxy_r = -99999;
        maxy_x = -99999;
        lx = [];
        ly_r = [];
        ly_x = [];
        legenda = [];
        
        
        for i_odpor=1:length(odpor_arr)
       
            nadoba = nadoba_arr(i_nadoba);
            dil = dily_arr(i_dily);
            odpor = odpor_arr(i_odpor);
        
            ix = (data.dily == dil) &(data.odpor == odpor) &(data.nadoba == nadoba);
            plot_data = data(ix,:);
            plot(hr, plot_data.odpor, plot_data.R5, 'o', 'LineStyle', 'none',  ...
                 'MarkerEdgeColor',barvy(i_odpor),'MarkerFaceColor',barvy(i_odpor),...
                 'MarkerSize',15);
            
            plot(hx, plot_data.odpor, plot_data.X5, 'o', 'LineStyle', 'none',  ...
                 'MarkerEdgeColor',barvy(i_odpor),'MarkerFaceColor',barvy(i_odpor),...
                'MarkerSize',15);
            

            minx = min(minx, min(plot_data.odpor));
            maxx = max(maxx, max(plot_data.odpor));

            
            miny_r = min(miny_r, min(plot_data.R5));
            maxy_r = max(maxy_r, max(plot_data.R5));
            
            miny_x = min(miny_x, min(plot_data.X5));
            maxy_x = max(maxy_x, max(plot_data.X5));
                       
            % lin reag
            lx =  [lx; plot_data.odpor];
            ly_r = [ly_r; plot_data.R5];
            ly_x = [ly_x; plot_data.X5];
            
            % legend
            legenda = [legenda, strcat("Rp ", string(odpor))];

        end
        
       % dopocitej linreg
       if min(lx) < max(lx)    
           mdl_r = fitlm(lx, ly_r);
           mdl_x = fitlm(lx, ly_x);
           
           lr_ra = mdl_r.Coefficients{'x1','Estimate'};
           lr_rb = mdl_r.Coefficients{'(Intercept)','Estimate'};
           lr_xa = mdl_x.Coefficients{'x1','Estimate'};
           lr_xb = mdl_x.Coefficients{'(Intercept)','Estimate'};
       end
               
       % uprav graf po konci vnitrni smycky
      
       axes(hr);
       if (min(lx) < max(lx)) && ~isempty(minx) && ~isempty(maxx )&& ~isempty(miny_r) && ~isempty(maxy_r)
           plot(mdl_r, "Marker", "none")
           xlim([minx-5 maxx+5]);
           %ylim([miny_r-0.2 maxy_r+0.2]);
           ylim(y_r_lim);
       else
           print ("PROBLEM!");
       end 
       if lr_rb>0
           znaminko = "+";
       else
            znaminko = "";
       end
       
       legenda1_r = [legenda, "", ...
           strcat('Lineární regrese y=', string(round(lr_ra, 2, "significant")), "x",znaminko, string(round(lr_rb, 2, "significant"))), ...
           "95% konfidenční interval"];
       
     
       
       legend(legenda1_r);
       xlabel("Rp", "FontSize", x_font_size);
       ylabel("R5 [cm H2O s/L]", "FontSize", y_font_size);
       title (strcat("Rezistance: délka trubice ",string(dil), " cm, nádoba ", string(nadoba), " L" ), "FontSize", t_font_size);
       saveas(gcf,strcat("pic\", "rezistance_dily_", string(dil), "_nadoba_", string(nadoba), ".png"));
       close;
       
       axes(hx);
       if min(lx) < max(lx) && ~isempty(lx) && ~isempty(minx) && ~isempty(maxx )&& ~isempty(miny_x) && ~isempty(maxy_x)
           plot(mdl_x, "Marker", "none")
           xlim([minx-5 maxx+5]);
           %ylim([miny_x-0.2 maxy_x+0.2]);
           ylim(y_x_lim);
       else
           print ("PROBLEM!");
       end
       if lr_xb>0
           znaminko = "+";
       else
            znaminko = "";
       end
       
       legenda_x = [legenda, "", ...
           strcat('Lineární regrese y=', string(round(lr_xa, 2, "significant")), "x", znaminko, string(round(lr_xb, 2, "significant"))), ...
           "95% konfidenční interval"];
       legend(legenda_x);
       xlabel("Rp", "FontSize", x_font_size);
       ylabel("X5 [cm H2O s/L]", "FontSize", y_font_size);
       title (strcat("Reaktance: délka trubice ",string(dil), " cm, nádoba ", string(nadoba), " L" ), "FontSize", t_font_size);
       saveas(gcf,strcat("pic\", "reaktance_dily_", string(dil), "_nadoba_", string(nadoba), ".png"));
       close;
    end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% smycka pro dily
for i_nadoba=1:length(nadoba_arr)
    for i_odpor=1:length(odpor_arr)
        figure
        hr=axes;
        hold on
        
        figure
        hx=axes;
        hold on
        
        minx = 99999;
        maxx = -99999;
        miny_r = 99999;
        miny_x = 99999;
        maxy_r = -99999;
        maxy_x = -99999;
        lx = [];
        ly_r = [];
        ly_x = [];
        legenda = [];
        
        
        for i_dily=1:length(dily_arr)
            dil = dily_arr(i_dily);
            odpor = odpor_arr(i_odpor);
            nadoba = nadoba_arr(i_nadoba);
            ix = (data.dily == dil) &(data.odpor == odpor) &(data.nadoba == nadoba);
            plot_data = data(ix,:);
            plot(hr, plot_data.dily, plot_data.R5, 'o', 'LineStyle', 'none',  ...
                 'MarkerEdgeColor',barvy(i_dily),'MarkerFaceColor',barvy(i_dily),...
                'MarkerSize',15);
            
            plot(hx, plot_data.dily, plot_data.X5, 'o', 'LineStyle', 'none',  ...
                 'MarkerEdgeColor',barvy(i_dily),'MarkerFaceColor',barvy(i_dily),...
                'MarkerSize',15);
            
            minx = min(minx, min(plot_data.dily));
            maxx = max(maxx, max(plot_data.dily));
            
            miny_r = min(miny_r, min(plot_data.R5));
            maxy_r = max(maxy_r, max(plot_data.R5));
            
            miny_x = min(miny_x, min(plot_data.X5));
            maxy_x = max(maxy_x, max(plot_data.X5));
                       
            % lin reag
            lx =  [lx; plot_data.dily];
            ly_r = [ly_r; plot_data.R5];
            ly_x = [ly_x; plot_data.X5];
            
            % legend
            legenda = [legenda, strcat("Délka trubice ", string(dil), " cm")];

        end
        
       % dopocitej linreg
       if min(lx) < max(lx)    
           mdl_r = fitlm(lx, ly_r);
           mdl_x = fitlm(lx, ly_x);
           
           lr_ra = mdl_r.Coefficients{'x1','Estimate'};
           lr_rb = mdl_r.Coefficients{'(Intercept)','Estimate'};
           lr_xa = mdl_x.Coefficients{'x1','Estimate'};
           lr_xb = mdl_x.Coefficients{'(Intercept)','Estimate'};
       end
               
       % uprav graf po konci vnitrni smycky
      
       axes(hr);
       if min(lx) < max(lx)  && ~isempty(lx) && ~isempty(minx) && ~isempty(maxx )&& ~isempty(miny_r) && ~isempty(maxy_r)
           plot(mdl_r, "Marker", "none")
           xlim([minx-5 maxx+5]);
           %ylim([miny_r-0.2 maxy_r+0.2]);
           ylim(y_r_lim);
       else
           print ("PROBLEM! r - nadoba");
       end 
       if lr_rb>0
           znaminko = "+";
       else
            znaminko = "";
       end
       
       legenda1_r = [legenda, "", ...
           strcat('Lineární regrese y=', string(round(lr_ra, 2, "significant")), "x", znaminko, string(round(lr_rb, 2, "significant"))), ...
           "95% konfidenční interval"];
       
     
       
       legend(legenda1_r);
       xlabel("Délka trubice [cm]", "FontSize", x_font_size);
       ylabel("R5 [cm H2O s/L]", "FontSize", y_font_size);
       title (strcat("Rezistance: Rp ",string(odpor), ", nádoba ", string(nadoba), " L" ), "FontSize", t_font_size);
       saveas(gcf,strcat("pic\", "rezistance_odpor_", string(odpor), "_nadoba_", string(nadoba), ".png"));
       close;
       
       axes(hx);
       if min(lx) < max(lx) && ~isempty(lx) && ~isempty(minx) && ~isempty(maxx )&& ~isempty(miny_x) && ~isempty(maxy_x)
           plot(mdl_x, "Marker", "none")
           xlim([minx-5 maxx+5]);
           %ylim([miny_x-0.2 maxy_x+0.2]);
           ylim(y_x_lim);
       else
           print ("PROBLEM! x - nadoba");
       end
       if lr_xb>0
           znaminko = "+";
       else
            znaminko = "";
       end
       legenda_x = [legenda, "", ...
           strcat('Lineární regrese y=', string(round(lr_xa, 2, "significant")), "x", znaminko, string(round(lr_xb, 2, "significant"))), ...
           "95% konfidenční interval"];
       legend(legenda_x);
      xlabel("Délka trubice [cm]", "FontSize", x_font_size);
       ylabel("X5 [cm H2O s/L]", "FontSize", y_font_size);
       title (strcat("Reaktance: Rp ",string(odpor), ", nádoba ", string(nadoba), " L" ), "FontSize", t_font_size);
       saveas(gcf,strcat("pic\", "reaktance_odpor_", string(odpor), "_nadoba_", string(nadoba), ".png"));
       close;
    end 
end


