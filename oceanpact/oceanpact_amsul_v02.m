

%% STEP 1: set mesh extents and set parameters for mesh. South Island of New Zealand

% lon min lon max - lat min lat max
% bbox = [166 176
        % -48 -40];

bbox = [-51 -38
        -26 -39];
        
% minimum resolution in meters.
min_el = 250;

% maximum resolution in meters.
max_el = 20e3;

% maximum resolution nearshore in meters.
max_el_ns = 1e3;

% mesh grade in decimal percent.
grade = 0.20;

% number of elements to resolve features.
R = 3;

%% STEP 2: specify geographical datasets and process the geographical data to be ...
% used later with other OceanMesh classes...

coastline = '/home/hp/git/OceanMesh2D/datasets/GSHHS_shp/f/GSHHS_f_L1';

gdat = geodata('shp',coastline,'bbox',bbox,'h0',min_el);

% NOTE: You can plot the shapefile with bounding box by using the overloaded plot ...
% command:

% plot(gdat,'shp');

%% STEP 3: create an edge function class
fh = edgefx('geodata',gdat,'fs',R,'max_el',max_el,'max_el_ns',max_el_ns,'g',grade);

%% STEP 4: Pass your edgefx class object along with some meshing options and build ...
% the mesh...

mshopts = meshgen('ef',fh,'bou',gdat,'plot_on',1);

% now build the mesh with your options and the edge function.
mshopts = mshopts.build;

%% STEP 5: Plot it and write a triangulation fort.14 compliant file to disk.
plot(mshopts.grd,'tri');
write(mshopts.grd,'South Island NZ');