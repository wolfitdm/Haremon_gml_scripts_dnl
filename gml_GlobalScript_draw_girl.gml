function draw_girl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
{
    var inBattle = object_index == obj_battlegirl;
    var inScene = object_index == obj_vncontroller;
    var cl = arg5;
    var always_lewd = false;
    
    if (sfw_battle() >= 0.75 || (0 && global.settingSafeMode && arg2 != global.speciesRobot))
        cl = global.clothesMax;
    else if (sfw_battle == 0.5 || 0)
        cl = max(2, cl);
    
    if (global.FLAG[387] == 1)
        cl = 0;
    
    if (global.FLAG[388] == 1)
        always_lewd = true;
    
    var mySpecies = arg2;
    var xx = arg0;
    var yy = arg1;
    var extraY = 0;
    var xsc, ysc;
    
    if (!inBattle)
    {
        xsc = arg3 * species_scale(mySpecies);
        ysc = arg4 * species_scale(mySpecies);
    }
    else
    {
        xsc = arg3;
        ysc = arg4;
    }
    
    var yoff, xoff;
    
    if (global.settingFancy == true && !inBattle)
    {
        xoff = (sprite_get_xoffset(species_basesprite(mySpecies)) * abs(xsc)) + 16;
        yoff = sprite_get_yoffset(species_basesprite(mySpecies)) * abs(ysc);
        
        if (!surface_exists(global.surfGIRL))
            global.surfGIRL = surface_create((sprite_get_width(species_basesprite(mySpecies)) * abs(xsc)) + 80, sprite_get_height(species_basesprite(mySpecies)) * abs(ysc));
        else
            surface_resize(global.surfGIRL, (sprite_get_width(species_basesprite(mySpecies)) * abs(xsc)) + 80, sprite_get_height(species_basesprite(mySpecies)) * abs(ysc));
    }
    else
    {
        xoff = xx;
        yoff = yy;
    }
    
    var xoff_2 = 0;
    var myMood = arg6;
    
    if (myMood == 3)
    {
        if (room == rmBattleTest)
        {
            if (sfw_battle() >= 0.75)
                myMood = 7;
            else
                myMood = 38;
        }
    }
    
    var alpha = arg7;
    var alpha2;
    
    if (global.settingFancy == true)
        alpha2 = 1;
    else
        alpha2 = alpha;
    
    var al_ = 1;
    var lastface = false;
    var cum = arg8;
    var cummed_ = cum[0] || cum[1] || cum[2] || cum[3];
    var col;
    
    if (inBattle)
        col = merge_color(c_white, c_black, (abs(girlIndex) - 1) * 0.18);
    else
        col = -1;
    
    var u = arg9;
    var wiggle = 0;
    var accessories = true;
    var storytime = false;
    
    if (inBattle)
    {
        if (global.environment == 13)
            u = 3;
        else if (girlIndex > 0 && mySpecies > 200)
            u = 1;
    }
    else if (global.dateLocation == 13)
    {
        if (global.environment == 13)
        {
            if (room != rmTown)
                u = 3;
        }
    }
    else if (global.dateLocation == 36)
    {
        if (global.environment == 36)
        {
            if (room != rmTown)
            {
                u = 3;
                accessories = false;
            }
        }
    }
    else if (room == rmVnTest)
    {
        if (global.sceneIndex == 248)
        {
            u = 1;
        }
        else if (global.sceneIndex == 264 || global.sceneIndex == 260)
        {
            u = 1;
            cl = global.clothesMax;
        }
        else if (global.sceneIndex == 268)
        {
            u = 3;
        }
        else if (global.sceneIndex == 274 && mySpecies == global.speciesCatgirl)
        {
            u = 3;
        }
        else if (global.sceneIndex == 331 && mySpecies == global.speciesCowgirl)
        {
            u = 1;
        }
        else if ((global.sceneIndex == 507 || global.sceneIndex == 508 || global.sceneIndex == 578 || global.sceneIndex == 583 || global.sceneIndex == 592 || global.sceneIndex == 593 || global.sceneIndex == 594) && mySpecies == global.speciesWitch)
        {
            u = 1;
        }
        else if (global.sceneIndex == 532)
        {
            if (lineIndex > 4 && lineIndex != 96)
                u = 3;
        }
        else if (global.sceneIndex == 593)
        {
            u = 1;
            cl = global.clothesMax;
        }
        else if (global.sceneIndex == 607)
        {
            xsc *= 1.25;
            ysc *= 1.25;
            yoff += 400;
        }
        else if (global.sceneIndex == 218 || global.sceneIndex == 219)
        {
            if (currentActor > 1)
            {
                wiggle = 1 + ((1 - alpha) * 9);
                alpha *= 0.8;
            }
        }
        else if (global.sceneIndex == 609)
        {
            u = 3;
            accessories = false;
        }
        else if (global.sceneIndex == 703)
        {
            u = 1;
            
            if (mySpecies == global.speciesRobot)
                u = 5;
            else if (mySpecies != global.speciesImp)
                accessories = false;
        }
    }
    
    var serious;
    
    if (object_index == obj_vncontroller)
        serious = seriousScene;
    else
        serious = false;
    
    if (u == 3)
    {
        if (serious || outfit_item(mySpecies, u) == 0)
            u = 1;
    }
    
    var ha = arg10;
    var ey = arg11;
    var gang = arg12;
    var clothesAlpha = 1;
    var undiesAlpha = 1;
    
    if (keepsake_active(global.itemLens) && !serious)
    {
        clothesAlpha = global.lensAlpha;
        
        if (u == 3 || cl < 4)
            undiesAlpha = global.lensAlpha;
    }
    
    var ang = 0;
    var topless = false;
    var bottomless = peeing();
    
    if (inScene)
    {
        if (global.sceneIndex == 344)
        {
            if (currentActor == 2)
            {
                if (lineIndex >= 11 && lineIndex <= 21)
                    ang = -45;
            }
        }
    }
    
    if (inScene)
    {
        if (global.sceneIndex != 0)
        {
            if (global.sceneIndex == 86)
            {
                if (lineIndex >= 59 && lineIndex <= 62)
                {
                    undiesAlpha = global.lensAlpha * 0.7;
                    clothesAlpha = global.lensAlpha * 0.5;
                }
            }
            else if (global.sceneIndex == 35)
            {
                if (lineIndex >= 4 && lineIndex <= 14)
                    undiesAlpha = 0.7;
            }
            else if (global.sceneIndex == 86)
            {
                if (lineIndex >= 52 && lineIndex <= 57)
                    undiesAlpha = 0.7;
            }
            else if (global.sceneIndex == 218 || global.sceneIndex == 219)
            {
                if (currentActor > 1)
                {
                    shader_set(shader_silhouette);
                    var c = merge_color(c_purple, c_black, 0.9);
                    shader_set_uniform_f(global.new_color, colour_get_red(c) / 255, colour_get_green(c) / 255, colour_get_blue(c) / 255);
                    shader_set_uniform_f(global.new_alpha, 1);
                }
            }
            
            if (actorLastMood[currentActor] != -1 && actorLastMood[currentActor] != actorMood[currentActor])
            {
                lastface = true;
                al_ = actorMoodFade * alpha2;
            }
            
            if (environment_is_residential(global.environment) && !(u == 6 && mySpecies != global.speciesSeraph))
            {
                if (!(global.sceneIndex == 238 || global.sceneIndex == 239 || global.sceneIndex == 69))
                    accessories = false;
            }
            
            if (global.sceneIndex == 118)
            {
                if (lineIndex > 9 && lineIndex < 16)
                {
                    u = 1;
                    cl = global.clothesMax;
                    storytime = true;
                }
            }
            else if (global.sceneIndex == 53)
            {
                if (global.girlOutfit[find_girl(global.speciesWitch)] == 3)
                    u = 1;
            }
        }
    }
    else if (inBattle)
    {
        if (global.activeTechnique == global.techniqueFlash)
        {
            if (instance_exists(obj_battleflash_gleam))
                clothesAlpha = 1 - obj_battleflash_gleam.image_alpha;
        }
    }
    
    clothesAlpha *= alpha2;
    undiesAlpha *= alpha2;
    var specialdrawundies = false;
    
    if (0 || sfw_battle() == 1)
    {
        undiesAlpha = 1;
        topless = false;
        bottomless = false;
        
        if (clothesAlpha < 1)
            specialdrawundies = true;
        
        if (global.settingSafeMode)
            clothesAlpha = 1;
    }
    
    if (!species_has_outfit(mySpecies, u))
        u = 1;
    
    var clothesSprite;
    
    if (cl == 4)
        clothesSprite = species_tornclothessprite(mySpecies, u);
    else if (bottomless)
        clothesSprite = species_clothessprite_nobottom(mySpecies, u);
    else
        clothesSprite = species_clothessprite(mySpecies, u);
    
    if (!inBattle)
    {
        if (global.settingFancy == true)
        {
            surface_set_target(global.surfGIRL);
            draw_clear_alpha(c_black, 0);
        }
    }
    
    switch (mySpecies)
    {
        default:
            if (cl > 4)
                draw_sprite_ext(species_accessorysprite_back(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (always_lewd || species_breasts_are_exposed(mySpecies, u, cl) || species_vag_is_exposed(cl))
                draw_sprite_ext(species_lewdsprite(mySpecies), global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies)
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (panties_are_exposed(cl, u, cummed_) || specialdrawundies)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (cl > 2)
            {
                draw_sprite_ext(species_shoessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 3)
                {
                    draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl == 6)
                        draw_sprite_ext(species_accessorysprite_front(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            draw_sprite_ext(species_hairsprite(mySpecies, ha), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (cl == 6)
                draw_sprite_ext(species_accessorysprite_front2(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            var acc = species_accessorysprite(mySpecies, 0, u, cl);
            
            for (var i_ = 1; i_ <= acc; i_++)
                draw_sprite_ext(species_accessorysprite(mySpecies, i_, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (accessories == true)
                draw_sprite_ext(species_weaponsprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.speciesCatgirl:
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (always_lewd || ((species_breasts_are_exposed(mySpecies, u, cl) || species_vag_is_exposed(cl)) && !bottomless))
                draw_sprite_ext(spr_catgirl_lewd, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies)
            {
                if (!(cl > 3 && u == 2))
                    draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            }
            
            if ((panties_are_exposed(cl, u, cummed_) || specialdrawundies) && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (cl > 2)
            {
                draw_sprite_ext(species_shoessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 3)
                {
                    draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl == 6)
                        draw_sprite_ext(species_accessorysprite_front(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            draw_sprite_ext(species_hairsprite(mySpecies, ha), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (cl == 6)
                draw_sprite_ext(species_accessorysprite_front2(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            var acc = species_accessorysprite(mySpecies, 0, u, cl);
            
            for (var i_ = 1; i_ <= acc; i_++)
                draw_sprite_ext(species_accessorysprite(mySpecies, i_, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.speciesWitch:
            if (global.sceneIndex == 593 || (global.sceneIndex == 594 && lineIndex > 200))
                accessories = false;
            
            if (inScene && global.sceneIndex == 583 && hov > 0)
                staffalp = max(0, 1 - (hov / (room_speed / 2)));
            else
                staffalp = 1;
            
            if (u != 3)
            {
                draw_sprite_ext(spr_witch_hair, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (u == 6)
                    draw_sprite_ext(spr_witch_xmas_sack, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            if (cl > 4)
                draw_sprite_ext(species_accessorysprite_back(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            draw_sprite_ext(spr_witch_hair2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (u != 3 && u != 6)
            {
                if (accessories == true && !(u == 4 && (bottomless || cl < 4)))
                    draw_sprite_ext(species_weaponsprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * staffalp);
                
                if (cl < 4 && global.FLAG[271] == 0 && u != 4)
                    draw_sprite_ext(spr_witch_book, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            if (always_lewd || species_breasts_are_exposed(mySpecies, u, cl) || species_vag_is_exposed(cl))
                draw_sprite_ext(spr_witch_lewd, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies)
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if ((panties_are_exposed(cl, u, cummed_) || specialdrawundies) && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (cl > 2)
            {
                if (cl > 3 && u == 2)
                    draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (!(u == 4 && bottomless))
                    draw_sprite_ext(species_shoessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 3 && u != 2)
                    draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            
            if (u != 3 && u != 6 && u != 4)
            {
                if (cl > 3 && global.FLAG[271] == 0)
                    draw_sprite_ext(spr_witch_book, (u == 2) + ((clothesSprite == 90 || clothesSprite == 119) * 2), xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            if (cl == 6)
                draw_sprite_ext(species_accessorysprite_front(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            if (u == 6)
                draw_sprite_ext(species_weaponsprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (cl == 6 && global.FLAG[291] == 0)
                draw_sprite_ext(species_accessorysprite_front2(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            var acc = species_accessorysprite(mySpecies, 0, u, cl);
            
            if (inBattle)
            {
                if (global.melonBattle == true)
                    acc--;
            }
            else if (u == 3 && accessories == false)
            {
                acc = 0;
            }
            
            for (var i_ = 1; i_ <= acc; i_++)
                draw_sprite_ext(species_accessorysprite(mySpecies, i_, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.speciesCowgirl:
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (always_lewd || species_breasts_are_exposed(mySpecies, u, cl) || species_vag_is_exposed(cl))
            {
                draw_sprite_ext(spr_cowgirl_lewd, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
                draw_sprite_ext(spr_cowgirl_niprings, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies)
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if ((panties_are_exposed(cl, u, cummed_) || specialdrawundies) && !bottomless)
            {
                if (!(u == 2 && cl > 3 && !specialdrawundies))
                    draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            }
            
            if (cl > 3)
            {
                if (u != 3 && u != 6)
                {
                    if (cl == 4 && u != 4)
                        draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                    
                    if (u == 1 || u == 7)
                    {
                        if (!bottomless)
                            draw_sprite_ext(species_tornclothessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl == 5)
                            draw_sprite_ext(species_clothessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    }
                    else
                    {
                        draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    }
                }
                else
                {
                    draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            else if (inScene)
            {
                if (global.sceneIndex == 76 || global.sceneIndex == 176)
                    draw_sprite_ext(species_tornclothessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            
            if (cl == 6)
                draw_sprite_ext(species_accessorysprite_front(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            if (u != 2)
                draw_sprite_ext(species_hairsprite(mySpecies, ha), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (cl == 6)
                draw_sprite_ext(species_accessorysprite_front2(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            var acc = species_accessorysprite(mySpecies, 0, u, cl);
            
            for (var i_ = 1; i_ <= acc; i_++)
                draw_sprite_ext(species_accessorysprite(mySpecies, i_, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (u == 2)
                draw_sprite_ext(species_hairsprite(mySpecies, ha), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.speciesImp:
            if (u == 4 && cl == 6)
                draw_sprite_ext(spr_imp_gyaru_jacketback, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            var wings;
            
            if (u != 6)
                wings = 225;
            else
                wings = 262;
            
            var wingx = sprite_get_xoffset(species_basesprite(mySpecies)) - sprite_get_xoffset(wings);
            var wingy = sprite_get_yoffset(species_basesprite(mySpecies)) - sprite_get_yoffset(wings);
            var sign_ = 1;
            var bobradsB, wingsc, batang;
            
            if (room == rmBattleTest)
            {
                batang = 10;
                bobradsB = bobrads;
                
                if (girlIndex > 0)
                    wingsc = (1 + (((sin(bobradsB) + 1) / 2) * 0.23)) - 0.2;
                else
                    wingsc = 1 - (((sin(bobradsB) + 1) / 2) * 0.23);
            }
            else
            {
                batang = 0;
                
                switch (myMood)
                {
                    case 7:
                    case 23:
                    case 3:
                    case 38:
                    case 16:
                        bobrads5 += (bobspd5 * 2);
                        break;
                    
                    case 9:
                    case 34:
                    case 15:
                    case 33:
                        bobrads5 += bobspd5;
                        break;
                    
                    case 18:
                        bobrads5 += (bobspd5 * 13);
                        break;
                    
                    case 26:
                    case 25:
                    case 32:
                        bobrads5 += (bobspd5 * 6);
                        break;
                    
                    case 30:
                        bobrads5 += (bobspd5 * 3);
                        break;
                    
                    case 10:
                    case 11:
                    case 36:
                        bobrads5 -= (bobspd5 / 4);
                        break;
                    
                    case 21:
                    case 35:
                        bobrads5 -= (bobspd5 / 3);
                        break;
                    
                    case 1:
                    case 29:
                        bobrads5 -= (bobspd5 / 2);
                        break;
                    
                    case 14:
                        bobrads5 -= (bobspd5 / 1.5);
                        break;
                }
                
                bobradsB = -bobrads5;
                wingsc = 1 - (((sin(bobradsB) + 1) / 2) * 0.23);
                
                if (room == rmVnTest && actorScaleX[currentActor] > 0)
                    sign_ = -1;
                
                if (global.sceneIndex == 0)
                    batang = -20;
            }
            
            draw_sprite_ext(wings, 0, xoff + lengthdir_x(wingx * xsc, gang + 180) + lengthdir_x(wingy * ysc, gang + 90), (yoff + lengthdir_y(wingx * xsc, gang + 180) + lengthdir_y(wingy * ysc, gang + 90)) - (((sin(bobradsB) + 1) / 2) * 7), xsc * wingsc, ysc, (gang - (9 * sign_) - (sin(bobradsB) * 9 * sign_)) + batang, col, alpha2);
            draw_sprite_ext(wings, 1, xoff + lengthdir_x(wingx * xsc, gang + 180) + lengthdir_x(wingy * ysc, gang + 90), (yoff + lengthdir_y(wingx * xsc, gang + 180) + lengthdir_y(wingy * ysc, gang + 90)) - (((sin(bobradsB) + 1) / 2) * 7), xsc * wingsc, ysc, (gang + (9 * sign_) + (sin(bobradsB) * 9 * sign_)) - batang, col, alpha2);
            draw_sprite_ext(spr_imp_tail, 0, xoff - (111 * xsc), yoff + (30 * ysc), xsc * (1 + (undulate(8) * 0.12)), ysc * (0.95 - (undulate(8) * 0.15)), gang + (undulate(6.5) * 8), col, alpha2);
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (always_lewd || species_breasts_are_exposed(mySpecies, u, cl) || species_vag_is_exposed(cl))
                draw_sprite_ext(spr_imp_lewd, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (panties_are_exposed(cl, u, cummed_) && !bottomless && !(u == 4 && cl > 4))
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (cl > 2)
            {
                draw_sprite_ext(species_shoessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 3)
                {
                    draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (clothesSprite == 266 && !bottomless)
                        draw_sprite_ext(spr_imp_gyaru_skirt, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl == 6)
                        draw_sprite_ext(species_accessorysprite_front(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            draw_sprite_ext(species_hairsprite(mySpecies, ha, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (cl == 6)
                draw_sprite_ext(species_accessorysprite_front2(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            var acc = species_accessorysprite(mySpecies, 0, u, cl);
            
            for (var i_ = 1; i_ <= acc; i_++)
                draw_sprite_ext(species_accessorysprite(mySpecies, i_, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (accessories == true)
                draw_sprite_ext(species_weaponsprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (u == 1 || u == 7)
                draw_sprite_ext(spr_imp_shackle, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            break;
        
        case global.speciesBunnygirl:
            var lm;
            
            if (lastface)
                lm = actorLastMood[currentActor];
            else
                lm = 8;
            
            if (room == rmVnTest)
            {
                if (global.sceneIndex != 119)
                {
                    if (lm == 2)
                        lm = 6;
                }
                
                if (myMood == 2)
                    myMood = 6;
            }
            
            var hairSprite;
            
            if (ha == 2)
            {
                hairSprite = 316;
            }
            else
            {
                switch (myMood)
                {
                    case 15:
                    case 14:
                    case 40:
                    case 21:
                    case 35:
                    case 33:
                    case 10:
                    case 27:
                    case 1:
                        hairSprite = 294;
                        cum[0] = 0;
                        break;
                    
                    default:
                        hairSprite = 293;
                        break;
                }
            }
            
            if (ha == 1)
            {
                draw_sprite_ext(spr_bunnygirl_hairback, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                draw_sprite_ext(spr_bunnygirl_tail, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            else if (ha == 2)
            {
                draw_sprite_ext(spr_bunnygirl_hairback2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            if (u == 4 && cl > 4)
            {
                if (!bottomless)
                {
                    draw_sprite_ext(spr_bunnygirl_dancer_shawlback, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    draw_sprite_ext(spr_bunnygirl_dancer_skirtback, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, lm, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (u != 4)
            {
                if (cl == 6)
                {
                    if (u == 1)
                        draw_sprite_ext(spr_bunnygirl_gloves, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    else if (u == 5)
                        draw_sprite_ext(spr_bunnygirl_gloves2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                }
                
                if (always_lewd || species_breasts_are_exposed(mySpecies, u, cl) || species_vag_is_exposed(cl))
                    draw_sprite_ext(spr_bunnygirl_lewds, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
                
                if (bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies)
                    draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                
                if ((panties_are_exposed(cl, u, cummed_) || specialdrawundies) && !bottomless)
                    draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                
                if (cl > 2)
                {
                    draw_sprite_ext(species_shoessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl == 6)
                            draw_sprite_ext(species_accessorysprite_front(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    }
                }
            }
            else if (cl > 0)
            {
                if (!bottomless)
                    draw_sprite_ext(spr_bunnygirl_dancer_panties, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 1)
                {
                    draw_sprite_ext(spr_bunnygirl_dancer_bra, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 2)
                    {
                        draw_sprite_ext(spr_bunnygirl_dancer_sandals, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 3)
                        {
                            if (cl > 4)
                                draw_sprite_ext(spr_bunnygirl_dancer_gloves, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (!bottomless)
                            {
                                draw_sprite_ext(spr_bunnygirl_dancer_skirtfront, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                                draw_sprite_ext(spr_bunnygirl_dancer_shawlfront, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            }
                            
                            if (cl > 4)
                                draw_sprite_ext(spr_bunnygirl_dancer_mask, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                }
            }
            
            draw_sprite_ext(hairSprite, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            var accc = species_accessorysprite_front2(mySpecies, u);
            var acimg = 0;
            
            if (accc == 303 && hairSprite == 294)
                accc = 304;
            else if (accc == 327 && hairSprite == 294)
                acimg = 1;
            
            if (cl == 6)
                draw_sprite_ext(accc, acimg, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            var acc = species_accessorysprite(mySpecies, 0, u, cl);
            
            for (var i_ = 1; i_ <= acc; i_++)
                draw_sprite_ext(species_accessorysprite(mySpecies, i_, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.speciesMonarch:
            if (u == 4)
                draw_sprite_ext(spr_monarch_moth_base, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            else if (u == 6 && cl > 4 && !bottomless)
                draw_sprite_ext(spr_monarch_xmas_base, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            else
                draw_sprite_ext(spr_monarch_base, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), u == 4, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), u == 4, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (always_lewd || species_breasts_are_exposed(mySpecies, u, cl) || species_vag_is_exposed(cl))
                draw_sprite_ext(spr_monarch_lewdbits, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies)
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if ((panties_are_exposed(cl, u, cummed_) || specialdrawundies) && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (cl > 2)
            {
                draw_sprite_ext(species_shoessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 3)
                {
                    draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl == 6)
                        draw_sprite_ext(species_accessorysprite_front(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            draw_sprite_ext(species_hairsprite(mySpecies, ha, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (cl == 6)
                draw_sprite_ext(species_accessorysprite_front2(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            var acc = species_accessorysprite(mySpecies, 0, u, cl);
            
            for (var i_ = 1; i_ <= acc; i_++)
                draw_sprite_ext(species_accessorysprite(mySpecies, i_, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (accessories == true)
                draw_sprite_ext(species_weaponsprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.speciesGargoyle:
            var xmas = false;
            
            if (room == rmVnTest)
            {
                if (global.sceneIndex == 176)
                {
                    if (have_tamed_species(global.speciesMonarch))
                    {
                        if (global.FLAG[83] == find_girl(global.speciesMonarch) || global.FLAG[84] == find_girl(global.speciesMonarch))
                        {
                            if (global.FLAG[85] == 1)
                                u = 1;
                        }
                    }
                }
            }
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), u == 4, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), u == 4, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (always_lewd || species_breasts_are_exposed(mySpecies, u, cl) || species_vag_is_exposed(cl))
                draw_sprite_ext(spr_gargoyle_pubes, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if ((bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies) || (u < 3 && cl == (global.clothesMax - 2)))
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if ((panties_are_exposed(cl, u, cummed_) || specialdrawundies) && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (u != 2 && u != 4)
            {
                if (cl > 3)
                {
                    if (u == 6)
                    {
                        if (cl > 4)
                            xmas = true;
                    }
                    
                    if (!xmas)
                        draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl == 6)
                        draw_sprite_ext(species_accessorysprite_front(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
                
                draw_sprite_ext(species_hairsprite(mySpecies, ha, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (xmas)
                    draw_sprite_ext(spr_gargoyle_xmas_top, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (cl == 6)
                    draw_sprite_ext(species_accessorysprite_front2(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                var acc = species_accessorysprite(mySpecies, 0, u, cl);
                
                for (var i_ = 1; i_ <= acc; i_++)
                    draw_sprite_ext(species_accessorysprite(mySpecies, i_, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            else if (u == 2)
            {
                if (cl > 3)
                {
                    if (!bottomless)
                        draw_sprite_ext(spr_gargoyle_suit, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    
                    if (cl > 4)
                    {
                        draw_sprite_ext(spr_gargoyle_sunglasses, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                        
                        if (cl > 5 && !bottomless)
                            draw_sprite_ext(spr_gargoyle_suit_sleeves, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    }
                }
                
                draw_sprite_ext(species_hairsprite(mySpecies, ha, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            else if (u == 4)
            {
                if (cl > 3 && !bottomless)
                {
                    draw_sprite_ext(spr_gargoyle_drac_outfit, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    
                    if (cl > 4)
                        draw_sprite_ext(spr_gargoyle_drac_cloakfront, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                }
                
                draw_sprite_ext(species_hairsprite(mySpecies, ha, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            break;
        
        case global.speciesKitsune:
            accessories = true;
            var tails = 0;
            
            if (room == rmBattleTest && global.battlePhase == global.phaseAttack && global.activeGirl == girlIndex && technique_category(global.activeTechnique) == 1)
                tails = 1;
            
            draw_sprite_ext(spr_kitsune_tails, tails, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (u == 3)
                draw_sprite_ext(spr_kitsune_hairback2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            else
                draw_sprite_ext(spr_kitsune_hairback, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (always_lewd || species_breasts_are_exposed(mySpecies, u, cl) || species_vag_is_exposed(cl))
                draw_sprite_ext(spr_kitsune_lewd, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies)
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if ((panties_are_exposed(cl, u, cummed_) || specialdrawundies) && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (u == 3)
            {
                if (cl > 3)
                    draw_sprite_ext(spr_kitsune_swimsuit_sleeves, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            else
            {
                if (cl > 3)
                    draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 2)
                {
                    var spr = 434;
                    
                    if (u == 1 && cl > 3)
                        spr = 433;
                    
                    draw_sprite_ext(spr, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                    
                    if (cl == 6)
                        draw_sprite_ext(species_accessorysprite_front(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            draw_sprite_ext(species_hairsprite(mySpecies, ha), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (cl == 6)
                draw_sprite_ext(species_accessorysprite_front2(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            var acc = species_accessorysprite(mySpecies, 0, u, cl);
            
            for (var i_ = 1; i_ <= acc; i_++)
                draw_sprite_ext(species_accessorysprite(mySpecies, i_, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (accessories == true)
                draw_sprite_ext(species_weaponsprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.speciesCerberus:
            var tailWag = 0;
            
            if (room == rmBattleTest)
            {
                if (global.activeTechnique == global.techniqueTailWag && global.activeGirl == girlIndex)
                    tailWag = obj_battlecontroller.tailAngle;
            }
            else if (inScene)
            {
                if (global.sceneIndex == 0)
                {
                    var _rad = (bobrads / 6.282) * room_speed;
                    
                    if (_rad <= (room_speed / 2))
                        tailWag = -40 + ease_in_out_quadratic(_rad, 0, 80, room_speed / 2);
                    else
                        tailWag = 40 - ease_in_out_quadratic(_rad - (room_speed / 2), 0, 80, room_speed / 2);
                }
                else
                {
                    if (!(global.sceneIndex == 193 || global.sceneIndex == 194))
                    {
                        if (myMood == 7 || myMood == 23 || myMood == 34)
                            actorEffrads[currentActor] += 1.5;
                        else if (myMood == 18)
                            actorEffrads[currentActor] += 2;
                        else if (myMood == 9 || myMood == 3 || myMood == 38)
                            actorEffrads[currentActor]++;
                        
                        if (actorEffrads[currentActor] > room_speed)
                            actorEffrads[currentActor] -= room_speed;
                    }
                    
                    var _rad = actorEffrads[currentActor];
                    
                    if (_rad == 0)
                        tailWag = 0;
                    else if (_rad <= (room_speed / 2))
                        tailWag = -40 + ease_in_out_quadratic(_rad, 0, 80, room_speed / 2);
                    else
                        tailWag = 40 - ease_in_out_quadratic(_rad - (room_speed / 2), 0, 80, room_speed / 2);
                }
            }
            
            draw_sprite_ext(spr_cerberus_tail, 0, xoff, yoff, xsc, ysc, gang + tailWag, col, alpha2);
            
            if (u == 4 && cl > 4)
            {
                draw_sprite_ext(spr_cerberus_pirate_capeback, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 5)
                    draw_sprite_ext(spr_cerberus_pirate_hatback, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            
            if (myMood == 21 || myMood == 35 || myMood == 1 || myMood == 7 || myMood == 18 || myMood == 10)
                draw_sprite_ext(spr_cerberus_hair_2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            else
                draw_sprite_ext(spr_cerberus_hair_1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (always_lewd || species_vag_is_exposed(cl))
                draw_sprite_ext(spr_cerberus_lewd, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (u == 4)
                draw_sprite_ext(spr_cerberus_pirate_eyepatch, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            var earstatus;
            
            if (myMood == 14 || myMood == 21 || myMood == 35 || myMood == 1 || myMood == 15 || myMood == 10 || myMood == 20)
            {
                draw_sprite_ext(spr_cerberus_hair_B2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                earstatus = 0;
            }
            else
            {
                draw_sprite_ext(spr_cerberus_hair_B1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                earstatus = 1;
            }
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if ((bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies) || (u == 1 && cl < 5 && cl > 1))
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if ((panties_are_exposed(cl, u, cummed_) || specialdrawundies) && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (u == 1)
            {
                if (cl < 2)
                {
                    draw_sprite_ext(spr_cerberus_collar_nude, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                }
                else
                {
                    if (cl > 2)
                    {
                        draw_sprite_ext(spr_cerberus_boots, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 3)
                        {
                            if (!bottomless)
                                draw_sprite_ext(spr_cerberus_pants, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 4)
                            {
                                draw_sprite_ext(spr_cerberus_shirt, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                                
                                if (cl > 5)
                                    draw_sprite_ext(spr_cerberus_jacket, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            }
                        }
                    }
                    
                    draw_sprite_ext(spr_cerberus_collar_clothed, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                }
            }
            else if (u == 4)
            {
                if (cl > 2)
                {
                    draw_sprite_ext(spr_cerberus_pirate_boots, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        if (!bottomless)
                            draw_sprite_ext(spr_cerberus_pirate_outfit, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                        {
                            draw_sprite_ext(spr_cerberus_pirate_capefront, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 5)
                                draw_sprite_ext(spr_cerberus_pirate_hatfront, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                }
            }
            else if (u == 6)
            {
                if (cl > 2)
                {
                    if (!bottomless)
                        draw_sprite_ext(spr_cerberus_xmas_pants, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        if (!bottomless)
                            draw_sprite_ext(spr_cerberus_xmas_shorts, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                        {
                            draw_sprite_ext(spr_cerberus_xmas_shirt, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 5)
                                draw_sprite_ext(spr_cerberus_xmas_vest, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                }
                
                if (earstatus == 0)
                    draw_sprite_ext(spr_cerberus_xmas_horn_earsdown, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                else
                    draw_sprite_ext(spr_cerberus_xmas_horn_earsup, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            else if (cl > 3)
            {
                draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            
            break;
        
        case global.speciesBalrog:
            if (global.sceneIndex == 503)
                u = global.girlOutfit[find_girl(global.speciesBalrog)];
            
            draw_sprite_ext(spr_balrog_hairback, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            var sign_ = 1;
            var bobradsB, walpha;
            
            if (room == rmBattleTest)
            {
                bobradsB = bobrads;
                
                if (global.activeGirl > girlIndex || global.activeTarget > girlIndex)
                    walpha = alpha2 * 0.5;
                else
                    walpha = alpha2;
            }
            else
            {
                bobradsB = -bobrads2;
                
                if (global.sceneIndex == 264)
                    walpha = alpha2 * 0.5;
                else
                    walpha = alpha2;
                
                if (room == rmVnTest)
                {
                    if (actorScaleX[currentActor] > 0)
                        sign_ = -1;
                }
            }
            
            draw_sprite_ext(spr_balrog_wings, 0, xoff + lengthdir_x(-40 * xsc, gang + 180) + lengthdir_x(297 * ysc, gang + 90), yoff + lengthdir_y(-40 * xsc, gang + 180) + lengthdir_y(297 * ysc, gang + 90), xsc, ysc, gang - (sin(bobradsB) * 20 * sign_), col, alpha2);
            
            if (room != rmTown)
                draw_sprite_ext(spr_balrog_wings, 1, xoff + lengthdir_x(-40 * xsc, gang + 180) + lengthdir_x(297 * ysc, gang + 90), yoff + lengthdir_y(-40 * xsc, gang + 180) + lengthdir_y(297 * ysc, gang + 90), xsc, ysc, gang + (sin(bobradsB) * 20 * sign_), col, walpha);
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            draw_sprite_ext(spr_balrog_crystal, 0, xoff, yoff + (sin(effrads) * 18), xsc, ysc, gang, col, alpha2);
            
            if (always_lewd || species_vag_is_exposed(cl))
                draw_sprite_ext(spr_balrog_lewd, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (u == 2)
            {
                draw_sprite_ext(spr_balrog_collar, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 2)
                    draw_sprite_ext(spr_balrog_shoe, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            draw_set_blend_mode(bm_add);
            
            if (myMood == 3)
                draw_sprite_ext(spr_balrog_face_glowlewd, 0, xoff, yoff, xsc, ysc, gang, col, sin(effrads2) * alpha2);
            else if (myMood == 38)
                draw_sprite_ext(spr_balrog_face_glowlewdside, 0, xoff, yoff, xsc, ysc, gang, col, sin(effrads2) * alpha2);
            else if (myMood == 19)
                draw_sprite_ext(spr_balrog_face_glowneutral, 0, xoff, yoff, xsc, ysc, gang, col, sin(effrads2) * alpha2);
            else if (myMood == 8)
                draw_sprite_ext(spr_balrog_face_glowvn, 0, xoff, yoff, xsc, ysc, gang, col, sin(effrads2) * alpha2);
            
            draw_set_blend_mode(bm_normal);
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies)
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if ((panties_are_exposed(cl, u, cummed_) || specialdrawundies) && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            draw_sprite_ext(spr_balrog_hair, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (u == 1 && cl > 2)
            {
                if (accessories)
                    draw_sprite_ext(spr_balrog_stockingflame, 0, xoff, yoff, xsc, ysc, gang, col, sin(effrads2) * clothesAlpha);
                
                draw_sprite_ext(spr_balrog_stockings, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            
            draw_sprite_ext(spr_balrog_tail, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (u == 1)
            {
                if (cl > 3)
                {
                    if (!bottomless)
                        draw_sprite_ext(spr_balrog_outfit, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 5)
                        draw_sprite_ext(spr_balrog_choker, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
                
                if (accessories)
                    draw_sprite_ext(spr_balrog_weapons, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                draw_sprite_ext(spr_balrog_earring, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            else if (u == 2)
            {
                if (cl > 2)
                {
                    draw_sprite_ext(spr_balrog_shoe, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        if (!bottomless)
                            draw_sprite_ext(spr_balrog_dress, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl == 6)
                            draw_sprite_ext(spr_balrog_crown, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    }
                }
                
                draw_sprite_ext(spr_balrog_earring2, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                draw_sprite_ext(spr_balrog_bracelet, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (accessories)
                {
                    if (cl > 3)
                        draw_sprite_ext(spr_balrog_weapons2, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    else
                        draw_sprite_ext(spr_balrog_weapons, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            else if (u == 3 && accessories)
            {
                draw_sprite_ext(spr_balrog_weapons, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            
            break;
        
        case global.speciesSeraph:
            xoff += 80;
            xoff_2 = 80;
            var walpha, weapontype;
            
            if (room == rmBattleTest)
            {
                if (girlIndex > 0)
                {
                    if (global.partyGirl[girlIndex] > -1)
                        weapontype = global.girlForm[global.partyGirl[girlIndex]];
                    else
                        weapontype = 1;
                }
                else
                {
                    weapontype = global.enemyForm[abs(girlIndex)];
                }
                
                effalpha = max(0, sin(effrads));
                
                if ((global.activeGirl > girlIndex || global.activeTarget > girlIndex) && girlIndex > 0)
                    walpha = alpha2 * 0.5;
                else
                    walpha = alpha2;
            }
            else
            {
                if (u == 2)
                    weapontype = 2;
                else
                    weapontype = 1;
                
                if (global.sceneIndex == 264)
                    walpha = alpha2 * 0.5;
                else
                    walpha = alpha2;
                
                if (global.sceneIndex != 0 && inScene)
                {
                    actorEffrads[currentActor] += 3.141 / room_speed;
                    
                    if (actorEffrads[currentActor] > 6.282)
                        actorEffrads[currentActor] -= 6.282;
                    
                    effalpha = max(0, sin(actorEffrads[currentActor]));
                }
                else
                {
                    effalpha = 0;
                }
            }
            
            var bras = 695;
            
            if (u == 4 && cl > 4)
                draw_sprite_ext(spr_seraph_nun_hoodback, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            draw_sprite_ext(spr_seraph_wingsback, 0, xoff, yoff, xsc, ysc, gang, col, walpha);
            
            if (u == 2)
            {
                if (accessories)
                    draw_sprite_ext(spr_seraph_shield, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (specialdrawundies && u != 3)
            {
                draw_sprite_ext(spr_seraph_panties, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                draw_sprite_ext(bras, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            if (u != 3)
            {
                if (cl > 0 && (u != 4 || cl < 4))
                {
                    if (!bottomless)
                    {
                        draw_sprite_ext(spr_seraph_panties, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                        
                        if (cl < 4)
                            draw_sprite_ext(spr_seraph_panties_eff, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * effalpha);
                    }
                    
                    if (cl > 1)
                    {
                        draw_sprite_ext(bras, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                        
                        if (cl < 5)
                            draw_sprite_ext(spr_seraph_bra_eff, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * effalpha);
                    }
                }
            }
            
            switch (u)
            {
                case 1:
                    draw_sprite_ext(spr_seraph_dress_anklet, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    draw_sprite_ext(spr_seraph_dress_anklet_eff, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * effalpha);
                    draw_sprite_ext(spr_seraph_dress_circlet, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    draw_sprite_ext(spr_seraph_dress_circlet_eff, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * effalpha);
                    
                    if (cl > 2)
                    {
                        draw_sprite_ext(spr_seraph_dress_shoes, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        draw_sprite_ext(spr_seraph_dress_shoes_eff, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha * effalpha);
                        
                        if (cl > 3)
                        {
                            if (!bottomless)
                            {
                                draw_sprite_ext(spr_seraph_dress_bottom, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                                draw_sprite_ext(spr_seraph_dress_bottom_eff, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha * effalpha);
                            }
                            
                            if (cl > 4)
                            {
                                draw_sprite_ext(spr_seraph_dress_top, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                                draw_sprite_ext(spr_seraph_dress_top_eff, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha * effalpha);
                            }
                        }
                    }
                    
                    draw_sprite_ext(spr_seraph_headwings, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    break;
                
                case 2:
                    draw_sprite_ext(spr_seraph_hair, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    
                    if (cl > 2)
                    {
                        if (!bottomless)
                        {
                            draw_sprite_ext(spr_seraph_armor_bottom, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            draw_sprite_ext(spr_seraph_armor_bottom_eff, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha * effalpha);
                        }
                        
                        if (cl > 4)
                        {
                            draw_sprite_ext(spr_seraph_armor_top, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            draw_sprite_ext(spr_seraph_armor_top_eff, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha * effalpha);
                            
                            if (cl > 5)
                            {
                                draw_sprite_ext(spr_seraph_armor_headgear, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                                draw_sprite_ext(spr_seraph_armor_headgear_eff, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha * effalpha);
                            }
                        }
                    }
                    
                    break;
                
                case 3:
                    if (cl > 0)
                    {
                        if (!bottomless)
                            draw_sprite_ext(spr_seraph_bikini_bottom, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 1)
                        {
                            draw_sprite_ext(spr_seraph_bikini_top, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 2)
                            {
                                draw_sprite_ext(spr_seraph_bikini_sarong_noacc, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                                
                                if (cl > 4)
                                    draw_sprite_ext(spr_seraph_bikini_scarf, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            }
                        }
                    }
                    
                    draw_sprite_ext(spr_seraph_headwings, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    break;
                
                case 4:
                    if (cl > 2)
                    {
                        if (!bottomless)
                            draw_sprite_ext(spr_seraph_nun_leggings, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 3 && !bottomless)
                            draw_sprite_ext(spr_seraph_nun_dress, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    }
                    
                    draw_sprite_ext(spr_seraph_hair, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    
                    if (cl > 4)
                        draw_sprite_ext(spr_seraph_nun_hoodfront, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    break;
                
                case 6:
                    if (cl > 2)
                    {
                        if (!bottomless)
                            draw_sprite_ext(spr_seraph_winter_legs, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                            draw_sprite_ext(spr_seraph_winter_sweater, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 3 && !bottomless)
                            draw_sprite_ext(spr_seraph_winter_skirt, cl <= 4, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    }
                    
                    draw_sprite_ext(spr_seraph_winter_muffs, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    break;
                
                case 7:
                    if (cl > 2)
                    {
                        draw_sprite_ext(spr_seraph_autumn_shoes, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 3)
                        {
                            if (!bottomless)
                                draw_sprite_ext(spr_seraph_autumn_bottom, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 4)
                                draw_sprite_ext(spr_seraph_autumn_top, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                    
                    break;
            }
            
            if (u != 2 && u != 4)
                draw_sprite_ext(spr_seraph_hair, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (accessories)
            {
                if (weapontype == 1)
                {
                    if (cl < 4 || u == 3 || u == 4)
                    {
                        draw_sprite_ext(spr_seraph_bow_nude, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    }
                    else if (u == 2)
                    {
                        draw_sprite_ext(spr_seraph_bow_armor, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    }
                    else if (u == 6)
                    {
                        if (room == rmBattleTest)
                            draw_sprite_ext(spr_seraph_bow_winter, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    }
                    else
                    {
                        draw_sprite_ext(spr_seraph_bow_dress, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    }
                    
                    if (u != 6)
                    {
                        if (cl < 4)
                            draw_sprite_ext(spr_seraph_arrow_nude, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                        else if (u == 2)
                            draw_sprite_ext(spr_seraph_arrow_armor, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                        else
                            draw_sprite_ext(spr_seraph_arrow_dress, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    }
                }
                else if ((u == 2 && cl > 2) || (u == 6 && cl > 3))
                {
                    if (u == 2 || room == rmBattleTest)
                    {
                        draw_sprite_ext(spr_seraph_sword_armor, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                        draw_sprite_ext(spr_seraph_sword_armor_eff, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * effalpha);
                    }
                }
                else if (cl < 4 || u == 3 || u == 4)
                {
                    draw_sprite_ext(spr_seraph_sword_nude, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    draw_sprite_ext(spr_seraph_sword_armor_eff, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * effalpha);
                }
                else
                {
                    draw_sprite_ext(spr_seraph_sword_dress, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    draw_sprite_ext(spr_seraph_sword_dress_eff, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * effalpha);
                }
            }
            
            draw_sprite_ext(spr_seraph_wingsfront, 0, xoff, yoff, xsc, ysc, gang, col, walpha);
            
            if (u == 7)
                draw_sprite_ext(spr_seraph_autumn_wreath, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            else if (u == 2)
                draw_sprite_ext(spr_seraph_halo2, 0, xoff, yoff + 20, xsc, ysc, gang, col, alpha2 * (effalpha + 0.4));
            else if (u != 6)
                draw_sprite_ext(spr_seraph_halo, 0, xoff, yoff + 20, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.speciesQuetzalcoatl:
            var sign_ = 1;
            var glow = 0;
            var flap = 36;
            var snekMouthsOpen = false;
            
            switch (myMood)
            {
                case 8:
                case 41:
                    glow = 851;
                    break;
                
                case 19:
                    glow = 852;
                    break;
                
                case 34:
                    glow = 853;
                    break;
                
                case 23:
                    glow = 854;
                    break;
                
                case 15:
                case 11:
                case 29:
                    glow = 855;
                    snekMouthsOpen = true;
                    break;
                
                case 36:
                case 33:
                    glow = 856;
                    snekMouthsOpen = true;
                    break;
                
                case 20:
                case 40:
                case 16:
                case 24:
                case 30:
                    glow = 857;
                    break;
                
                case 21:
                case 26:
                    glow = 858;
                    snekMouthsOpen = true;
                    break;
                
                case 35:
                case 45:
                    glow = 859;
                    snekMouthsOpen = true;
                    break;
                
                case 3:
                    glow = 860;
                    snekMouthsOpen = true;
                    break;
                
                case 38:
                    glow = 861;
                    snekMouthsOpen = true;
                    break;
            }
            
            var bobradsB, tailinmouth;
            
            if (room == rmBattleTest)
            {
                tailinmouth = false;
                snekMouthsOpen = myMood == 1 || girl_is_attacking(girlIndex);
                snekTongueRads = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                
                if (bobrads < 4.7115 && bobrads > 1.5705)
                {
                    bobradsB = -(((1 - ((sin(bobrads) + 1) / 1.924)) * 9.423) % 3.141);
                }
                else
                {
                    flap /= 4;
                    bobradsB = ((bobrads - 1.5705) / 3.141) * 21.987000000000002;
                }
                
                if (girlIndex > 0)
                    sign_ = -1;
            }
            else
            {
                tailinmouth = myMood == 8 || myMood == 19 || myMood == 2;
                
                if (myMood == 7 || myMood == 18 || myMood == 9 || myMood == 3 || myMood == 38)
                {
                    bobradsB = -(effrads2 * 10);
                    flap = 18;
                }
                else if (bobrads3 < 4.7115 && bobrads3 > 1.5705)
                {
                    bobradsB = -(((1 - ((sin(bobrads3) + 1) / 1.924)) * 9.423) % 3.141);
                }
                else
                {
                    flap /= 4;
                    bobradsB = ((bobrads3 - 1.5705) / 3.141) * 21.987000000000002;
                }
                
                if (room == rmVnTest && global.sceneIndex != 0)
                {
                    if ((actorScaleX[currentActor] * actorXScaleFactor[currentActor]) > 0)
                        sign_ = -1;
                }
                else if (room == rmTown)
                {
                    snekTongueRads = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                }
            }
            
            if (room != rmTown && !(room == rmVnTest && global.sceneIndex != 0))
            {
                if (global.sceneIndex == 0)
                    sign_ *= -1;
                
                draw_sprite_ext(spr_snek_hair_back, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                for (var j = 2; j <= 9; j++)
                {
                    snekTongueAlpha[j] = sin(snekTongueRads[j]);
                    
                    if (j < 7)
                        draw_sprite_ext(spr_snek_hair_back_heads, j - 2, xoff, yoff, xsc, ysc, gang, col, !snekMouthsOpen * alpha2);
                    
                    draw_sprite_ext(spr_snek_hair_back_mouths_open, j - 2, xoff, yoff, xsc, ysc, gang, col, snekMouthsOpen * alpha2);
                    draw_sprite_ext(spr_snek_hair_back_tongues, j - 2, xoff, yoff, xsc, ysc, gang, col, !snekMouthsOpen * snekTongueAlpha[j] * alpha2);
                }
            }
            
            draw_sprite_ext(spr_snek_tail_back, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            draw_sprite_ext(spr_snek_wing_left, 0, xoff + lengthdir_x(71 * xsc, gang) + lengthdir_x(627 * ysc, gang + 90), yoff + lengthdir_y(71 * xsc, gang) + lengthdir_y(627 * ysc, gang + 90), xsc, ysc, gang - (sin(bobradsB) * flap * -sign_), col, alpha2);
            draw_sprite_ext(spr_snek_wing_right, 0, xoff + lengthdir_x(71 * xsc, gang) + lengthdir_x(627 * ysc, gang + 90), yoff + lengthdir_y(71 * xsc, gang) + lengthdir_y(627 * ysc, gang + 90), xsc * 0.9, ysc, gang + (sin(bobradsB) * flap * -sign_), col, alpha2);
            
            if (!tailinmouth)
                draw_sprite_ext(spr_snek_tail_tip1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (species_breasts_are_exposed(mySpecies, u, cl))
                draw_sprite_ext(spr_snek_nips, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (cl > 0)
            {
                if (u == 3)
                {
                    if (!bottomless)
                        draw_sprite_ext(spr_snek_swimsuit_bottom, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 1)
                        draw_sprite_ext(spr_snek_swimsuit_top, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
                else if (!bottomless && !(u == 2 && cl > 3 && !specialdrawundies))
                {
                    draw_sprite_ext(spr_snek_underwear, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            draw_sprite_ext(spr_snek_tail_front, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (glow > 0)
            {
                draw_set_blend_mode(bm_add);
                draw_sprite_ext(glow, 0, xoff, yoff, xsc, ysc, gang, col, sin(effrads2) * alpha2 * al_);
                draw_set_blend_mode(bm_normal);
            }
            
            if (cl > 3)
            {
                if (u == 1)
                {
                    if (cl > 4 && !bottomless)
                        draw_sprite_ext(spr_snek_dress_full, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    else
                        draw_sprite_ext(spr_snek_dress_base, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
                else if (u == 2)
                {
                    draw_sprite_ext(spr_snek_tshirt, xsc > 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
                else if (u == 4 && !bottomless)
                {
                    draw_sprite_ext(spr_snek_jiangshi_dress, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
                else if (u == 6)
                {
                    draw_sprite_ext(spr_snek_xmas_coat, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 4)
                        draw_sprite_ext(spr_snek_xmas_scarf, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            if (u == 1 || cl < 4)
            {
                draw_sprite_ext(spr_snek_hair_front_naked, cl > 3, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            else if (u == 6 && cl == 6)
            {
                draw_sprite_ext(spr_snek_xmas_hair, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                draw_sprite_ext(spr_snek_xmas_hat, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            else
            {
                draw_sprite_ext(spr_snek_hair_front_clothed, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            snekTongueAlpha[0] = sin(snekTongueRads[0]);
            snekTongueAlpha[1] = sin(snekTongueRads[1]);
            draw_sprite_ext(spr_snek_hair_front_tongues, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * snekTongueAlpha[0]);
            draw_sprite_ext(spr_snek_hair_front_tongues, 1, xoff, yoff, xsc, ysc, gang, col, alpha2 * snekTongueAlpha[1]);
            draw_sprite_ext(spr_snek_hair_front_mouth_open, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * snekMouthsOpen);
            
            if (tailinmouth && u != 6)
            {
                if (u == 4)
                    draw_sprite_ext(spr_snek_jiangshi_tail, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                else
                    draw_sprite_ext(spr_snek_tail_tip2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            if (u == 4 && cl > 4)
                draw_sprite_ext(spr_snek_jiangshi_hat, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            if (u == 6)
                draw_sprite_ext(spr_snek_xmas_sneks, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.speciesMinotaur:
            var poppyX = xoff - (220 * xsc);
            var poppyY = yoff + (220 * ysc);
            
            if (room == rmBattleTest)
            {
                effalpha = abs(sin(effrads));
            }
            else if (inScene)
            {
                actorEffrads[currentActor] += 3.141 / room_speed;
                
                if (actorEffrads[currentActor] > 6.282)
                    actorEffrads[currentActor] -= 6.282;
                
                effalpha = abs(sin(actorEffrads[currentActor]));
            }
            else
            {
                effalpha = 1;
            }
            
            accessories = true;
            var drawPoppy = global.scriptedBattleIndex == 48 || global.sceneIndex == 457 || (global.sceneIndex == 0 && room == rmVnTest);
            var poppyscale = 0.5;
            var poppyx = -140;
            var poppyy = 80;
            
            if (room == rmBattleTest)
            {
                poppyx -= (global.girlXadd[girlIndex] - dodgeX);
                
                if (global.battlePhase == global.phaseAttack && global.activeGirl == girlIndex && global.activeTechnique == global.techniqueHug)
                    poppyx -= (global.girlXadd[girlIndex] / 2);
                
                poppyy -= global.girlYadd[girlIndex];
                
                if (global.activeGirl == girlIndex && global.battlePhase == 3)
                    poppyy += (global.battleSelectionHop * 60);
            }
            
            var poppyArm;
            
            if (drawPoppy)
            {
                cl = global.clothesMax;
                
                if (keepsake_active(global.itemLens))
                    keepsake_deactivate(global.itemLens);
                
                if (room == rmBattleTest)
                    poppyArm = 1 + (global.battlePhase == global.phaseAttack && global.activeGirl == girlIndex && global.activeTechnique != global.techniqueHug);
                else
                    poppyArm = 1;
                
                if (poppyArm == 1)
                    draw_sprite_ext(spr_minotaur_poppy_back_arm1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                draw_sprite_ext(spr_minotaur_poppy_back, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            if (u == 1 && cl == global.clothesMax && !bottomless)
                draw_sprite_ext(spr_minotaur_outfit1_back, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (cl < 2)
                draw_sprite_ext(spr_minotaur_nipple, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (u != 3)
            {
                if ((cl < 5 && cl > 1) || specialdrawundies)
                    draw_sprite_ext(spr_minotaur_bra, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                
                if ((cl < 4 && cl > 0 && !bottomless) || specialdrawundies)
                    draw_sprite_ext(spr_minotaur_underwear, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            }
            
            if (u == 1)
            {
                if (cl > 2)
                {
                    if (cl > 3)
                    {
                        if (!bottomless)
                            draw_sprite_ext(spr_minotaur_outfit1_bottom, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                        {
                            draw_sprite_ext(spr_minotaur_outfit1_toponly, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 5)
                                draw_sprite_ext(spr_minotaur_outfit1_mantle, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                    
                    draw_sprite_ext(spr_minotaur_outfit1_gloves, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
                
                draw_sprite_ext(spr_minotaur_outfit1_necklace, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            else if (u == 2)
            {
                if (cl > 2)
                {
                    draw_sprite_ext(spr_minotaur_outfit2_gloves, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    draw_sprite_ext(spr_minotaur_outfit2_gloves, 1, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        if (!bottomless)
                            draw_sprite_ext(spr_minotaur_outfit2_bottom, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                            draw_sprite_ext(spr_minotaur_outfit2_toponly, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    }
                }
            }
            else if (u == 3)
            {
                if (cl > 0 && !bottomless)
                    draw_sprite_ext(spr_minotaur_swimsuit_bottom, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 1)
                    draw_sprite_ext(spr_minotaur_swimsuit_top, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            draw_sprite_ext(spr_minotaur_hair, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (myMood == 21 || myMood == 35 || myMood == 4 || myMood == 12 || myMood == 26 || myMood == 3 || myMood == 38)
                draw_sprite_ext(spr_minotaur_breath, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * effalpha);
            
            if (u == 1 || u == 3)
                draw_sprite_ext(spr_minotaur_hammer, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            else if (u == 2)
                draw_sprite_ext(spr_minotaur_hammer, 1, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            if (drawPoppy)
            {
                var poppyMood;
                
                if (instance_exists(obj_vncontroller) && room == rmBattleTest)
                    poppyMood = obj_vncontroller.sceneBattleGirlMood[obj_vncontroller.lineIndex][2];
                else
                    poppyMood = myMood;
                
                draw_sprite_ext(spr_minotaur_poppy_front, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                var poppyface;
                
                if (poppyArm == 2)
                {
                    poppyface = 0;
                }
                else
                {
                    switch (poppyMood)
                    {
                        case 26:
                        case 4:
                            poppyface = 0;
                            break;
                        
                        case 21:
                        case 35:
                        case 10:
                        case 12:
                        case 20:
                            poppyface = 1;
                            break;
                        
                        case 19:
                        case 36:
                        case 33:
                            poppyface = 5;
                            break;
                        
                        case 7:
                        case 18:
                        case 9:
                            poppyface = 3;
                            break;
                        
                        case 14:
                        case 1:
                        case 40:
                        case 15:
                        case 29:
                            poppyface = 4;
                            break;
                        
                        case 2:
                        case 6:
                            poppyface = 6;
                            break;
                        
                        default:
                            poppyface = 2;
                            break;
                    }
                }
                
                draw_sprite_ext(spr_minotaur_poppy_faces, poppyface, xoff, yoff, xsc, ysc, gang, col, alpha2);
                draw_sprite_ext(spr_minotaur_poppy_hair, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                draw_sprite_ext(spr_minotaur_poppy_arm, poppyArm - 1, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            break;
        
        case global.speciesRobot:
            if (global.sceneIndex == 50 && global.TEMP_FLAG[103] == 1)
            {
                if (global.settingFancy)
                    surface_reset_target();
                
                return -1;
            }
            
            if (global.sceneIndex == 176 && room == rmVnTest && specialscene == 1)
                u = 5;
            
            if (!accessories && u != 5)
                accessories = true;
            
            if (room == rmBattleTest && (myMood == 19 || myMood == 2) && !instance_exists(obj_vncontroller))
            {
                if (global.scriptedBattleIndex == 54)
                    myMood = 21;
                else if (global.scriptedBattleIndex == 55)
                    myMood = 26;
                else if (global.battlePhase == global.phaseAttack && global.activeGirl == girlIndex && technique_category(global.activeTechnique) == 1)
                    myMood = 35;
            }
            else if (((global.sceneIndex == 565 && lineIndex > 13) || global.sceneIndex == 50 || global.sceneIndex == 591 || global.sceneIndex == 601 || global.sceneIndex == 705) && room == rmVnTest)
            {
                u = 1;
            }
            
            if (u == 4)
                draw_sprite_ext(spr_robot_idol_back, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (u != 5 || !accessories)
            {
                if (!accessories || u == 3 || u == 5)
                    draw_sprite_ext(spr_robot_righthand, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                else if (u == 4)
                    draw_sprite_ext(spr_robot_righthand, 2, xoff, yoff, xsc, ysc, gang, col, alpha2);
                else
                    draw_sprite_ext(spr_robot_righthand, 1, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                draw_sprite_ext(spr_robot_lefthand, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            draw_sprite_ext(spr_robot_base, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (bra_is_exposed(cl, u, undiesAlpha) || (u == 1 && cl < 5 && cl > 1))
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (panties_are_exposed(cl, u, cummed_) && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (u == 1)
            {
                draw_sprite_ext(spr_robot_maid_ears, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (accessories && !(global.sceneIndex == 549 && lineIndex >= 70))
                    draw_sprite_ext(spr_robot_maid_duster, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (cl > 2)
                {
                    if (!bottomless)
                        draw_sprite_ext(spr_robot_leggings, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    draw_sprite_ext(spr_robot_maid_shoes, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 4)
                        draw_sprite_ext(spr_robot_maid_arm_back, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        draw_sprite_ext(spr_robot_maid_dress, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                            draw_sprite_ext(spr_robot_maid_arm_front, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    }
                }
            }
            else if (u == 2)
            {
                draw_sprite_ext(spr_robot_miko_headdress, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (accessories)
                    draw_sprite_ext(spr_robot_miko_gohei, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (cl > 2)
                {
                    draw_sprite_ext(spr_robot_miko_shoes, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        draw_sprite_ext(spr_robot_miko_armor, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                            draw_sprite_ext(spr_robot_miko_arms, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    }
                }
            }
            else if (u == 3)
            {
                if (cl > 0)
                    draw_sprite_ext(spr_robot_swimsuit, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 3)
                    draw_sprite_ext(spr_robot_swimsuit_swimmie, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            else if (u == 4)
            {
                draw_sprite_ext(spr_robot_idol_ears, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (accessories)
                    draw_sprite_ext(spr_robot_idol_mic, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (cl > 2)
                {
                    draw_sprite_ext(spr_robot_idol_shoes, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        draw_sprite_ext(spr_robot_idol_dress, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                        {
                            draw_sprite_ext(spr_robot_idol_skirt, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 5)
                                draw_sprite_ext(spr_robot_idol_arms, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                }
            }
            else if (u == 5)
            {
                if (accessories)
                {
                    draw_sprite_ext(spr_robot_samurai_arm_back, 1, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    draw_sprite_ext(spr_robot_samurai_sword_back, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                }
                
                if (cl > 2)
                {
                    draw_sprite_ext(spr_robot_samurai_shoes, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        draw_sprite_ext(spr_robot_samurai_arm_back, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        draw_sprite_ext(spr_robot_samurai_armor, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        draw_sprite_ext(spr_robot_samurai_arm_front, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                        {
                            draw_sprite_ext(spr_robot_samurai_skirt, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 5)
                                draw_sprite_ext(spr_robot_samurai_helmet, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                }
                
                if (accessories)
                {
                    draw_sprite_ext(spr_robot_samurai_arm_front, 1, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    draw_sprite_ext(spr_robot_samurai_sword_front, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                }
            }
            else if (u == 6)
            {
                if (cl > 4)
                    draw_sprite_ext(spr_robot_xmas_backarm, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (accessories)
                    draw_sprite_ext(spr_robot_xmas_rpg, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 2)
                {
                    draw_sprite_ext(spr_robot_xmas_shoes, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        draw_sprite_ext(spr_robot_xmas_dress, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                        {
                            draw_sprite_ext(spr_robot_xmas_armfront, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 4)
                                draw_sprite_ext(spr_robot_xmas_hat, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                }
            }
            
            break;
        
        case global.speciesLich:
            ha = 1;
            var rippleShader = global.settingFancy && shader_current() != 0;
            
            if (global.sceneIndex == 999)
            {
                if (lineIndex > 48)
                {
                    u = 3;
                }
                else if (lineIndex > 24)
                {
                    u = 2;
                    ha = 2;
                }
                else
                {
                    u = 1;
                }
            }
            
            var bobAddY;
            
            if (inScene)
            {
                actorEffrads[currentActor] += 0.28269 / room_speed;
                
                if (actorEffrads[currentActor] > 6.282)
                    actorEffrads[currentActor] -= 6.282;
                
                effrads = actorEffrads[currentActor];
                actorEffrads2[currentActor] += 0.34551 / room_speed;
                
                if (actorEffrads2[currentActor] > 6.282)
                    actorEffrads2[currentActor] -= 6.282;
                
                effrads2 = actorEffrads2[currentActor];
                bobAddY = species_yadd4(global.speciesLich);
            }
            else if (!inBattle)
            {
                effrads = 0;
                effrads2 = 0;
                bobAddY = species_yadd4(global.speciesLich);
            }
            else
            {
                bobAddY = bobY + 100;
                
                if (girl_has_condition(real_girl(girlIndex), 26))
                {
                    ha = 2;
                    myMood = 25;
                }
                else if (global.activeGirl == girlIndex && global.battlePhase == global.phaseAttack)
                {
                    if (technique_category(global.activeTechnique) == 1 && technique_element(global.activeTechnique) == 18)
                        myMood = 35;
                    else if (technique_category(global.activeTechnique) == 3)
                        myMood = 38;
                }
            }
            
            var bloodcol = merge_color(c_white, c_red, max(0, sin(((current_time % 4000) / 4000) * 3.141 * 2)));
            var bloodalp = 0.8 + (0.2 * sin(((current_time % 4000) / 4000) * 3.141 * 2));
            bobAddY -= species_hover_y(global.speciesLich);
            var drawBlood;
            
            if (inBattle || global.sceneIndex == 583 || (0 && keyboard_check(vk_alt)))
                drawBlood = true;
            else
                drawBlood = false;
            
            if (drawBlood)
            {
                if (rippleShader)
                {
                    shader_set(shader_ripple2);
                    shader_set_uniform_f(global.uniSize2, 1951, 2546);
                    shader_set_uniform_f(global.uniWave2, 220 * global.wigglefactor, 8 * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime2, current_time / 6000);
                }
                
                draw_sprite_ext(spr_lich_blood_back, 0, xoff, yoff - bobAddY, xsc, ysc, gang, bloodcol, bloodalp);
                
                if (rippleShader)
                {
                    shader_set_uniform_f(global.uniWave2, 400, 15);
                    shader_set_uniform_f(global.uniTime2, current_time / 12000);
                }
                
                draw_sprite_ext(spr_lich_pages_back, 0, xoff, yoff - bobAddY, xsc, ysc, gang, col, alpha2);
                
                if (rippleShader)
                    shader_reset();
            }
            
            if (ha == 2)
            {
                if (rippleShader)
                {
                    shader_set(shader_ripple);
                    shader_set_uniform_f(global.uniSize, 1951, 2546);
                    shader_set_uniform_f(global.uniWave, 200 * global.wigglefactor, 4 * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime, current_time / 5500);
                }
                
                draw_sprite_ext(spr_lich_hair_back_2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (rippleShader)
                    shader_reset();
            }
            else
            {
                draw_sprite_ext(spr_lich_hair_back, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            if (u == 1 && cl >= (global.clothesMax - 1))
            {
                if (rippleShader)
                {
                    shader_set(shader_ripple);
                    shader_set_uniform_f(global.uniSize, 1951, 2546);
                    shader_set_uniform_f(global.uniWave, 200 * global.wigglefactor, 5 * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime, current_time / 5000);
                }
                
                draw_sprite_ext(spr_lich_cape_1, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (rippleShader)
                    shader_reset();
            }
            else if (u == 2 && cl >= 4)
            {
                if (rippleShader)
                {
                    shader_set(shader_ripple);
                    shader_set_uniform_f(global.uniSize, 1951, 2546);
                    shader_set_uniform_f(global.uniWave, 200 * global.wigglefactor, 5 * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime, current_time / 5000);
                }
                
                draw_sprite_ext(spr_lich_cape_2, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (rippleShader)
                    shader_reset();
            }
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            draw_sprite_ext(spr_lich_lewd, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (bra_is_exposed(cl, u, undiesAlpha) || specialdrawundies)
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if ((panties_are_exposed(cl, u, cummed_) && !bottomless) || specialdrawundies)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (u == 1)
            {
                draw_sprite_ext(spr_lich_accessories_1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (cl >= (global.clothesMax - 1))
                {
                    draw_sprite_ext(spr_lich_dress_1_cape, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    draw_sprite_ext(spr_lich_accessory_1_cape, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    draw_sprite_ext(spr_lich_cape_1_front, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (rippleShader)
                    {
                        shader_set(shader_ripple);
                        shader_set_uniform_f(global.uniSize, 1951, 2546);
                        shader_set_uniform_f(global.uniWave, 200 * global.wigglefactor, 5 * global.wigglefactor);
                        shader_set_uniform_f(global.uniTime, current_time / 5000);
                    }
                    
                    draw_sprite_ext(spr_lich_cape_1_front, 1, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (rippleShader)
                        shader_reset();
                }
                else if (cl > 3)
                {
                    draw_sprite_ext(spr_lich_dress_1_nocape, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            else if (u == 2)
            {
                draw_sprite_ext(spr_lich_accessories_2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (cl > 3)
                    draw_sprite_ext(spr_lich_dress_2, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            
            if (ha == 2)
            {
                if (rippleShader)
                {
                    shader_set(shader_ripple);
                    shader_set_uniform_f(global.uniWave, 200 * global.wigglefactor, 2 * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime, current_time / 5500);
                }
                
                draw_sprite_ext(spr_lich_hair_2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (rippleShader)
                    shader_reset();
            }
            else
            {
                draw_sprite_ext(spr_lich_hair_1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            if (u == 1 && cl == global.clothesMax)
            {
                if (ha == 1)
                    draw_sprite_ext(spr_lich_hat_1, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                else
                    draw_sprite_ext(spr_lich_hat_2, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            }
            
            if (ha == 1)
                draw_sprite_ext(spr_lich_headdress_1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            else
                draw_sprite_ext(spr_lich_headdress_2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (room != rmTown)
            {
                var tomex = xoff + lengthdir_x(475 * xsc, gang) + lengthdir_x((1150 + (sin(effrads * 5) * 15)) * ysc, gang + 90);
                var tomey = yoff + lengthdir_y(475 * xsc, gang) + lengthdir_y((1150 + (sin(effrads * 5) * 15)) * ysc, gang + 90);
                
                if (!(global.sceneIndex == 218 && room == rmVnTest))
                {
                    if (!part_system_exists(global.sysGrimoire))
                    {
                        global.sysGrimoire = part_system_create();
                        part_system_automatic_draw(global.sysGrimoire, false);
                    }
                    
                    if (per_second(3))
                        part_particles_create(global.sysGrimoire, (tomex - 50) + irandom(100), (tomey - 20) + irandom(20), global.pt_blooddrop, 1);
                    
                    part_system_drawit(global.sysGrimoire);
                }
                
                draw_sprite_ext(spr_lich_tome, 0, tomex, tomey, xsc, ysc, gang + (sin(effrads * 2) * 7), col, alpha2);
            }
            
            if (drawBlood)
            {
                if (rippleShader)
                {
                    shader_set(shader_ripple2);
                    shader_set_uniform_f(global.uniWave2, 220 * global.wigglefactor, 8 * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime2, current_time / 6000);
                }
                
                draw_sprite_ext(spr_lich_blood_front, 0, xoff, yoff - bobAddY, xsc, ysc, gang, bloodcol, bloodalp);
                draw_sprite_ext(spr_lich_skull, 0, xoff + lengthdir_x(-422 * xsc, gang) + lengthdir_x((1110 + (sin(effrads2 * 5) * 24)) * ysc, gang + 90), yoff + lengthdir_y(-422 * xsc, gang) + lengthdir_y((1110 + (sin(effrads2 * 5) * 24)) * ysc, gang + 90), xsc, ysc, gang + (sin(effrads2 * 3) * 8), bloodcol, alpha2 * 0.85);
                
                if (rippleShader)
                {
                    shader_set_uniform_f(global.uniWave2, 400 * global.wigglefactor, 15 * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime2, current_time / 12000);
                }
                
                draw_sprite_ext(spr_lich_pages_front, 0, xoff, yoff - bobAddY, xsc, ysc, gang, col, alpha2);
                
                if (rippleShader)
                    shader_reset();
            }
            
            if (rippleShader)
                shaders_reset();
            
            break;
        
        case global.speciesDullahan:
            var pump = on_date() && global.environment == 14 && room != rmTown && !storytime;
            var skipback = false;
            
            for (var _j = 0; _j <= 7; _j++)
            {
                armAlp[_j] = 1;
                armScl[_j] = 1;
            }
            
            if (room == rmBattleTest)
            {
                u = 1;
            }
            else
            {
                if (u == 1)
                    u = 2;
                
                accessories = false;
            }
            
            if (object_index == obj_vncontroller)
            {
                if (global.sceneIndex == 629)
                {
                    if (lineIndex < 5)
                    {
                        u = 1;
                        accessories = true;
                    }
                }
                else if (global.sceneIndex == 633)
                {
                    if (lineIndex >= armorline)
                    {
                        u = 1;
                        accessories = true;
                    }
                }
                else if (global.sceneIndex == 639)
                {
                    if (lineIndex <= armorendline)
                    {
                        u = 1;
                        accessories = true;
                    }
                }
                else if (global.sceneIndex == 640)
                {
                    var sil;
                    
                    if (lineIndex < 14)
                        sil = 1;
                    else if (lineIndex == 14)
                        sil = max(1 - (sceneLineTimer / room_speed), 0);
                    else
                        sil = 0;
                    
                    if (sil > 0)
                        col = merge_color(c_white, c_black, sil);
                }
                else if (global.sceneIndex == 623)
                {
                    u = 1;
                    
                    if (lineIndex < 100)
                        skipback = true;
                    
                    accessories = true;
                    var _l = lineIndex - armorSnapStartLine;
                    
                    if (_l >= -2)
                        u = 1;
                    else
                        u = 2;
                    
                    for (var _j = 0; _j <= 7; _j++)
                    {
                        if (_j < _l)
                        {
                            armAlp[_j] = 1;
                            armScl[_j] = 1;
                        }
                        else if (_j > _l)
                        {
                            armAlp[_j] = 0;
                            armScl[_j] = 1;
                        }
                        else
                        {
                            armAlp[_j] = sceneLineTimer / (sceneAutoEndTime[lineIndex] * room_speed);
                            armScl[_j] = 8 - (armAlp[_j] * 7);
                        }
                    }
                }
            }
            
            var lastMood;
            
            if (room == rmVnTest)
                lastMood = actorLastMood[currentActor];
            else
                lastMood = myMood;
            
            var rippleShader = global.settingFancy && shader_current() != 0;
            
            if (accessories)
            {
                if (rippleShader)
                {
                    shader_set_uniform_f(global.uniSize, 1815, 2480);
                    shader_set_uniform_f(global.uniSize2, 1815, 2480);
                }
                
                var scyA = armAlp[7];
                
                if (rippleShader)
                {
                    shader_set(shader_ripple);
                    shader_set_uniform_f(global.uniWave, 400 * (0.5 + (scyA / 2)) * global.wigglefactor, 12 * scyA * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime, current_time / 7000);
                }
                
                draw_sprite_ext(spr_dullahan_scythe, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (0.75 + (undulate(3) * 0.1)) * scyA);
                
                if (rippleShader)
                {
                    shader_set_uniform_f(global.uniTime, current_time / 6000);
                    shader_set_uniform_f(global.uniWave, 350 * (0.5 + (scyA / 2)) * global.wigglefactor, 17 * scyA * global.wigglefactor);
                }
                
                draw_sprite_ext(spr_dullahan_scythe, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * 0.55 * scyA);
                
                if (rippleShader)
                    shader_reset();
            }
            
            if (u == 1 && !skipback)
            {
                if (cl > 3)
                {
                    draw_sprite_ext(spr_dullahan_armor_back, 1, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 4)
                        draw_sprite_ext(spr_dullahan_armor_back, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            if ((u == 1 && cl <= 3) || (u == 2 && cl != 4) || u == 3)
                draw_d_head(xoff, yoff, xsc, ysc, gang, col, alpha2, lastface, mySpecies, lastMood, u, ey, al_, myMood);
            
            if (pump)
                draw_sprite_ext(spr_dullahan_base_nohead, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            else
                draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            draw_girl_serum(mySpecies, xoff, yoff, xsc, ysc, gang, col, alpha2, cum);
            
            if (cl > 1 && u != 3)
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (cl > 0 && u != 3 && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (pump)
            {
                draw_sprite_ext(spr_dullahan_boots, 0, xoff, yoff, xsc, ysc, 0, col, clothesAlpha);
                draw_sprite_ext(spr_dullahan_skirt, 0, xoff, yoff, xsc, ysc, 0, col, clothesAlpha);
                draw_sprite_ext(spr_dullahan_jacket_nohead, 0, xoff, yoff, xsc, ysc, 0, col, clothesAlpha);
            }
            else
            {
                switch (u)
                {
                    case 1:
                        if (cl > 2)
                        {
                            if (armAlp[1] != 1)
                            {
                                draw_sprite_ext(spr_dullahan_armor_boots, 1, xoff, yoff, xsc * armScl[0], ysc * armScl[0], gang, col, clothesAlpha * armAlp[0]);
                                draw_sprite_ext(spr_dullahan_armor_boots, 2, xoff, yoff, xsc * armScl[1], ysc * armScl[1], gang, col, clothesAlpha * armAlp[1]);
                            }
                            else
                            {
                                draw_sprite_ext(spr_dullahan_armor_boots, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            }
                            
                            if (cl > 3)
                            {
                                if (cl > 5)
                                    draw_sprite_ext(spr_dullahan_armor_backarm, 0, xoff, yoff, xsc * armScl[5], ysc * armScl[5], gang, col, clothesAlpha * armAlp[5]);
                                
                                draw_sprite_ext(spr_dullahan_armor_upper, 0, xoff, yoff, xsc * armScl[2], ysc * armScl[2], gang, col, clothesAlpha * armAlp[2]);
                                
                                if (cl > 4)
                                {
                                    draw_sprite_ext(spr_dullahan_armor_lower, 2, xoff, yoff, xsc * armScl[4], ysc * armScl[4], gang, col, clothesAlpha * armAlp[4]);
                                    draw_sprite_ext(spr_dullahan_armor_lower, 1, xoff, yoff, xsc * armScl[3], ysc * armScl[3], gang, col, clothesAlpha * armAlp[3]);
                                }
                                
                                draw_d_head(xoff, yoff, xsc, ysc, gang, col, alpha2, lastface, mySpecies, lastMood, u, ey, al_, myMood);
                                
                                if (cl > 5)
                                    draw_sprite_ext(spr_dullahan_armor_frontarm, 0, xoff, yoff, xsc * armScl[6], ysc * armScl[6], gang, col, clothesAlpha * armAlp[6]);
                                else
                                    draw_sprite_ext(spr_dullahan_arm, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            }
                        }
                        
                        if (rippleShader)
                        {
                            shader_set(shader_ripple2);
                            shader_set_uniform_f(global.uniWave, 200 * global.wigglefactor, 4 * global.wigglefactor);
                            shader_set_uniform_f(global.uniTime, current_time / 12000);
                        }
                        
                        draw_sprite_ext(spr_dullahan_mask, 1, xoff, yoff, xsc * armScl[7], ysc * armScl[7], gang, col, clothesAlpha * 0.9 * armAlp[7]);
                        
                        if (rippleShader)
                            shader_reset();
                        
                        draw_sprite_ext(spr_dullahan_mask, 0, xoff, yoff, xsc * armScl[7], ysc * armScl[7], gang, col, clothesAlpha * armAlp[7]);
                        break;
                    
                    case 2:
                        if (cl > 2)
                        {
                            draw_sprite_ext(spr_dullahan_boots, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 3)
                            {
                                draw_sprite_ext(spr_dullahan_skirt, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                                draw_d_head(xoff, yoff, xsc, ysc, gang, col, alpha2, lastface, mySpecies, lastMood, u, ey, al_, myMood);
                                
                                if (cl > 4)
                                    draw_sprite_ext(spr_dullahan_jacket, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                                else
                                    draw_sprite_ext(spr_dullahan_arm, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            }
                        }
                        
                        break;
                    
                    case 3:
                        if (cl > 0)
                        {
                            draw_sprite_ext(spr_dullahan_swimsuit, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 3)
                                draw_sprite_ext(spr_dullahan_swimsuit_jacket, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                        
                        break;
                    
                    case 4:
                        if (cl > 2)
                        {
                            if (cl > 5)
                            {
                                if (rippleShader)
                                {
                                    shader_set(shader_ripple);
                                    shader_set_uniform_f(global.uniWave, 210 * global.wigglefactor, 4 * global.wigglefactor);
                                    shader_set_uniform_f(global.uniTime, current_time / 5100);
                                }
                                
                                draw_sprite_ext(spr_dullahan_halloween_cloak, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                                
                                if (rippleShader)
                                    shader_reset();
                            }
                            
                            if (cl > 3)
                                draw_sprite_ext(spr_dullahan_halloween_jacket, 1, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            draw_sprite_ext(spr_dullahan_halloween_pants, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 3)
                            {
                                draw_sprite_ext(spr_dullahan_halloween_jacket, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                                
                                if (cl > 5)
                                    draw_sprite_ext(spr_dullahan_halloween_cloak, 1, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            }
                        }
                        
                        draw_d_head(xoff, yoff, xsc, ysc, gang, col, alpha2, lastface, mySpecies, lastMood, u, ey, al_, myMood);
                        break;
                }
            }
            
            if (!pump)
            {
                if (rippleShader)
                {
                    shader_set(shader_ripple);
                    shader_set_uniform_f(global.uniWave, 150 * global.wigglefactor, 6 * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime, current_time / 7100);
                }
                
                draw_sprite_ext(spr_dullahan_smoke2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * 0.6);
                
                if (rippleShader)
                    shader_reset();
                
                draw_sprite_ext(spr_dullahan_smoke, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (rippleShader)
                {
                    shader_set(shader_ripple);
                    shader_set_uniform_f(global.uniWave, 200 * global.wigglefactor, 3 * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime, current_time / 6500);
                }
            }
            else
            {
                draw_sprite_ext(spr_dullahan_pumpkin, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            if (pump)
                draw_sprite_ext(spr_dullahan_pumpkin_smoke, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (0.6 + (undulate(4) * 0.4)));
            else
                draw_sprite_ext(spr_dullahan_smoke2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (0.75 + (undulate(3) * 0.1)));
            
            if (rippleShader)
                shader_reset();
            
            break;
        
        case global.speciesStarchild:
            var rippleShader = global.settingFancy && shader_current() != 0;
            extraY = undulate(6) * 30 * ysc;
            
            if (room == rmBattleTest)
                draw_girl_back(xoff, yoff, global.speciesStarchild, xsc, ysc, alpha2, myMood);
            
            if (u == 1)
            {
                if (rippleShader)
                {
                    shader_set(shader_ripple);
                    shader_set_uniform_f(global.uniWave, 160 * global.wigglefactor, 8 * global.wigglefactor);
                    shader_set_uniform_f(global.uniTime, current_time / 7000);
                }
                
                draw_sprite_ext(spr_starchild_hairback1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (rippleShader)
                    shader_reset();
                
                if (cl > 4)
                    draw_sprite_ext(spr_starchild_cape1, 0, xoff + lengthdir_x(27 * xsc, gang) + lengthdir_x(1300 * ysc, gang + 90), yoff + lengthdir_y(27 * xsc, gang) + lengthdir_y(1300 * ysc, gang + 90), xsc * (0.95 + (undulate(6.5) * 0.05)), ysc * (0.98 - (undulate(6.5) * 0.02)), gang, col, alpha2);
                
                if (!accessories)
                    draw_sprite_ext(spr_starchild_armB, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                else
                    draw_sprite_ext(spr_starchild_arm, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (cl > 5)
                {
                    if (!accessories)
                        draw_sprite_ext(spr_starchild_glove1B, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    else
                        draw_sprite_ext(spr_starchild_glove1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                }
                
                draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (specialdrawundies || cl < 4)
                    draw_sprite_ext(spr_starchild_underwear, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                
                if (cl > 2)
                {
                    draw_sprite_ext(spr_starchild_outfit1_bottom, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        draw_sprite_ext(spr_starchild_outfit1_top, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                        {
                            draw_sprite_ext(spr_starchild_outfit1_skirt, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 5)
                                draw_sprite_ext(spr_starchild_glove1_right, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                }
            }
            else if (u == 2)
            {
                draw_sprite_ext(spr_starchild_hairback2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (cl > 4)
                    draw_sprite_ext(spr_starchild_cape2, 0, xoff + lengthdir_x(55 * xsc, gang) + lengthdir_x(1300 * ysc, gang + 90), yoff + lengthdir_y(55 * xsc, gang) + lengthdir_y(1300 * ysc, gang + 90), xsc * (0.95 + (undulate(6.5) * 0.05)), ysc * (0.98 - (undulate(6.5) * 0.02)), gang, col, alpha2);
                
                if (!accessories)
                    draw_sprite_ext(spr_starchild_armB, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                else
                    draw_sprite_ext(spr_starchild_arm, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (cl > 5)
                {
                    if (!accessories)
                        draw_sprite_ext(spr_starchild_glove2B, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    else
                        draw_sprite_ext(spr_starchild_glove2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                }
                
                draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (specialdrawundies || cl < 4)
                    draw_sprite_ext(spr_starchild_underwear, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                
                if (cl > 2)
                {
                    draw_sprite_ext(spr_starchild_outfit2_bottom, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl > 3)
                    {
                        draw_sprite_ext(spr_starchild_outfit2_top, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 4)
                        {
                            draw_sprite_ext(spr_starchild_outfit2_mantle, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 5)
                                draw_sprite_ext(spr_starchild_glove2_right, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                }
            }
            else if (u == 3)
            {
                draw_sprite_ext(spr_starchild_hairback2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (cl > 0)
                {
                    if (cl > 4)
                    {
                        if (accessories)
                            draw_sprite_ext(spr_starchild_glove_underwear, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                        else
                            draw_sprite_ext(spr_starchild_glove_underwearB, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                    }
                    
                    draw_sprite_ext(spr_starchild_underwear, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                    
                    if (cl > 2)
                    {
                        draw_sprite_ext(spr_starchild_leggings, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                        
                        if (cl > 4)
                            draw_sprite_ext(spr_starchild_glove_underwear_right, 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
                    }
                }
            }
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (u != 1)
                draw_sprite_ext(spr_starchild_hairfront2, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            else
                draw_sprite_ext(spr_starchild_hairfront1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (u == 1)
                draw_sprite_ext(spr_starchild_headdress1, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            else
                draw_sprite_ext(spr_starchild_headdress2, 0, xoff, yoff + (undulate(4) * 20 * ysc), xsc, ysc, gang, col, alpha2);
            
            if (accessories && global.sceneIndex != 665)
            {
                draw_sprite_ext(spr_starchild_staff, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                
                if (room != rmTown)
                    draw_sprite_ext(spr_starchild_staff, 1, xoff, yoff, xsc, ysc, gang, col, alpha2);
            }
            
            break;
        
        case global.specialLadyInBlack:
            if (global.environment == 6 || global.environment == 5 || global.sceneIndex == 274 || global.environment == 20)
                u = 1;
            
            xoff += 40;
            xoff_2 = 4;
            var drawhoodie = !have_reached_quest_stage(28, 6);
            var removeblazer = u == 1 && !drawhoodie && (global.environment == 6 || global.environment == 20) && global.sceneIndex != 649;
            var flashback;
            
            if (object_index == obj_vncontroller)
                flashback = global.sceneIndex == 154 && lineIndex >= 60 && lineIndex <= 62;
            else
                flashback = false;
            
            if (drawhoodie && u == 1 && cl == 6 && room != rmBattleTest)
                draw_sprite_ext(spr_lady_hoodie_back, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            if (u == 2 && cl > 4)
                draw_sprite_ext(spr_lady_jacket_back, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), lady_lips(), xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), lady_lips(), xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (u == 1)
            {
                if (inScene)
                {
                    var gl = 0;
                    
                    if (global.sceneIndex == 74 || global.sceneIndex == 16 || global.sceneIndex == 271 || flashback)
                        gl = 1;
                    
                    draw_sprite_ext(spr_lady_glasses, gl, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    
                    if ((global.sceneIndex == 153 && lineIndex >= 152) || global.TEMP_FLAG[13] == 1)
                        draw_sprite_ext(spr_lady_katana, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    else if ((((global.FLAG[55] == true || (global.sceneIndex == 136 && lineIndex >= 57) || (global.sceneIndex == 154 && lineIndex >= 169)) && global.TEMP_FLAG[13] == 0 && !(global.sceneIndex == 371 && lineIndex < 85) && ((global.FLAG[267] == 0 && !global.questCompleted[28]) || global.sceneIndex == 444)) || global.sceneIndex == 659) && global.sceneIndex != 399)
                        draw_sprite_ext(spr_lady_baton, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                }
                else
                {
                    draw_sprite_ext(spr_lady_glasses, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    draw_sprite_ext(spr_lady_baton, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
                    
                    if (inBattle)
                    {
                        if (global.settingFancy)
                            draw_set_blend_mode(bm_add);
                        
                        draw_sprite_ext(spr_lady_baton, 1, xoff, yoff, xsc, ysc, gang, col, 1 * abs(sin(effrads * 6)));
                        draw_set_blend_mode(bm_normal);
                    }
                }
            }
            
            if (always_lewd || species_breasts_are_exposed(mySpecies, u, cl) || species_vag_is_exposed(cl))
                draw_sprite_ext(spr_lady_lewdbits, global.settingPubes, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (bra_is_exposed(cl, u, undiesAlpha))
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (panties_are_exposed(cl, u, cummed_) && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (cl > 2 && u != 3)
            {
                draw_sprite_ext(species_shoessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (u == 1)
                {
                    if (cl >= (4 - inScene))
                    {
                        if (cl >= (5 - inScene))
                            clothesSprite = 1365;
                        else
                            clothesSprite = 1366;
                        
                        draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (inScene)
                        {
                            if (cl >= 5 && !removeblazer)
                                draw_sprite_ext(spr_lady_blazer, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                }
                else if (u == 2)
                {
                    if (cl > 2)
                    {
                        draw_sprite_ext(spr_lady_jeans, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        
                        if (cl > 3)
                        {
                            draw_sprite_ext(spr_lady_shirt, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            draw_sprite_ext(spr_lady_necklace, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                            
                            if (cl > 4)
                                draw_sprite_ext(spr_lady_jacket, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                        }
                    }
                }
            }
            
            draw_sprite_ext(species_hairsprite(mySpecies, ha), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (global.sceneIndex == 16)
                draw_sprite_ext(spr_lady_shade, 0, xoff, yoff, xsc, ysc, gang, col, 1);
            
            if (cl == 6)
            {
                if (u == 1 && drawhoodie)
                {
                    draw_sprite_ext(species_accessorysprite_front2(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
                else if (u == 2 && global.sceneIndex != 610 && global.sceneIndex != 648)
                {
                    draw_sprite_ext(spr_lady_beanie, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    draw_sprite_ext(spr_lady_sunglasses, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            if (u == 2 && global.sceneIndex != 610 && global.sceneIndex != 648)
                draw_sprite_ext(spr_lady_lollie, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            if (global.sceneIndex == 648)
                draw_sprite_ext(spr_lady_glasses, 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.specialGuildMaster:
            draw_sprite_ext(species_basesprite(mySpecies), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (lastface)
                draw_sprite_ext(species_facesprite(mySpecies, actorLastMood[currentActor], u, ey), 0, xoff, yoff, xsc, ysc, gang, col, alpha2 * (1 - al_));
            
            draw_sprite_ext(species_facesprite(mySpecies, myMood, u, ey), 0, xoff, yoff, xsc, ysc, gang, col, al_ * alpha2);
            
            if (bra_is_exposed(cl, u, undiesAlpha))
                draw_sprite_ext(species_brasprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (panties_are_exposed(cl, u, cummed_) && !bottomless)
                draw_sprite_ext(species_pantiessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, undiesAlpha);
            
            if (cl > 2)
            {
                draw_sprite_ext(species_shoessprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                
                if (cl > 3)
                {
                    draw_sprite_ext(clothesSprite, 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                    
                    if (cl == 6)
                        draw_sprite_ext(species_accessorysprite_front(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
                }
            }
            
            draw_sprite_ext(species_hairsprite(mySpecies, ha), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (cl == 6)
                draw_sprite_ext(species_accessorysprite_front2(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, clothesAlpha);
            
            var acc = species_accessorysprite(mySpecies, 0, u, cl);
            
            for (var i_ = 1; i_ <= acc; i_++)
                draw_sprite_ext(species_accessorysprite(mySpecies, i_, u, cl), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            if (accessories == true)
                draw_sprite_ext(species_weaponsprite(mySpecies, u), 0, xoff, yoff, xsc, ysc, gang, col, alpha2);
            
            break;
        
        case global.monsterBloodySkull:
            if (per_second(3))
                part_particles_create(global.sysGirl[girlIndex + 1], girl_x(girlIndex) + irandom_range(-50, 50), girl_y(girlIndex) + (sin(effrads2) * 50) + irandom_range(-50, 50), global.pt_blooddrop, 1);
            
            draw_sprite_ext(spr_lich_skull, 0, xoff, yoff + (sin(effrads2) * 50), xsc, ysc, sin(effrads) * 10, col, alpha2);
            break;
    }
    
    if (shader_current() != -1)
        shader_reset();
    
    if (!inBattle)
    {
        var he = false;
        var se = false;
        
        if (inScene)
        {
            if (global.sceneIndex != 0)
            {
                if (actorHeartEyes[currentActor] == true)
                    he = true;
                else if (actorStarEyes[currentActor] == true)
                    se = true;
            }
        }
        
        if (he == true || se == true)
        {
            if (actorMiscRads[currentActor] <= pi)
            {
                var eyeScale = 0.1 + ((abs(sin(actorMiscRads[currentActor] * 2)) / (1 + ((actorMiscRads[currentActor] > 1.5707963267948966) / 2))) * 0.6);
                var eyeAlpha = (eyeScale - 0.1) * 3;
                var eyeCoords = species_eyeoffset(mySpecies);
                var xside;
                
                if (xsc < 0)
                    xside = xoff + (sprite_get_xoffset(species_basesprite(mySpecies)) * abs(xsc));
                else
                    xside = xoff - (sprite_get_xoffset(species_basesprite(mySpecies)) * abs(xsc));
                
                var eyeX = xside + (eyeCoords[0] * xsc);
                var eyeY = (yoff - (sprite_get_yoffset(species_basesprite(mySpecies)) * ysc)) + (eyeCoords[1] * ysc);
                var eyespr;
                
                if (se)
                {
                    eyespr = 1964;
                    eyeAlpha = 1;
                    eyeScale += 0.25;
                }
                else
                {
                    eyespr = 1970;
                }
                
                draw_sprite_ext(eyespr, 0, eyeX, eyeY, eyeScale * 0.95, eyeScale * 0.95, 0, -1, eyeAlpha);
                
                if (array_length_1d(eyeCoords) > 2)
                {
                    eyeX = xside + (eyeCoords[2] * xsc);
                    eyeY = (yoff - (sprite_get_yoffset(species_basesprite(mySpecies)) * ysc)) + (eyeCoords[3] * ysc);
                    draw_sprite_ext(eyespr, 0, eyeX, eyeY, eyeScale, eyeScale, 0, -1, eyeAlpha);
                }
            }
        }
        
        if (global.settingSafeMode == true)
        {
            var lewdcoord0 = species_lewdoffset(mySpecies, 0);
            var lewdcoord1 = species_lewdoffset(mySpecies, 1);
            var lewdcoord2 = species_lewdoffset(mySpecies, 2);
            var xysc = max(abs(xsc), abs(ysc));
            var xside;
            
            if (xsc < 0)
                xside = xoff + (sprite_get_xoffset(species_basesprite(mySpecies)) * abs(xsc));
            else
                xside = xoff - (sprite_get_xoffset(species_basesprite(mySpecies)) * abs(xsc));
            
            if (always_lewd || species_breasts_are_exposed(mySpecies, u, cl))
            {
                draw_sprite_ext(spr_affectionheart, 0, xside + (lewdcoord1[0] * xsc) + (8 * sign(xsc)), (yoff - (sprite_get_yoffset(species_basesprite(mySpecies)) * ysc)) + (lewdcoord1[1] * ysc), global.censorScale * xysc * 0.7, global.censorScale * xysc * 0.7, -12 * sign(xsc), -1, 1);
                draw_sprite_ext(spr_affectionheart, 0, xside + (lewdcoord0[0] * xsc) + (8 * sign(xsc)), (yoff - (sprite_get_yoffset(species_basesprite(mySpecies)) * ysc)) + (lewdcoord0[1] * ysc), global.censorScale * xysc * 0.7, global.censorScale * xysc * 0.7, 12 * sign(xsc), -1, 1);
            }
            
            if (always_lewd || species_vag_is_exposed(cl))
                draw_sprite_ext(spr_affectionheart, 0, xside + (lewdcoord2[0] * xsc) + (8 * sign(xsc)), (yoff - (sprite_get_yoffset(species_basesprite(mySpecies)) * ysc)) + (lewdcoord2[1] * ysc), global.censorScale * xysc * 0.8, global.censorScale * xysc * 0.8, 0, -1, 1);
        }
        
        if (global.settingFancy == true)
        {
            surface_opaquify(global.surfGIRL);
            surface_reset_target();
            
            if (wiggle > 0)
            {
                shader_set(shader_ripple);
                shader_set_uniform_f(global.uniWave, (240 / wiggle) * global.wigglefactor, 5 * wiggle * global.wigglefactor);
                shader_set_uniform_f(global.uniTime, current_time / 2800);
            }
            
            draw_surface_ext(global.surfGIRL, xx - xoff, (yy - yoff) + extraY, 1, 1, ang, -1, alpha);
            
            if (wiggle > 0)
                shader_reset();
            
            if (room == rmVnTest && currentActor > 0 && actorOverlayAlpha[currentActor] > 0)
            {
                draw_set_blend_mode(bm_add);
                draw_surface_silhouette(global.surfGIRL, xx - xoff, (yy - yoff) + extraY, 1, 1, ang, actorOverlayColor[currentActor], actorOverlayAlpha[currentActor]);
                draw_set_blend_mode(bm_normal);
            }
            
            surface_free(global.surfGIRL);
        }
    }
}
