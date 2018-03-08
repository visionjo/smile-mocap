function [dsamps, do_display] = get_current_sample_string(Hds)
%GET_CURRENT_SAMPLE_STRING is simple function that gets and returns string
%of current sample being displayed. The assumption is that current sample
%is properly displayed according to the drop-down menu in GUI.

ids = Hds.menu_samples.Value;
samps = Hds.menu_samples.String;

if (length(samps) == 7) && strcmp(samps, 'Samples')
    dsamps = {};
    do_display = 0;
    return;
end
do_display = 1;
dsamps = samps{ids};

