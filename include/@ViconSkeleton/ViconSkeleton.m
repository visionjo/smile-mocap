classdef ViconSkeleton
    %VICONSKELETON Summary of this class goes here
    %   Detailed explanation goes here
    
  
    properties
        RFHD    % right front head
        LBHD    % left back head
        RBHD    % right back head
        C7      % back center neck
        T10     % mid spine
        CLAV    % front center below neck
        STRN    % front center middle ribs
        RBAK    % back right shoulder blade
        
        LSHO    % left shoulder
        LUPA    % left upper arm
        LELB    % left elbow
        LFRM    % left forearm
        LWRA    % left wristA
        LWRB    % left wristB
        LFIN    % left finger
        
        
        RSHO    % right shoulder
        RUPA    % right upper arm
        RELB    % right elbow
        RFRM    % right forearm
        RWRA    % right wristA
        RWRB    % right wristB
        RFIN    % right finger
        LASI    % front left pelvis
        RASI    % front right pelvis
        LPSI    % back left pelvis (but)
        RPSI    % back right pelvis (but)
        LTHI    % left thigh
        LKNE    % left knee
        LTIB    % left tibia/shin
        LANK    % left ankle
        LHEE    % left heel
        LTOE    % left toe
        RTHI    % right thigh
        RKNE    % right knee
        RTIB    % right tibia/shin
        RANK    % right ankle
        RHEE    % right heel
        RTOE    % right toe
        
        nparts;
        part_strings;
        markers;        % cell array of names and indices TODO
        nframes;
    end
    
    methods
        function obj = ViconSkeleton(fpath)
            %VICONSKELETON Construct an instance of this class
            %   Detailed explanation goes here
            T = readtable(fpath);
            cell_data = table2cell(T);
            
            parts = cellfun(@(x) x(1:end-2), T.Properties.VariableNames,'uni',false);
            uparts = fieldnames(obj);
            
            
            obj.nparts = length(uparts);
            obj.nframes = size(obj.RTOE,1);
            for x = 1:obj.nparts
                part = uparts{x};
                ids = strcmp(part, parts);
                coords = cell2mat(cell_data(:,ids));
                obj.(part) = coords;
            end
            obj = obj.set_nframes();
            obj = obj.set_nparts();
            %             cellfun(@(x) x(1:end-2), T.Properties.VariableNames,'uni',false);
        end
        function cl_out = findAttrValue(obj,attrName,varargin)
            if ischar(obj)
                mc = meta.class.fromName(obj);
            elseif isobject(obj)
                mc = metaclass(obj);
            end
            ii = 0; numb_props = length(mc.PropertyList);
            cl_array = cell(1,numb_props);
            for  c = 1:numb_props
                mp = mc.PropertyList(c);
                if isempty (findprop(mp,attrName))
                    error('Not a valid attribute name')
                end
                attrValue = mp.(attrName);
                if attrValue
                    if islogical(attrValue) || strcmp(varargin{1},attrValue)
                        ii = ii + 1;
                        cl_array(ii) = {mp.Name};
                    end
                end
            end
            cl_out = cl_array(1:ii);
        end
        function print(obj, frame_id)
            if nargin < 2, frame_id = 1;    end
            fields = fieldnames(obj);
            obj.nfields = length(fields);
            str_disp = cell(1, nfields);
            for x = 1:obj.nfields
                att = fields{x};
                vals = obj.(att);
                str_disp{x} = sprintf('%s: (%d, %d, %d)\n', att, ...
                    vals(frame_id, 1), vals(frame_id, 2), vals(frame_id, 3));
            end
            fprintf([str_disp{:} '\n\n']);
            %             sprintf(
        end
        
        function show(obj)
            fields = fieldnames(obj);
            obj.nparts = length(fields);
            % Overlay the skeleton on this RGB frame.
            for i = 1:obj.nparts
                for body = 1:nBodies
                    X1 = [colorJointIndices(SkeletonConnectionMap(i,1),1,body) colorJointIndices(SkeletonConnectionMap(i,2),1,body)];
                    Y1 = [colorJointIndices(SkeletonConnectionMap(i,1),2,body) colorJointIndices(SkeletonConnectionMap(i,2),2,body)];
                    line(X1,Y1, 'LineWidth', 1.5, 'LineStyle', '-', 'Marker', '+', 'Color', colors(body));
                    %         imgOut = insertShape(imgOut,'Line',[X1(1) X1(2) Y1(1) Y1(2)],'LineWidth',5,'Color',colors(body));
                    hold on;
                end
                hold off;
            end
        end
        
        function obj = set_nparts(obj)
            sensor_names = fieldnames(obj);
            
            % determine field names pointing to parts-- part references are
            % all caps
            parts_ids=cell2mat(cellfun(@(str) any(isstrprop(str,'upper')...
                ), sensor_names, 'uni', false));
            
            sensor_names = sensor_names(parts_ids);
            obj.nparts = length(sensor_names);
            obj.part_strings =  sensor_names;
            
        end
        function obj = set_nframes(obj)
            obj.nframes = size(obj.C7, 1);
        end
        
        function nnans = count_nans(obj, part)
            % count the number of nans found in a matrix. Note that matrix
            % is assumed to be made up of samples (i.e., one unique feature
            % row, with columns seperating feature dimensions).
            
            miss_matrix = isnan(obj.(part));
        end
        function [obj, count_incomplete_parts]  = ismissing(obj)
            %              ismissing(obj.RASI)
            obj = obj.set_nparts();
            obj = obj.set_nframes();
            
            count_incomplete_parts = zeros(1, obj.nparts);
            for x = 1:obj.nparts
                miss_matrix = isnan(obj.(obj.part_strings{x}));
                % sum across the rows
                % i.e., this will be 3 for samples x, y, and z = nan, 1 if a
                % single channel is nan, 0 if none are nan (i.e., coords for
                % ith sample were properly/ completely captured).
                sample_counts = sum(miss_matrix,2);
                %
                count_incomplete_parts(x) = sum(sample_counts > 0);
            end
            
            
        end
        
        function parts = get_parts_str(obj)
            % returns cell array of members of instance of ViconSkeleton
            parts = obj.part_strings;
        end
        
        function fhandle = scatter_plot(obj, frame_step)
            %  plots skeleton as scatter plot in euclean space 
            % 'frame_step' is optional argument allowing for the number of
            % frames skipped between axis views to be altered (default 100)
            
            if nargin < 2
                frame_step = 100;
            end
            parts = obj.get_parts_str();            
            fhandle = figure();
            
            for x = 1:frame_step:obj.nframes
                % for each frame (i.e., 100 fps captured by vicon)
                hold on;
                for r = 1:obj.nparts
                    % for each marker 
                    fprintf(1, 'adding part %s to scatter plot\n', parts{r});
                    
                    coords = obj.(parts{r})(x,:);
                    scatter3(coords(1), coords(2), coords(3));
                end
                view(45,45)
                pause(1)
                clf(fhandle)
            end
        end
    end
end

