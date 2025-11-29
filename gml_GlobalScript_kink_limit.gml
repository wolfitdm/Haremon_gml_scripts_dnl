function kink_limit(arg0)
{
    if (global.FLAG[323])
        return 999;
    
    var _bon = 0;
    
    if (girl_panties(arg0) == global.itemFrillyPanties)
    {
        _bon += (girl_panties_level(arg0) + 1);
    }
    else if (girl_panties(arg0) == global.itemLoincloth && !racial_bonus(arg0, global.speciesGargoyle))
    {
        if (girl_panties_level(arg0) == 3)
            return 0;
        else
            _bon -= (girl_panties_level(arg0) + 1);
    }
    else if (girl_panties(arg0) == global.itemAnniesPanties)
    {
        return max(0, girl_panties_level(arg0) - 1);
    }
    
    if (sticker_pinned(arg0, 107))
        return 0;
    else if (sticker_pinned(arg0, 271))
        _bon += 2;
    
    return 3 + _bon;
}
