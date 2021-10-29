%% Nodes

scale = 24;

n1 = [-7.5/scale; -8.42/scale; 0];
n2 = [-7.5/scale; 8.42/scale; 0];
n3 = [7.5/scale; -8.42/scale; 0];
n4 = [7.5/scale; 8.42/scale; 0];
n5 = [0; -7.5/scale; -8.42/scale];
n6 = [0; -7.5/scale; 8.42/scale];
n7 = [0; 7.5/scale; -8.42/scale];
n8 = [0; 7.5/scale; 8.42/scale];
n9 = [-8.42/scale; 0; 7.5/scale];
n10 = [8.42/scale; 0; 7.5/scale];
n11 = [-8.42/scale; 0; -7.5/scale];
n12 = [8.42/scale; 0; -7.5/scale];

nodes_matrix = [n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12];

alphaX = 45;
alphaY = 35;
alphaZ = 0;

Rx = [1 0 0; 0 cosd(alphaX) -sind(alphaX); 0 sind(alphaX) cosd(alphaX)];
Ry = [cosd(alphaY) 0 sind(alphaY); 0 1 0; -sind(alphaY) 0 cosd(alphaY)];
Rz = [cosd(alphaZ) -sind(alphaZ) 0; sind(alphaZ) cosd(alphaZ) 0; 0 0 1];
rotation_matrix = Rz * Ry * Rx;

nodes_matrix_rotated = rotation_matrix * nodes_matrix;

%% Rods

ort_z = [0; 0; 1];

rod_start_point_1 = nodes_matrix_rotated(:, 1);
rod_start_point_2 = nodes_matrix_rotated(:, 3);
rod_start_point_3 = nodes_matrix_rotated(:, 5);
rod_start_point_4 = nodes_matrix_rotated(:, 7);
rod_start_point_5 = nodes_matrix_rotated(:, 9);
rod_start_point_6 = nodes_matrix_rotated(:, 11);

rod_vector_1 = nodes_matrix_rotated(:, 2) - nodes_matrix_rotated(:, 1);
rod_vector_2 = nodes_matrix_rotated(:, 4) - nodes_matrix_rotated(:, 3);
rod_vector_3 = nodes_matrix_rotated(:, 6) - nodes_matrix_rotated(:, 5);
rod_vector_4 = nodes_matrix_rotated(:, 8) - nodes_matrix_rotated(:, 7);
rod_vector_5 = nodes_matrix_rotated(:, 10) - nodes_matrix_rotated(:, 9);
rod_vector_6 = nodes_matrix_rotated(:, 12) - nodes_matrix_rotated(:, 11);

rod_rotation_axis_1 = cross(ort_z, rod_vector_1);
rod_rotation_axis_2 = cross(ort_z, rod_vector_2);
rod_rotation_axis_3 = cross(ort_z, rod_vector_3);
rod_rotation_axis_4 = cross(ort_z, rod_vector_4);
rod_rotation_axis_5 = cross(ort_z, rod_vector_5);
rod_rotation_axis_6 = cross(ort_z, rod_vector_6);

rod_angle_1 = asind(norm(rod_rotation_axis_1) / norm(rod_vector_1));
rod_angle_2 = asind(norm(rod_rotation_axis_2) / norm(rod_vector_2));
rod_angle_3 = asind(norm(rod_rotation_axis_3) / norm(rod_vector_3));
rod_angle_4 = asind(norm(rod_rotation_axis_4) / norm(rod_vector_4));
rod_angle_5 = asind(norm(rod_rotation_axis_5) / norm(rod_vector_5));
rod_angle_6 = asind(norm(rod_rotation_axis_6) / norm(rod_vector_6));

if rod_vector_1(3) < 0
    rod_angle_1 = 180 - rod_angle_1;
end

if rod_vector_2(3) < 0
    rod_angle_2 = 180 - rod_angle_2;
end

if rod_vector_3(3) < 0
    rod_angle_3 = 180 - rod_angle_3;
