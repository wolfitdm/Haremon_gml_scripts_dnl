var candebug = max(0, 1);

if (keyboard_check_pressed(192) && (keyboard_check(vk_shift) || candebug == true || global.debugging == true))
{
    global.debugging = !global.debugging;
    keyboard_string = "";
}

if (global.debugging == false)
{
    debugY = max(-1000, debugY - 40);
    debugString = "";
}
else
{
    debugY = min(-500, debugY + 40);
}

if (debugY > -1000)
{
    draw_sprite_ext(spr_vn_textbox, 0, 0, debugY, 0.5, global.guiWidth / sprite_get_height(spr_vn_textbox), 270, -1, 0.9);
    draw_set_alpha(1);
    draw_set_font(font_vn);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    draw_set_color(merge_color(c_white, c_ltgray, 0.5));
    var dbh = min(170, string_height(debugBacklog));
    draw_text(32, debugY + 528 + dbh, debugString);
    draw_set_color(merge_color(c_gray, c_ltgray, 0.5));
    draw_text(32, (debugY + 528) - max(0, string_height(debugBacklog) - 170), debugBacklog);
    debugTimer--;
    
    if (debugTimer == 0)
    {
        debugFlicker = !debugFlicker;
        debugTimer = room_speed / 2;
    }
    
    if (debugFlicker == true)
        draw_text(32 + string_width(debugString), debugY + 528 + dbh, "|");
    
    debugString = keyboard_string;
    
    if (keyboard_check_pressed(vk_enter) && debugString != "")
    {
        var i = 0;
        
        do
            i++;
        until (string_char_at(debugString, i) == " " || i > string_length(debugString));
        
        i--;
        var keyword = string_copy(debugString, 1, i);
        var arg;
        arg[0] = "";
        arg[1] = "";
        arg[2] = "";
        arg[3] = "";
        arg[4] = "";
        var argX;
        argX[0] = "";
        argX[1] = "";
        argX[2] = "";
        argX[3] = "";
        argX[4] = "";
        var argB;
        argB[0] = "";
        argB[1] = "";
        argB[2] = "";
        argB[3] = "";
        argB[4] = "";
        
        if (i < string_length(debugString))
        {
            var j = i + 1;
            var args = 0;
            
            do
            {
                var js = j;
                
                do
                    j++;
                until (string_char_at(debugString, j) == " " || j > string_length(debugString));
                
                j--;
                argX[args] = string_copy(debugString, js + 1, j - js);
                arg[args] = string_lower(argX[args]);
                argB[args] = argX[args];
                args++;
                j++;
            }
            until (j > string_length(debugString));
        }
        
        debugBacklog += (debugString + "\n");
        var debugged = false;
        
        switch (keyword)
        {
            case "restoreranch":
                debugBacklog += "CONSOLE: restoring ranch\n";
                
                for (var h = 1; h <= global.playerGirls; h++)
                {
                    if (!(species_is_in_party(global.girlSpecies[h]) || species_is_in_party(global.girlSpecies[girl_real_index(h)]) || species_is_in_party(species_trueform(global.girlSpecies[h]))))
                        scene_action_sendgirltoranch(h);
                }
                
                debugged = true;
                break;
            
            case "resetpackage":
                debugBacklog += "CONSOLE: resetting HSN package\n";
                global.FLAG[144] = 0;
                debugged = true;
                break;
            
            case "changename":
                var _name = argB[0];
                
                if (name_is_valid(_name))
                {
                    global.playerName = _name;
                    debugBacklog += ("CONSOLE: changing your name to " + string(global.playerName) + "\n");
                }
                else
                {
                    debugBacklog += ("ERROR: that name is invalid! Max length is " + string(16) + " characters, and you can't use the name of an NPC or Haremon.\n");
                }
                
                debugged = true;
                break;
            
            case "setdate":
                var valid = true;
                arg[0] = real(string_digits(arg[0]));
                arg[1] = real(string_digits(arg[1]));
                
                if (round(arg[0]) != arg[0] || arg[0] < 1 || arg[0] > 12)
                {
                    debugBacklog += "ERROR: invalid month\n";
                    valid = false;
                    debugged = true;
                }
                
                if (round(arg[1]) != arg[1] || arg[1] < 1 || arg[1] > month_days(arg[0]))
                {
                    debugBacklog += "ERROR: invalid day\n";
                    valid = false;
                    debugged = true;
                }
                
                if (valid == true)
                {
                    global.DATE_BASED_EVENTS = true;
                    global.MONTH = arg[0];
                    global.DAY = arg[1];
                    debugged = true;
                    debugBacklog += ("CONSOLE: setting date to " + month_name(global.MONTH) + " " + string(global.DAY) + "\n");
                }
                
                break;
            
            case "resettexts":
                debugBacklog += "CONSOLE: text messages reset\n";
                global.playerTexts = 0;
                global.newmessages = 0;
                debugged = true;
                break;
            
            case "fixtexts":
                debugBacklog += "CONSOLE: text messages fixed\n";
                global.playerTexts--;
                debugged = true;
                break;
            
            case "flush":
                debugBacklog += "CONSOLE: flushing texture memory\n";
                draw_texture_flush();
                debugged = true;
                break;
            
            case "flushaudio":
                debugBacklog += "CONSOLE: flushing audio memory\n";
                audio_group_unload(2);
                audio_group_unload(0);
                audio_group_unload(5);
                audio_group_unload(4);
                audio_group_unload(1);
                audio_group_unload(13);
                audio_group_unload(3);
                audio_group_unload(9);
                audio_group_unload(8);
                audio_group_unload(7);
                audio_group_unload(6);
                audio_group_unload(11);
                audio_group_unload(10);
                audio_group_unload(12);
                debugged = true;
                break;
            
            case "tech":
                debugBacklog += "CONSOLE: adding all techniques to VRM list\n";
                
                for (i = 1; i <= global.totalTechniques; i++)
                    global.techniqueSeen[i] = true;
                
                debugged = true;
                break;
        }
        
        if (candebug == true && debugged == false)
        {
            switch (keyword)
            {
                case "jump":
                    if (global.sceneIndex == 0)
                    {
                        event_perform(ev_other, ev_user7);
                        debugBacklog += "CONSOLE: executing jump\n";
                        global.debugging = false;
                    }
                    else
                    {
                        debugBacklog += "ERROR: You can only use this command from the main menu!\n";
                    }
                    
                    debugged = true;
                    break;
                
                case "give":
                    var git = -1;
                    
                    if (string_letters(arg[0]) == "all" || string_letters(arg[0]) == "everything")
                    {
                        git = -2;
                    }
                    else
                    {
                        if (string_letters(arg[1]) != "")
                        {
                            for (var itt = 1; itt <= global.totalItems; itt++)
                            {
                                if (string_replace_all(string_lower(item_name(itt)), " ", "_") == arg[1])
                                    git = itt;
                            }
                        }
                        else
                        {
                            git = real(string_digits(arg[1]));
                        }
                        
                        arg[0] = string_digits(arg[0]);
                    }
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid quantity\n";
                    }
                    else if ((git == -1 || git < 1 || git > global.totalItems || ((item_is_easteregg(git) || item_is_spoiler(git) || !item_is_implemented(git)) && 1)) && git != -2)
                    {
                        debugBacklog += "ERROR: invalid item ID\n";
                    }
                    else if (git == -2)
                    {
                        if (show_question("WARNING: giving all items could have unintended consequences. Only proceed it you know what you're doing!\n\nCertain story-related items will NOT be added, to avoid breaking the game's progression. The game will also likely freeze for several seconds.\n\nProceed?"))
                        {
                            for (var itt = 1; itt <= global.totalItems; itt++)
                            {
                                if (!(item_is_easteregg(itt) || item_is_spoiler(itt)) && item_is_implemented(itt))
                                    scene_action_additem(itt, 99);
                            }
                            
                            debugBacklog += "CONSOLE: giving 99 of everything\n";
                            
                            if (room == rmBattleTest)
                                setup_pockets();
                        }
                    }
                    else
                    {
                        var met = arg[2];
                        
                        if (met == "" && item_type(git) == 1)
                            met = "0";
                        
                        scene_action_additem(git, real(arg[0]), met);
                        debugBacklog += ("CONSOLE: giving " + arg[0] + " " + item_name_plural(git) + "\n");
                        
                        if (room == rmBattleTest)
                            setup_pockets();
                    }
                    
                    break;
                
                case "whereis":
                case "find":
                    var git = -1;
                    
                    if (arg[0] == "all")
                    {
                        var str = "";
                        
                        for (var j = 1; j <= global.totalItems; j++)
                        {
                            str += "----------------------\n";
                            str += ("#" + number_addzeroes(j) + ": " + string(item_name(j)) + "\n");
                            str += item_acquisition(j);
                            str += "----------------------\n";
                        }
                        
                        debugBacklog += "CONSOLE: all item acquisition info copied to clipboard!\n";
                        clipboard_set_text(str);
                        break;
                    }
                    else if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.totalItems; itt++)
                        {
                            if (string_replace_all(string_lower(item_name(itt)), " ", "_") == arg[0])
                                git = itt;
                        }
                    }
                    else
                    {
                        git = real(string_digits(arg[0]));
                    }
                    
                    if (git == -1 || git < 1 || git > global.totalItems || ((item_is_easteregg(git) || item_is_spoiler(git) || !item_is_implemented(git)) && 1))
                    {
                        debugBacklog += "ERROR: invalid item ID\n";
                    }
                    else
                    {
                        var str = item_acquisition(git) + "\n\nNOTE: this information may be inaccurate or incomplete, and may include features you do not yet have access to, or shop inventory you have not yet unlocked.";
                        debugBacklog += "CONSOLE: info copied to clipboard!\n";
                        clipboard_set_text(str);
                        show_message(str);
                    }
                    
                    break;
                
                case "unlockdata":
                    for (var ida = 1; ida <= global.playerGirls; ida++)
                    {
                        for (var daa = 1; daa <= global.girlDataTotal; daa++)
                            global.girlDataKnown[ida][daa] = true;
                        
                        for (var gt = 1; gt <= 32; gt++)
                            global.girlGiftPreferenceKnown[ida][gt] = true;
                    }
                    
                    for (var ida = 1; ida <= global.totalMajorNPCs; ida++)
                    {
                        for (var daa = 1; daa <= global.girlDataTotal; daa++)
                            global.npcDataKnown[global.npcIndex[ida]][daa] = true;
                        
                        for (var gt = 1; gt <= 32; gt++)
                            global.npcGiftPreferenceKnown[ida][gt] = true;
                    }
                    
                    debugBacklog += "CONSOLE: unlocking all data\n";
                    break;
                
                case "scene":
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid scene (enter a number)\n";
                    }
                    else if ((real(arg[0]) > global.totalScenes || real(arg[0]) < 0 || scene_is_secret(real(arg[0]))) && true)
                    {
                        debugBacklog += "ERROR: invalid scene\n";
                    }
                    else
                    {
                        global.sceneIndexNew = real(arg[0]);
                        debugBacklog += ("CONSOLE: jumping to scene " + arg[0] + "\n");
                        
                        if (room != rmVnTest)
                        {
                            global.sceneIndex = real(arg[0]);
                            room_goto(rmVnTest);
                        }
                        else
                        {
                            alarm[1] = 1;
                        }
                    }
                    
                    break;
                
                case "line":
                    if (!instance_exists(obj_vncontroller))
                    {
                        debugBacklog += "ERROR: no scene running!\n";
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                        {
                            debugBacklog += "ERROR: invalid line\n";
                        }
                        else if (real(arg[0]) > obj_vncontroller.sceneLines || real(arg[0]) < 1)
                        {
                            debugBacklog += "ERROR: invalid line\n";
                        }
                        else
                        {
                            with (obj_vncontroller)
                            {
                                lineIndex = real(arg[0]);
                                cheatingLine = true;
                                event_perform(ev_other, ev_user1);
                            }
                            
                            debugBacklog += ("CONSOLE: jumping to line " + string(real(arg[0])) + "\n");
                        }
                    }
                    
                    break;
                
                case "setguildrank":
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid rank\n";
                    }
                    else
                    {
                        arg[0] = real(arg[0]);
                        
                        if (arg[0] > (global.guildRankMax + 1) || arg[0] < 0)
                        {
                            debugBacklog += "ERROR: invalid rank\n";
                        }
                        else
                        {
                            global.guildRank = arg[0];
                            debugBacklog += ("CONSOLE: set guild rank to " + string(arg[0]) + "\n");
                        }
                    }
                    
                    break;
                
                case "getguildrank":
                    debugBacklog += ("CONSOLE: current guild rank is " + string(global.guildRank) + "\n");
                    break;
                
                case "catalogue":
                    construct_item_database();
                    debugBacklog += "CONSOLE: copying the item catalogue to your clipboard\n";
                    break;
                
                case "catalogue2":
                    construct_item_database2();
                    debugBacklog += "CONSOLE: copying the item catalogue to your clipboard\n";
                    break;
                
                case "techcatalogue":
                    construct_technique_database();
                    debugBacklog += "CONSOLE: copying the technique catalogue to your clipboard\n";
                    break;
                
                case "kinkcatalogue":
                    construct_kink_database();
                    debugBacklog += "CONSOLE: copying the kink catalogue to your clipboard\n";
                    break;
                
                case "godmode":
                    global.godmode = !global.godmode;
                    
                    if (global.godmode == true)
                        debugBacklog += "CONSOLE: activating god mode\n";
                    else
                        debugBacklog += "CONSOLE: deactivating god mode\n";
                    
                    break;
                
                case "hellmode":
                    if (room == rmBattleTest)
                    {
                        debugBacklog += "CONSOLE: activating hell mode\n";
                        global.enemyHp[1] = 999999999;
                        obj_battlecontroller.enemyTargetHp[1] = global.enemyHp[1];
                        global.enemyHp[2] = 999999999;
                        obj_battlecontroller.enemyTargetHp[2] = global.enemyHp[2];
                        global.enemyHp[3] = 999999999;
                        obj_battlecontroller.enemyTargetHp[3] = global.enemyHp[3];
                    }
                    else
                    {
                        debugBacklog += "ERROR: this command can only be used in battle\n";
                    }
                    
                    break;
                
                case "challengecap":
                    global.TEMP_FLAG[1] = !global.TEMP_FLAG[1];
                    
                    if (global.TEMP_FLAG[1] == true)
                        debugBacklog += "CONSOLE: activating zone caps\n";
                    else
                        debugBacklog += "CONSOLE: deactivating zone caps\n";
                    
                    break;
                
                case "checkchallenge":
                    debugBacklog += ("CONSOLE: current challenge rating is " + string(global.adaptiveDifficulty / 200) + "\n");
                    break;
                
                case "warp":
                    global.TEMP_FLAG[2] = !global.TEMP_FLAG[2];
                    
                    if (global.TEMP_FLAG[2] == true)
                        debugBacklog += "CONSOLE: activating warp mode\n";
                    else
                        debugBacklog += "CONSOLE: deactivating warp mode\n";
                    
                    break;
                
                case "stickerclicker":
                    global.TEMP_FLAG[153] = !global.TEMP_FLAG[153];
                    
                    if (global.TEMP_FLAG[153] == true)
                        debugBacklog += "CONSOLE: activating sticker-clicker mode. Alt-click stickers to unlock/lock them.\n";
                    else
                        debugBacklog += "CONSOLE: deactivating sticker-clicker mode\n";
                    
                    break;
                
                case "spintowin":
                    global.TEMP_FLAG[6] = !global.TEMP_FLAG[6];
                    
                    if (global.TEMP_FLAG[6] == true)
                        debugBacklog += "CONSOLE: activating spinner auto-win\n";
                    else
                        debugBacklog += "CONSOLE: deactivating spinner auto-win\n";
                    
                    break;
                
                case "takeyourtime":
                    global.TEMP_FLAG[3] = !global.TEMP_FLAG[3];
                    
                    if (global.TEMP_FLAG[3] == true)
                    {
                        debugBacklog += "CONSOLE: activating choice timers\n";
                    }
                    else
                    {
                        debugBacklog += "CONSOLE: deactivating choice timers\n";
                        
                        if (instance_exists(obj_vncontroller))
                            obj_vncontroller.makeAutoChoices = false;
                    }
                    
                    break;
                
                case "hungerstrike":
                    global.TEMP_FLAG[4] = !global.TEMP_FLAG[4];
                    
                    if (global.TEMP_FLAG[4] == true)
                        debugBacklog += "CONSOLE: activating hunger\n";
                    else
                        debugBacklog += "CONSOLE: deactivating hunger\n";
                    
                    break;
                
                case "harem":
                    global.TEMP_FLAG[7] = !global.TEMP_FLAG[7];
                    
                    if (global.TEMP_FLAG[7] == true)
                        debugBacklog += "CONSOLE: activating harem mode\n";
                    else
                        debugBacklog += "CONSOLE: deactivating harem mode\n";
                    
                    break;
                
                case "regifter":
                    global.TEMP_FLAG[9] = !global.TEMP_FLAG[9];
                    
                    if (global.TEMP_FLAG[9] == true)
                        debugBacklog += "CONSOLE: activating regift mode\n";
                    else
                        debugBacklog += "CONSOLE: deactivating regift mode\n";
                    
                    break;
                
                case "encounter":
                    if (room != rmDungeonTest)
                    {
                        debugBacklog += "ERROR: only usable on the dungeon screen!\n";
                    }
                    else
                    {
                        debugBacklog += "CONSOLE: triggering an encounter\n";
                        start_dungeon_encounter(-1);
                    }
                    
                    break;
                
                case "restartscene":
                case "refresh":
                    if (room != rmVnTest)
                    {
                        debugBacklog += "ERROR: must be used during a scene!";
                    }
                    else
                    {
                        with (obj_vncontroller)
                        {
                            scene_set_info(global.sceneIndex);
                            lineIndex = 0;
                            typeIndex = 0;
                        }
                        
                        instance_destroy(obj_matchgame);
                        debugBacklog += "CONSOLE: restarting the scene\n";
                    }
                    
                    break;
                
                case "restart":
                    game_restart();
                    break;
                
                case "run":
                case "escape":
                case "flee":
                    if (room != rmBattleTest)
                    {
                        debugBacklog += "ERROR: can only be used in battle!";
                    }
                    else
                    {
                        with (obj_battlecontroller)
                        {
                            global.battlePhase = global.phaseWait;
                            
                            for (var g = 1; g <= 3; g++)
                            {
                                girlSg[g] = 0;
                                global.girlRunning[g] = true;
                            }
                        }
                        
                        debugBacklog += "CONSOLE: running from battle\n";
                    }
                    
                    break;
                
                case "repel":
                    if (room != rmDungeonTest)
                    {
                        debugBacklog += "ERROR: can only be used on the dungeon screen!\n";
                    }
                    else
                    {
                        global.dungeonMonsters = 0;
                        debugBacklog += "CONSOLE: removing monsters\n";
                    }
                    
                    break;
                
                case "cartographer":
                    if (room != rmDungeonTest)
                    {
                        debugBacklog += "ERROR: must be used on the dungeon screen!\n";
                    }
                    else
                    {
                        with (obj_dungeoncontroller)
                        {
                            for (i = 1; i <= global.tiles; i++)
                                global.tileFlipped[i] = true;
                            
                            update_explore_quests();
                        }
                        
                        debugBacklog += "CONSOLE: revealing map\n";
                    }
                    
                    break;
                
                case "refreshsales":
                    refresh_sales();
                    debugBacklog += "CONSOLE: refreshing sales\n";
                    break;
                
                case "addmoney":
                case "$":
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid dollar amount\n";
                    }
                    else if (real(arg[0]) < 0)
                    {
                        debugBacklog += "ERROR: invalid dollar amount\n";
                    }
                    else
                    {
                        global.playerMoney += real(arg[0]);
                        debugBacklog += ("CONSOLE: adding $" + string(real(arg[0])) + "\n");
                    }
                    
                    break;
                
                case "addfood":
                case "food":
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid amount\n";
                    }
                    else if (real(arg[0]) < 0)
                    {
                        debugBacklog += "ERROR: invalid amount\n";
                    }
                    else
                    {
                        global.currentFood += real(arg[0]);
                        debugBacklog += ("CONSOLE: adding " + string(real(arg[0])) + " food\n");
                    }
                    
                    break;
                
                case "tick":
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid tick #\n";
                    }
                    else if (real(arg[0]) < 0)
                    {
                        debugBacklog += "ERROR: invalid tick #\n";
                    }
                    else
                    {
                        tick(real(arg[0]));
                        debugBacklog += ("CONSOLE: tick x" + string(arg[0]) + "\n");
                    }
                    
                    break;
                
                case "setguildseals":
                    arg[0] = real(string_digits(arg[0]));
                    arg[1] = real(string_digits(arg[1]));
                    
                    if (string(arg[0]) == "")
                    {
                        debugBacklog += "ERROR: invalid rank\n";
                    }
                    else if (arg[0] > global.guildRankMax || arg[0] < 0)
                    {
                        debugBacklog += "ERROR: invalid rank\n";
                    }
                    else if (string(arg[1]) == "")
                    {
                        debugBacklog += "ERROR: invalid seal count\n";
                    }
                    else if (arg[1] < 0)
                    {
                        debugBacklog += "ERROR: invalid seal count\n";
                    }
                    else
                    {
                        global.rankSeals[arg[0]] = arg[1];
                        debugBacklog += ("CONSOLE: set guild seals for rank " + string(arg[0]) + " to " + string(arg[1]) + "\n");
                    }
                    
                    break;
                
                case "addtechnique":
                case "tech":
                case "learn":
                case "teach":
                    if (room == rmBattleTest)
                    {
                        debugBacklog += "ERROR: can't be used in battle\n";
                        break;
                    }
                    
                    var gir = -1;
                    var tec = -1;
                    var lev = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if (real(arg[0]) < 0 || real(arg[0]) > global.playerGirls)
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    if (string_letters(arg[1]) == "all")
                    {
                        tec = -69;
                    }
                    else
                    {
                        var itt;
                        
                        if (string_letters(arg[1]) != "")
                        {
                            for (itt = 1; itt <= global.totalTechniques; itt++)
                            {
                                if (string_lower(string_replace_all(technique_name(itt), " ", "_")) == arg[1] && ((technique_is_implemented(itt) && !technique_is_secret(itt)) || 0))
                                    tec = itt;
                            }
                        }
                        else
                        {
                            arg[1] = string_digits(arg[1]);
                            
                            if (arg[1] == "")
                                debugBacklog += "ERROR: invalid technique ID\n";
                            else if (real(arg[1]) < 1 || real(arg[1]) > global.totalTechniques || ((!technique_is_implemented(real(arg[1])) || technique_is_secret(itt)) && 1))
                                debugBacklog += "ERROR: invalid technique ID\n";
                            else
                                tec = real(arg[1]);
                        }
                    }
                    
                    arg[2] = string_digits(arg[2]);
                    
                    if (arg[2] == "")
                        lev = 0;
                    else if (real(arg[2]) < 0 || real(arg[2]) > 5)
                        debugBacklog += "ERROR: invalid technique level\n";
                    else
                        lev = real(arg[2]);
                    
                    if (gir != -1 && tec != -1 && lev != -1)
                    {
                        if (tec != -69)
                        {
                            if (technique_is_copyable(tec) || tec == global.techniqueCopycat || tec == global.techniqueCopycat2A || tec == global.techniqueCopycat2B || tec == global.techniqueMetronome || 0)
                            {
                                if (instance_exists(obj_battlecontroller))
                                {
                                    with (obj_battlecontroller)
                                        scene_action_learnmove(gir, tec, lev);
                                    
                                    obj_battlecontroller.girlTechniqueUsed[party_find_girl(gir)][global.girlTechniques[gir]] = 0;
                                }
                                else
                                {
                                    scene_action_learnmove(gir, tec, lev);
                                }
                                
                                debugBacklog += ("CONSOLE: teaching " + global.girlName[gir] + " to use " + technique_name(tec) + " (level " + string(lev) + ") \n");
                            }
                            else
                            {
                                debugBacklog += "ERROR: invalid technique! \n";
                            }
                        }
                        else
                        {
                            for (var itt = 1; itt <= global.totalTechniques; itt++)
                            {
                                if ((technique_is_copyable(itt) || tec == global.techniqueCopycat || tec == global.techniqueCopycat2A || tec == global.techniqueCopycat2B || tec == global.techniqueMetronome || 0) && ((technique_is_implemented(itt) && !technique_is_secret(itt)) || 0))
                                {
                                    scene_action_learnmove(gir, itt, lev);
                                    
                                    if (instance_exists(obj_battlecontroller))
                                        obj_battlecontroller.girlTechniqueUsed[party_find_girl(gir)][global.girlTechniques[gir]] = 0;
                                }
                            }
                            
                            debugBacklog += ("CONSOLE: teaching " + global.girlName[gir] + " to use EVERY technique (level " + string(lev) + ") \n");
                        }
                    }
                    
                    break;
                
                case "removetechnique":
                case "forget":
                    if (room == rmBattleTest)
                    {
                        debugBacklog += "ERROR: can't be used in battle\n";
                        break;
                    }
                    
                    var gir = -1;
                    var tec = -1;
                    var lev = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if (real(arg[0]) < 0 || real(arg[0]) > global.playerGirls)
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    if (gir == -1)
                    {
                        debugBacklog += "ERROR: invalid girl ID\n";
                    }
                    else if (string_letters(arg[1]) != "")
                    {
                        for (var itt = 1; itt <= global.totalTechniques; itt++)
                        {
                            if (string_lower(string_replace_all(technique_name(itt), " ", "_")) == arg[1] && girl_knows_move(gir, itt))
                            {
                                tec = itt;
                                show_debug_message("TECH: " + string(itt));
                            }
                        }
                    }
                    else
                    {
                        arg[1] = string_digits(arg[1]);
                        
                        if (arg[1] == "")
                            debugBacklog += "ERROR: invalid technique ID\n";
                        else if (!girl_knows_move(gir, real(arg[1])))
                            debugBacklog += "ERROR: invalid technique ID\n";
                        else
                            tec = real(arg[1]);
                    }
                    
                    if (gir != -1 && tec != -1)
                    {
                        for (var t = 1; t <= global.girlTechniques[gir]; t++)
                        {
                            if (global.girlTechnique[gir][t] == tec)
                            {
                                for (var t2 = t; t2 < global.girlTechniques[gir]; t2++)
                                {
                                    global.girlTechnique[gir][t] = global.girlTechnique[gir][t + 1];
                                    global.girlTechniqueLevel[gir][t] = global.girlTechniqueLevel[gir][t + 1];
                                    global.girlTechniqueActive[gir][t] = global.girlTechniqueActive[gir][t + 1];
                                    global.girlTechniqueInvestment[gir][t] = global.girlTechniqueInvestment[gir][t + 1];
                                }
                                
                                global.girlTechniques[gir]--;
                                t--;
                            }
                        }
                        
                        debugBacklog += ("CONSOLE: removing " + technique_name(tec) + " from " + possessive(global.girlName[gir]) + " moveset\n");
                    }
                    
                    break;
                
                case "tutorlist":
                    var gir = -1;
                    var tec = -1;
                    var lev = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if (real(arg[0]) < 0 || real(arg[0]) > global.playerGirls)
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    if (gir != -1)
                    {
                        gir = girl_real_index(gir);
                        var str = global.girlName[gir] + " can learn the following techniques in her base form...\n\n";
                        var _m = species_moveset(global.girlSpecies[gir]);
                        
                        for (_n = 0; _n < array_length(_m); _n++)
                            str += (technique_name(_m[_n]) + "\n");
                        
                        var _n = 0;
                        
                        do
                        {
                            _n++;
                            str += (technique_name(species_tutorlist(global.girlSpecies[gir], _n)) + "\n");
                        }
                        until (species_tutorlist(global.girlSpecies[gir], _n) == -1);
                        
                        if (species_can_awaken(global.girlSpecies[gir]))
                        {
                            str += "\n...and the following techniques in her Awakened form...\n\n";
                            var _sp = species_trueform(global.girlSpecies[gir]);
                            _m = species_moveset(_sp);
                            
                            for (_n = 0; _n < array_length(_m); _n++)
                                str += (technique_name(_m[_n]) + "\n");
                            
                            _n = 0;
                            
                            do
                            {
                                _n++;
                                str += (technique_name(species_tutorlist(_sp, _n)) + "\n");
                            }
                            until (species_tutorlist(_sp, _n) == -1);
                        }
                        
                        str += "\n...and ALL Haremon can learn the following techniques...\n\n";
                        _n = 0;
                        
                        do
                        {
                            _n++;
                            str += (technique_name(species_tutorlist(-1, _n)) + "\n");
                        }
                        until (species_tutorlist(-1, _n) == -1);
                        
                        show_message(str);
                        debugBacklog += "CONSOLE: listing learnable techniques\n";
                    }
                    
                    break;
                
                case "addkink":
                    var gir = -1;
                    var tec = -1;
                    var lev = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if (real(arg[0]) < 0 || real(arg[0]) > global.playerGirls)
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    if (string_letters(arg[1]) == "all")
                    {
                        tec = -69;
                    }
                    else if (string_letters(arg[1]) != "")
                    {
                        for (var itt = 1; itt <= global.totalKinks; itt++)
                        {
                            if (string_lower(string_replace_all(kink_name(itt), " ", "_")) == arg[1])
                                tec = itt;
                        }
                        
                        if (tec == -1)
                            debugBacklog += "ERROR: invalid kink ID\n";
                    }
                    else
                    {
                        arg[1] = string_digits(arg[1]);
                        
                        if (arg[1] == "")
                            debugBacklog += "ERROR: invalid kink ID\n";
                        else if (real(arg[1]) < 1 || real(arg[1]) > global.totalKinks)
                            debugBacklog += "ERROR: invalid kink ID\n";
                        else
                            tec = real(arg[1]);
                    }
                    
                    if (gir != -1 && tec != -1)
                    {
                        var nkinks = array_create(global.totalKinks + 10, false);
                        nkinks[18] = true;
                        
                        for (var m_ = 1; m_ <= global.girlKinks[gir]; m_++)
                        {
                            if (global.girlKink[gir][m_] > 0)
                                nkinks[global.girlKink[gir][m_]] = true;
                        }
                        
                        if (tec != -69)
                        {
                            if (!nkinks[tec])
                                scene_action_learnkink(gir, tec);
                            
                            debugBacklog += ("CONSOLE: teaching " + global.girlName[gir] + " the " + kink_name(tec) + " kink \n");
                        }
                        else
                        {
                            for (var itt = 1; itt <= global.totalKinks; itt++)
                            {
                                if (nkinks[itt])
                                    continue;
                                
                                scene_action_learnkink(gir, itt);
                            }
                            
                            debugBacklog += ("CONSOLE: teaching " + global.girlName[gir] + " EVERY kink \n");
                        }
                    }
                    
                    break;
                
                case "affection":
                case "setaffection":
                    var gir = 0;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                        
                        for (var itt = 1; itt <= global.npcs; itt++)
                        {
                            if (string_lower(global.npcNameShort[itt]) == arg[0] && gir == 0)
                                gir = -itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if ((real(arg[0]) < 1 || real(arg[0]) > global.playerGirls) && !(real(arg[0]) >= -global.npcs && real(arg[0]) < 0))
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    arg[1] = string_digits(arg[1]);
                    
                    if (arg[1] == "")
                    {
                        debugBacklog += "ERROR: invalid affection level\n";
                    }
                    else if (gir == 0)
                    {
                        debugBacklog += "ERROR: invalid girl ID\n";
                    }
                    else if (gir > 0)
                    {
                        global.girlAffection[girl_real_index(gir)] = real(arg[1]);
                        debugBacklog += ("CONSOLE: set " + possessive(global.girlName[gir]) + " affection to " + string(arg[1]) + "\n");
                    }
                    else
                    {
                        global.npcAffection[-gir] = real(arg[1]);
                        debugBacklog += ("CONSOLE: set " + possessive(global.npcNameShort[-gir]) + " affection to " + string(arg[1]) + "\n");
                    }
                    
                    break;
                
                case "kinktutorlist":
                    var gir = -1;
                    var tec = -1;
                    var lev = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if (real(arg[0]) < 0 || real(arg[0]) > global.playerGirls)
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    if (gir != -1)
                    {
                        gir = girl_real_index(gir);
                        var str = global.girlName[gir] + " can learn the following kinks in her base form...\n\n";
                        var _m = species_kinkset(global.girlSpecies[gir]);
                        
                        for (var _n = 0; _n < array_length(_m); _n++)
                            str += (kink_name(_m[_n]) + "\n");
                        
                        _m = species_kinktutorlist(global.girlSpecies[gir]);
                        
                        for (var _n = 0; _n < array_length(_m); _n++)
                            str += (kink_name(_m[_n]) + "\n");
                        
                        if (species_can_awaken(global.girlSpecies[gir]))
                        {
                            str += "\n...and the following kinks in her Awakened form...\n\n";
                            var _sp = species_trueform(global.girlSpecies[gir]);
                            _m = species_kinkset(_sp);
                            
                            for (var _n = 0; _n < array_length(_m); _n++)
                                str += (kink_name(_m[_n]) + "\n");
                            
                            _m = species_kinktutorlist(_sp);
                            
                            for (var _n = 0; _n < array_length(_m); _n++)
                                str += (kink_name(_m[_n]) + "\n");
                        }
                        
                        str += "\n...and ALL Haremon can learn the following kinks...\n\n";
                        _m = species_kinktutorlist(-1);
                        
                        for (var _n = 0; _n < array_length(_m); _n++)
                            str += (kink_name(_m[_n]) + "\n");
                        
                        show_message(str);
                        debugBacklog += "CONSOLE: listing learnable kinks\n";
                    }
                    
                    break;
                
                case "bond":
                case "setbond":
                    var gir = 0;
                    var gir2 = 0;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if ((real(arg[0]) < 1 || real(arg[0]) > global.playerGirls) && !(real(arg[0]) >= -global.npcs && real(arg[0]) < 0))
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    if (string_letters(arg[1]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[1])
                                gir2 = itt;
                        }
                    }
                    else
                    {
                        arg[1] = string_digits(arg[1]);
                        
                        if (arg[1] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if ((real(arg[1]) < 1 || real(arg[1]) > global.playerGirls) && !(real(arg[1]) >= -global.npcs && real(arg[1]) < 0))
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir2 = real(arg[1]);
                    }
                    
                    arg[2] = string_digits(arg[2]);
                    
                    if (arg[2] == "")
                    {
                        debugBacklog += "ERROR: invalid affection level\n";
                    }
                    else if (gir <= 0 || gir2 <= 0)
                    {
                        debugBacklog += "ERROR: invalid girl ID\n";
                    }
                    else if (gir == gir2)
                    {
                        debugBacklog += "ERROR: a girl can't bond with herself!\n";
                    }
                    else
                    {
                        global.girlBond[min(gir, gir2)][max(gir, gir2)] = real(arg[2]);
                        global.girlRelationship[min(gir, gir2)][max(gir, gir2)] = real(arg[2]) div 100;
                        debugBacklog += ("CONSOLE: set " + global.girlName[gir] + " and " + possessive(global.girlName[gir2]) + " bond to " + string(arg[2]) + "\n");
                    }
                    
                    break;
                
                case "checkbond":
                case "getbond":
                    var gir = 0;
                    var gir2 = 0;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if ((real(arg[0]) < 1 || real(arg[0]) > global.playerGirls) && !(real(arg[0]) >= -global.npcs && real(arg[0]) < 0))
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    if (string_letters(arg[1]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[1])
                                gir2 = itt;
                        }
                    }
                    else
                    {
                        arg[1] = string_digits(arg[1]);
                        
                        if (arg[1] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if ((real(arg[1]) < 1 || real(arg[1]) > global.playerGirls) && !(real(arg[1]) >= -global.npcs && real(arg[1]) < 0))
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir2 = real(arg[1]);
                    }
                    
                    if (gir <= 0 || gir2 <= 0)
                        debugBacklog += "ERROR: invalid girl ID\n";
                    else if (gir == gir2)
                        debugBacklog += "ERROR: a girl can't bond with herself!\n";
                    else
                        debugBacklog += ("CONSOLE: " + global.girlName[gir] + " and " + possessive(global.girlName[gir2]) + " bond is " + string(global.girlBond[min(gir, gir2)][max(gir, gir2)]) + "\n");
                    
                    break;
                
                case "maxbonds":
                case "maxbond":
                case "bondmax":
                case "bondsmax":
                    for (var _g = 1; _g <= global.playerGirls; _g++)
                    {
                        for (var _h = 1; _h <= global.playerGirls; _h++)
                        {
                            if (_h != _g)
                            {
                                global.girlBond[min(_h, _g)][max(_h, _g)] = bonding_pair_maxrank_real(_h, _g) * 100;
                                global.girlRelationship[min(_h, _g)][max(_h, _g)] = bonding_pair_maxrank_real(_h, _g);
                            }
                        }
                    }
                    
                    debugBacklog += "CONSOLE: maxing out all Haremon bonds!\n";
                    break;
                
                case "viewbond":
                case "bondscene":
                    var gir = 0;
                    var gir2 = 0;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if ((real(arg[0]) < 1 || real(arg[0]) > global.playerGirls) && !(real(arg[0]) >= -global.npcs && real(arg[0]) < 0))
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    if (string_letters(arg[1]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[1])
                                gir2 = itt;
                        }
                    }
                    else
                    {
                        arg[1] = string_digits(arg[1]);
                        
                        if (arg[1] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if ((real(arg[1]) < 1 || real(arg[1]) > global.playerGirls) && !(real(arg[1]) >= -global.npcs && real(arg[1]) < 0))
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir2 = real(arg[1]);
                    }
                    
                    arg[2] = string_digits(arg[2]);
                    
                    if (arg[2] == "")
                    {
                        debugBacklog += "ERROR: invalid relationship level\n";
                    }
                    else if (real(arg[2]) < 0 || real(arg[2]) > 5)
                    {
                        debugBacklog += "ERROR: invalid relationship level\n";
                    }
                    else if (gir <= 0 || gir2 <= 0)
                    {
                        debugBacklog += "ERROR: invalid girl ID\n";
                    }
                    else if (gir == gir2)
                    {
                        debugBacklog += "ERROR: a girl can't bond with herself!\n";
                    }
                    else
                    {
                        global.FLAG[83] = gir;
                        global.FLAG[84] = gir2;
                        global.FLAG[85] = floor(real(arg[2]));
                        global.FLAG[95] = 1;
                        debugBacklog += ("CONSOLE: viewing " + global.girlName[gir] + " and " + possessive(global.girlName[gir2]) + " bonding scene for rank " + string(arg[2]) + "\n");
                        global.sceneIndexNew = 176;
                        
                        if (room != rmVnTest)
                        {
                            global.sceneIndex = 176;
                            room_goto(rmVnTest);
                        }
                        else
                        {
                            alarm[1] = 1;
                        }
                    }
                    
                    break;
                
                case "rename":
                    var gir = 0;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                        
                        for (var itt = 1; itt <= global.npcs; itt++)
                        {
                            if (string_lower(global.npcNameShort[itt]) == arg[0] && gir == 0)
                                gir = -itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if ((real(arg[0]) < 1 || real(arg[0]) > global.playerGirls) && !(real(arg[0]) >= -global.npcs && real(arg[0]) < 0))
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    if (gir == 0)
                    {
                        debugBacklog += "ERROR: invalid girl ID\n";
                    }
                    else if (arg[1] == "" || string_pos("@", arg[1]) > 0 || string_pos("\\", arg[1]) > 0)
                    {
                        debugBacklog += "ERROR: invalid name! (you can't use @ or \\ in a character's name, or leave it blank)\n";
                    }
                    else if (gir > 0)
                    {
                        debugBacklog += ("CONSOLE: renaming " + global.girlName[gir] + " to " + string(argX[1]) + "\n");
                        global.girlName[gir] = argX[1];
                        global.girlName[girl_real_index(gir)] = argX[1];
                        
                        if (species_can_awaken(global.girlSpecies[gir]))
                            global.girlName[find_girl(species_trueform(global.girlSpecies[gir]))] = argX[1];
                    }
                    else
                    {
                        debugBacklog += ("CONSOLE: renaming " + global.npcNameShort[-gir] + " to " + string(argX[1]) + "\n");
                        global.npcName[-gir] = argX[1];
                        global.npcNameShort[-gir] = argX[1];
                    }
                    
                    break;
                
                case "fight":
                    var valid = true;
                    
                    for (var a = 0; a <= 2; a++)
                    {
                        if (arg[a] != "-1")
                            arg[a] = string_digits(arg[a]);
                        
                        if (arg[a] == "")
                        {
                            debugBacklog += "ERROR: invalid enemy ID\n";
                            valid = false;
                            break;
                        }
                        else
                        {
                            arg[a] = real(arg[a]);
                            
                            if (arg[a] != -1 && species_is_implemented(arg[a]) == false)
                            {
                                debugBacklog += "ERROR: invalid enemy ID\n";
                                valid = false;
                            }
                        }
                    }
                    
                    if (valid == true)
                    {
                        global.TEMP_FLAG[137] = true;
                        global.encounterEnemies = 0;
                        var be = 1;
                        
                        repeat (3)
                        {
                            global.encounterEnemySpecies[global.encounterEnemies + 1] = arg[be - 1];
                            
                            if (global.encounterEnemySpecies[global.encounterEnemies + 1] != -1)
                                global.encounterEnemies++;
                            
                            be++;
                        }
                        
                        if (global.encounterEnemies == 0)
                        {
                            debugBacklog += "ERROR: there must be at least one enemy!\n";
                        }
                        else
                        {
                            global.TEMP_FLAG[5] = max(-1, real2(arg[3]));
                            instance_create(0, 0, obj_demostart);
                            debugBacklog += "CONSOLE: beginning debug battle\n";
                        }
                    }
                    
                    break;
                
                case "dfight":
                    var _e = real(string_digits(arg[0]));
                    
                    if (_e <= 0)
                        _e = 1;
                    
                    start_dungeon_encounter(_e);
                    break;
                
                case "sfight":
                case "scriptedbattle":
                case "sb":
                    var _e = real(string_digits(arg[0]));
                    
                    if (_e <= 0)
                        _e = 1;
                    
                    scene_action_startscriptedbattle(_e);
                    break;
                
                case "shards":
                case "setshards":
                    var gir = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                            {
                                gir = itt;
                                break;
                            }
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if (real(arg[0]) < 1 || real(arg[0]) > global.playerGirls)
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    arg[1] = string_digits(arg[1]);
                    
                    if (arg[1] == "")
                    {
                        debugBacklog += "ERROR: invalid shard count\n";
                    }
                    else if (real(arg[1]) < 0)
                    {
                        debugBacklog += "ERROR: invalid shard count\n";
                    }
                    else if (gir == -1)
                    {
                        debugBacklog += "ERROR: invalid girl ID\n";
                    }
                    else
                    {
                        global.girlShards[gir] = real(arg[1]);
                        debugBacklog += ("CONSOLE: set " + possessive(global.girlName[gir]) + " shards to " + string(arg[1]) + "\n");
                    }
                    
                    break;
                
                case "petals":
                case "setpetals":
                    var gir = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                            {
                                gir = itt;
                                break;
                            }
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if (real(arg[0]) < 1 || real(arg[0]) > global.playerGirls)
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    arg[1] = string_digits(arg[1]);
                    
                    if (arg[1] == "")
                    {
                        debugBacklog += "ERROR: invalid petal count\n";
                    }
                    else if (real(arg[1]) < 0)
                    {
                        debugBacklog += "ERROR: invalid petal count\n";
                    }
                    else if (gir == -1)
                    {
                        debugBacklog += "ERROR: invalid girl ID\n";
                    }
                    else
                    {
                        global.girlPetals[gir] = real(arg[1]);
                        debugBacklog += ("CONSOLE: set " + possessive(global.girlName[gir]) + " petals to " + string(arg[1]) + "\n");
                    }
                    
                    break;
                
                case "girl$":
                case "girlmoney":
                    var gir = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                gir = itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if (real(arg[0]) < 1 || real(arg[0]) > global.playerGirls)
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    arg[1] = string_digits(arg[1]);
                    
                    if (arg[1] == "")
                    {
                        debugBacklog += "ERROR: invalid $ amount\n";
                    }
                    else if (real(arg[1]) < 0)
                    {
                        debugBacklog += "ERROR: invalid $ amount\n";
                    }
                    else if (gir == -1)
                    {
                        debugBacklog += "ERROR: invalid girl ID\n";
                    }
                    else
                    {
                        global.girlMoney[gir] = real(arg[1]);
                        debugBacklog += ("CONSOLE: set " + possessive(global.girlName[gir]) + " pocket money to " + string(arg[1]) + "\n");
                    }
                    
                    break;
                
                case "dressup":
                case "setoutfit":
                case "so":
                    var gir = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == string_lower(arg[0]))
                                gir = itt;
                        }
                        
                        for (var itt = 1; itt <= global.npcs; itt++)
                        {
                            if (string_lower(global.npcName[itt]) == string_lower(arg[0]))
                                gir = -itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if (real(arg[0]) < 1 || real(arg[0]) > global.playerGirls)
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    arg[1] = string_digits(arg[1]);
                    
                    if (gir == -1)
                    {
                        debugBacklog += "ERROR: invalid girl ID\n";
                    }
                    else if (arg[1] == "")
                    {
                        debugBacklog += "ERROR: invalid outfit\n";
                    }
                    else if (real(arg[1]) < 1 || (gir > 0 && !species_has_outfit(global.girlSpecies[gir], real(arg[1]))))
                    {
                        debugBacklog += "ERROR: invalid outfit\n";
                    }
                    else if (gir > 0)
                    {
                        global.girlOutfit[gir] = real(arg[1]);
                        debugBacklog += ("CONSOLE: set " + possessive(global.girlName[gir]) + " outfit to " + item_name(outfit_item(global.girlSpecies[gir], real(arg[1]))) + "\n");
                    }
                    else
                    {
                        global.npcOutfit[-gir] = real(arg[1]);
                        debugBacklog += ("CONSOLE: set " + possessive(global.npcName[-gir]) + " outfit to " + item_name(outfit_item(gir, real(arg[1]))) + "\n");
                    }
                    
                    break;
                
                case "setpanties":
                    var gir = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == string_lower(arg[0]))
                                gir = itt;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else if (real(arg[0]) < 1 || real(arg[0]) > global.playerGirls)
                            debugBacklog += "ERROR: invalid girl ID\n";
                        else
                            gir = real(arg[0]);
                    }
                    
                    var _pan;
                    
                    if (arg[1] == "")
                        _pan = -1;
                    else if (string_letters(arg[1]) != "")
                        _pan = find_item(arg[1]);
                    else
                        _pan = real(string_digits(arg[1]));
                    
                    var _lvl;
                    
                    if (string_digits(arg[2]) == "")
                        _lvl = -1;
                    else
                        _lvl = real(string_digits(arg[2]));
                    
                    if (gir == -1)
                    {
                        debugBacklog += "ERROR: invalid girl ID\n";
                    }
                    else if (arg[1] == "" || _pan == -1 || item_type(_pan) != 1)
                    {
                        debugBacklog += "ERROR: invalid item ID\n";
                    }
                    else if (_lvl < 0 || (_lvl > 0 && !panties_can_be_upgraded(_pan, _lvl - 1)))
                    {
                        debugBacklog += "ERROR: invalid panties level\n";
                    }
                    else
                    {
                        if (species_is_awoken(global.girlSpecies[gir]))
                            gir = girl_real_index(gir);
                        
                        if (global.girlPanties[gir] > 0)
                            scene_action_additem(girl_panties(gir), 1, girl_panties_level(gir), true);
                        
                        global.girlPanties[gir] = _pan + (_lvl / 10);
                        debugBacklog += ("CONSOLE: set " + possessive(global.girlName[gir]) + " panties to " + item_name(_pan, string(_lvl)) + "\n");
                    }
                    
                    break;
                
                case "setguildquest":
                    arg[0] = string_digits(arg[0]);
                    arg[1] = string_digits(arg[1]);
                    arg[2] = string_digits(arg[2]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid rank\n";
                    }
                    else if (real(arg[0]) > global.guildRankMax || real(arg[0]) < 0)
                    {
                        debugBacklog += "ERROR: invalid rank\n";
                    }
                    else if (arg[1] == "")
                    {
                        debugBacklog += "ERROR: invalid slot\n";
                    }
                    else if (real(arg[1]) > global.guildRankQuests[real(arg[0])] || real(arg[1]) < 1)
                    {
                        debugBacklog += "ERROR: invalid slot\n";
                    }
                    else if (arg[2] == "")
                    {
                        debugBacklog += "ERROR: invalid quest ID\n";
                    }
                    else if (real(arg[2]) > global.guildTotalQuests || real(arg[2]) < 1 || !guild_quest_implemented(real(arg[2])))
                    {
                        debugBacklog += "ERROR: invalid quest ID\n";
                    }
                    else
                    {
                        var r_ = real(arg[0]);
                        var q_ = real(arg[1]);
                        var gq = real(arg[2]);
                        global.guildRankQuest[r_][q_] = gq;
                        global.guildRankQuestParameter[r_][q_] = guild_quest_parameter(gq);
                        global.guildRankQuestParameter2[r_][q_] = guild_quest_parameter2(gq);
                        global.guildRankQuestParameter3[r_][q_] = guild_quest_parameter3(gq);
                        debugBacklog += ("CONSOLE: added " + guild_quest_name(gq) + " quest to guild, rank " + string(r_) + ", slot " + string(q_) + "\n");
                    }
                    
                    break;
                
                case "addquest":
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid quest ID\n";
                    }
                    else if (real(arg[0]) > global.quests || real(arg[0]) < 1 || quest_implemented(real(arg[0])) == false || (arg[0] > global.quests && !guild_quest_implemented(real(arg[0]) - global.quests)))
                    {
                        debugBacklog += "ERROR: invalid quest ID\n";
                    }
                    else
                    {
                        var qq = real(arg[0]);
                        
                        if (quest_is_active(qq))
                        {
                            debugBacklog += ("ERROR: " + quest_name(qq) + " is already active!\n");
                        }
                        else
                        {
                            debugBacklog += ("CONSOLE: added " + quest_name(qq) + " quest\n");
                            scene_action_addquest(qq);
                        }
                    }
                    
                    break;
                
                case "unlockcg":
                    if (arg[0] == "all")
                    {
                        debugBacklog += "CONSOLE: unlocking all CGs \n";
                        
                        for (var qq = 1; qq <= global.cgs; qq++)
                        {
                            if (!(cg_is_spoiler(qq) && true))
                                global.cgUnlocked[qq] = true;
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                        {
                            debugBacklog += "ERROR: invalid cg ID\n";
                        }
                        else if (real(arg[0]) > global.cgs || real(arg[0]) < 1 || (cg_is_spoiler(real(arg[0])) && true))
                        {
                            debugBacklog += "ERROR: invalid cg ID\n";
                        }
                        else
                        {
                            var qq = real(arg[0]);
                            debugBacklog += ("CONSOLE: unlocking CG " + string(qq) + " \n");
                            global.cgUnlocked[qq] = true;
                        }
                    }
                    
                    break;
                
                case "difficulty":
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid difficulty\n";
                    }
                    else if (real(arg[0]) > 3 || real(arg[0]) < 1 || real(arg[0]) != round(real(arg[0])))
                    {
                        debugBacklog += "ERROR: invalid difficulty\n";
                    }
                    else
                    {
                        var qq = real(arg[0]);
                        global.settingDifficulty = qq;
                        debugBacklog += ("CONSOLE: setting difficulty to " + difficulty_name(qq) + " \n");
                    }
                    
                    break;
                
                case "challenge":
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid difficulty\n";
                    }
                    else if (real(arg[0]) < 0)
                    {
                        debugBacklog += "ERROR: invalid difficulty\n";
                    }
                    else
                    {
                        var qq = real(arg[0]);
                        global.adaptiveDifficulty = qq;
                        debugBacklog += ("CONSOLE: setting challenge rating to " + string(qq) + " \n");
                    }
                    
                    break;
                
                case "unlockrecipes":
                    if (string_digits(arg[0]) != "")
                        arg[0] = real(string_digits(arg[0]));
                    else
                        arg[0] = 999;
                    
                    global.craftedItems = 0;
                    
                    for (var i_ = 1; i_ <= global.totalItems; i_++)
                    {
                        if (global.craftedItems < arg[0])
                        {
                            if (item_is_craftable(i_))
                            {
                                global.craftedItems++;
                                global.craftedItem[global.craftedItems] = i_;
                            }
                        }
                    }
                    
                    debugBacklog += ("CONSOLE: unlocking " + string(global.craftedItems) + " crafting recipes \n");
                    break;
                
                case "unlockmeals":
                    if (string_digits(arg[0]) != "")
                        arg[0] = real(string_digits(arg[0]));
                    else
                        arg[0] = 999;
                    
                    global.cookedMeals = 0;
                    
                    for (var i_ = 1; i_ <= global.totalMeals; i_++)
                    {
                        if (global.cookedMeals < arg[0])
                        {
                            if (meal_type(i_) == "SPECIAL")
                            {
                                global.cookedMeals++;
                                global.cookedMeal[global.cookedMeals] = i_;
                            }
                        }
                    }
                    
                    debugBacklog += ("CONSOLE: unlocking " + string(global.cookedMeals) + " cooking recipes \n");
                    break;
                
                case "receivetext":
                case "txt":
                    if (arg[0] == "all")
                    {
                        for (var i_ = 1; i_ <= global.totalSpecies; i_++)
                        {
                            var t_ = species_texts(global.speciesId[i_]);
                            
                            if (t_[1] != -1)
                                receive_text(t_[1], true);
                        }
                        
                        for (var i_ = 1; i_ <= global.npcs; i_++)
                        {
                            var t_ = npc_texts(i_);
                            
                            if (t_[1] != -1)
                                receive_text(t_[1], true);
                        }
                    }
                    else
                    {
                        arg[0] = string_digits(arg[0]);
                        
                        if (arg[0] == "")
                        {
                            debugBacklog += "ERROR: invalid message ID\n";
                        }
                        else if (real(arg[0]) < 1)
                        {
                            debugBacklog += "ERROR: invalid message ID\n";
                        }
                        else if (text_is_blocked(real(arg[0])))
                        {
                            debugBacklog += "ERROR: blocked message\n";
                        }
                        else
                        {
                            var qq = real(arg[0]);
                            debugBacklog += "CONSOLE: received message\n";
                            lonelyGirl = 1;
                            global.completedquest = 1;
                            receive_text(qq, true);
                        }
                    }
                    
                    break;
                
                case "setclothes":
                case "sc":
                    if (room == rmVnTest)
                    {
                        var acto = real(arg[0]);
                        var clot = real(arg[1]);
                        
                        if (!(acto > 0 && acto <= obj_vncontroller.sceneActors[obj_vncontroller.lineIndex]))
                        {
                            debugBacklog += "ERROR: invalid actor index\n";
                        }
                        else if (!(clot >= 0 && clot <= global.clothesMax))
                        {
                            debugBacklog += ("ERROR: invalid clothing index (range is 0 to " + string(global.clothesMax) + ")\n");
                        }
                        else
                        {
                            obj_vncontroller.actorClothes[acto] = clot;
                            debugBacklog += ("CONSOLE: set actor " + string(acto) + "'s clothing state to " + string(clot) + "\n");
                        }
                    }
                    else if (room == rmBattleTest)
                    {
                        if (arg[0] == "" || string_letters(arg[0]) != "")
                        {
                            debugBacklog += "ERROR: invalid actor index\n";
                        }
                        else if (real(arg[0]) > global.girls_ || real(arg[0]) < -global.enemies_ || real(arg[0]) == 0)
                        {
                            debugBacklog += "ERROR: invalid actor index\n";
                        }
                        else if (arg[1] == "" || string_letters(arg[1]) != "")
                        {
                            debugBacklog += "ERROR: invalid clothing state\n";
                        }
                        else if (real(arg[1]) > global.clothesMax || real(arg[1]) < 0)
                        {
                            debugBacklog += "ERROR: invalid clothing state\n";
                        }
                        else
                        {
                            var gg = real(arg[0]);
                            var nam = "";
                            
                            if (gg > 0)
                            {
                                nam = global.girlName[global.partyGirl[gg]];
                                global.girlClothed[global.partyGirl[gg]] = real(arg[1]);
                                global.girlClothedReal[global.partyGirl[gg]] = real(arg[1]);
                            }
                            else
                            {
                                nam = enemy_real_name(gg);
                                global.enemyClothed[-gg] = real(arg[1]);
                                global.enemyClothedReal[-gg] = real(arg[1]);
                            }
                            
                            debugBacklog += ("CONSOLE: set " + nam + "'s clothing state to " + string(real(arg[1])) + "\n");
                        }
                    }
                    else
                    {
                        debugBacklog += "ERROR: can't use that here!\n";
                    }
                    
                    break;
                
                case "setqueststep":
                    arg[0] = string_digits(arg[0]);
                    arg[1] = string_digits(arg[1]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid quest index\n";
                    }
                    else if (quest_find(real(arg[0])) <= 0)
                    {
                        debugBacklog += "ERROR: invalid quest index\n";
                    }
                    else if (arg[1] == "")
                    {
                        debugBacklog += "ERROR: invalid quest step\n";
                    }
                    else if (real(arg[1]) <= 0)
                    {
                        debugBacklog += "ERROR: invalid quest step\n";
                    }
                    else
                    {
                        var qq = real(arg[0]);
                        var qs = real(arg[1]);
                        debugBacklog += ("CONSOLE: advanced quest " + quest_name(qq) + " to step " + string(qs) + "\n");
                        global.questStep[quest_find(qq)] = qs;
                    }
                    
                    break;
                
                case "completequest":
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid quest index\n";
                    }
                    else if (quest_find(real(arg[0])) <= 0)
                    {
                        debugBacklog += "ERROR: invalid quest index\n";
                    }
                    else
                    {
                        var qq = real(arg[0]);
                        debugBacklog += ("CONSOLE: completed quest " + quest_name(qq) + "\n");
                        scene_action_completequest(qq);
                    }
                    
                    break;
                
                case "removequest":
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        debugBacklog += "ERROR: invalid quest index\n";
                    }
                    else if (quest_find(real(arg[0])) <= 0)
                    {
                        debugBacklog += "ERROR: invalid quest index\n";
                    }
                    else
                    {
                        var qq = real(arg[0]);
                        debugBacklog += ("CONSOLE: removed quest " + quest_name(qq) + "\n");
                        scene_action_removequest(qq);
                    }
                    
                    break;
                
                case "install":
                    if (arg[0] == "all")
                    {
                        debugBacklog += "CONSOLE: installing all apps\n";
                        
                        for (i = 1; i <= global.appsTotal; i++)
                        {
                            if ((i != 13 && i != 14 && i != 16 && i != 6 && i != 10) || 0)
                                global.appInstalled[i] = 1;
                        }
                    }
                    else if (string_digits(arg[0]) == "")
                    {
                        debugBacklog += "ERROR: invalid app\n";
                    }
                    else if (real(arg[0]) < 1 || real(arg[0]) > global.appsTotal)
                    {
                        debugBacklog += "ERROR: invalid app\n";
                    }
                    else
                    {
                        global.appInstalled[real(arg[0])] = true;
                        debugBacklog += ("CONSOLE: installing " + app_name(real(arg[0])) + " app\n");
                    }
                    
                    break;
                
                case "addcontact":
                    if (arg[0] == "all")
                    {
                        debugBacklog += "CONSOLE: adding all contacts\n";
                        
                        for (i = 1; i <= global.playerGirls; i++)
                        {
                            if (!species_is_awoken(global.girlSpecies[i]))
                                scene_action_addcontact(1, i);
                        }
                        
                        scene_action_addcontact(2, global.npcProfessor);
                        scene_action_addcontact(2, global.npcShopkeeper);
                        scene_action_addcontact(2, global.npcGuildMaster);
                        scene_action_addcontact(2, global.npcFarmer);
                        scene_action_addcontact(2, global.npcLadyInBlack);
                    }
                    else
                    {
                        debugBacklog += "ERROR: not implemented yet!\n";
                    }
                    
                    break;
                
                case "removecontact":
                    if (string_digits(arg[0]) == "")
                    {
                        debugBacklog += "ERROR: invalid contact number";
                    }
                    else
                    {
                        arg[0] = real(string_digits(arg[0]));
                        
                        if (arg[0] < 1 || arg[0] > global.contacts)
                        {
                            debugBacklog += "ERROR: invalid contact number";
                        }
                        else
                        {
                            debugBacklog += "CONSOLE: removing contact\n";
                            remove_contact(arg[0]);
                        }
                    }
                    
                    break;
                
                case "unlockenvironment":
                    if (arg[0] == "all")
                    {
                        for (var ei = 1; ei <= global.battleEnvironments; ei++)
                            global.environmentUnlocked[ei] = true;
                        
                        debugBacklog += "CONSOLE: unlocking all environments\n";
                        
                        if (room == rmTown)
                        {
                            with (obj_towncontroller)
                            {
                                for (var ei = 1; ei <= townOptions; ei++)
                                    optionAvailable[ei] = 1;
                            }
                        }
                    }
                    else if (string_digits(arg[0]) == "")
                    {
                        debugBacklog += "ERROR: invalid environment\n";
                    }
                    else if (real(arg[0]) < 1 || real(arg[0]) > global.battleEnvironments)
                    {
                        debugBacklog += "ERROR: invalid environment\n";
                    }
                    else
                    {
                        global.environmentUnlocked[real(arg[0])] = true;
                        debugBacklog += ("CONSOLE: unlocking " + global.battleEnvironmentProperName[real(arg[0])] + "\n");
                        
                        if (room == rmTown)
                        {
                            with (obj_towncontroller)
                                optionAvailable[real(arg[0])] = 1;
                        }
                    }
                    
                    break;
                
                case "save":
                    save_game(2);
                    debugBacklog += "CONSOLE: saving the game\n";
                    break;
                
                case "town":
                    global.leavingDungeon = true;
                    scene_action_gotoroom(2);
                    global.FLAG[61] = 0;
                    debugBacklog += ("CONSOLE: returning to " + global.townName + "\n");
                    break;
                
                case "addgirl":
                    appOpen = 0;
                    var spec_ = -1;
                    
                    if (string_letters(arg[0]) != "")
                    {
                        for (var hhh = 1; hhh <= global.totalSpecies; hhh++)
                        {
                            if (string_lower(species_name(global.speciesId[hhh])) == string_letters(arg[0]))
                                spec_ = global.speciesId[hhh];
                        }
                    }
                    else if (real(arg[0]) > global.totalSpecies || real(arg[0]) < 1)
                    {
                        spec_ = -1;
                    }
                    else
                    {
                        spec_ = real(arg[0]);
                    }
                    
                    if (spec_ == -1 || (species_is_implemented(spec_) == false && true))
                    {
                        debugBacklog += "ERROR: invalid species ID\n";
                    }
                    else
                    {
                        if (argX[1] == "")
                            argX[1] = species_name(spec_);
                        
                        scene_action_add_girl(spec_, 1, argX[1], false);
                        
                        if (global.partyGirls < global.partySize)
                            scene_action_add_girl_to_party(global.playerGirls);
                        else
                            scene_action_sendgirltoranch(global.playerGirls);
                        
                        debugBacklog += ("CONSOLE: adding " + species_name(spec_) + "\n");
                    }
                    
                    break;
                
                case "inflict":
                    var ind = 0;
                    var valid = true;
                    
                    if (string_letters(arg[0]) == "")
                    {
                        ind = real(arg[0]);
                        
                        if (room == rmBattleTest)
                        {
                            if (ind > global.girls_ || ind < -global.enemies_)
                            {
                                debugBacklog += "ERROR: invalid actor index\n";
                                valid = false;
                            }
                            else if (ind > 0)
                            {
                                ind = global.partyGirl[ind];
                            }
                        }
                        else if (ind > global.playerGirls)
                        {
                            debugBacklog += "ERROR: invalid actor index\n";
                            valid = false;
                        }
                    }
                    else
                    {
                        for (var itt = 1; itt <= global.playerGirls; itt++)
                        {
                            if (string_lower(global.girlName[itt]) == arg[0])
                                ind = itt;
                        }
                    }
                    
                    if (ind == 0)
                    {
                        debugBacklog += "ERROR: invalid actor index\n";
                        valid = false;
                    }
                    
                    var cond = 0;
                    
                    if (string_letters(arg[1]) == "")
                    {
                        cond = real(arg[1]);
                        
                        if (cond > 30 || cond < 0)
                        {
                            debugBacklog += "ERROR: invalid condition index\n";
                            valid = false;
                        }
                    }
                    else
                    {
                        for (var itt = 0; itt <= 30; itt++)
                        {
                            if (string_lower(condition_name(itt)) == arg[1] || string_lower(condition_name_noun(itt)) == arg[1])
                                cond = itt;
                        }
                    }
                    
                    if (cond == 0)
                    {
                        debugBacklog += "ERROR: invalid condition index\n";
                        valid = false;
                    }
                    
                    if (valid == true)
                    {
                        var nam;
                        
                        if (ind >= 0)
                        {
                            nam = global.girlName[ind];
                            
                            if (global.girlCondition[ind][1] == 0)
                                global.girlConditions[ind] = 0;
                            
                            global.girlConditions[ind]++;
                            global.girlCondition[ind][global.girlConditions[ind]] = cond;
                            
                            if (cond == 14)
                                global.girlPleasure[ind] = 100;
                            
                            if (room == rmBattleTest)
                            {
                                obj_battlecontroller.girlFreezeTimer[party_find_girl(ind)] = obj_battlecontroller.freezeTimerMax;
                                obj_battlecontroller.fearTurns[girl_position_in_party(ind)] = 0;
                            }
                        }
                        else
                        {
                            nam = global.enemyName[-ind];
                            
                            if (global.enemyCondition[-ind][1] == 0)
                                global.enemyConditions[-ind] = 0;
                            
                            global.enemyConditions[-ind]++;
                            global.enemyCondition[-ind][global.enemyConditions[-ind]] = cond;
                            obj_battlecontroller.enemyFreezeTimer[-ind] = obj_battlecontroller.freezeTimerMax;
                            obj_battlecontroller.fearTurnsE[-ind] = 0;
                            
                            if (cond == 14)
                                global.enemyPleasure[-ind] = 100;
                        }
                        
                        debugBacklog += ("CONSOLE: inflicting " + condition_name(cond) + " status on " + nam + "\n");
                    }
                    
                    break;
                
                case "beastmode":
                    if (room != rmBattleTest)
                    {
                        debugBacklog += "ERROR: can only be used in battle!\n";
                        var valid = false;
                    }
                    else
                    {
                        var boost = 999999;
                        set_boost(1, 1, boost);
                        set_boost(1, 2, boost);
                        set_boost(1, 3, boost);
                        set_boost(1, 4, 99);
                        set_boost(1, 0, boost);
                        set_boost(2, 1, boost);
                        set_boost(2, 2, boost);
                        set_boost(2, 3, boost);
                        set_boost(2, 4, 99);
                        set_boost(2, 0, boost);
                        set_boost(3, 1, boost);
                        set_boost(3, 2, boost);
                        set_boost(3, 3, boost);
                        set_boost(3, 4, 99);
                        set_boost(3, 0, boost);
                        debugBacklog += "CONSOLE: entering Beast Mode";
                    }
                    
                    break;
                
                case "scent":
                    if (room != rmBattleTest)
                    {
                        debugBacklog += "ERROR: can only be used in battle!\n";
                        var valid = false;
                    }
                    else
                    {
                        with (obj_battlecontroller)
                        {
                            enemyScented[1] = true;
                            enemyScented[2] = true;
                            enemyScented[3] = true;
                        }
                        
                        debugBacklog += "CONSOLE: scenting all enemies\n";
                    }
                    
                    break;
                
                case "boostfor":
                case "boostpow":
                case "boostall":
                case "boostspd":
                case "boostagi":
                case "boostcrit":
                    var ind = 0;
                    var valid = true;
                    ind = real(arg[0]);
                    
                    if (room != rmBattleTest)
                    {
                        debugBacklog += "ERROR: can only be used in battle!\n";
                        valid = false;
                    }
                    else
                    {
                        if (ind > global.girls_ || ind < -global.enemies_ || ind == 0)
                        {
                            debugBacklog += "ERROR: invalid actor index\n";
                            valid = false;
                        }
                        
                        if (string_digits(arg[1]) == "")
                        {
                            debugBacklog += "ERROR: invalid boost\n";
                        }
                        else if (valid == true)
                        {
                            var boost = real(arg[1]);
                            var nam;
                            
                            if (ind >= 0)
                                nam = global.girlName[global.partyGirl[ind]];
                            else
                                nam = global.enemyName[-ind];
                            
                            if (keyword == "boostfor")
                                set_boost(ind, 1, boost);
                            else if (keyword == "boostall")
                                set_boost(ind, 2, boost);
                            else if (keyword == "boostpow")
                                set_boost(ind, 3, boost);
                            else if (keyword == "boostspd")
                                set_boost(ind, 4, boost);
                            else if (keyword == "boostagi")
                                set_boost(ind, 0, boost);
                            else if (keyword == "boostcrit")
                                set_boost(ind, 7, boost);
                            
                            debugBacklog += ("CONSOLE: setting " + nam + "'s stat boost to " + string(boost) + "\n");
                        }
                    }
                    
                    break;
                
                case "hp":
                case "sethp":
                    var ind = 0;
                    var valid = true;
                    
                    if (string_digits(arg[0]) == "")
                    {
                        debugBacklog += "ERROR: invalid actor value. use -3 to 3 (only in battle)\n";
                        break;
                    }
                    
                    ind = real(arg[0]);
                    
                    if (room != rmBattleTest)
                    {
                        debugBacklog += "ERROR: can only be used in battle!\n";
                        valid = false;
                    }
                    else
                    {
                        if (ind > global.girls_ || ind < -global.enemies_ || ind == 0)
                        {
                            debugBacklog += "ERROR: invalid actor index\n";
                            valid = false;
                        }
                        
                        if (string_digits(arg[1]) == "")
                        {
                            debugBacklog += "ERROR: invalid HP value\n";
                        }
                        else if (valid == true)
                        {
                            var boost = real(arg[1]);
                            var nam = "NULL";
                            
                            if (ind >= 0)
                            {
                                nam = global.girlName[global.partyGirl[ind]];
                                global.girlHp[global.partyGirl[ind]] = boost;
                                obj_battlecontroller.girlTargetHp[ind] = boost;
                            }
                            else
                            {
                                nam = global.enemyName[-ind];
                                global.enemyHp[-ind] = boost;
                                obj_battlecontroller.enemyTargetHp[-ind] = boost;
                            }
                            
                            debugBacklog += ("CONSOLE: setting " + nam + "'s HP to " + string(boost) + "\n");
                        }
                    }
                    
                    break;
                
                case "pleasure":
                case "setpleasure":
                    var ind = 0;
                    var valid = true;
                    
                    if (string_digits(arg[0]) == "")
                    {
                        debugBacklog += "ERROR: invalid actor value. use -3 to 3 (only in battle)\n";
                        break;
                    }
                    
                    ind = real(arg[0]);
                    
                    if (room != rmBattleTest)
                    {
                        debugBacklog += "ERROR: can only be used in battle!\n";
                        valid = false;
                    }
                    else
                    {
                        if (ind > global.girls_ || ind < -global.enemies_ || ind == 0)
                        {
                            debugBacklog += "ERROR: invalid actor index\n";
                            valid = false;
                        }
                        
                        if (string_digits(arg[1]) == "")
                        {
                            debugBacklog += "ERROR: invalid value (must be 1 to 100)\n";
                        }
                        else if (valid == true)
                        {
                            var boost = real(arg[1]);
                            var nam = "NULL";
                            
                            if (ind >= 0)
                            {
                                nam = global.girlName[global.partyGirl[ind]];
                                global.girlPleasure[global.partyGirl[ind]] = boost;
                            }
                            else
                            {
                                nam = global.enemyName[-ind];
                                global.enemyPleasure[-ind] = boost;
                            }
                            
                            debugBacklog += ("CONSOLE: setting " + nam + "'s " + pleasure_term() + " to " + string(boost) + "\n");
                        }
                    }
                    
                    break;
                
                case "kill":
                    if (room != rmBattleTest)
                    {
                        debugBacklog += "ERROR: can only be used in battle!\n";
                    }
                    else
                    {
                        var ind = 0;
                        
                        if (arg[0] == "")
                        {
                            debugBacklog += "ERROR: invalid actor index\n";
                        }
                        else
                        {
                            ind = real(arg[0]);
                            
                            if (ind > global.girls_ || ind < -global.enemies_ || ind == 0)
                            {
                                debugBacklog += "ERROR: invalid actor index\n";
                            }
                            else
                            {
                                var nam;
                                
                                if (ind >= 0)
                                {
                                    nam = global.girlName[global.partyGirl[ind]];
                                    global.girlHp[global.partyGirl[ind]] = 0;
                                }
                                else
                                {
                                    nam = global.enemyName[-ind];
                                    global.enemyHp[-ind] = 0;
                                }
                                
                                global.battlePhase = global.phaseWait;
                                debugBacklog += ("CONSOLE: killing " + nam + "\n");
                            }
                        }
                    }
                    
                    break;
                
                case "gameover":
                    if (room != rmBattleTest)
                    {
                        debugBacklog += "ERROR: can only be used in battle!\n";
                    }
                    else
                    {
                        global.girlHp[global.partyGirl[1]] = 0;
                        global.girlHp[global.partyGirl[2]] = 0;
                        global.girlHp[global.partyGirl[3]] = 0;
                    }
                    
                    break;
                
                case "victory":
                case "v":
                case "win":
                    if (room != rmBattleTest)
                    {
                        debugBacklog += "ERROR: this command can only be used in battle!\n";
                    }
                    else
                    {
                        with (obj_battlecontroller)
                        {
                            for (var e_ = 1; e_ <= global.enemies_; e_++)
                            {
                                if (global.enemySpecies[e_] < 100 && global.enemyShadow[e_] == false)
                                {
                                    enemyTamed[e_] = true;
                                }
                                else if (global.enemySpecies[e_] == global.monsterWatcher)
                                {
                                    global.enemyHp[e_] = 1;
                                    enemyTargetHp[e_] = 1;
                                }
                                else
                                {
                                    global.enemyConditions[e_] = 1;
                                    global.enemyCondition[e_][1] = 8;
                                    global.enemyHp[e_] = 0;
                                }
                            }
                            
                            global.battlePhase = global.phaseWait;
                            reset_camera_position();
                            reset_girl_expressions();
                            reset_girl_positions();
                            global.pacifistSuccess = false;
                        }
                    }
                    
                    break;
                
                case "pacifistvictory":
                    if (room != rmBattleTest)
                    {
                        debugBacklog += "ERROR: this command can only be used in battle!\n";
                    }
                    else
                    {
                        with (obj_battlecontroller)
                        {
                            global.enemyHp[1] = 0;
                            global.enemyHp[2] = 0;
                            global.enemyHp[3] = 0;
                            global.enemyConditions[1] = 1;
                            global.enemyCondition[1][1] = 8;
                            global.enemyConditions[2] = 1;
                            global.enemyCondition[2][1] = 8;
                            global.enemyConditions[3] = 1;
                            global.enemyCondition[3][1] = 8;
                            global.battlePhase = global.phaseWait;
                            reset_camera_position();
                            reset_girl_expressions();
                            reset_girl_positions();
                        }
                    }
                    
                    break;
                
                case "setprompts":
                    if (real(arg[0]) == 0 || real(arg[0]) == 1 || real(arg[0]) == 2)
                    {
                        global.settingPromptMode = real(arg[0]);
                        debugBacklog += ("CONSOLE: Setting prompt mode to " + string(real(arg[0])) + "\n");
                    }
                    else
                    {
                        debugBacklog += "ERROR: invalid setting\n";
                    }
                    
                    break;
                
                case "unlocktutorial":
                    if (arg[0] == "all")
                    {
                        for (var t = 1; t <= global.tutorials; t++)
                            global.tutorialCompleted[t] = true;
                        
                        debugBacklog += "CONSOLE: Unlocking all tutorials\n";
                    }
                    else if (!(real(arg[0]) < 1 || real(arg[0]) > global.tutorials))
                    {
                        global.tutorialCompleted[real(arg[0])] = true;
                        debugBacklog += ("CONSOLE: Unlocking tutorial #" + string(real(arg[0])) + ": \"" + tutorial_title(real(arg[0])) + "\"\n");
                    }
                    else
                    {
                        debugBacklog += "ERROR: invalid tutorial index\n";
                    }
                    
                    break;
                
                case "unlocknote":
                    if (arg[0] == "all")
                    {
                        for (var t = 1; t <= total_lore(); t++)
                            global.loreUnlocked[t] = true;
                        
                        debugBacklog += "CONSOLE: Unlocking all notes\n";
                    }
                    else if (!(real(arg[0]) < 1 || real(arg[0]) > total_lore()))
                    {
                        global.tutorialCompleted[real(arg[0])] = true;
                        debugBacklog += ("CONSOLE: Unlocking note #" + string(real(arg[0])) + ": \"" + lore_name(real(arg[0])) + "\"\n");
                    }
                    else
                    {
                        debugBacklog += "ERROR: invalid note index\n";
                    }
                    
                    break;
                
                case "removeitem":
                    if (arg[0] == "all")
                    {
                        var siz = bag_size();
                        
                        for (var n = 1; n <= siz; n++)
                        {
                            global.bagItem[n] = -1;
                            global.bagItemQuantity[n] = 0;
                        }
                        
                        debugBacklog += "CONSOLE: deleting all items\n";
                    }
                    else
                    {
                        var git;
                        
                        if (string_letters(arg[0]) != "")
                        {
                            for (var itt = 1; itt <= global.totalItems; itt++)
                            {
                                if (string_replace_all(string_lower(item_name(itt)), " ", "_") == arg[0])
                                    git = itt;
                            }
                        }
                        else
                        {
                            git = real(arg[0]);
                        }
                        
                        if (git < 1 || git > global.totalItems)
                        {
                            debugBacklog += "ERROR: invalid item ID\n";
                        }
                        else
                        {
                            scene_action_removeitem(git, -1);
                            debugBacklog += ("CONSOLE: deleting " + item_name(git) + "\n");
                        }
                    }
                    
                    break;
                
                case "itemlist":
                    for (var nnn = 0; nnn < global.totalItems; nnn += 50)
                    {
                        var str = "";
                        
                        for (var n = 1; n <= 50; n++)
                        {
                            var n2 = n + nnn;
                            
                            if (n2 <= global.totalItems)
                            {
                                if (item_name(n2) == "???")
                                    str += (string(n2) + ": ??? [undefined]\n");
                                else if (!item_is_easteregg(n2) && item_is_implemented(n2) && !item_is_spoiler(n2))
                                    str += (string(n2) + ": " + item_name(n2) + "\n");
                                else
                                    str += (string(n2) + ": ??? [secret item]\n");
                            }
                        }
                        
                        show_message(str);
                    }
                    
                    debugBacklog += "CONSOLE: showing item list\n";
                    break;
                
                case "scenelist":
                    var nnn = 0;
                    
                    while (nnn < global.totalScenes)
                    {
                        var str = "";
                        
                        repeat (40)
                        {
                            do
                                nnn += 0.1;
                            until (scene_name(nnn) != "???" || nnn > global.totalScenes);
                            
                            var dig = 3;
                            
                            if (nnn < 10)
                                dig = 1;
                            else if (nnn < 100)
                                dig = 2;
                            
                            if (nnn <= global.totalScenes)
                                str += (string_format(nnn, dig, nnn != round(nnn)) + ": " + scene_name(nnn) + "\n");
                        }
                        
                        show_message(str);
                    }
                    
                    debugBacklog += "CONSOLE: showing scene list\n";
                    break;
                
                case "techlist":
                    for (var nnn = 0; nnn < global.totalTechniques; nnn += 50)
                    {
                        var str = "";
                        
                        for (var n = 1; n <= 50; n++)
                        {
                            var n2 = n + nnn;
                            
                            if (n2 <= global.totalTechniques && technique_is_implemented(n2))
                                str += (string(n2) + ": " + technique_name(n2) + "\n");
                        }
                        
                        show_message(str);
                    }
                    
                    debugBacklog += "CONSOLE: showing technique list\n";
                    break;
                
                case "kinklist":
                    for (var nnn = 0; nnn < global.totalKinks; nnn += 50)
                    {
                        var str = "";
                        
                        for (var n = 1; n <= 50; n++)
                        {
                            var n2 = n + nnn;
                            
                            if (n2 <= global.totalKinks)
                                str += (string(n2) + ": " + kink_name(n2) + "\n");
                        }
                        
                        show_message(str);
                    }
                    
                    debugBacklog += "CONSOLE: showing kink list\n";
                    break;
                
                case "checkflag":
                    var valid = true;
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        valid = false;
                    }
                    else
                    {
                        var f = real(arg[0]);
                        
                        if (f < 1 || f > global.FLAGS)
                            valid = false;
                        else
                            debugBacklog += ("CONSOLE: flag " + string(f) + " is set to " + string(global.FLAG[f]) + "\n");
                    }
                    
                    if (valid == false)
                        debugBacklog += "ERROR: invalid flag ID!\n";
                    
                    break;
                
                case "setflag":
                    var valid = true;
                    var f;
                    
                    if (arg[0] == "")
                    {
                        valid = false;
                    }
                    else
                    {
                        f = real(arg[0]);
                        
                        if (f < 0 || f > global.FLAGS || (flag_is_secret(f) && 1))
                            valid = false;
                    }
                    
                    if (valid == false)
                    {
                        debugBacklog += "ERROR: invalid flag ID!\n";
                    }
                    else
                    {
                        if (arg[1] == "")
                        {
                            valid = false;
                        }
                        else
                        {
                            var g = real(arg[1]);
                            
                            if (!is_real(g))
                            {
                                valid = false;
                            }
                            else
                            {
                                debugBacklog += ("CONSOLE: setting flag " + string(f) + " to " + string(g) + "\n");
                                global.FLAG[f] = g;
                            }
                        }
                        
                        if (valid == false)
                            debugBacklog += "ERROR: invalid flag value!\n";
                    }
                    
                    break;
                
                case "checktempflag":
                    var valid = true;
                    arg[0] = string_digits(arg[0]);
                    
                    if (arg[0] == "")
                    {
                        valid = false;
                    }
                    else
                    {
                        var f = real(arg[0]);
                        
                        if (f < 0 || f > global.TEMP_FLAGS)
                            valid = false;
                        else
                            debugBacklog += ("CONSOLE: temp flag " + string(f) + " is set to " + string(global.TEMP_FLAG[f]) + "\n");
                    }
                    
                    if (valid == false)
                        debugBacklog += "ERROR: invalid flag ID!\n";
                    
                    break;
                
                case "settempflag":
                    var valid = true;
                    arg[0] = string_digits(arg[0]);
                    var f;
                    
                    if (arg[0] == "")
                    {
                        valid = false;
                    }
                    else
                    {
                        f = real(arg[0]);
                        
                        if (f < 0 || f > global.TEMP_FLAGS || f == 151)
                            valid = false;
                    }
                    
                    if (valid == false)
                    {
                        debugBacklog += "ERROR: invalid flag ID!\n";
                    }
                    else
                    {
                        arg[1] = string_digits(arg[1]);
                        
                        if (arg[1] == "")
                        {
                            valid = false;
                        }
                        else
                        {
                            var g = real(arg[1]);
                            
                            if (g < 0)
                            {
                                valid = false;
                            }
                            else
                            {
                                debugBacklog += ("CONSOLE: setting temp flag " + string(f) + " to " + string(g) + "\n");
                                global.TEMP_FLAG[f] = g;
                            }
                        }
                        
                        if (valid == false)
                            debugBacklog += "ERROR: invalid flag value!\n";
                    }
                    
                    break;
                
                case "questlist":
                    for (var nnn = 0; nnn < global.quests; nnn += 50)
                    {
                        var str = "";
                        
                        for (var n = 1; n <= 50; n++)
                        {
                            var n2 = n + nnn;
                            
                            if (n2 <= global.quests)
                            {
                                if (quest_implemented(n2))
                                    str += (string(n2) + ": " + quest_name(n2) + "\n");
                                else
                                    str += (string(n2) + ": ???");
                            }
                        }
                        
                        show_message(str);
                    }
                    
                    debugBacklog += "CONSOLE: showing quest list\n";
                    break;
                
                case "guildquestlist":
                    for (var nnn = 0; nnn < global.guildTotalQuests; nnn += 50)
                    {
                        var str = "";
                        
                        for (var n = 1; n <= 50; n++)
                        {
                            var n2 = n + nnn;
                            
                            if (n2 <= global.guildTotalQuests)
                                str += (string(n2) + ": " + guild_quest_name(n2) + "\n");
                        }
                        
                        show_message(str);
                    }
                    
                    debugBacklog += "CONSOLE: showing guild quest list\n";
                    break;
                
                case "specieslist":
                    var str = "";
                    
                    for (var n = 1; n <= 300; n++)
                    {
                        if (species_is_implemented(n) && species_name(n) != "???" && !species_is_spoiler(n))
                            str += (string(n) + ": " + species_name(n) + "\n");
                    }
                    
                    show_message(str);
                    debugBacklog += "CONSOLE: showing \"species\" list\n";
                    break;
                
                case "haremonlist":
                    var str = "";
                    
                    for (var n = 1; n <= global.playerGirls; n++)
                    {
                        str += (string(n) + ": " + global.girlName[n]);
                        
                        if (species_is_awoken(global.girlSpecies[n]))
                            str += " (Awakened)";
                        
                        str += "\n";
                    }
                    
                    show_message(str);
                    debugBacklog += "CONSOLE: showing Haremon name list\n";
                    break;
                
                case "settime":
                    var tim_ = -1;
                    
                    switch (string_lower(string_letters(arg[0])))
                    {
                        case "morning":
                            tim_ = 0;
                            break;
                        
                        case "afternoon":
                            tim_ = 1;
                            break;
                        
                        case "evening":
                            tim_ = 2;
                            break;
                        
                        case "night":
                            tim_ = 3;
                            break;
                    }
                    
                    if (tim_ == -1)
                    {
                        debugBacklog += "ERROR: invalid time of day! Enter morning, afternoon, evening, or night\n";
                    }
                    else
                    {
                        global.timeOfDay = tim_;
                        debugBacklog += ("CONSOLE: setting time to " + time_string(global.timeOfDay) + "\n");
                    }
                    
                    break;
                
                case "setday":
                    var tim_ = -1;
                    
                    switch (string_lower(string_letters(arg[0])))
                    {
                        case "monday":
                            tim_ = 1;
                            break;
                        
                        case "tuesday":
                            tim_ = 2;
                            break;
                        
                        case "wednesday":
                            tim_ = 3;
                            break;
                        
                        case "thursday":
                            tim_ = 4;
                            break;
                        
                        case "friday":
                            tim_ = 5;
                            break;
                        
                        case "saturday":
                            tim_ = 6;
                            break;
                        
                        case "sunday":
                            tim_ = 7;
                            break;
                    }
                    
                    if (tim_ == -1)
                    {
                        debugBacklog += "ERROR: invalid day! Enter the name of a day\n";
                    }
                    else
                    {
                        global.dayOfWeek = tim_;
                        debugBacklog += ("CONSOLE: setting day to " + day_name(global.dayOfWeek) + "\n");
                    }
                    
                    break;
                
                case "tomorrow":
                case "t":
                    scene_action_advanceday();
                    debugBacklog += "CONSOLE: advancing to the next day\n";
                    break;
                
                case "later":
                    scene_action_advancetime();
                    debugBacklog += "CONSOLE: advancing to the next time of day\n";
                    break;
                
                case "attentive":
                    if (global.TEMP_FLAG[57] == 0)
                    {
                        global.TEMP_FLAG[57] = 1;
                        debugBacklog += "CONSOLE: activating attention hack\n";
                    }
                    else
                    {
                        global.TEMP_FLAG[57] = 0;
                        debugBacklog += "CONSOLE: deactivating attention hack\n";
                    }
                    
                    break;
                
                case "unlimitedpower":
                    if (global.FLAG[323] == 0)
                    {
                        global.FLAG[323] = 1;
                        debugBacklog += "CONSOLE: activating tech limit hack\n";
                    }
                    else
                    {
                        global.FLAG[323] = 0;
                        debugBacklog += "CONSOLE: deactivating tech limit hack\n";
                    }
                    
                    break;
                
                case "fullheal":
                    for (var n = 1; n <= global.playerGirls; n++)
                    {
                        global.girlHp[n] = global.girlMaxHp[n];
                        global.girlConditions[n] = 1;
                        global.girlCondition[n][1] = 0;
                        global.girlClothed[n] = global.clothesMax;
                        
                        if (room == rmBattleTest)
                        {
                            if (girl_position_in_party(n) < 4 && girl_position_in_party(n) > 0)
                                obj_battlecontroller.girlTargetHp[girl_position_in_party(n)] = global.girlHp[n];
                            
                            global.girlClothedReal[n] = global.clothesMax;
                        }
                    }
                    
                    debugBacklog += "CONSOLE: fully healing HP and status of all Haremon\n";
                    break;
                
                case "sin":
                    var amt_ = real(string_digits(arg[2]));
                    
                    if (amt_ < 0)
                    {
                        debugBacklog += "ERROR: invalid number!\n";
                    }
                    else
                    {
                        var sin_ = arg[1];
                        
                        switch (sin_)
                        {
                            case "lust":
                                global.playerLust = amt_;
                                debugBacklog += ("CONSOLE: setting Lust to " + string(amt_) + "\n");
                                break;
                            
                            case "wrath":
                                global.playerWrath = amt_;
                                debugBacklog += ("CONSOLE: setting Wrath to " + string(amt_) + "\n");
                                break;
                            
                            case "gluttony":
                                global.playerGluttony = amt_;
                                debugBacklog += ("CONSOLE: setting Gluttony to " + string(amt_) + "\n");
                                break;
                            
                            case "avarice":
                                global.playerAvarice = amt_;
                                debugBacklog += ("CONSOLE: setting Avarice to " + string(amt_) + "\n");
                                break;
                            
                            case "sloth":
                                global.playerSloth = amt_;
                                debugBacklog += ("CONSOLE: setting Sloth to " + string(amt_) + "\n");
                                break;
                            
                            case "pride":
                                global.playerPride = amt_;
                                debugBacklog += ("CONSOLE: setting Pride to " + string(amt_) + "\n");
                                break;
                            
                            case "envy":
                                global.playerEnvy = amt_;
                                debugBacklog += ("CONSOLE: setting Envy to " + string(amt_) + "\n");
                                break;
                            
                            default:
                                debugBacklog += "ERROR: invalid sin!\n";
                                break;
                        }
                    }
                    
                    break;
                
                case "enemyinfo":
                    if (room == rmBattleTest)
                    {
                        with (obj_battlecontroller)
                        {
                            var str = "ENEMY INFO\n\n";
                            
                            for (i = 1; i <= 3; i++)
                            {
                                if (global.enemies_ >= i)
                                {
                                    str += ("ENEMY 1: " + species_name(global.enemySpecies[i]) + "\n");
                                    str += ("fortitude: " + string(global.enemyFortitude[i]) + "\n");
                                    str += ("allure: " + string(global.enemyAllure[i]) + "\n");
                                    str += ("power: " + string(global.enemyPower[i]) + "\n");
                                    str += ("speed: " + string(global.enemySpeed[i]) + "\n");
                                    str += ("move 1: " + technique_name(global.enemyTechnique[i][1]) + " (level " + string(global.enemyTechniqueLevel[i][1]) + ")\n");
                                    
                                    if (global.enemyTechniques[i] > 1)
                                    {
                                        str += ("move 2: " + technique_name(global.enemyTechnique[i][2]) + " (level " + string(global.enemyTechniqueLevel[i][2]) + ")\n");
                                        
                                        if (global.enemyTechniques[i] > 2)
                                        {
                                            str += ("move 3: " + technique_name(global.enemyTechnique[i][3]) + " (level " + string(global.enemyTechniqueLevel[i][3]) + ")\n");
                                            
                                            if (global.enemyTechniques[i] > 3)
                                            {
                                                str += ("move 4: " + technique_name(global.enemyTechnique[i][4]) + " (level " + string(global.enemyTechniqueLevel[i][4]) + ")\n");
                                                
                                                if (global.enemyTechniques[i] > 4)
                                                    str += ("move 4: " + technique_name(global.enemyTechnique[i][5]) + " (level " + string(global.enemyTechniqueLevel[i][5]) + ")\n");
                                            }
                                        }
                                    }
                                    
                                    str += "\n";
                                }
                            }
                            
                            show_message(str);
                        }
                        
                        debugBacklog += "CONSOLE: displaying enemy rundown\n";
                    }
                    else
                    {
                        debugBacklog += "ERROR: can only be used in battle!\n";
                    }
                    
                    break;
                
                case "resettechs":
                    debugBacklog += "CONSOLE: Resetting techniques";
                    
                    for (i = 1; i <= global.playerGirls; i++)
                    {
                        global.girlTechniques[i] = 0;
                        var techs_ = species_moveset(global.girlSpecies[i]);
                        var techcost_ = species_moveset_cost(global.girlSpecies[i]);
                        global.girlTechniqueLimit[i] = 5;
                        
                        for (var t_ = 0; t_ < array_length_1d(techs_); t_++)
                        {
                            if (techcost_[t_] == 0)
                            {
                                global.girlTechniques[i]++;
                                global.girlTechnique[i][global.girlTechniques[i]] = techs_[t_];
                                global.girlTechniqueLevel[i][global.girlTechniques[i]] = 0;
                                global.girlTechniqueActive[i][global.girlTechniques[i]] = false;
                                global.girlTechniqueActive[i][global.girlTechniques[i]] = can_set_technique(i, techs_[t_]);
                                global.girlTechniqueInvestment[i][global.girlTechniques[i]] = 0;
                            }
                        }
                    }
                    
                    break;
                
                case "ranchprogress":
                    var str = "";
                    
                    for (var g = 1; g <= global.ranchGirls; g++)
                        str += (global.girlName[global.ranchGirl[g]] + ": " + string(ranch_girl_progress(g)) + "\n");
                    
                    show_message(str);
                    debugBacklog += "CONSOLE: Showing ranch activity progress values\n";
                    break;
                
                case "hello":
                case "hi":
                    debugBacklog += "Hi! I hope you're having a nice day. If you're not, then I hope it gets better!\n";
                    break;
                
                case "getitemid":
                    for (i = 0; i <= global.totalItems; i++)
                    {
                        if (string_lower(item_name_base(i)) == string_replace_all(string_lower(arg[0]), "_", " "))
                        {
                            debugBacklog += ("CONSOLE: Item \"" + arg[0] + "\" has item ID #" + string(i) + "\n");
                            debugged = true;
                            break;
                        }
                    }
                    
                    if (!debugged)
                        debugBacklog += "ERROR: Item not found!\n";
                    
                    break;
                
                case "getquestid":
                    for (i = 0; i <= global.quests; i++)
                    {
                        if (string_lower(quest_name(i)) == string_replace_all(string_lower(arg[0]), "_", " "))
                        {
                            debugBacklog += ("CONSOLE: Quest \"" + arg[0] + "\" has quest ID #" + string(i) + "\n");
                            debugged = true;
                            break;
                        }
                    }
                    
                    if (!debugged)
                        debugBacklog += "ERROR: Quest not found!\n";
                    
                    break;
                
                case "gettechniqueid":
                case "gettechid":
                    for (i = 0; i <= global.totalTechniques; i++)
                    {
                        if (string_lower(technique_name(i)) == string_replace_all(string_lower(arg[0]), "_", " "))
                        {
                            debugBacklog += ("CONSOLE: Technique \"" + arg[0] + "\" has technique ID #" + string(i) + "\n");
                            debugged = true;
                            break;
                        }
                    }
                    
                    if (!debugged)
                        debugBacklog += "ERROR: Technique not found!\n";
                    
                    break;
                
                case "getsceneid":
                    for (i = 0; i <= 710; i++)
                    {
                        if (string_lower(scene_name(i)) == string_replace_all(string_lower(arg[0]), "_", " ") || string_lower(scene_name2(i)) == string_replace_all(string_lower(arg[0]), "_", " "))
                        {
                            debugBacklog += ("CONSOLE: Scene \"" + arg[0] + "\" has scene ID #" + string(i) + "\n");
                            debugged = true;
                            break;
                        }
                    }
                    
                    if (!debugged)
                        debugBacklog += "ERROR: Scene not found!\n";
                    
                    break;
                
                case "getspeciesid":
                    for (i = 0; i <= global.totalSpecies; i++)
                    {
                        if (string_lower(species_name(i)) == string_replace_all(string_lower(arg[0]), "_", " "))
                        {
                            debugBacklog += ("CONSOLE: Species \"" + arg[0] + "\" has species ID #" + string(i) + "\n");
                            debugged = true;
                            break;
                        }
                    }
                    
                    if (!debugged)
                    {
                        for (i = 0; i <= global.totalMonsters; i++)
                        {
                            if (string_lower(species_name(100 + i)) == string_replace_all(string_lower(arg[0]), "_", " "))
                            {
                                debugBacklog += ("CONSOLE: Species \"" + arg[0] + "\" has species ID #" + string(100 + i) + "\n");
                                debugged = true;
                                break;
                            }
                        }
                        
                        if (!debugged)
                            debugBacklog += "ERROR: Species not found!\n";
                    }
                    
                    break;
                
                case "clear":
                    debugBacklog = "";
                    break;
                
                case "help":
                    debugBacklog += "CONSOLE: opening help page\n";
                    open_url_fixed("https://www.patreon.com/posts/haremon-debug-64480933");
                    break;
                
                case "dnlgetitemnames":
                    var base_name = "";
                    var base_id = "";
                    var str = "";
                    var fullstr = "";
                    
                    for (i = 0; i <= global.totalItems; i++)
                    {
                        if ((i % 50) == 0 && str != "")
                        {
                            show_message(str);
                            str = "";
                        }
                        
                        base_id = string(i);
                        base_name = item_name_base(i);
                        base_name = string_lower(base_name);
                        base_name = string_replace_all(base_name, " ", "_");
                        str += ("id: " + base_id + ": getitemid " + base_name + "\n");
                        fullstr += str;
                    }
                    
                    if (str != "")
                    {
                        show_message(str);
                        str = "";
                    }
                    
                    debugBacklog += ("CONSOLE: " + keyword + " copy names to clipboard\n");
                    
                    if (fullstr != "")
                        clipboard_set_text(fullstr);
                    
                    break;
                
                case "dnlgetquestnames":
                    var base_name = "";
                    var base_id = "";
                    var str = "";
                    var fullstr = "";
                    
                    for (i = 0; i <= global.quests; i++)
                    {
                        if ((i % 50) == 0 && i != 0 && str != "")
                        {
                            show_message(str);
                            str = "";
                        }
                        
                        base_id = string(i);
                        base_name = quest_name(i);
                        base_name = string_lower(base_name);
                        base_name = string_replace_all(base_name, " ", "_");
                        str += ("id: " + base_id + ": getquestid " + base_name + "\n");
                        fullstr += str;
                    }
                    
                    if (str != "")
                    {
                        show_message(str);
                        str = "";
                    }
                    
                    debugBacklog += ("CONSOLE: " + keyword + " copy names to clipboard\n");
                    
                    if (fullstr != "")
                        clipboard_set_text(fullstr);
                    
                    break;
                
                case "dnlgettechniquenames":
                case "dnlgettechnames":
                    var base_name = "";
                    var base_id = "";
                    var str = "";
                    var fullstr = "";
                    var com = (keyword == "dnlgettechnames") ? "gettechid" : "gettechniqueid";
                    
                    for (i = 0; i <= global.totalTechniques; i++)
                    {
                        if ((i % 50) == 0 && i != 0 && str != "")
                        {
                            show_message(str);
                            str = "";
                        }
                        
                        base_id = string(i);
                        base_name = technique_name(i);
                        base_name = string_lower(base_name);
                        base_name = string_replace_all(base_name, " ", "_");
                        str += ("id: " + base_id + ": " + com + " " + base_name + "\n");
                        fullstr += str;
                    }
                    
                    if (str != "")
                    {
                        show_message(str);
                        str = "";
                    }
                    
                    debugBacklog += ("CONSOLE: " + keyword + " copy names to clipboard\n");
                    
                    if (fullstr != "")
                        clipboard_set_text(fullstr);
                    
                    break;
                
                case "dnlgetscenenames":
                    var base_str = "";
                    var base_name = "";
                    var base_id = "";
                    var str = "";
                    var fullstr = "";
                    
                    for (i = 0; i <= 710; i++)
                    {
                        if ((i % 50) == 0 && i != 0 && str != "")
                        {
                            show_message(str);
                            str = "";
                        }
                        
                        base_id = string(i);
                        base_name = scene_name(i);
                        base_name = string_lower(base_name);
                        base_name = string_replace_all(base_name, " ", "_");
                        str += ("id: " + base_id + ": getsceneid " + base_name + "\n");
                        fullstr += str;
                        if (i == 76) {
                            continue;
                        }
                        base_name = scene_name2(i);
                        base_name = string_lower(base_name);
                        base_name = string_replace_all(base_name, " ", "_");
                        str += ("id: " + base_id + ": getsceneid " + base_name + "\n");
                        fullstr += str;
                    }
                    
                    if (str != "")
                    {
                        show_message(str);
                        str = "";
                    }
                    
                    debugBacklog += ("CONSOLE: " + keyword + " copy names to clipboard\n");
                    
                    if (fullstr != "")
                        clipboard_set_text(fullstr);
                    
                    break;
                
                case "dnlgetspeciesnames":
                    var base_str = "";
                    var base_name = "";
                    var base_id = "";
                    var str = "";
                    var fullstr = "";
                    
                    for (i = 0; i <= global.totalSpecies; i++)
                    {
                        if ((i % 50) == 0 && i != 0 && str != "")
                        {
                            show_message(str);
                            str = "";
                        }
                        
                        base_id = string(i);
                        base_name = species_name(i);
                        base_name = string_lower(base_name);
                        base_name = string_replace_all(base_name, " ", "_");
                        str += ("id: " + base_id + ": getspeciesid " + base_name + "\n");
                        fullstr += str;
                    }
                    
                    for (i = 0; i <= global.totalMonsters; i++)
                    {
                        if (((i + 100) % 50) == 0 && i != 0 && str != "")
                        {
                            show_message(str);
                            str = "";
                        }
                        
                        base_id = string(100 + i);
                        base_name = species_name(100 + i);
                        base_name = string_lower(base_name);
                        base_name = string_replace_all(base_name, " ", "_");
                        str += ("id: " + base_id + ": getspeciesid " + base_name + "\n");
                        fullstr += str;
                    }
                    
                    if (str != "")
                    {
                        show_message(str);
                        str = "";
                    }
                    
                    debugBacklog += ("CONSOLE: " + keyword + " copy names to clipboard\n");
                    
                    if (fullstr != "")
                        clipboard_set_text(fullstr);
                    
                    break;
                
                case "dnlalwaysnakedmode":
                    if (global.FLAGS < 389)
                    {
                        debugBacklog += "ERROR: invalid command\n";
                        break;
                    }
                    
                    var tf = 387;
                    var toggle = global.FLAG[tf] == 1;
                    toggle = !toggle;
                    
                    if (toggle)
                        global.FLAG[tf] = 1;
                    else
                        global.FLAG[tf] = 0;
                    
                    if (toggle)
                        debugBacklog += "CONSOLE: activating always naked mode\n";
                    else
                        debugBacklog += "CONSOLE: deactivating always naked mode\n";
                    
                    break;
                
                case "dnlalwayspaintlewdspritemode":
                    if (global.FLAGS < 389)
                    {
                        debugBacklog += "ERROR: invalid command\n";
                        break;
                    }
                    
                    var tf = 388;
                    var toggle = global.FLAG[tf] == 1;
                    toggle = !toggle;
                    
                    if (toggle)
                        global.FLAG[tf] = 1;
                    else
                        global.FLAG[tf] = 0;
                    
                    if (toggle)
                        debugBacklog += "CONSOLE: activating always paint lewd sprite mode\n";
                    else
                        debugBacklog += "CONSOLE: deactivating always paint lewd sprite mode\n";
                    
                    break;
                
                case "dnlhelp":
                    debugBacklog += "CONSOLE: real opening help pages\n";
                    open_url_fixed("https://www.patreon.com/posts/haremon-debug-64480933");
                    open_url_fixed("https://attachments.f95zone.to/2020/05/679777_haremon_debug_commands.txt");
                    open_url_fixed("https://attachments.f95zone.to/2025/11/5491676_haremon_0.42.2_command_list_all.txt");
                    open_url_fixed("https://attachments.f95zone.to/2025/11/5505784__haremon_0.42.2_command_list_and_0.42.5_all.txt");
                    break;
                
                default:
                    debugBacklog += "ERROR: invalid command\n";
                    break;
            }
        }
        
        debugString = "";
        keyboard_string = "";
    }
}
