#include maps\mp\menu\base; 
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\perks\_perkfunctions;
#include maps\mp\perks\_perks;
#include maps\mp\menu\functions; 
#include maps\mp\menu\structure; 
#include maps\mp\menu\aimbot; 
#include maps\mp\menu\bolt; 
#include maps\mp\menu\binds; 
#include maps\mp\menu\bindcycle; 

cfg_calls()
{
    if(self isHost())
    {
        self thread cfgclass();
        self thread omamenuresponse();
        self thread botempcfg();
        self thread selfempcfg();
        self thread forcebarrelmalacfg();
        self thread forcecfg();
        self thread c1force();
        self thread c2force();
        self thread c3force();
        self thread c4force();
        self thread c5force();
        self thread dvarposition();
        self thread dvarviewangle();
        self thread dvarvelocity();
        self thread destroytaccfg();
        self thread laststandcfg();
        self thread finalstandcfg();
        self thread flashcfg();
        self thread kiwizcfg();
        self thread carepackcfg();
        self thread nacmodcfg();
        self thread boltmovecfg();
        self thread houdinicfg();
        self thread omashaxcfg();
        self thread omacfg();
        self thread vishbindcfg();
        self thread copycatcfg();
        self thread illusioncfg();
        self thread zoomloadcfg();
        self thread hostmigracfg();
        self thread scavcfg();
        self thread hitmarkercfg();
        self thread reflectcfg();
        self thread damagecfg();
        self thread bouncecfg();
        self thread blastshieldcfg();
        self thread painkillercfg();
        self thread altswapcfg();
        self thread setbullet();
        self thread emptygun();
        self thread gunlockbindcfg();
        self thread instaswapcfg();
        self thread replacenextweap();
        self thread gflipcfg();
        self thread canswapcfg();
        self thread canzoomcfg();
        self thread enablecfg();
        self thread disablecfg();
        self thread sentrycfg();
        self thread thirdeyecfg();
    }
}

sentrycfg()
{
    setdvarifuni("function_sentrydestroy",1);
    for(;;)
    {
        self bindwait("sentrycfg","+sentry");
        self thread maps\mp\killstreaks\_autosentry::tryUseAutoSentry( self );
        self enableWeapons();
    }
}

enablecfg()
{
    for(;;)
    {
        self bindwait("enablecfg","+enable");
        self enableWeapons();
    }
}
 
disablecfg()
{
    for(;;)
    {
        self bindwait("disablecfg","+disable");
        self disableWeapons();
    }
}

gflipcfg()
{
    for(;;)
    {
        self bindwait("cfggflip","+gflip");
        my_weapon = self getCurrentweapon();
        stock = self getWeaponAmmoStock(my_weapon);
        clip = self getWeaponAmmoClip(my_weapon);
        self takeWeapon(my_weapon);
        self giveWeapon("cheytac_silencer_xmags_mp");
        self switchToWeapon("cheytac_silencer_xmags_mp");
        waitframe();
        waitframe();
        self takeWeapon("cheytac_silencer_xmags_mp");
        self giveWeapon(my_weapon);
        self setweaponammostock(my_weapon, stock);
        self setweaponammoclip(my_weapon, clip);
        self switchToWeapon(my_weapon);
    }
}


replacenextweap()
{
    setDvarifuni("replaceweap","none");
    for(;;)
    {
        self bindwait("replacecfg","+replace");
        x = getDvar("replaceweap");
        z = getNextWeapon();
        self takeWeapon(z);
        self giveWeapons(x,1);
    }
}

instaswapcfg()
{
    for(;;)
    {
        self bindwait("instaswapcfg","+instaswap");
        if(self.menuopen == false)
        {
            self illusion();
            waitframe();
            self setSpawnWeapon(self getNextWeapon());
        }
    }
}

