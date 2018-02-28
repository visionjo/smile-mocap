classdef KinectSkeleton
    %KINECT_SKELETON class contains Kinect data used to represent human
    %joints (i.e., skeleton)
    % initial the skeleton index
    
    properties
        %         SkeletonConnectionMap
        Map
        nframes
        meta_record
        colors
        is_body_tracked
        ids_tracked_bodies
        ids_color_joints
    end
    
    methods
        function obj = KinectSkeleton(meta_record)
            %KINECT_SKELETON Construct an instance of this class
            %   Detailed explanation goes here
            
            obj.nframes = length(meta_record);
            
            obj.meta_record = meta_record;
            obj.colors = ['r';'g';'b';'c';'y';'m'];
            obj.is_body_tracked = cell2mat(cellfun(@(x) any(x.IsBodyTracked), meta_record, 'uni',false));
            obj.ids_tracked_bodies = cell2mat(cellfun(@(x) find(x.IsBodyTracked), meta_record, 'uni',false));
            
            obj.ids_color_joints = cell(1, obj.nframes);
            for x = 1:obj.nframes
                obj.ids_color_joints{x} = meta_record{x}.ColorJointIndices(:, :, obj.ids_tracked_bodies(x));
            end
            obj.Map = KinectParts();
        end
        
    end
end

