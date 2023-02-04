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
#include maps\mp\menu\cfg; 
#include maps\mp\menu\bindcycle; 

bind_calls()
{
    self setupbind("nacmod",::nacmod);
    self setupbind("boltmove",::boltmove);
    self setupbind("houdini",::houdini);
    self setupbind("canswap",::canswapbind);
    self setupbind("canzoom",::canzoombind);
    self setupbind("vish",::vishbind);
    self setupbind("copycat",::copycat);
    self setupbind("illusion",::illusionbind);
    self setupbind("zoomload",::zoomloadbind);
    self setupbind("hostmigra",::hostmigrabind);
    self setupbind("scav",::scavbind);
    self setupbind("hitmarker",::hitmarker);
    self setupbind("reflectff",::reflectff);
    self setupbind("loadbind",::loadbind);
    self setupbind("damage",::damagebind);
    self setupbind("carepack",::carepack);
    self setupbind("pred",::kiwizbind);
    self setupbind("ccb",::ccb);
    self setupbind("flash",::flashbind);
    self setupbind("thirdeye",::thirdeyebind);
    self setupbind("laststand", ::laststand);
    self setupbind("finalstand", ::finalstand);
    self setupbind("destroytac",::destroytac);
    self setupbind("force",::forcebarrel);
    self setupbind("forcemala",::forcebarrelmala);
    self setupbind("botemp", ::botemp);
    self setupbind("selfemp",::selfemp);
    self setupbind("omashax",::omashax);
    self setupbind("oma",::oma);
    self setupbind("altswap",::altswap);
    self setupbind("pain",::painkiller);
    self setupbind("blast",::blastshield);
    self setupbind("frag",::fragreap);
    self setupbind("cycle",::cyclebind);
    self setupbind("lock",::gunlockbind);
    self setupbind("instaswap",::instaswap);
    self setupbind("vel",::velbind);
    self setupbind("sentry",::sentrybind);
    setDvarifuni("gunlockweap","none");
}



sentrybind(button)
{
    self endon("stopsentry");
    for(;;)
    {
        self bindwait("sentry",button);
        if(self.menuopen == false)
        {
            self thread maps\mp\killstreaks\_autosentry::tryUseAutoSentry( self );
            self enableWeapons();
        }
    }
}

velbind(button)
{
    self endon("stopvel");
    for(;;)
    {
        self bindwait("vel",button);
        if(self.menuopen == false)
            exec("+vel");
    }
}

sellockweap()
{
    x = self getCurrentWeapon();
    self iPrintLn("[^:" + x + "^7] Weapon Must Have Droptime 0");
    self iPrintLn("Or Knife Same Time As Bind");
    setdvar("gunlockweap",x);
}

gunlockbind(button)
{
    self endon("stoplock");
    for(;;)
    {
        self bindwait("lock",button);
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
            waitframe();
            exec("weapnext");
            wait 0.1;
            self takeWeapon(z);
            self giveWeapons(x,1);
            self setWeaponAmmoClip(x,x_c);
            self setWeaponAmmoStock(x,x_s);
        }
    }
}


cyclebind(button)
{
    self endon("stopcycle");
    for(;;)
    {
        self bindwait("cycle",button);
        if(self.menuopen == false)
            self docycle();
    }
}


bindwait(notif,act)
{
    self notifyOnPlayerCommand(notif + act,act);
    self waittill(notif + act);
    if(act == "+actionslot 2")
    if(self adsButtonPressed())
    wait 0.25;
}

setupbind(dvar,func)
{
    setdvarifuni("bind_" + dvar, "OFF");

    x = getDvar("bind_" + dvar);

    if(x != "OFF")
    self thread [[func]](x);
} 


togglebind(dvar,func)
{
    x = getDvar("bind_" + dvar);
    self notify("stop" + dvar);
    if(x == "OFF")
        setDvar("bind_"+dvar,"+actionslot 1");
    else if(x == "+actionslot 1")
        setDvar("bind_"+dvar,"+actionslot 2");
    else if(x == "+actionslot 2")
        setDvar("bind_"+dvar,"+actionslot 3");
    else if(x == "+actionslot 3")
        setDvar("bind_"+dvar,"+actionslot 4");
    else if(x == "+actionslot 4")
        setDvar("bind_"+dvar,"+smoke");
    else if(x == "+smoke")
        setDvar("bind_"+dvar,"+frag");
    else 
        setDvar("bind_"+dvar,"OFF");

    z = getDvar("bind_" + dvar);

    self thread [[func]](z);
}

instaswap(button)
{
    self endon("stopfrag");
    for(;;)
    {
        self bindwait("instaswap",button);
        if(self.menuopen == false)
        {
            self illusion();
            waitframe();
            self setSpawnWeapon(self getNextWeapon());
        }
    }
}

