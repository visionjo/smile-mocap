function varargout = SkeletonAlignmentViewer(varargin)
% SkeletonAlignmentViewer MATLAB code for SkeletonAlignmentViewer.fig
%      SkeletonAlignmentViewer, by itself, creates a new SkeletonAlignmentViewer or raises the existing
%      singleton*.
%
%      H = SkeletonAlignmentViewer returns the handle to a new SkeletonAlignmentViewer or the handle to
%      the existing singleton*.
%
%      SkeletonAlignmentViewer('CALLBACK',hObject,eventData,Hds,...) calls the local
%      function named CALLBACK in SkeletonAlignmentViewer.M with the given input arguments.
%
%      SkeletonAlignmentViewer('Property','Value',...) creates a new SkeletonAlignmentViewer or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SkeletonAlignmentViewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SkeletonAlignmentViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SkeletonAlignmentViewer

% Last Modified by GUIDE v2.5 07-Mar-2018 22:45:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SkeletonAlignmentViewer_OpeningFcn, ...
    'gui_OutputFcn',  @SkeletonAlignmentViewer_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);

% 'Metadata','meta_record','Times','time_record','Images','image_record','Depth','deep_record'

% Hds = load_video(hObject, Hds);
% set_display (Hds);
% set_buttons (Hds);

% if isempty (cur_frame), return;  end
% axis(Hds.axis_preview);
% display_frame (Hds);


opt_args = {'datadir', 'filename', 'outfile'};
parse_opts = false;
if nargin
    
    if ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
        if length(varargin{2}) > 1
            parse_opts = true;
        end
    end
    %     if length(varargin{1}) == 2 && strcmp(varargin{1}{1}, '.mat')
    
    
    
    if parse_opts || (length(varargin{1}) > 1 && any(~strcmp(varargin{1}, 'lb_actions_CreateFcn')))
        mapObj = containers.Map(varargin{1}(1:2:end),varargin{1}(2:2:end),'UniformValues',false);
        keySet = mapObj.keys;
        setValues = mapObj.values;
        video_data = [];
        datadir = [];
        filename = [];
        outfile = [];
        %         images = [];
        for x = 1:length(keySet)
            ids = find(strcmp(keySet{x}, opt_args));
            if ids
                switch keySet{x}
                    case 'datadir'
                        datadir = setValues{x};
                    case 'filename'
                        filename = setValues{x};
                    case 'outfile'
                        outfile = setValues{x};
                    otherwise
                        fprintf(1, 'SkeletonAlignmentViewer(): Unknown key %s', keySet{x});
                end
            end
        end
        if ~isempty(filename) && ~isempty(datadir)
            fpath = [datadir filename '.mat'];
            load(fpath, 'image_record')
            video_data = Video(image_record, fpath);% times, metadata, depth);
        end
        %         Hds.datadir = datadir;
        %         Hds.filename = filename;
        %         Hds.outfile = outfile;
        %         Hds.video_data = video_data;
    end
    
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SkeletonAlignmentViewer is made visible.
function SkeletonAlignmentViewer_OpeningFcn(hObject, eventdata, Hds, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
% varargin   command line arguments to SkeletonAlignmentViewer (see VARARGIN)

% Determine whether ExemplarFinder is already running
hdlAllFigs=findall(0,'Type','figure');
sFigureNames=get(hdlAllFigs,'Name');
sVisible=get(hdlAllFigs,'Visible');
if any(strcmp(sFigureNames,'SkeletonAlignmentViewer')&strcmp(sVisible,'on'))
    fprintf('WARNING:  SkeletonAlignmentViewer is already running.\n\n');
    
    % Verify that the user wishes to open another session
    sInput=questdlg('Would you like to start a new session?', ...
        'WARNING: Program running','Yes','No','No');
    if isempty(sInput) || strcmpi(sInput,'no')
        %         Quit_Program();
        return;
    else
        quit_program();
    end
    
end

tmp = fileparts(which('SkeletonAlignmentViewer'));

Hds.rootdir = [fileparts(tmp(1:end-3)) filesep];

axes(Hds.logo_smile);
imshow([Hds.rootdir fullfile('docs', 'logo-smile.png')]);
axes(Hds.logo_nu);
imshow([Hds.rootdir fullfile('docs', 'nu_logo.png')]);

axes(Hds.axis_preview);

% Choose default command line output for SkeletonAlignmentViewer
Hds.output = hObject;
% imshow('logo-smile.png');

opt_args = {'datadir', 'filename', 'outfile'};
opts_ids = length(varargin);
if opts_ids
    
    if ischar(varargin{1}) &&  opts_ids == 1
        gui_State.gui_Callback = str2func(varargin{1});
        Hds.video_data = {};
        
    else
        if opts_ids == 1
            opts = varargin{1};
        else
            opts = varargin{2};
        end
        
        mapObj = containers.Map(opts(1:2:end),opts(2:2:end),'UniformValues',false);
        keySet = mapObj.keys;
        setValues = mapObj.values;
        
        video_data = [];
        datadir = [];
        filename = [];
        outfile = [];
        %         images = [];
        for x = 1:length(keySet)
            ids = find(strcmp(keySet{x}, opt_args));
            if ids
                switch keySet{x}
                    case 'datadir'
                        datadir = setValues{x};
                    case 'filename'
                        filename = setValues{x};
                    case 'outfile'
                        outfile = setValues{x};
                    otherwise
                        fprintf(1, 'SkeletonAlignmentViewer(): Unknown key %s', keySet{x});
                end
            end
        end
        if ~isempty(filename) && ~isempty(datadir)
            fpath = [datadir filename '.mat'];
            load(fpath, 'image_record')
            video_data = Video(image_record, fpath);% times, metadata, depth);
            video_data.fpath = fpath;
            
            video_data.current_index = 1;
            
            Hds.video_data = video_data;
            
        end
        
        % Update Hds structure
        if video_data.display
            display_frame (Hds);
            set_buttons(Hds);
            set_display (Hds)
        end
        %         Hds.Palette  = ColorPalette(video_data.nframes);
    end
