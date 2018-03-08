classdef Video
    %% Container class video object to label via action_labeler
    %
    %   AUTHOR    : J. Robinson
    %   DATE      : 3-March-2018
    %   Revision  : 1.0
    %   DEVELOPED : MATLAB R2017a
    %   FILENAME  : Video.m
    %
    
    properties
        do_skullaton;
        fpath;
        frames;
        nframes;
        current_index;     % index of current frame being displayed
        display;
        unsaved;           % true if labels modified but not saved
    end
    
    methods (Access = public)
        
        
        
        function this = Video(images, fpath)
            % Constructor
            
            this.frames = images;
            this.nframes = length(this.frames);
            this.current_index = 1;
            %             this.Labels = [];
            
            if this.nframes > 0
                % only display if images exist
                this.display = true;
            else
                this.display = false;
            end
            
            this.fpath = fpath;
            this.unsaved = false;
            
            this.do_skullaton = false;
        end
    end
end

