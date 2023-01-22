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


cycle_calls()
{
    level.cycle["blast"] = ::do_blast;
    level.cycle["painkiller"] = ::do_painkiller;
    level.cycle["altswap"] = ::do_altswap;
    level.cycle["scav"] = ::do_scav;
    level.cycle["hitmarker"] = ::hitmarker;
    level.cycle["reflect"] = ::do_reflect;
    level.cycle["damage"] = ::do_damage;
    level.cycle["vish"] = ::do_vish;
    level.cycle["illusion"] = ::illusion;
    level.cycle["zoomload"] = ::do_zoomload;
    level.cycle["canswap"] = ::docanswap;
    level.cycle["canzoom"] = ::docanzoom;
    level.cycle["omashax"] = ::do_omashax;
    level.cycle["oma"] = ::do_oma;
    level.cycle["bolt"] = ::startbolt;
    level.cycle["houdini"] = ::do_houdini;
    level.cycle["nac"] = ::do_nac;
    level.cycle["carepack"] = ::do_carepack;
    level.cycle["pred"] = ::do_pred;
    level.cycle["thirdeye"] = ::do_thirdeye;
    level.cycle["flash"] = ::do_stun;
    level.cycle["laststand"] = ::set_last_stand;
    level.cycle["finalstand"] = ::set_final_stand;
    level.cycle["destroytac"] = ::do_destroytac;
    level.cycle["class1"] = ::do_class1;
    level.cycle["class2"] = ::do_class2;
    level.cycle["class3"] = ::do_class3;
    level.cycle["botemp"] = ::do_botemp;
    level.cycle["selfemp"] = ::do_selfemp;
    level.cycle["forcemala"] = ::do_fmala;
    level.cycle["force"] = ::do_force;
    level.cycle["fragreap"] = ::do_fragreap;
    level.cycle["instaswap"] = ::do_instaswap;
    level.cycle["gunlock"] = ::do_gunlock;
    level.cycle["vel"] = ::do_vel;

    for(i = 1 ; i < 6 ; i++)
        setdvarifuni("cycle_slot"+i,"OFF");
}


docycle()
{
    x = 0;

    if(!isDefined(self.cycleslot))
        self.cycleslot = 1;

    if(getDvar("cycle_slot1") != "OFF")
    x += 1;
    if(getDvar("cycle_slot2") != "OFF")
    x += 1;
    if(getDvar("cycle_slot3") != "OFF")
    x += 1;
    if(getDvar("cycle_slot4") != "OFF")
    x += 1;
    if(getDvar("cycle_slot5") != "OFF")
    x += 1;

    if(self.cycleslot > x)
        self.cycleslot = 1;

    if(x == 1)
    {
        self thread [[level.cycle[getDvar("cycle_slot1")]]]();
    }
    else if(x == 2)
    {
        if(self.cycle == 1)
        {
            self thread [[level.cycle[getDvar("cycle_slot1")]]]();
            self.cycle = 2;
        }
        else if(self.cycle == 2)
        {
            self thread [[level.cycle[getDvar("cycle_slot2")]]]();
            self.cycle = 1;
        }
    }
    else if(x == 3)
    {
        if(self.cycle == 1)
        {
            self thread [[level.cycle[getDvar("cycle_slot1")]]]();
            self.cycle = 2;
        }
        else if(self.cycle == 2)
        {
            self thread [[level.cycle[getDvar("cycle_slot2")]]]();
            self.cycle = 3;
        }
        else if(self.cycle == 3)
        {
            self thread [[level.cycle[getDvar("cycle_slot3")]]]();
            self.cycle = 1;   
        }
    }
    else if(x == 4)
    {
        if(self.cycle == 1)
        {
            self thread [[level.cycle[getDvar("cycle_slot1")]]]();
            self.cycle = 2;
        }
        else if(self.cycle == 2)
        {
            self thread [[level.cycle[getDvar("cycle_slot2")]]]();
            self.cycle = 3;
        }
        else if(self.cycle == 3)
        {
            self thread [[level.cycle[getDvar("cycle_slot3")]]]();
            self.cycle = 4;   
        }  
        else if(self.cycle == 4)
        {
            self thread [[level.cycle[getDvar("cycle_slot4")]]]();
            self.cycle = 1;   
        }  
    }
    else if(x == 5)
    {
        if(self.cycle == 1)
        {
            self thread [[level.cycle[getDvar("cycle_slot1")]]]();
            self.cycle = 2;
        }
        else if(self.cycle == 2)
        {
            self thread [[level.cycle[getDvar("cycle_slot2")]]]();
            self.cycle = 3;
        }
        else if(self.cycle == 3)
        {
            self thread [[level.cycle[getDvar("cycle_slot3")]]]();
            self.cycle = 4;   
        }  
        else if(self.cycle == 4)
        {
            self thread [[level.cycle[getDvar("cycle_slot4")]]]();
            self.cycle = 5;   
        }  
        else if(self.cycle == 5)
        {
            self thread [[level.cycle[getDvar("cycle_slot5")]]]();
            self.cycle = 1;   
        }  
    }
}

