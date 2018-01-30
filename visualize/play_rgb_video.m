function play_rgb_video(images)
%PLAY_RGB_VIDEO Display stack of images as video
% It is assumed image-stack is a cell array (i.e., frame per element).
F = images2frames(images);
figure()
movie(F)