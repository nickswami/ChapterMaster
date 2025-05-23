// Displays weapon based on the armour type to change the art to match the armour type
// TODO: Refactor a lot of individual armour/weapon checks/array_contains changes to be built-in into each weapon struct presented here.
// TODO: Overall a refactor to weapon draw logic would be good, as current approach may be a bit too verbose and at the same time not very customizable.
// My advice is to use Bolter and Power Sword as baselines for all origin, offset and other adjustments, to keep stuff consistent.
/// @mixin
function scr_ui_display_weapons(left_or_right, current_armor, equiped_weapon, current_armor_type) {
    clear = false;
    display_type = "normal_ranged";
    var sprite_found = false;



    // Handle one-handed ranged

    // Handle two-handed ranged

    // Handle one-handed melee


    // Handle one-handed fist melee


    // Handle two-handed melee

    static set_as_normal_ranged = function(sprite, left_or_right) {
        ui_weapon[left_or_right] = sprite;
        arm_variant[left_or_right] = 1;
        ui_spec[left_or_right] = false;
        new_weapon_draw[left_or_right] = true;
        display_type = "normal_ranged";
    }
    
    static set_as_ranged_assault = function(sprite, left_or_right) {
        ui_weapon[left_or_right] = sprite;
        display_type = "ranged_assault";
        arm_variant[left_or_right] = 0;
        hand_variant[left_or_right] = 0;
        ui_spec[left_or_right] = true;
    }
    
    static set_as_ranged_twohand = function(sprite, left_or_right) {
        ui_weapon[left_or_right] = sprite;
        display_type = "ranged_twohand";
        arm_variant[1] = 0;
        arm_variant[2] = 0;
        hand_variant[1] = 0;
        hand_variant[2] = 0;
        ui_spec[left_or_right] = true;
        ui_twoh[left_or_right] = true;
    }
    
    static set_as_special_ranged = function(sprite, left_or_right) {
        ui_weapon[left_or_right] = sprite;
        arm_variant[left_or_right] = 0;
        hand_variant[left_or_right] = 0;
        ui_spec[left_or_right] = true;
        new_weapon_draw[left_or_right] = true;
        display_type = "special_ranged";
    }
    
    static set_as_terminator_ranged = function(sprite, left_or_right) {
        ui_weapon[left_or_right] = sprite;
        arm_variant[left_or_right] = 2;
        hand_variant[left_or_right] = 0;
        ui_spec[left_or_right] = true;
        display_type = "terminator_ranged";
    }
    
    static set_as_melee_onehand = function(sprite, left_or_right) {
        ui_weapon[left_or_right] = sprite;
        arm_variant[left_or_right] = 0;
        hand_variant[left_or_right] = 0;
        hand_on_top[left_or_right]=true;
        ui_spec[left_or_right] = true;
        display_type = "melee_onehand";
    }
    
    static set_as_normal_fist = function(sprite, left_or_right) {
        ui_weapon[left_or_right] = sprite;
        arm_variant[left_or_right] = 1;
        ui_spec[left_or_right] = true;
        display_type = "normal_fist";
    }
    
    static set_as_melee_twohand = function(sprite, left_or_right) {
        ui_weapon[left_or_right] = sprite;
        display_type = "melee_twohand";
        arm_variant[1] = 0;
        arm_variant[2] = 0;
        hand_variant[1] = 0;
        hand_variant[2] = 0;
        hand_on_top[1]=true;
        hand_on_top[2]=true;
        ui_spec[left_or_right] = true;
        ui_twoh[left_or_right] = true;
    }
    
    static set_as_terminator_melee = function(sprite, left_or_right) {
        ui_weapon[left_or_right] = sprite;
        arm_variant[left_or_right] = 1;
        hand_on_top[left_or_right]=true;
        ui_spec[left_or_right] = true;
        display_type = "terminator_melee";
    }
    
    static set_as_terminator_fist = function(sprite, left_or_right) {
        ui_weapon[left_or_right] = sprite;
        arm_variant[left_or_right] = 1;
        ui_spec[left_or_right] = true;
        display_type = "terminator_fist";
    }

    /////////
    // Hands and stuff
    //////////

    if ("Autocannon" == equiped_weapon) {
        arm_variant[1] = 0;
        arm_variant[2] = 1;
        hand_variant[1] = 6;
        hand_on_top[2]=true;
    }
    // New weapon draw method

    // Adjust weapon sprites meant for normal power armour but used on terminators
    if (current_armor_type == ArmourType.Terminator && !array_contains(["terminator_ranged", "terminator_melee","terminator_fist"],display_type)){
        ui_ymod[left_or_right] -= 20;
        if (display_type == "normal_ranged") {
            ui_xmod[left_or_right] -= 24;
            ui_ymod[left_or_right] += 24;
        }
        if (display_type == "melee_onehand" && equiped_weapon != "Company Standard") {
            arm_variant[left_or_right] = 2;
            hand_variant[left_or_right] = 2;
            ui_xmod[left_or_right] -= 14;
            ui_ymod[left_or_right] += 23;
        }

        if (display_type == "melee_twohand") {
            arm_variant[1] = 2;
            arm_variant[2] = 2;
            hand_variant[1] = 3;
            hand_variant[2] = 4;
            ui_ymod[left_or_right] += 25;
        }

        if (display_type == "ranged_twohand") {
            arm_variant[1] = 2;
            arm_variant[2] = 2;
            hand_variant[1] = 0;
            hand_variant[2] = 0;
            ui_ymod[left_or_right] += 15;
        }

        if (array_contains(["Chainaxe", "Power Axe", "Crozius Arcanum", "Power Mace", "Mace of Absolution", "Relic Blade"], equiped_weapon)) {
            hand_variant[left_or_right] = 3;
            arm_variant[left_or_right] = 3;
        }
    } else if (current_armor_type == ArmourType.Scout){
        ui_xmod[left_or_right] += 4;
        ui_ymod[left_or_right] += 11;
    }

    // This is for when weapon sprites that are touching the ground and must be independent of unit height.
    if ((display_type == "melee_onehand" && equiped_weapon != "Combat Knife") || equiped_weapon == "Sniper Rifle") {
        ui_ymod[left_or_right] = 0;
    }

    // Flip the ui_xmod for offhand
    if (left_or_right == 2  && ui_xmod[left_or_right] != 0) {
        /*and (current_armor=0)*/
        ui_xmod[left_or_right] = ui_xmod[left_or_right] * -1;
    }
}

function dreadnought_sprite_components(component){
    var components = {
        "Assault Cannon" : spr_dread_assault_cannon,
        "Lascannon" : spr_dread_plasma_cannon,
        "Close Combat Weapon":spr_dread_claw,
        "Twin Linked Heavy Bolter":spr_dread_heavy_bolter,
        "Plasma Cannon" : spr_dread_plasma_cannon,
        "Autocannon" : spr_dread_autocannon,
        "Missile Launcher" :spr_dread_missile,
        "Dreadnought Lightning Claw": spr_dread_claw,
        "CCW Heavy Flamer": spr_dread_claw,
        "Dreadnought Power Claw": spr_dread_claw,
        "Inferno Cannon": spr_dread_plasma_cannon,
        "Multi-Melta": spr_dread_plasma_cannon,
        "Twin Linked Lascannon": spr_dread_lascannon,
        "Heavy Conversion Beam Projector": spr_dread_plasma_cannon,
    };
    if (struct_exists(components, component)){
        return components[$ component]
    } else {
        return spr_weapon_blank;
    }
}