end

if rod_vector_4(3) < 0
    rod_angle_4 = 180 - rod_angle_4;
end

if rod_vector_5(3) < 0
    rod_angle_5 = 180 - rod_angle_5;
end

if rod_vector_6(3) < 0
    rod_angle_6 = 180 - rod_angle_6;
end

%% Spools parameters

spool_active_radius = 0.003; % m
spool_active_length = 0.015; % m
spool_active_density = 1410; % kg/m^3
spool_active_end_radius = 0.0005;

spool_passive_radius = 0.0005; % m
spool_passive_length = 0.0005; % m
spool_passive_density = 1410; % kg/m^3

spool_color = [255/255 255/255 255/255];
spool_passive_color = [255/255 255/255 255/255];

cable_color = [0/255 255/255 0/255];
cable_passive_color = [255/255 0/255 0/255];

%% Rods parameters

% active rods: 2, 3, 6
% passive rods: 1, 4, 5

rod_length = norm(nodes_matrix(:, 2) - nodes_matrix(:, 1)); % m
rod_squeeze = 2 * spool_active_length;
rod_length_with_drive = rod_length - rod_squeeze;

rod_radius = 0.004; % m
rod_hole_radius = 0.003; % m

rod_cross_section = [rod_hole_radius -rod_length/2;
                     rod_radius -rod_length/2;
                     rod_radius rod_length/2;
                     rod_hole_radius rod_length/2];

rod_cross_section_with_drive = [rod_hole_radius -rod_length_with_drive/2;
                     rod_radius -rod_length_with_drive/2;
                     rod_radius rod_length_with_drive/2;
                     rod_hole_radius rod_length_with_drive/2];
                 
rod_mass = 0.028; % kg
rod_mass_with_drive = 0.038; % kg

rod_color = [100/255 100/255 100/255];
rod_color_with_drive = [100/255 100/255 100/255];
rod_opacity = 1;
rod_opacity_with_drive = 1;

%% Rods ends parameters

rod_end_offset = rod_length / 2;
rod_end_offset_with_drive = rod_length_with_drive / 2;
rod_end_drive_offset = spool_active_length;

rod_end_radius = rod_radius;

rod_end_mass = 0.05; % kg
rod_end_mass_with_drive = 0.2; % kg

rod_end_color = [100/255 100/255 100/255];
rod_end_color_with_drive= [100/255 100/255 100/255];
rod_end_opacity = 1;
rod_end_opacity_with_drive = 1;

%% Springs parameters

spring_pretension = 1; % N
spring_stiffness = 300; % N/m
spring_damping = 150; % N/m/s

spring_initial_length_1  = norm(n5 - n1);  % m
spring_initial_length_2  = norm(n6 - n1);  % m
spring_initial_length_3  = norm(n9 - n1);  % m
spring_initial_length_4  = norm(n11 - n1); % m

spring_initial_length_5  = norm(n7 - n2);  % m
spring_initial_length_6  = norm(n8 - n2);  % m
spring_initial_length_7  = norm(n9 - n2);  % m
spring_initial_length_8  = norm(n11 - n2); % m

spring_initial_length_9  = norm(n5 - n3);  % m
spring_initial_length_10 = norm(n6 - n3);  % m
spring_initial_length_11 = norm(n10 - n3); % m
spring_initial_length_12 = norm(n12 - n3); % m

spring_initial_length_13 = norm(n7 - n4);  % m
spring_initial_length_14 = norm(n8 - n4);  % m
spring_initial_length_15 = norm(n10 - n4); % m
spring_initial_length_16 = norm(n12 - n4); % m

spring_initial_length_17 = norm(n11 - n5); % m
spring_initial_length_18 = norm(n12 - n5); % m

spring_initial_length_19 = norm(n9 - n6);  % m
spring_initial_length_20 = norm(n10 - n6); % m

spring_initial_length_21 = norm(n11 - n7); % m
spring_initial_length_22 = norm(n12 - n7); % m