else
    
    Hds.video_data = {};
    
    %     Hds.Palette  = ColorPalette(10000);
end
userhome = [utils.getuserhome() filesep];

outdir = [fullfile(userhome, 'Dropbox'), filesep];

Hds.outcsv = fullfile(userhome, 'Dropbox', 'alignments.csv');

Hds.outdir = outdir;

set(Hds.tf_outdir, 'String', Hds.outcsv)

Hds.outdir = outdir;
% Hds.outbin = [outdir 'tmp.csv'];

guidata(hObject, Hds);



% --- Outputs from this function are returned to the command line.
function varargout = SkeletonAlignmentViewer_OutputFcn(hObject, eventdata, Hds)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)

% Get default command line output from Hds structure
varargout{1} = Hds.output;

% --- Executes on button press in pb_load.
function pb_load_Callback(hObject, ~, Hds)       %#ok<DEFNU>
% open M file; preview set to index 1

Hds = load_video(hObject, Hds);
set_display (Hds);
set_buttons (Hds);

% if ~isempty(Hds.video_data)
%     Hds.Palette  = ColorPalette(Hds.video_data.nframes);
% else
%     Hds.Palette  = ColorPalette(10000);
% end

% if isempty (cur_frame), return;  end
% axis(Hds.axis_preview);
display_frame (Hds);

%% Scroll Pad Panel
% --- Executes on button press in pb_prev, ay, pb_next, pb_last, pb_first
function pb_scroll_Callback(hObject, ~, Hds) %#ok<DEFNU>


culprit_varname = get(hObject,'Tag');   % component event triggered upon

