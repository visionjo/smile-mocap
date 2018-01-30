function F = images2frames(images, do_resize)
%IMAGES2FRAMES Converts imagestack into arrays of frames (structure)
%   Passed in a stack of images, each image is converted to struct frame
%   and concatenated in same array.
% 
%   The array of frame objects is returned.
% Written By: Joseph Robinson
if nargin < 2, do_resize = true;   end
nimages = length(images);

F=[];

if do_resize
    for z = 1:nimages
        F = [F; im2frame(imresize3(images{z},[560,420,3]))];
    end
else
    for z = 1:nimages
        F = [F; im2frame(images{z})];
    end
end