spring_initial_length_23 = norm(n9 - n8);  % m
spring_initial_length_24 = norm(n10 - n8); % m

spring_natural_length_1  = spring_initial_length_1 - spring_pretension / spring_stiffness;  % m
spring_natural_length_2  = spring_initial_length_2 - spring_pretension / spring_stiffness;  % m
spring_natural_length_3  = spring_initial_length_3 - spring_pretension / spring_stiffness;  % m
spring_natural_length_4  = spring_initial_length_4 - spring_pretension / spring_stiffness;  % m
spring_natural_length_5  = spring_initial_length_5 - spring_pretension / spring_stiffness;  % m
spring_natural_length_6  = spring_initial_length_6 - spring_pretension / spring_stiffness;  % m
spring_natural_length_7  = spring_initial_length_7 - spring_pretension / spring_stiffness;  % m
spring_natural_length_8  = spring_initial_length_8 - spring_pretension / spring_stiffness;  % m
spring_natural_length_9  = spring_initial_length_9 - spring_pretension / spring_stiffness;  % m
spring_natural_length_10 = spring_initial_length_10 - spring_pretension / spring_stiffness; % m
spring_natural_length_11 = spring_initial_length_11 - spring_pretension / spring_stiffness; % m
spring_natural_length_12 = spring_initial_length_12 - spring_pretension / spring_stiffness; % m
spring_natural_length_13 = spring_initial_length_13 - spring_pretension / spring_stiffness; % m
spring_natural_length_14 = spring_initial_length_14 - spring_pretension / spring_stiffness; % m
spring_natural_length_15 = spring_initial_length_15 - spring_pretension / spring_stiffness; % m
spring_natural_length_16 = spring_initial_length_16 - spring_pretension / spring_stiffness; % m
spring_natural_length_17 = spring_initial_length_17 - spring_pretension / spring_stiffness; % m
spring_natural_length_18 = spring_initial_length_18 - spring_pretension / spring_stiffness; % m
spring_natural_length_19 = spring_initial_length_19 - spring_pretension / spring_stiffness; % m
spring_natural_length_20 = spring_initial_length_20 - spring_pretension / spring_stiffness; % m
spring_natural_length_21 = spring_initial_length_21 - spring_pretension / spring_stiffness; % m
spring_natural_length_22 = spring_initial_length_22 - spring_pretension / spring_stiffness; % m
spring_natural_length_23 = spring_initial_length_23 - spring_pretension / spring_stiffness; % m
spring_natural_length_24 = spring_initial_length_24 - spring_pretension / spring_stiffness; % m

%% Contact parameters

contact_stiffness = 1e6;
contact_damping = 1e3;
contact_transition_region_width = 1e-3;
contact_static_friction_coef = 0.8;
contact_dynamic_friction_coef = 0.6;
contact_critical_velocity = 0.001;

%% Load

load_radius = 0.1; % m
load_mass = 0.5; % kg
load_color = [0/255 0/255 255/255];
load_opacity = 1;

load_spool_radius = 0.0005; % m
load_spool_length = 0.0005; % m
load_spool_density = 1410; % kg/m^3

load_spool_color = [255/255 255/255 255/255];
load_spool_opacity = 1;

load_cable_color = [255/255 255/255 255/255];
load_cable_opacity = 1;

load_spring_pretension = 0; % N
load_spring_stiffness = 120; % N/m
load_spring_damping = 60; % N/m/s

load_spring_initial_length_1  = (norm(n3 - n1) - 2 * load_radius) / 2;   % m
load_spring_initial_length_2 = load_spring_initial_length_1;             % m

load_spring_initial_length_3  = (norm(n7 - n5) - 2 * load_radius) / 2;   % m
load_spring_initial_length_4 = load_spring_initial_length_3;             % m

load_spring_initial_length_5  = (norm(n11 - n9) - 2 * load_radius) / 2;  % m
load_spring_initial_length_6 = load_spring_initial_length_5;             % m

