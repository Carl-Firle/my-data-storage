// Maße in mm
laptop_width = 350;
laptop_depth = 230;
base_thickness = 20;
screen_thickness = 10;
screen_height = 220;
hinge_gap = 5;

// Farben (optional, nur für Vorschau in OpenSCAD)
base_color = [0.2, 0.2, 0.2];
key_color = [0.8, 0.8, 0.8];
touchpad_color = [0.5, 0.5, 0.5];

// Basis (Tastaturteil)
color(base_color)
translate([0, 0, 0])
    cube([laptop_width, laptop_depth, base_thickness]);

// Bildschirm (stehend hinten an der Basis)
color(base_color)
translate([0, laptop_depth - screen_thickness - hinge_gap, base_thickness])
    cube([laptop_width, screen_thickness, screen_height]);

// Tastatur (angedeutet als kleine Tastenfläche)
key_rows = 5;
key_cols = 14;
key_spacing_x = 20;
key_spacing_y = 20;
key_size = 15;

for (row = [0:key_rows - 1])
    for (col = [0:key_cols - 1]) {
        x = 20 + col * key_spacing_x;
        y = 80 + row * key_spacing_y; // weiter oben auf der Basis
        color(key_color)
        translate([x, y, base_thickness + 1])
            cube([key_size, key_size, 2]);
    }

// Touchpad (unterhalb der Tastatur, mittig)
touchpad_width = 80;
touchpad_depth = 50;
touchpad_x = (laptop_width - touchpad_width) / 2;
touchpad_y = 30; // weiter vorne

color(touchpad_color)
translate([touchpad_x, touchpad_y, base_thickness + 1])
    cube([touchpad_width, touchpad_depth, 2]);