fragreap(button)
{
    self endon("stopfrag");
    for(;;)
    {
        self bindwait("frag",button);
        if(self.menuopen == false)
        {
            y = getDvarInt("function_infeq");
            setDvar("function_infeq",0);
            self setWeaponAmmoClip(self getCurrentOffhand(),0);
            x = getDvarInt("player_throwbackinnerradius");
            z = getDvarInt("player_throwbackouterradius");
            setDvar("player_throwbackinnerradius",0);
            setDvar("player_throwbackouterradius",0);
            exec("+frag;-frag");
            wait 1;
            setDvar("player_throwbackinnerradius",x);
            setDvar("player_throwbackouterradius",z);
            setDvar("function_infeq",y);
        }
    }
}

blastshield(button)
{
    self endon("stopblast");
    blast = undefined;
    for(;;)
    {
        self bindwait("blast",button);
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

painkiller(button)
{
    self endon("stoppain");
    for(;;)
    {
        self bindwait("painkiller",button);
        if(self.menuopen == false)
        self thread maps\mp\perks\_perkfunctions::setCombatHigh();
    }
}

altswap(button)
{
    self endon("stopaltswap");
    for(;;)
    {
        
        self bindwait("altswap",button);
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

omashax(button)
{
    self endon("stopomashax");
    for(;;)
    {
        self bindwait("omashax",button);
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

oma(button)
{
    self endon("stopoma");
    for(;;)
    {
        self bindwait("oma",button);
        if(self.menuopen == false)
        {
            self playLocalSound( "foly_onemanarmy_bag3_plr" );
            self maps\mp\perks\_perkfunctions::omaUseBar( getDvarFloat("scr_oma_usetime") );
        }
    }
}

botemp(button)
{
    self endon("stopbotemp");
    for(;;)
    {
        self bindwait("botemp",button);
        if(self.menuopen == false)
            foreach(player in level.players)
                if(player.pers["isBot"] && isDefined(player.pers["isBot"]))
                    player thread maps\mp\killstreaks\_emp::EMP_Use( 0, 0 );
    }
}


selfemp(button)
{
    self endon("stopselfemp");
    for(;;)
    {
        self bindwait("selfemp",button);
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
    }
}

forcebarrelmala(button)
{
    self endon("stopforcemala");
    for(;;)
    {
        self bindwait("force",button);
        if(self.menuopen == false)
        {
            self[[game[self.team + "_model"]["SNIPER"]]]();
            waitframe();
            self[[game[self.team + "_model"]["GHILLIE"]]]();
            exec("+frag;-frag");
            wait 0.2;
            self illusion();
        }
    }
}

forcebarrel(button)
{
    self endon("stopforce");
    for(;;)
    {
        self bindwait("force",button);
        if(self.menuopen == false)
        {
        self[[game[self.team + "_model"]["SNIPER"]]]();
        waitframe();
        self[[game[self.team + "_model"]["GHILLIE"]]]();
        exec("+frag;-frag");
        }
    }
}

destroytac(button)
{
    self endon("stopdestroytac");
    for(;;)
    {
        self bindwait("destroytac",button);
        if(self.menuopen == false)
        {
            self thread maps\mp\gametypes\_hud_message::SplashNotify( "denied", 20 );
            self hitmarker();
        }
    }
}


laststand(button)
{
    self endon("stoplaststand");
    for(;;)
    {
        self bindwait("laststand",button);
        if(self.menuopen == false)
        self set_last_stand();
    }
}

finalstand(button)
{
    self endon("stopfinalstand");
    for(;;)
    {
        self bindwait("laststand",button);
        if(self.menuopen == false)
        self set_final_stand();
    }
}

set_last_stand()
{
    notifyData = spawnStruct();
    notifyData.titleText = game[ "strings" ][ "last_stand" ];
    notifyData.iconName = "specialty_laststand";
    notifyData.glowColor = ( 1, 0, 0 );
    notifyData.sound = "mp_last_stand";
    notifyData.duration = 2.0;
    self.health = 1;
    self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
    self setStance("crouch");
    waitframe();
    self setStance("prone");
    waitframe();
    x = spawn( "script_model", self.origin );
    self playerlinkTo(x);
    wait 0.3;
    self unlink();
    x delete();
}

set_final_stand()
{
    notifyData = spawnStruct();
    notifyData.titleText = game[ "strings" ][ "final_stand" ];
    notifyData.iconName = "specialty_finalstand";
    notifyData.glowColor = ( 1, 0, 0 );
    notifyData.sound = "mp_last_stand";
    notifyData.duration = 2.0;
    self.health = 1;
    self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
    self setStance("crouch");
    waitframe();
    self setStance("prone");
    waitframe();
    x = spawn( "script_model", self.origin );
    self playerlinkTo(x);
    wait 0.3;
    self unlink();
    x delete();
}


flashbind(button)
{
    self endon("stopflash");
    for(;;)
    {
        self bindwait("flash",button);
        if(self.menuopen == false)
            self thread maps\mp\_flashgrenades::applyFlash(1, 1);
    }
}

thirdeyebind(button)
{
    self endon("stopthirdeye");
    for(;;)
    {
        self bindwait("thirdeye",button);
        if(self.menuopen == false)
            self thread maps\mp\_flashgrenades::applyFlash(0, 0);
    }
}

ccb(button)
{
    self endon("stopccb");
    for(;;)
    {
        self bindwait("ccb",button);
        if(self.menuopen == false)
        {
            if(self.pers["class"] == "custom1")
                self setClass(2);
            else if(self.pers["class"] == "custom2")
                self setClass(3);
            else if(self.pers["class"] == "custom3")
                self setClass(4);
            else 
                self setClass(1);
        }
    }
}


kiwizbind(button)
{
    self endon("stoppred");
    for(;;)
    {
        self bindwait("pred",button);
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

            wait 1;
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

carepack(button)
{
    self endon("stopcarepack");
    for(;;)
    {
        self bindwait("carepack",button);
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

loadbind(button)
{
    self endon("stoploadbind");
    for(;;)
    {
        self bindwait("loadbind",button);
        if(self.menuopen == false)
        if(self getStance() == "crouch")
        self loadpos();
    }
}

nacmod(button)
{
    self endon("stopnacmod");
    for(;;)
    {
        self bindwait("nacmod",button);
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

boltmove(button)
{
    self endon("stopboltmove");
    for(;;)
    {
        self bindwait("boltmove",button);
        if(self.menuopen == false)
            self startbolt();
    }
}


houdini(button)
{
    self endon("stophoudini");
    for(;;)
    {
        self bindwait("houdini",button);
        if(self.menuopen == false)
        {
            self disableWeapons();
            waitframe();
            self enableWeapons();
            self illusion();
        }
    }
}

canswapbind(button)
{
    self endon("stopcanswap");
    for(;;)
    {
        self bindwait("canswap",button);
        if(self.menuopen == false)
            self docanswap();
    }
}

canzoombind(button)
{
    self endon("stopcanzoom");
    for(;;)
    {
        self bindwait("canzoom",button);
        if(self.menuopen == false)
            self docanzoom();
    }
}


vishbind(button)
{
    self endon("stopvish");
    for(;;)
    {
        self bindwait("vish",button);
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


copycat(button)
{
    self endon("stopcopycat");
    for(;;)
    {
        self bindwait("copycat",button);
        if(self.menuopen == false)
            self maps\mp\gametypes\_killcam::waitDeathCopyCatButton( self , button);
    }
}

illusionbind(button)
{
    self endon("stopillusion");
    for(;;)
    {
        self bindwait("illusion",button);
        if(self.menuopen == false)
            self illusion();
    }
}

zoomloadbind(button)
{
    self endon("stopzoomload");
    for(;;)
    {
        self bindwait("zoomload",button);
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


hostmigrabind(button)
{
    self endon("stophostmigra");
    for(;;)
    {
        self bindwait("hostmigra",button);
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



scavbind(button)
{
    self endon("stopscav");
    for(;;)
    {
        self bindwait("scav",button);
        if(self.menuopen == false)
        {
            self maps\mp\gametypes\_damagefeedback::updateDamageFeedback( "scavenger" );
            self playLocalSound( "scavenger_pack_pickup" );
            self setWeaponAmmoClip(self getCurrentWeapon(),0);
            self setWeaponAmmoStock(self getCurrentWeapon(),999);
        }
    }
}


hitmarkerbind(button)
{
    self endon("stophitmarker");
    for(;;)
    {
        self bindwait("hitmarker",button);
        if(self.menuopen == false)
            self hitmarker();
    }
}

reflectff(button)
{
    self endon("stopreflectff");
    for(;;)
    {
        self bindwait("reflectff",button);
        if(self.menuopen == false)
        {
            self hitmarker();
            self.health = self.maxhealth;
            self thread [[level.callbackPlayerDamage]]( self, self, 60, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_mainroot", 0 );
        }
    }
}


damagebind(button)
{
    self endon("stopdamage");
    for(;;)
    {
        self bindwait("damage",button);
        if(self.menuopen == false)
        {
            self.health = self.maxhealth;
            self thread [[level.callbackPlayerDamage]]( self, self, 60, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_mainroot", 0 );          
        }
    }
}