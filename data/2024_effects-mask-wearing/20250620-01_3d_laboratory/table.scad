// Maße in mm
table_width = 800;
table_height = 730;
top_thickness = 40;

column_radius = 50;
column_height = table_height - top_thickness;

base_size = 300;      // Seitenlänge der quadratischen Bodenplatte
base_thickness = 20;  // Dicke der Bodenplatte

// Tischplatte (zentriert oben)
translate([0, 0, table_height - top_thickness])
    cube([table_width, table_width, top_thickness], center=true);

// Mittelsäule (zwischen Bodenplatte und Tischplatte)
translate([0, 0, base_thickness + column_height / 2])
    cylinder(h=column_height, r=column_radius, center=true);

// Bodenplatte (zentriert unten)
translate([0, 0, base_thickness / 2])
    cube([base_size, base_size, base_thickness], center=true);