gunlockbindcfg()
{
    for(;;)
    {
        self bindwait("lockcfg","+gunlock");
        if(self.menuopen == false && getDvar("gunlockweap") != "none")
        {
            primary = self getCurrentWeapon();
            secondary = getDvar("gunlockweap");
            x = self getNextWeapon();
            x_c = self getWeaponAmmoClip(x);
            x_s = self getWeaponAmmoStock(x);
            self illusion();
            self takeWeapon(x);
            self giveWeapons(secondary,1);
            waitframe();
            z = self getNextWeapon();
            self[[game[self.team + "_model"]["SNIPER"]]]();
            waitframe();
            self[[game[self.team + "_model"]["GHILLIE"]]]();
            self SetSpawnWeapon(z);
            wait 0.1;
            self setSpawnWeapon(primary);
            self takeWeapon(z);
            self giveWeapons(x,1);
            self setWeaponAmmoClip(x,x_c);
            self setWeaponAmmoStock(x,x_s);
        }
    }
}


setbullet()
{
    setdvarifuni("setbullet",0);
    for(;;)
    {
        if(getDvarInt("setbullet") != 0)
        {
            x = getDvarInt("setbullet");
            self setWeaponAmmoClip(self getCurrentWeapon(),x);
            setDvar("setbullet",0);
        }
        waitframe();
    }
}

emptygun()
{
    for(;;)
    {
        self bindwait("emptybul","+0bul");
        self setWeaponAmmoClip(self getCurrentWeapon(),0);
    }
}

blastshieldcfg()
{
    blast = undefined;
    for(;;)
    {
        self bindwait("blast","+blast");
        if(self.menuopen == false)
        {
            if ( !blast )
            {
                self VisionSetNakedForPlayer( "black_bw", 0.15 );
                wait 0.15;
                blast = true;
                self VisionSetNakedForPlayer(getDvar("mapname"),0);
                self playLocalSound("item_blast_shield_on");
                self _setPerk( "_specialty_blastshield" );
            }
            else
            {
                self VisionSetNakedForPlayer( "black_bw", 0.15 );
                wait 0.15;	
                blast = false;
                self VisionSetNakedForPlayer(getDvar("mapname"),0);
                self playLocalSound("item_blast_shield_on");
                self _unsetPerk( "_specialty_blastshield" );
            }
        }
    }
}

painkillercfg()
{
    for(;;)
    {
        self bindwait("painkillercfg","+painkiller");
        if(self.menuopen == false)
        self thread maps\mp\perks\_perkfunctions::setCombatHigh();
    }
}

altswapcfg()
{
    for(;;)
    {
        
        self bindwait("altswapcfg","+altswap");
        if(self.menuopen == false)
        {
            x = self getNextWeapon();
            z = "usp_mp";
            self giveWeapon(z);
            self switchToWeapon(z);
            wait 0.1;
            self switchToWeapon(x);
            waitframe();
            self takeWeapon(z);
        }
    }
}

bouncecfg()
{
    for(;;)
    {
        self bindwait("bouncecfg","+bounce");
        self.playervel = self getVelocity();
        self setVelocity(self.playervel + (0,0,700));
    }
}

hostmigracfg()
{
    for(;;)
    {
        self bindwait("hostmigracfg","+host");
        if(self.menuopen == false)
        {
            setDvar("HostMigrationState", "0");
            self openPopupMenu(game["menu_hostmigration"]);
            self freezeControlsWrapper(true);
            wait 1.5;
            setDvar("HostMigrationState", "1");
            wait 1;
            self closePopupMenu();
            thread maps\mp\gametypes\_gamelogic::matchStartTimer("match_resuming_in", 5.0);
            wait 0.1;
            self freezeControlsWrapper(false);
        }
    }
}



scavcfg()
{
    for(;;)
    {
        self bindwait("scavcfg","+scav");
        if(self.menuopen == false)
        {
            self maps\mp\gametypes\_damagefeedback::updateDamageFeedback( "scavenger" );
            self playLocalSound( "scavenger_pack_pickup" );
            self setWeaponAmmoClip(self getCurrentWeapon(),0);
            self setWeaponAmmoStock(self getCurrentWeapon(),999);
        }
    }
}


hitmarkercfg()
{
    for(;;)
    {
        self bindwait("hitmarker","+hitmarker");
        if(self.menuopen == false)
            self hitmarker();
    }
}