% --- Executes next button press.
if strcmp(culprit_varname, 'pb_next')
    
    video_data = Hds.video_data;  % localize corpus vals
    
    % increment index to point at next exemplar in corpus
    Hds.video_data.current_index = video_data.current_index + 1;
    
    % check index stays within bounds, i.e. less than equal to # exemplars
    if Hds.video_data.current_index > Hds.video_data.nframes
        % logic governing this source should prevent this, but to ensure ...
        Hds.video_data.current_index = Hds.video_data.nframes;
    end
    
    % assign next exemplar in corpus
    %     next_frame = video_data.frames{Hds.video_data.current_index};
    
    % update GUI's axis with plot of next exemplar
    display_frame(Hds); % func call to display, i.e., plot
    
    set_display(Hds);
    
    
    % --- Executes previous button press.
elseif strcmp(culprit_varname, 'pb_prev')
    
    video_data = Hds.video_data;  % localize corpus vals
    
    if video_data.current_index == 1
        % check index stays within bounds, i.e. less than equal to # exemplars
        % if not, re-set GUI component states
        
        %         set_gui_components(Hds)
        
        set_buttons (Hds)
        return;
    else
        % decrease index to point at next exemplar in corpus
        Hds.video_data.current_index = video_data.current_index - 1;
    end
    % assign next exemplar in corpus
    %     previous_frame = video_data.frames{Hds.video_data.current_index};
    
    % update GUI's axis with plot of next exemplar
    display_frame(Hds); % func call to display, i.e., plot
    
    
    set_display(Hds);
    
    % --- Executes << button press.
elseif strcmp(culprit_varname, 'pb_first')
    video_data = Hds.video_data;  % localize corpus vals
    
    % set index to 1, i.e., first exemplar
    Hds.video_data.current_index = 1;
    
    % assign 1st exemplar in corpus
    %     first_frame = video_data.frames{Hds.video_data.current_index};
    
    % update GUI's axis with plot of 1st exemplar
    display_frame(Hds); % func call to display, i.e., plot
    
    set_display(Hds);
    % --- Executes >> button press.
elseif strcmp(culprit_varname, 'pb_last')
    
    video_data = Hds.video_data;  % localize corpus vals
    
    % set index to 1, i.e., first exemplar
    Hds.video_data.current_index = video_data.nframes;
    
    % assign 1st exemplar in corpus
    %     last_exemplar = video_data.frames{Hds.video_data.current_index};
    
    % update GUI's axis with plot of 1st exemplar
    display_frame(Hds); % func call to display, i.e., plot
    
    
    set_display(Hds);
    % --- Executes add button press.
end
Hds.slidebar.Value = Hds.video_data.current_index/Hds.video_data.nframes;
guidata(hObject, Hds);              % Update Hds structure
set_buttons(Hds);
set_display (Hds)
% set_gui_components(Hds);            % set GUI components [state] and labels



% --- Executes on when icon from toolbar triggers an event.
% Determines the icon [culprit] that triggered event by use 'Tag' property.
% Then Hds accordingly.
function mnu_Callback(hObject, ~, Hds)   %#ok<DEFNU>
% hObject    handle to action icon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)

var_name = get (hObject,'Tag');
if strcmp('icon_',var_name(1:5))
    culprit = 'load';
else
    culprit = lower( get(hObject,'Label') );
end

switch culprit
    % determine component that triggered event
    case 'new'
        % Start a new corpus (TBD, likely aim to allow corpus merging)
        fprintf (1, '\nComing Soon!!\n');
        
    case 'load'
        % open M file; preview set to index 1
        cur_exemplar = load_video(hObject, Hds);
        
        if isempty (cur_exemplar), return;  end
        display_frame (Hds);
        %         start_session();
    case 'save'
        Hds = save_corpus( hObject, Hds );
        set_buttons (Hds);
        
    case 'save as...'
        fname = save_corpus_as(Hds.video_data.corpus);
        if ~isempty (fname)
            Hds.video_data.fpath = fname;
            Hds.video_data.unsaved = false;
            guidata(hObject, Hds);              % Update Hds structure
            set_buttons(Hds);
        end
        
    case 'save copy as...'
        save_corpus_as(Hds.video_data.corpus);
        
    case 'exit'
        if Hds.video_data.unsaved
            do_save = quit_program();
            if do_save, save_corpus( hObject, Hds );    end
            
        end
        
        delete(gcf);
        
    case 'about'
        figAbout();
