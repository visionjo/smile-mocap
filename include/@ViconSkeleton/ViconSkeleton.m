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
    end
    
    methods
        function obj = ViconSkeleton(fpath)
            %VICONSKELETON Construct an instance of this class
            %   Detailed explanation goes here
            T = readtable(fpath);
            cell_data = table2cell(T);
            
            parts = cellfun(@(x) x(1:end-2), T.Properties.VariableNames,'uni',false);
            uparts = fieldnames(obj);
            
            
            nparts = length(uparts);
            
            for x = 1:nparts
                part = uparts{x};
                ids = strcmp(part, parts);
                coords = cell2mat(cell_data(:,ids));
                obj.(part) = coords;
            end
            
            %             cellfun(@(x) x(1:end-2), T.Properties.VariableNames,'uni',false);
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end