load_spring_natural_length_1 = load_spring_initial_length_1 - load_spring_pretension / load_spring_stiffness;  % m
load_spring_natural_length_2 = load_spring_initial_length_2 - load_spring_pretension / load_spring_stiffness;  % m
load_spring_natural_length_3 = load_spring_initial_length_3 - load_spring_pretension / load_spring_stiffness;  % m
load_spring_natural_length_4 = load_spring_initial_length_4 - load_spring_pretension / load_spring_stiffness;  % m
load_spring_natural_length_5 = load_spring_initial_length_5 - load_spring_pretension / load_spring_stiffness;  % m
load_spring_natural_length_6 = load_spring_initial_length_6 - load_spring_pretension / load_spring_stiffness;  % m

%% World

plane_offset = -(rod_length/2 + 0.032 + rod_radius); % m
plane_length_x = 10; % m
plane_length_y = 10; % m
grivity_z = -9.80665; % m*s^2

%% Signals

input_filtering_time = 0.01; % s


close all;

%% Plot tensegrity structure

tensegrity_structure_figure = figure('Name', 'Tensegrity structure', ...
                                     'NumberTitle', 'off', ...
                                     'Position', [0 0 900 800]);
hold on;

for point_i = 1:12
    
    % Plot initial tensegrity structure
    plot3(nodes_matrix(1, point_i), ...
          nodes_matrix(2, point_i), ...
          nodes_matrix(3, point_i), ...
          'o', 'Color','[1 0 0]');
   
    text(nodes_matrix(1, point_i), ...
         nodes_matrix(2, point_i), ...
         nodes_matrix(3, point_i) - 0.01, ...
         string(point_i), ...
         'FontSize', 12, ...
         'Color', '[1 0 0]', ...
         'HorizontalAlignment', 'center', ...
         'VerticalAlignment', 'top');
      
    if mod(point_i, 2) == 0
        plot3(linspace(nodes_matrix(1, point_i), ...
                       nodes_matrix(1, point_i - 1), 10), ...
              linspace(nodes_matrix(2, point_i), ...
                       nodes_matrix(2, point_i - 1), 10), ...
              linspace(nodes_matrix(3, point_i), ...
                       nodes_matrix(3, point_i - 1), 10), ...
              'Color', '[1 0 0]');  
    end
    
    % Plot rotated tensegrity structure

    plot3(nodes_matrix_rotated(1, point_i), ...
          nodes_matrix_rotated(2, point_i), ...
          nodes_matrix_rotated(3, point_i), ...
          '*', 'Color','[0 0 1]');
    
    text(nodes_matrix_rotated(1, point_i), ...
         nodes_matrix_rotated(2, point_i), ...
         nodes_matrix_rotated(3, point_i) - 0.01, ...
         string(point_i), ...
         'FontSize', 12, ...
         'Color', '[0 0 1]', ...
         'HorizontalAlignment', 'center', ...
         'VerticalAlignment', 'top');
      
    if mod(point_i, 2) == 0
        plot3(linspace(nodes_matrix_rotated(1, point_i), ...
                       nodes_matrix_rotated(1, point_i - 1), 10), ...
              linspace(nodes_matrix_rotated(2, point_i), ...
                       nodes_matrix_rotated(2, point_i - 1), 10), ...
              linspace(nodes_matrix_rotated(3, point_i), ...
                       nodes_matrix_rotated(3, point_i - 1), 10), ...
              'Color', '[0 0 1]');  
    end
    
end

hold off;
grid on;
axis on;
xlabel('X');
ylabel('Y');
zlabel('Z');
view(180,0);

%% Plot spring and cable connectivity

tensegrity_connectivity_figure = figure('Name', 'Tensegrity connectivity', ...
                                        'NumberTitle', 'off', ...
                                        'Position', [0 0 900 800]);

hold on;

