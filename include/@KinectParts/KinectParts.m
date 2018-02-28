classdef KinectParts
    %KinectParts contain information of a human skeleton as seen by a
    %Kinect Sensor-- 'nodes' is a cell array containing names and indices
    %of each marker; 'edges' is a cell array containing indices of adjacent
    %nodes (i.e., connected nodes)
    
    properties
        nodes
        edges
    end
    
    methods
        function obj = KinectParts()
            %nodes Construct an instance of this class
            %   Detailed explanation goes here
            
            obj.edges = {[4 3]; ...  % Neck
                [3 21]; ... % Head
                [21 2]; ... % Right Leg
                [2 1];...
                [21 9];...
                [9 10];  ... % Hip
                [10 11];...
                [11 12]; ... % Left Leg
                [12 24];...
                [12 25];...
                [21 5];  ... % Spine
                [5 6];...
                [6 7];   ... % Left Hand
                [7 8];...
                [8 22];...
                [8 23];...
                [1 17];...
                [17 18];...
                [18 19]; ...  % Right Hand
                [19 20];...
                [1 13];...
                [13 14];...
                [14 15];...
                [15 16];...
                };
            
            obj = obj.set_nodes();
            
        end
        
        function obj = set_nodes(obj)
            node_carray.name{1} = 'root';
            node_carray.number{1} = 9:12;
            
            node_carray.name{2} = 'lhip';
            node_carray.number{2} = 9:11;
            
            node_carray.name{3} = 'lknee';
            node_carray.number{3} = 21;
            
            node_carray.name{4} = 'lankle';
            node_carray.number{4} = 23;
            
            node_carray.name{5} = 'ltoe';
            node_carray.number{5} = 25:26;
            
            node_carray.name{6} = 'rhip';
            node_carray.number{6} = 10:12;
            
            node_carray.name{7} = 'rknee';
            node_carray.number{7} = 22;
            
            node_carray.name{8} = 'rankle';
            node_carray.number{8} = 24;
            
            node_carray.name{9} = 'rtoe';
            node_carray.number{9} = 27:28;
            
            node_carray.name{10} = 'midtorso';
            node_carray.number{10} = [7:8 7:12];
            
            node_carray.name{11} = 'neck';
            node_carray.number{11} = 5:6;
            
            node_carray.name{12} = 'head';
            node_carray.number{12} = 1:4;
            
            node_carray.name{13} = 'lshoulder';
            node_carray.number{13} = 5;
            
            node_carray.name{14} = 'lelbow';
            node_carray.number{14} = 13;
            
            node_carray.name{15} = 'lwrist';
            node_carray.number{15} = 15:16;
            
            node_carray.name{16} = 'lfinger';
            node_carray.number{16} = 19;
            
            node_carray.name{17} = 'rshoulder';
            node_carray.number{17} = 6;
            
            node_carray.name{18} = 'relbow';
            node_carray.number{18} = 14;
            
            node_carray.name{19} = 'rwrist';
            node_carray.number{19} = 17:18;
            
            node_carray.name{20} = 'lfinger';
            node_carray.number{20} = 20;
            
            obj.nodes = node_carray;
        end
    end
end

