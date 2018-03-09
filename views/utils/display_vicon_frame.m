function display_vicon_frame(Hds)
% Hds.v_skeleton.scatter_plot2(Hds);%,cut_sec);
colors=[];
colors(1:3)='k';
colors(4:9)='y';
colors(10:16)='r';
colors(17:23)='g';
colors(24:27)='y';
colors(28:38)='b';

parts = Hds.v_skeleton.get_parts_str();
cla(Hds.axis_vicon)
axes(Hds.axis_vicon);

hold on;
grid on;
axis([-1000,1500,-500,1500,0,2000]);

for r = 1:Hds.v_skeleton.nparts
    % for each marker
    
    coords = Hds.v_skeleton.(parts{r})(Hds.v_current_index,:);
    scatter3(coords(1), coords(2), coords(3),char(colors(r)),'filled');
end
view(135,30)
hold off;