for point_i = 1:12
    
    % Plot initial tensegrity structure
    plot3(nodes_matrix(1, point_i), ...
          nodes_matrix(2, point_i), ...
          nodes_matrix(3, point_i), ...
          'o', 'Color','[0 0 0]');
   
    text(nodes_matrix(1, point_i) - 0.01, ...
         nodes_matrix(2, point_i), ...
         nodes_matrix(3, point_i) - 0.01, ...
         string(point_i), ...
         'FontSize', 12, ...
         'Color', '[0 0 0]', ...
         'HorizontalAlignment', 'center', ...
         'VerticalAlignment', 'top');
      
    if mod(point_i, 2) == 0
        plot3(linspace(nodes_matrix(1, point_i), ...
                       nodes_matrix(1, point_i - 1), 10), ...
              linspace(nodes_matrix(2, point_i), ...
                       nodes_matrix(2, point_i - 1), 10), ...
              linspace(nodes_matrix(3, point_i), ...
                       nodes_matrix(3, point_i - 1), 10), ...
              'Color', '[0 0 0]');  
    end
    
end

spring_connectivity(:, :, 1)  = [n1, n5];
spring_connectivity(:, :, 2)  = [n1, n6];
spring_connectivity(:, :, 3)  = [n1, n9];
spring_connectivity(:, :, 4)  = [n1, n11];
spring_connectivity(:, :, 5)  = [n2, n7];
spring_connectivity(:, :, 6)  = [n2, n8];
spring_connectivity(:, :, 7)  = [n2, n9];
spring_connectivity(:, :, 8)  = [n2, n11];
spring_connectivity(:, :, 9)  = [n3, n5];
spring_connectivity(:, :, 10) = [n3, n6];
spring_connectivity(:, :, 11) = [n3, n10];
spring_connectivity(:, :, 12) = [n3, n12];
spring_connectivity(:, :, 13) = [n4, n7];
spring_connectivity(:, :, 14) = [n4, n8];
spring_connectivity(:, :, 15) = [n4, n10];
spring_connectivity(:, :, 16) = [n4, n12];
spring_connectivity(:, :, 17) = [n5, n11];
spring_connectivity(:, :, 18) = [n5, n12];
spring_connectivity(:, :, 19) = [n6, n9];
spring_connectivity(:, :, 20) = [n6, n10];
spring_connectivity(:, :, 21) = [n7, n11];
spring_connectivity(:, :, 22) = [n7, n12];
spring_connectivity(:, :, 23) = [n8, n9];
spring_connectivity(:, :, 24) = [n8, n10];

                       
for pair_i = 1:size(spring_connectivity, 3)
    plot3(linspace(spring_connectivity(1, 2, pair_i), ...
                   spring_connectivity(1, 1, pair_i), 10), ...
          linspace(spring_connectivity(2, 2, pair_i), ...
                   spring_connectivity(2, 1, pair_i), 10), ...
          linspace(spring_connectivity(3, 2, pair_i), ...
                   spring_connectivity(3, 1, pair_i), 10), ...
          'Color', '[1 0 0]');  
end

cable_connectivity(:, :, 1)  = [n1, n12];
cable_connectivity(:, :, 2)  = [n2, n6];
cable_connectivity(:, :, 3)  = [n3, n7];
cable_connectivity(:, :, 4)  = [n4, n9];
cable_connectivity(:, :, 5)  = [n5, n10];
cable_connectivity(:, :, 6)  = [n8, n11];

                       
for pair_i = 1:size(cable_connectivity, 3)
    plot3(linspace(cable_connectivity(1, 2, pair_i), ...
                   cable_connectivity(1, 1, pair_i), 10), ...
          linspace(cable_connectivity(2, 2, pair_i), ...
                   cable_connectivity(2, 1, pair_i), 10), ...
          linspace(cable_connectivity(3, 2, pair_i), ...
                   cable_connectivity(3, 1, pair_i), 10), ...
          'Color', '[0 1 0]');  
end

hold off;
grid on;
axis on;
xlabel('X');
ylabel('Y');
zlabel('Z');
view(45,45);