end




% --- Executes on button press in pb_save.
function save_Callback(hObject, ~, Hds) %#ok<DEFNU>
% hObject    handle to pb_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
Hds = save_corpus( hObject, Hds );
set_buttons (Hds);

% --------------------------------------------------------------------
function mnu_help_child_Callback(~,~,~) %#ok<DEFNU>
% hObject    handle to mnu_help_child (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
open ('README.txt');


% --- Executes on button press in pb_new.
function pb_new_Callback(hObject, ~, Hds) %#ok<DEFNU>
% hObject    handle to pb_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
% Add exemplars from shotfile or load corpus from MAT
dirname = uigetdir('~','Select Data Directory');
% in=[pname temp];
% guidata(hObject, Hds);              % Update Hds structure
new_video( hObject, Hds, dirname );




% --- Executes on slider movement.
function slidebar_Callback(hObject, eventdata, Hds)
% hObject    handle to slidebar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if isempty(Hds.video_data), return; end
pos = hObject.Value;
frame_id = round(Hds.video_data.nframes*pos);
if frame_id == 0
    Hds.video_data.current_index = 1;
else
    
    Hds.video_data.current_index = round(Hds.video_data.nframes*pos);
end

display_frame(Hds);
% set_buttons(Hds);
set_display (Hds);
guidata(hObject, Hds);              % Update Hds structure



% --------------------------------------------------------------------
function icon_load_ClickedCallback(hObject, eventdata, Hds)
% hObject    handle to icon_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
Hds = load_video(hObject, Hds);

% if ~isempty(Hds.video_data)
%     Hds.Palette  = ColorPalette(Hds.video_data.nframes);
% else
%     Hds.Palette  = ColorPalette(10000);
% end

axes(Hds.axis_color);
% imshow(Hds.Palette.panel)
axes(Hds.axis_preview)

set(Hds.lb_actions,'Value', 1);
set(Hds.slidebar,'Value',0);

set_display (Hds);
set_buttons (Hds);

fname = strrep(strrep(strrep(Hds.video_data.fpath, ...
    fileparts(Hds.video_data.fpath),''),filesep,''), '.mat', '');

Hds.outdir = Hds.tf_outdir.String;
if ~strcmp(Hds.outdir(end), '/')
    Hds.outdir = [Hds.outdir '/'];
end
set(Hds.tf_outdir, 'String', Hds.outdir);
% outbin = strcat(Hds.outdir, fname, '.csv');
% Hds.outbin = outbin;
% Hds.outdir = [fileparts(outbin) filesep];
% set(Hds.tf_outdir, 'String', Hds.outdir)


% if ~exist(Hds.outdir, 'dir')
%     mkdir(Hds.outdir);
% end

% if isempty (cur_frame), return;  end
% axis(Hds.axis_preview);
display_frame (Hds);
guidata(hObject, Hds);              % Update Hds structure




% --- Executes on button press in b_start.
function b_start_Callback(hObject, eventdata, Hds)
% hObject    handle to b_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
action_types = get(Hds.lb_actions,'String');     % get selected item
ids_selected = get(Hds.lb_actions,'Value');

Hds.video_data.Labels = [Hds.video_data.Labels;...
    Label(action_types{ids_selected}, Hds.video_data.current_index)];


pos = Hds.slidebar.Value;
frame_id = round(Hds.video_data.nframes*pos);
if frame_id == 0
    Hds.video_data.current_index = 1;
else
    
    Hds.video_data.current_index = round(Hds.video_data.nframes*pos);
end
cLabel.start_frame = Hds.video_data.current_index;
cLabel.end_frame = Hds.video_data.current_index + 1;

% Hds.Palette = Hds.Palette.add(ids_selected, cLabel);

% Hds.Palette = Hds.Palette.add(ids_selected, );
% Hds.video_data.color_palette(:,Hds.video_data.current_index,:) ...
%     = repmat(Hds.video_data.colors{ids_selected},[150, 1]);

axes(Hds.axis_color);
imshow(Hds.Palette.panel)
axes(Hds.axis_preview)

% set(Hds.b_start, 'Enable','off');
set(Hds.b_end, 'Enable','on');
guidata(hObject, Hds);              % Update Hds structure


% --- Executes on button press in b_end.
function b_end_Callback(hObject, eventdata, Hds)
% hObject    handle to b_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
action_types = get(Hds.lb_actions,'String');     % get selected item
ids_selected = get(Hds.lb_actions,'Value');

Hds.video_data.Labels(end) = Hds.video_data.Labels(end).set_end(Hds.video_data.current_index);
cLabel = Hds.video_data.Labels(end);

% Hds.Palette = Hds.Palette.add(ids_selected, cLabel);
set(Hds.b_start, 'Enable','on');
set(Hds.b_end, 'Enable','off');

% dlmwrite('test.csv',N,'delimiter',',','-append');
contents = {};
if exist(Hds.outbin, 'file')
    contents =csv2cell(Hds.outbin,'fromfile');
end
% append action label
contents = [contents; {cLabel.action_type, cLabel.start_frame, cLabel.end_frame}];
cell2csv(Hds.outbin,contents);
% nentries = size(contents, 1);

% for x = 1:nentries
%     cell2csv(Hds.outbin,{cLabel.action_type, cLabel.start_frame, cLabel.end_frame});
% end
axes(Hds.axis_color);
% imshow(Hds.Palette.panel)
axes(Hds.axis_preview)

items = get(Hds.lb_actions,'String');
nitems = length(find(cellfun(@isempty,items)==0));

% if ids_selected + 1
if ids_selected + 1 > nitems
    set(Hds.lb_actions,'Value', nitems);
else
    set(Hds.lb_actions,'Value', ids_selected + 1);
end
guidata(hObject, Hds);              % Update Hds structure


% --- Executes on button press in b_remove.
function b_remove_Callback(hObject, eventdata, Hds)
% hObject    handle to b_remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)