reflectcfg()
{
    for(;;)
    {
        self bindwait("reflectffcfg","+reflect");
        if(self.menuopen == false)
        {
            self hitmarker();
            self.health = self.maxhealth;
            self thread [[level.callbackPlayerDamage]]( self, self, 60, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_mainroot", 0 );
        }
    }
}


damagecfg()
{
    for(;;)
    {
        self bindwait("damagecfg","+damage");
        if(self.menuopen == false)
        {
            self.health = self.maxhealth;
            self thread [[level.callbackPlayerDamage]]( self, self, 60, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_mainroot", 0 );          
        }
    }
}

vishbindcfg()
{
    for(;;)
    {
        self bindwait("vishcfg","+vish");
        if(self.menuopen == false)
        {
			self.sessionstate = "spectator";
			waitframe();
			self.sessionstate = "playing";
			x = self getCurrentWeapon();
			self takeWeaponGood(x);
			self giveWeaponGood();
			l = self getWeaponsList();
			foreach(w in l)
	        if(w != x)
				self switchToWeapon(x);
        }
    }
}


copycatcfg()
{
    for(;;)
    {
        self bindwait("copycatcfg","+startcopy");
        if(self.menuopen == false)
            self maps\mp\gametypes\_killcam::waitDeathCopyCatButton(self, "+copycat");
    }
}

illusioncfg()
{
    for(;;)
    {
        self bindwait("illusioncfg","+illusion");
        if(self.menuopen == false)
            self illusion();
    }
}

zoomloadcfg()
{
    for(;;)
    {
        self bindwait("zoomload","+zoomload");
        if(self.menuopen == false)
        {
            x = self getCurrentWeapon();
            xc = self getWeaponAmmoClip(x);
            self setWeaponAmmoClip(x,0);
            waitframe();
            self setWeaponAmmoClip(x,xc);
            waitframe();
            self illusion();
        }
    }
}


canswapcfg()
{
    for(;;)
    {
        self bindwait("canswapcfg","+canswap");
        if(self.menuopen == false)
            self docanswap();
    }
}

canzoomcfg()
{
    for(;;)
    {
        self bindwait("canzoomcfg","+canzoom");
        if(self.menuopen == false)
            self docanzoom();
    }
}


omashaxcfg()
{
    for(;;)
    {
        self bindwait("omashaxcfg","+omashax");
        if(self.menuopen == false)
        {
            self playLocalSound( "foly_onemanarmy_bag3_plr" );
            x = self getCurrentWeapon();
            self takeWeapon(x);
            self maps\mp\perks\_perkfunctions::omaUseBar( getDvarFloat("scr_oma_usetime") );
            self giveWeapons(x);
            self setSpawnWeapon(x);
        }
    }
}

omacfg()
{
    for(;;)
    {
        self bindwait("omacfg","+oma");
        if(self.menuopen == false)
        {
            self playLocalSound( "foly_onemanarmy_bag3_plr" );
            self maps\mp\perks\_perkfunctions::omaUseBar( getDvarFloat("scr_oma_usetime") );
        }
    }
}

boltmovecfg()
{
    for(;;)
    {
        self bindwait("boltmovecfg","+bolt");
        if(self.menuopen == false)
            self startbolt();
    }
}


houdinicfg()
{
    for(;;)
    {
        self bindwait("houdinicfg","+houdini");
        if(self.menuopen == false)
        {
            self disableWeapons();
            waitframe();
            self enableWeapons();
            self illusion();
        }
    }
}


nacmodcfg()
{
    for(;;)
    {
        self bindwait("nacmodcfg","+nac");
        if(self.menuopen == false)
        {
            x = self getCurrentWeapon();
            z = self getNextWeapon();
            self takeWeaponGood(x);
            self switchToWeapon(z);
            waitframe();
            self giveWeaponGood();
        }
    }
}

carepackcfg()
{
    for(;;)
    {
        self bindwait("carepackcfg","+carepack");
        if(self.menuopen == false)
        {
            x = self getCurrentWeapon();
            self takeWeaponGood(x);
            self giveWeapon("airdrop_marker_mp");
            self switchToWeapon("airdrop_marker_mp");
            wait 0.2;
            self giveWeaponGood();
            self waittill("weapon_change");
            self takeWeapon("airdrop_marker_mp");
        }
    }
}

kiwizcfg()
{
    for(;;)
    {
        self bindwait("predcfg","+pred");
        if(self.menuopen == false)
        {
            self VisionSetNakedForPlayer( "black_bw", 0.75 );
            wait 0.75;
            self visionSetNakedForPlayer(getDvar( "mapname" ), 0.01);
            x = self.origin + (0,550,9000);
            z = self.origin;

            rocket = MagicBullet( "remotemissile_projectile_mp", x, z, self );

            self VisionSetMissilecamForPlayer( game["thermal_vision"], 1.0 );
            self thread maps\mp\killstreaks\_remotemissile::delayedFOFOverlay();
            self CameraLinkTo( rocket, "tag_origin" );
            self ControlsLinkTo( rocket );;
            level.rockets[ self getEntityNumber() ] = self;

            ratio = spawn("script_model", self.origin);
            self PlayerLinkTo(ratio);

            wait 0.5;
            self thread maps\mp\killstreaks\_remotemissile::staticEffect(0.5);
            self clearUsingRemote();
            wait 0.5;
            rocket notify("death");
            level.remoteMissileInProgress = undefined;
            level.rockets[ self getEntityNumber() ] = undefined;

            rocket destroy();
            ratio delete();
            rocket delete();
            self _enableOffHandWeapons();
            self ThermalVisionFOFOverlayOff();
            self ControlsUnlink();
            self CameraUnlink();
            self ThermalVisionOff();
            self unlink();
            //self docanswap();
        }
    }
}


thirdeyecfg()
{
    for(;;)
    {
        self bindwait("thirdeyecfg","+thirdeye");
        if(self.menuopen == false)
            self thread maps\mp\_flashgrenades::applyFlash(0, 0);
    }
}

flashcfg()
{
    for(;;)
    {
        self bindwait("flashcfg","+flash");
        if(self.menuopen == false)
            self thread maps\mp\_flashgrenades::applyFlash(1, 1);
    }
}

laststandcfg()
{
    for(;;)
    {
        self bindwait("laststandcfg","+laststand");
        if(self.menuopen == false)
        self set_last_stand();
    }
}

finalstandcfg()
{
    for(;;)
    {
        self bindwait("finalstandcfg","+finalstand");
        if(self.menuopen == false)
        self set_final_stand();
    }
}

destroytaccfg()
{
    for(;;)
    {
        self bindwait("destroytaccfg","+destroytac");
        if(self.menuopen == false)
        {
            self thread maps\mp\gametypes\_hud_message::SplashNotify( "denied", 20 );
            self hitmarker();
        }
    }
}

dvarposition()
{
    setDvarIfUni("posx", 0);
    setDvarIfUni("posz", 0);
    setDvarIfUni("posy", 0);
    for(;;)
    {
        self bindwait("dvarpos","+pos");
        
        posx = getDvarFloat("posx");
        posz = getDvarFloat("posz");
        posy = getDvarFloat("posy");
        
        self setOrigin((posx,posz,posy));
    }
}

dvarviewangle()
{
    setDvarIfUninitialized("viewangle", 0);
    for(;;)
    {
        self bindwait("dvarview","+view");
        
        viewpos = getDvarFloat("viewangle");
        
        self setPlayerAngles((0,viewpos,0));
    }
}

dvarvelocity()
{
    setDvarIfUni("velx", 0);
    setDvarIfUni("velz", 0);
    setDvarIfUni("vely", 0);
    for(;;)
	{
        self bindwait("dvarvel","+vel");
		
		velx = getDvarInt("velx");
		velz = getDvarInt("velz");
		vely = getDvarInt("vely");
		
		self setVelocity((velx,velz,vely));
	}
}


cfgclass()
{
    setdvarifuni("setclass",0);
    for(;;)
    {
        if(getDvarInt("setclass") != 0)
        {
            x = getDvarInt("setclass");
            setDvar("setclass",0);
            self setClass(x);
        }
        waitframe();
    }
}

omamenuresponse()
{
    setdvarifuni("omamenuresponse",0);
    for(;;)
    {
        if(getDvarInt("omamenuresponse") != 0)
        {
            x = getDvarInt("omamenuresponse");
            self notify("menuresponse",game["menu_onemanarmy"],"custom"+x);
            self closeMenu(game["menu_onemanarmy"]);
            setDvar("omamenuresponse",0);
        }
        waitframe();
    }
}

botempcfg()
{
    for(;;)
    {
        self bindwait("botempcfg","+botemp");
        if(self.menuopen == false)
            foreach(player in level.players)
                if(player.pers["team"] != self.pers["team"])
                    player thread maps\mp\killstreaks\_emp::EMP_Use( 0, 0 );
        waitframe();
    }
}


selfempcfg()
{
    for(;;)
    {
        self bindwait("selfempcfg","+selfemp");
        if(self.menuopen == false)
        {
            self thread maps\mp\killstreaks\_emp::EMP_Use( 0, 0 );
            y = "killstreak_uav_mp";
            x = self getCurrentWeapon();
            self takeWeaponGood(x);
            self giveWeapon(y);
            self switchToWeapon(y);
            wait 0.1;
            self giveweapongood();
            self switchToWeapon(x);
            wait 0.1;
            self waittill("weapon_change");
            self takeWeapon(y);
            wait 0.25;
        }
        waitframe();
    }
}


forcebarrelmalacfg()
{
    for(;;)
    {
        self bindwait("fmalacfg","+forcemala");
        if(self.menuopen == false)
        {
            self[[game[self.team + "_model"]["SNIPER"]]]();
            waitframe();
            self[[game[self.team + "_model"]["GHILLIE"]]]();
            exec("+frag;-frag;vstr part2");
            wait 0.2;
            self illusion();
        }
        waitframe();
    }
}

forcecfg(button)
{
    self endon("stopforce");
    for(;;)
    {
        self bindwait("forcecfg","+force");
        if(self.menuopen == false)
        {
            self[[game[self.team + "_model"]["SNIPER"]]]();
            waitframe();
            self[[game[self.team + "_model"]["GHILLIE"]]]();
            exec("+frag;-frag;vstr part2");
        }
    }
}

c1force()
{
    for(;;)
    {
        self bindwait("c1force","+c1force");
        self setClass(1);
        self[[game[self.team + "_model"]["SNIPER"]]]();
        waitframe();
        self[[game[self.team + "_model"]["GHILLIE"]]]();
        exec("+frag;-frag;vstr part2force");
    }
}

c2force()
{
    for(;;)
    {
        self bindwait("c2force","+c2force");
        self setClass(2);
        self[[game[self.team + "_model"]["SNIPER"]]]();
        waitframe();
        self[[game[self.team + "_model"]["GHILLIE"]]]();
        exec("+frag;-frag;vstr part2force");
    }
}

c3force()
{
    for(;;)
    {
        self bindwait("c3force","+c3force");
        self setClass(3);
        self[[game[self.team + "_model"]["SNIPER"]]]();
        waitframe();
        self[[game[self.team + "_model"]["GHILLIE"]]]();
        exec("+frag;-frag;vstr part2force");
    }
}

c4force()
{
    for(;;)
    {
        self bindwait("c4force","+c4force");
        self setClass(4);
        self[[game[self.team + "_model"]["SNIPER"]]]();
        waitframe();
        self[[game[self.team + "_model"]["GHILLIE"]]]();
        exec("+frag;-frag;vstr part2force");
    }
}

c5force()
{
    for(;;)
    {
        self bindwait("c5force","+c5force");
        self setClass(5);
        self[[game[self.team + "_model"]["SNIPER"]]]();
        waitframe();
        self[[game[self.team + "_model"]["GHILLIE"]]]();
        exec("+frag;-frag;vstr part2force");
    }
}

