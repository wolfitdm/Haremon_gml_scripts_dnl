function init_flags()
{
    global.FLAGS = 400;
    
    for (var i = 1; i <= global.FLAGS; i++)
        global.FLAG[i] = 0;
    
    global.FLAG[24] = 50;
    global.FLAG[142] = 1;
    global.FLAG[143] = -1;
    global.FLAG[351] = 1;
    global.FLAG[387] = 1;
    global.FLAG[388] = 1;
    global.TEMP_FLAGS = 197;
    
    for (var i = 1; i <= global.TEMP_FLAGS; i++)
        global.TEMP_FLAG[i] = 0;
    
    global.TEMP_FLAG[1] = 1;
    global.TEMP_FLAG[3] = 1;
    global.TEMP_FLAG[4] = 1;
    global.TEMP_FLAG[5] = -1;
    global.TEMP_FLAG[8] = 1;
    global.TEMP_FLAG[176] = chance(1);
    global.TEST_FLAGS = 10;
    
    for (var i = 1; i <= global.TEST_FLAGS; i++)
        global.TEST_FLAG[i] = 0;
    
    global.totalTopics = 53;
    
    for (var n = 1; n <= global.npcs; n++)
    {
        for (var i = 1; i <= global.totalTopics; i++)
            global.topicDiscussed[n][i] = false;
    }
    
    global.ambushed = 0;
    global.sneakattack = 0;
    global.tilerarity = 0;
    global.cursorScale = 0.4;
    global.dungeonActiveGirl = 1;
    global.loadingGame = false;
    global.giftItem = 1;
    global.lensAlpha = 1;
    global.soloFight = false;
    global.scriptedBattle = false;
    global.encounterIndex = 0;
    global.scriptedBattleIndex = 0;
    global.leavingDungeon = true;
    global.dungeonIsLoadingManual = false;
    global.gameIsLoading = false;
    global.addFood = 0;
    global.addFood2 = 0;
    global.edibleShrooms = "";
    global.newShopItems = false;
    global.addedLens = false;
    global.giftedSpecial = false;
    global.giftedSpecial2 = false;
    global.shroomsRevealed = false;
    global.startHordeBattle = false;
    global.girlGoingToRoom = 0;
    global.canSleepIn = true;
    global.adaptiveDifficulty = 0;
    global.ranchProgress = 0;
    global.haveSlept = false;
    global.mousePrompt = -1;
    global.criticals = 0;
    global.exploits = 0;
    global.technicals = 0;
    global.perfects = 0;
    global.changingRanch = false;
    global.newmessages = 0;
    global.lastSavePath = "";
    global.playTime = 0;
    global.haveBloomers = false;
    global.haveLens = false;
    global.shopMaxSize = 150;
    global.dreamGirl = 0;
    
    for (var i = 1; i <= global.totalSpecies2; i++)
        global.scoutAbilityActive[i] = false;
    
    global.scout = -1;
    global.girlGivingGift = 0;
    global.girlConfessing = 0;
    global.girlTexting = 0;
    global.girlPropositioning = 0;
    global.girlGoingOnDate = 0;
    global.dateLocation = -1;
    global.melonsSmashed = 0;
    global.confessing = false;
    global.repeatGift = false;
    global.DATE_BASED_EVENTS = 1;
    global.globalVoiceIndex = -1;
    global.lastVoiceSituation = -1;
    global.lastVoiceType = -1;
    global.lastVoice = -1;
    global.MONTH = current_month;
    global.DAY = current_day;
    global.currentmonth = date_get_month(date_current_datetime());
    global.currentday = date_get_day(date_current_datetime());
    global.completedquest = -1;
    global.godmode = false;
    global.tickBonus = 0;
    global.advancingTime = false;
    global.anniesSonsName = "Jack";
    global.anniesExsName = "Jeffery";
    global.testingScene = false;
    global.scenesSeen = [];
    global.scenesSeenRecently = [];
    
    for (var i = 1; i <= total_lore(); i++)
        global.loreUnlocked[i] = 0;
    
    global.importantBattle = false;
    global.sunnyTotems = [];
    global.wigglefactor = 1;
    global.environmentLevel = 1;
    global.repelling = false;
    global.chewingGum = false;
    global.edibleShrooms = "";
    global.shroomsRevealed = false;
    global.questActive = 0;
    global.inDungeon = false;
    global.maxTiles = 91;
    
    for (var i = 1; i <= global.maxTiles; i++)
        global.tileVisible[i] = true;
    
    global.turnsSinceLastBattle = 0;
    global.startingFood = 10;
    global.currentFood = global.startingFood;
    global.currentTurn = 1;
    global.battleTime = false;
    global.tiles = 0;
    global.totalTileDepth = 1;
    global.activeTile = 0;
    global.tileCard[0] = 5;
    global.tileRarity[0] = 0;
    global.tileColor[0] = 2916;
    global.tileEvent[0] = 0;
    global.tilePlaced[0] = false;
    global.tileEssential[0] = false;
    global.tileFlipped[0] = false;
    global.tileActivated[0] = false;
    global.tileDepth[0] = 0;
    global.tileVisible[0] = true;
    global.tileLocked[0] = false;
    global.tilePolarity[0] = -1;
    global.tileDarkness[0] = false;
    global.tileBurning[0] = false;
    global.tileFrozen[0] = false;
    global.tileElectrified[0] = false;
    global.dungeonChaosEffectActive = [0, 0, 0, 0, 0, 0, 0];
    global.girlX[3] = 0;
    global.girlY[3] = 0;
    global.girlTargetX[3] = 0;
    global.girlTargetY[3] = 0;
    global.girlTile[3] = 0;
    global.girlEffectElement[3] = 0;
    global.dungeonStarting = false;
    global.startTile = 19;
    global.partyGirlsLast = 0;
    global.revealTreasure = false;
    global.levelUpTiles = false;
    global.returnToStart = false;
    global.bossBattle = false;
    global.tilesToUnlock = 0;
    global.dungeonMonsterTile[0] = 0;
    global.monsterTargetX[0] = 0;
    global.monsterTargetY[0] = 0;
    global.dungeonMonsterSpecies[0] = 0;
    global.dungeonMonsterEncounter[0] = 0;
    global.dungeonMonsterMenacing[0] = 0;
    global.dungeonMonsters = 0;
    global.dungeonMaxMonsters = 0;
    global.dungeonvignettes = [];
    global.loverNickname = "";
    global.dungeonPolarity = 0;
    global.dungeonTemperature = 0;
    global.dungeonTemperatureAdd = 0;
    global.katieMoveset = [];
    
    for (var i = 1; i <= 9; i++)
        global.katieMoveset[i] = [];
    
    global.canSticker266 = false;
    global.canSticker267 = [0, 0, 0, 0, 0];
    global.canSticker268 = false;
    global.canSticker269 = false;
    global.activeKeepsakes = [];
    global.musicIndex = -1;
    
    for (var i = 1; i <= global.totalTechniques; i++)
        global.techniqueSeen[i] = 0;
    
    var dst;
    dst[0] = "OFF";
    dst[1] = "ON";
    show_debug_message("date based events: " + dst[global.DATE_BASED_EVENTS] + " (using date " + month_name(global.currentmonth) + " " + string(global.currentday) + ")");
    
    if (is_halloween())
        show_debug_message("It's Halloween!");
    
    if (is_christmas())
        show_debug_message("It's Christmas!");
    
    if (is_valentines())
        show_debug_message("It's Valentine's!");
}