if ~exist(Hds.outbin, 'file')
    warndlg('No label file found','!! Warning !!')
end
actions = Hds.lb_actions.String;
ids = Hds.lb_actions.Value;

% Construct a questdlg with three options
choice = questdlg(['Are you sure you want to remove "' actions{ids} '" label(s)?'], ...
    'WARNING','Yes','No');
% Handle response

if ~isempty(choice) && strcmp(choice, 'Yes')
    disp(['Removing ' choice]);
    Hds = update_action_labels(Hds);
end
guidata(hObject, Hds);


% --- Executes on button press in tb_play.
function tb_play_Callback(hObject, eventdata, Hds) %#ok<DEFNU>
if isempty(Hds.video_data), return; end
while  eventdata.Source.Value
    video_data = Hds.video_data;  % localize corpus vals
    
    % increment index to point at next exemplar in corpus
    Hds.video_data.current_index = video_data.current_index + 1;
    
    
    pos = Hds.video_data.current_index/Hds.video_data.nframes;
    set(Hds.slidebar, 'Value', pos);
    % check index stays within bounds, i.e. less than equal to # exemplars
    if Hds.video_data.current_index == Hds.video_data.nframes
        % logic governing this source should prevent this, but to ensure ...
        display_frame(Hds); % func call to display, i.e., plot
        set_display(Hds);
        set(Hds.tb_play, 'Value', 0)
        eventdata.Source.Value = 1;
        break;
    end
    
    % update GUI's axis with plot of next exemplar
    display_frame(Hds); % func call to display, i.e., plot
    set_display(Hds);
    pause(.25)
