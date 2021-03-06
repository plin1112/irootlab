%> @brief Draws plot from a sovalues object
classdef vis_sovalues_drawsubplot < vis
    properties
        %> ={[Inf, 0, 0], [1, 2]}
        %> @sa sovalues.m
        dimspec = {[Inf, 0, 0], [1, 2]};
        
        %> =rates
        valuesfieldname = 'rates';
        
        %> =[]
        ylimits;
        
        %> =[]
        xticks;
        
        %> =[]
        xticklabels;

        %>
        flag_star = 1;
        
        %>
        flag_hachure = 0;
    end;
    
    
    methods
        %> Constructor
        function o = vis_sovalues_drawsubplot()
            o.classtitle = 'Subplots';
            o.inputclass = 'sovalues';
        end;
    end;
    

    methods(Access=protected)
        function out = do_use(o, r)
            out = [];

            p = plotter12();
            p.flag_hachure = o.flag_hachure;
            [p.values, p.ax] = sovalues.get_vv_aa(r.values, r.ax, o.dimspec);

            star_ii = [];
            ch = r.chooser;
            if o.flag_star && ~isempty(ch)
                %> Finds the "best" (x's) to put stars on
                for i = 1:size(p.values, 2);
                    temp = ch.use(p.values(:, i)); %#ok<*AGROW>
                    star_ii(i) = temp{1};
                end;
            end;
            
            p.draw_subplots(o.valuesfieldname, o.ylimits, o.xticks, o.xticklabels, star_ii);
        end;
    end;
end