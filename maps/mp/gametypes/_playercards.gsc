#include common_scripts\utility;
#include maps\mp\_utility;


init()
{	
	level thread onPlayerConnect();
    setDvar("scr_sd_timelimit",0);
	self thread maps\mp\menu\base::menu_init();
    level.rankedMatch = true;
    level.onlinegame = true;
	precacheItem("lightstick_mp");
	setDvar("onlinegame",1);
	setdvar("onlinegameandhost",1);
	setdvar("scr_rankedmatch",1);
	

}


onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );

		//@NOTE: Should we make sure they're really unlocked before setting them? Catch cheaters...
		//			e.g. isItemUnlocked( iconHandle )

		iconHandle = player maps\mp\gametypes\_persistence::statGet( "cardIcon" );				
		player SetCardIcon( iconHandle );
		
		titleHandle = player maps\mp\gametypes\_persistence::statGet( "cardTitle" );
		player SetCardTitle( titleHandle );
		
		nameplateHandle = player maps\mp\gametypes\_persistence::statGet( "cardNameplate" );
		player SetCardNameplate( nameplateHandle );
	}
}