end
guidata(hObject, Hds);

% --- Executes on mouse press over figure background.
function fig_SkeletonAlignmentViewer_ButtonDownFcn(hObject, eventdata, Hds)
% hObject    handle to fig_SkeletonAlignmentViewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
disp(hObject)


% --- Executes on key press with focus on fig_SkeletonAlignmentViewer and none of its controls.
function fig_SkeletonAlignmentViewer_KeyPressFcn(hObject, eventdata, Hds)
% hObject    handle to fig_SkeletonAlignmentViewer (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% Hds    structure with Hds and user data (see GUIDATA)
if strcmp(eventdata.Key, 'space')
    
elseif strcmp(eventdata.Key, 'escape')
    
end

function set_sample_menu(hObject, Hds)

d1 = dir([Hds.loaddir 'action_data/*.mat']);
samps = strrep({d1.name}, '.mat','');
set(Hds.menu_samples, 'String', samps)
guidata(hObject, Hds);              % Update Hds structure

% --- Executes on button press in b_loaddir.
function b_loaddir_Callback(hObject, eventdata, Hds)
% hObject    handle to b_loaddir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
indir = get(Hds.tf_loaddir,'String');

if isdir(indir)
    path = uigetdir(indir,'Directory Selector');
else
    path = uigetdir(utils.getuserhome(),'Directory Selector');
end
if  path == 0
    disp('Cancel Selected')
    return;
else
    path = strcat(path, '/');
end
Hds.loaddir = path;
set(Hds.tf_loaddir, 'String', path);


guidata(hObject, Hds);              % Update Hds structure
set_sample_menu(hObject, Hds);
initialize_output_file(Hds);

% --- Executes on button press in b_select.
function b_select_Callback(hObject, eventdata, Hds)
% hObject    handle to b_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
outdir = get(Hds.tf_outdir,'String');

if isdir(outdir)
    path = uigetdir(outdir,'Directory Selector');
else
    path = uigetdir(utils.getuserhome(),'Directory Selector');
end
if  path == 0
    disp('Cancel Selected')
    return;
else
    path = strcat(path, '/');
end
Hds.outdir = path;
set(Hds.tf_outdir, 'String', path);
guidata(hObject, Hds);              % Update Hds structure



% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes on selection change in menu_samples.
function menu_samples_Callback(hObject, eventdata, Hds)
% hObject    handle to menu_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu_samples contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu_samples
% ids = Hds.menu_samples.Value;
% samps = Hds.menu_samples.String;
%
% if (length(samps) == 7) && strcmp(samps, 'Samples')
%     return;
% end

[cell_tag, do_display] = get_current_sample_string(Hds);
if ~do_display
    return;
end

Hds = display_data(hObject, Hds, cell_tag);

% --- Executes on button press in b_tag.
function b_tag_Callback(hObject, ~, Hds)
% hObject    handle to b_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[cell_tag, do_display] = get_current_sample_string(Hds);
if ~do_display
    return;
end





%% Create Function
% --- Each Executes during object creation, after setting all properties.
function tf_outdir_CreateFcn(hObject, eventdata, Hds)
% hObject    handle to tf_outdir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    empty - Hds not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tf_loaddir_CreateFcn(hObject, eventdata, Hds)
% hObject    handle to tf_loaddir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    empty - Hds not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu26_CreateFcn(hObject, eventdata, Hds)
% hObject    handle to popupmenu26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    empty - Hds not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function menu_samples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function slidebar_CreateFcn(hObject, eventdata, Hds)
% hObject    handle to slidebar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    empty - Hds not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function lb_actions_CreateFcn(hObject, eventdata, Hds)
% hObject    handle to lb_actions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    empty - Hds not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