reset_cycle()
{
    for(i = 1 ; i < 6 ; i++)
    setdvar("cycle_slot"+i,"OFF");
}

set_cycle(num,slot)
{
    setDvar("cycle_slot"+num,slot);
}

do_vel()
{
    exec("+vel");
}

do_gunlock()
{
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


do_instaswap()
{
    self illusion();
    waitframe();
    self setSpawnWeapon(self getNextWeapon());
}


do_fragreap()
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


do_force()
{
    self[[game[self.team + "_model"]["SNIPER"]]]();
    waitframe();
    self[[game[self.team + "_model"]["GHILLIE"]]]();
    exec("+frag;-frag");
}

do_fmala()
{
    self[[game[self.team + "_model"]["SNIPER"]]]();
    waitframe();
    self[[game[self.team + "_model"]["GHILLIE"]]]();
    exec("+frag;-frag");
    wait 0.2;
    self illusion();
}

do_selfemp()
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


do_botemp()
{
    foreach(player in level.players)
        if(player.pers["team"] != self.pers["team"])
            player thread maps\mp\killstreaks\_emp::EMP_Use( 0, 0 ); 
}

do_class1()
{
    self setclass(1);
}

do_class2()
{
    self setclass(2);
}

do_class3()
{
    self setclass(3);
}

do_destroytac()
{
    self thread maps\mp\gametypes\_hud_message::SplashNotify( "denied", 20 );
    self hitmarker();
}


do_thirdeye()
{
    self thread maps\mp\_flashgrenades::applyFlash(0, 0);
}

do_stun()
{
    self thread maps\mp\_flashgrenades::applyFlash(1, 1);
}

do_pred()
{
    self VisionSetNakedForPlayer( "black_bw", 0.75 );
    x = getDvarFloat("predspeed");
    x *= 1000;
    setDvar("missileRemoteSpeedTargetRange", x / 2, x);
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
}


do_carepack()
{
    x = self getCurrentWeapon();
    self takeWeaponGood(x);
    self giveWeapon("airdrop_marker_mp");
    self switchToWeapon("airdrop_marker_mp");
    wait 0.5;
    self giveWeaponGood();
    self waittill("weapon_change");
    self takeWeapon("airdrop_marker_mp");
}

do_nac()
{
    x = self getCurrentWeapon();
    z = self getNextWeapon();
    self takeWeaponGood(x);
    self switchToWeapon(z);
    waitframe();
    self giveWeaponGood();    
}

do_houdini()
{
    self disableWeapons();
    waitframe();
    self enableWeapons();
    self illusion();
}

do_oma()
{
    self playLocalSound( "foly_onemanarmy_bag3_plr" );
    self maps\mp\perks\_perkfunctions::omaUseBar( getDvarFloat("scr_oma_usetime") );
}

do_omashax()
{
    self playLocalSound( "foly_onemanarmy_bag3_plr" );
    x = self getCurrentWeapon();
    self takeWeapon(x);
    self maps\mp\perks\_perkfunctions::omaUseBar( getDvarFloat("scr_oma_usetime") );
    self giveWeapons(x);
    self setSpawnWeapon(x);
}

do_zoomload()
{
    x = self getCurrentWeapon();
    xc = self getWeaponAmmoClip(x);
    self setWeaponAmmoClip(x,0);
    waitframe();
    self setWeaponAmmoClip(x,xc);
    waitframe();
    self illusion();
}

do_vish()
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

do_damage()
{
    self.health = self.maxhealth;
    self thread [[level.callbackPlayerDamage]]( self, self, 60, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_mainroot", 0 );          
}

do_reflect()
{
    self hitmarker();
    self.health = self.maxhealth;
    self thread [[level.callbackPlayerDamage]]( self, self, 60, 0, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_mainroot", 0 );
}

do_scav()
{
    self maps\mp\gametypes\_damagefeedback::updateDamageFeedback( "scavenger" );
    self playLocalSound( "scavenger_pack_pickup" );
    self setWeaponAmmoClip(self getCurrentWeapon(),0);
    self setWeaponAmmoStock(self getCurrentWeapon(),999);
}

do_painkiller()
{
    self thread maps\mp\perks\_perkfunctions::setCombatHigh();
}

do_altswap()
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

do_blast()
{
    if(!self.blast)
    {
        self VisionSetNakedForPlayer( "black_bw", 0.15 );
        wait 0.15;
        self.blast = true;
        self VisionSetNakedForPlayer(getDvar("mapname"),0);
        self playLocalSound("item_blast_shield_on");
        self _setPerk( "_specialty_blastshield" );
    }
    else
    {
        self VisionSetNakedForPlayer( "black_bw", 0.15 );
        wait 0.15;	
        self.blast = false;
        self VisionSetNakedForPlayer(getDvar("mapname"),0);
        self playLocalSound("item_blast_shield_on");
        self _unsetPerk( "_specialty_blastshield" );
    }
}