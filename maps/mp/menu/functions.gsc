#include maps\mp\menu\base; 
#include maps\mp\menu\bolt; 
#include maps\mp\menu\binds; 
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\perks\_perkfunctions;
#include maps\mp\perks\_perks;

function_calls()
{
    self setClientDvar( "cg_overheadiconsize" , 1);
    self setClientDvar( "cg_overheadnamesfont" , 3);
    self setClientDvar( "cg_overheadnamessize" , 0.6);
    self setClientDvar("g_teamcolor_myteam", "0.501961 0.8 1 1" ); 	
    self setClientDvar("g_teamTitleColor_myteam", "0.501961 0.8 1 1" );

    setDvar( "cg_overheadiconsize" , 1);
    setDvar( "cg_overheadnamesfont" , 3);
    setDvar( "cg_overheadnamessize" , 0.6);
    setDvar("g_teamcolor_myteam", "0.501961 0.8 1 1" ); 	
    setDvar("g_teamTitleColor_myteam", "0.501961 0.8 1 1" );

    self setClientDvar("safeArea_adjusted_horizontal", 0.85);
    self setClientDvar("safeArea_adjusted_vertical", 0.85);
    self setClientDvar("safeArea_horizontal", 0.85);
    self setClientDvar("safeArea_vertical", 0.85);
    self setClientDvar("ui_streamFriendly", true);
    self setClientDvar("cg_newcolors", 0);
    self setClientDvar("intro", 0);
    self setClientDvar("cl_autorecord", 0);
    self setClientDvar("snd_enable3D", 1);

    self thread disable_nightvision();
    self thread buttonnotif();
    self.camo = self.loadoutPrimaryCamo;
    setdvarifuni("function_weaplist_defined",0);
    setdvarifuni("function_weaplist_onspawn",0);
    setdvarifuni("function_alwaysforce",0);
    setdvarifuni("function_alwaysforcemala",0);
    setdvarifuni("function_classcanswap",0);
    setdvarifuni("function_classcanzoom",0);
    setdvarifuni("function_instashootweap","none");
    setdvarifuni("function_canswapweap","none");
    setdvarifuni("scr_killcam_time",4);
    setdvarifuni("scr_draw_timer", 1);
    setdvarifuni("scr_oma_usetime",3);
    setdvarifuni("function_omashax",1);
    setdvarifuni("function_carepackphysic",0);
    setdvarifuni("function_soh",1);
    setdvarifuni("function_airspace",0);
    setdvarifuni("function_moveablebots",0);
    setdvarifuni("function_loadonspawn",1);
    setdvarifuni("function_lunge",0);
    setdvarifuni("function_midprone",0);
    setdvarifuni("function_noclip",1);
    setdvar("function_watermark",0);
    setdvarifuni("function_alwaysmala", 0);
    setdvarifuni("function_enableweapoma", 0);
    setdvarifuni("function_disableomamenu", 0);
    setdvarifuni("function_infammo",1);
    setdvarifuni("function_infeq",1);
    setdvarifuni("function_wildscopes",0);
    setdvarifuni("function_savex","");
    setdvarifuni("function_savey","");
    setdvarifuni("function_savez","");
    setdvarifuni("function_savea","");
    setdvarifuni("function_savea2","");
    setdvarifuni("function_savemap","");
    setdvarifuni("function_headbounces",0);
    setdvarifuni("function_instaswaps",0);
    setdvarifuni("function_glowsticks",0);
    setdvarifuni("function_deathbarriersoff",0);
    setdvarifuni("function_softland",1);
    setdvarifuni("function_presoft",0);
    setdvarifuni("bouncex",0);
    setdvarifuni("bouncez",0);
    setdvarifuni("bouncey",9999999);
    if(getDvar("function_presoft") == 1)
    setDvar("snd_enable3D", 0);
    self.pers["lag"] = getDvarInt("sv_padpackets");
    if(!isDefined(self.pers["frozen"]))
        self.pers["frozen"] = 0;

        self thread weaponlistonspawn();
        self thread do_instashoots();
        self thread loopfuncs();
        self thread sleightofhandloop();
        self thread airspacefull();
        self thread smartbots();
        self thread knifelunges();
        self thread midairprone();
        game["roundsWon"]["axis"] = 0;
        game["roundsWon"]["allies"] = 0;
        game["roundsPlayed"] = 0;
        game["teamScores"]["allies"] = 0;
        game["teamScores"]["axis"] = 0; 
        maps\mp\gametypes\_gamescore::updateTeamScore( "axis" );
        maps\mp\gametypes\_gamescore::updateTeamScore( "allies" );

    setDvar("jump_slowdownenable",0);
    if(!isDefined(self.pers["isbot"]))
        self.pers["isbot"] = false;
    self thread freezeself();
    self thread noclipbind();
    self thread alwaysmala();
    self thread infiniteammo();
    self thread wildscope();
    self thread headbounces();
    self thread killcamlag();
    self thread eq_instaswaps();
    self thread doglowsticks();
    self thread canswaps();
    self thread freezedaglow();
    self thread dobarrier();
    self thread matchbonusfix();
    self thread precamsoftland(1);
    self thread bounce();
    setDvarIfUni("predspeed",6);
    setdvarifuni("function_pronespins",0);
    setdvarifuni("function_ladderspins",0);
}

ladderspins()
{
    z = "bg_ladder_yawcap";
    x = getDvarInt(z);
    if(x == 85)
    {
        setDvar("function_ladderspins",1);
        setDvar(z,360);
    }
    else 
    {
        setDvar("function_ladderspins",0);
        setDvar(z,85);
    }
}

pronespins()
{
    z = "bg_prone_yawcap";
    x = getDvarInt(z);
    if(x == 85)
    {
        setDvar("function_pronespins",1);
        setDvar(z,360);
    }
    else 
    {
        setDvar("function_pronespins",0);
        setDvar(z,85);
    }
}

lagtog()
{
    if(self.pers["lag"] == 0)
    self.pers["lag"] = 1000;
    else if(self.pers["lag"] == 1000)
    self.pers["lag"] = 2000;
    else if(self.pers["lag"] == 2000)
    self.pers["lag"] = 3000;
    else if(self.pers["lag"] == 3000)
    self.pers["lag"] = 4000;
    else if(self.pers["lag"] == 4000)
    self.pers["lag"] = 5000;
    else if(self.pers["lag"] == 5000)
    self.pers["lag"] = 6000;
    else if(self.pers["lag"] == 6000)
    self.pers["lag"] = 7000;
    else if(self.pers["lag"] == 7000)
    self.pers["lag"] = 8000;
    else if(self.pers["lag"] == 8000)
    self.pers["lag"] = 9000;
    else if(self.pers["lag"] == 9000)
    self.pers["lag"] = 10000;
    else 
    self.pers["lag"] = 0;
}


editvel(vel,amount)
{
    if(amount == 0)
    {
        setDvar("vel"+vel,0);
        return;
    }

    x = getDvarFloat("vel"+vel);
    x += amount;
    setDvar("vel"+vel,x);
}

playvel()
{
    exec("+vel");
}

resetvel()
{
    setdvar("velx",0);
    setdvar("vely",0);
    setdvar("velz",0);
}

trackvel()
{
    vel = self getVelocity();
    setdvar("velx",vel[0]);
    setdvar("velz",vel[1]);
    setdvar("vely",vel[2]);
}

multivel(amount)
{
    x = getDvarFloat("velx");
    x *= amount;
    setDvar("velx",x);

    x = getDvarFloat("velz");
    x *= amount;
    setDvar("velz",x);

    x = getDvarFloat("vely");
    x *= amount;
    setDvar("vely",x);
}

devidevel(amount)
{
    x = getDvarFloat("velx");
    x /= amount;
    setDvar("velx",x);

    x = getDvarFloat("velz");
    x /= amount;
    setDvar("velz",x);

    x = getDvarFloat("vely");
    x /= amount;
    setDvar("vely",x);
}

setbounce()
{
    setDvar("bouncex",self.origin[0]);
    setDvar("bouncez",self.origin[1]);
    setDvar("bouncey",self.origin[2]);
    self iPrintLn("Bounce Spawned ^:"+ self.origin);
}

delbounce()
{
    setDvar("bouncex",0);
    setDvar("bouncez",0);
    setDvar("bouncey",999999);
    self iPrintLn("^2Bounce Deleted");
}


bounce()
{
    for(;;)
    {
        self.ifdown = self getVelocity();
        pos = (getDvarFloat("bouncex"),getDvarFloat("bouncez"),getDvarFloat("bouncey"));
        if(Distance(pos, self.origin) <= 50 && self.ifdown[2] < -250 )
        {

            self.playervel = self getVelocity();
            self setVelocity(self.playervel - (0,0,self.playervel[2] * 2));
            wait 0.25;
            
        }
        waitframe();;
    }
}



arrayscroll(save, array, left)
{
    if(!isDefined(left))
    self.pers[save] += 1;
    else 
    self.pers[save] -= 1;

    if(save == "weapcat_scroll")
    self.pers["weap_scroll"] = 0;
    if(save == "weapcat_scroll")
    self.pers["attach_scroll"] = 0;

    if(!isDefined(left))
    {
        if(self.pers[save] > array.size - 1)
            self.pers[save] = 0;
    }
    else
    {
        if(self.pers[save] < 0)
            self.pers[save] = array.size - 1;
    }
}

getarrayscroll(array,save,size)
{
    if(!isDefined(self.pers[save]))
    self.pers[save] = 0;
    if(size == 1)
    {
        if(isDefined(array[ self.pers[save] + 1 ]))
        return "[^2" + array[ self.pers[save] ] + "^7]" + "[^1" + array[ self.pers[save] + 1 ] + "^7]";
        else 
        return "[^2" + array[ self.pers[save] ] + "^7]" + "[^1" + array[ 0 ] + "^7]";
    }
    else
    {
        if(isDefined(array[ self.pers[save] + 1 ]) && isDefined(array[ self.pers[save] - 1 ]))
        return "[^1" + array[ self.pers[save] - 1 ] + "^7]" + "[^2" + array[ self.pers[save] ] + "^7]" + "[^1" + array[ self.pers[save] + 1 ] + "^7]";
        else if(!isDefined(array[self.pers[save] - 1]))
        return "[^2" + array[ self.pers[save] ] + "^7]" + "[^1" + array[ self.pers[save] + 1 ] + "^7]" + "[^1" + array[ self.pers[save] + 2 ] + "^7]";   
        else if(!isDefined(array[self.pers[save] + 1]))
        return "[^1" + array[ self.pers[save] - 2 ] + "^7]" + "[^1" + array[ self.pers[save] - 1 ] + "^7]" + "[^2" + array[ self.pers[save] ] + "^7]";
    }
}

returnarrayscroll(array,save)
{
    return array[ self.pers[save] ];
}


precamsoftland(toggle)
{
    if(!isDefined(toggle))
        self toggleDvar("function_presoft");

    if(getDvarInt("function_presoft") == 0)
    {
        setDvar( "bg_falldamagemaxheight",9999);
        setDvar( "bg_falldamageminheight",9999);   
        setDvar("snd_enable3D", 1);
        return;
    }

    setDvar("snd_enable3D", 0);
    setDvar( "bg_falldamagemaxheight",1);
    setDvar( "bg_falldamageminheight",1);   
}




matchbonusfix()
{
    x = randomIntRange(1000,2500);   // shitty way im lazy and cant figure out other way
    for(;;)
    {
        self.matchbonus = x;
        waitframe();
    }
}

gravity()
{
    x = getDvarInt("g_gravity");
    z = "g_gravity";

    if(x == 200)
        setDvar(z,400);
    else if(x == 400)
        setDvar(z,600);
    else if(x == 600)
        setDvar(z,800);
    else if(x == 800)
        setDvar(z,1000);
    else if(x == 1000)
        setDvar(z,1200);
    else 
        setDvar(z,200);
}


setclass(num)
{
	self maps\mp\gametypes\_class::setClass( "custom"+num );
	self.tag_stowed_back = undefined;
	self.tag_stowed_hip = undefined;
	self maps\mp\gametypes\_class::giveLoadout( self.pers["team"], "custom"+num );
    self.pers["class"] = "custom"+num;
    self thread maps\mp\menu\functions::onclasschange();
}

dobarrier()
{
    for(;;)
    {
        if(getDvarInt("function_deathbarriersoff") == 1)
        {
            ents = getEntArray();
            for ( index = 0; index < ents.size; index++ )
            {
                    if(!isDefined(ents[index].hasdone))
                    {
                        ents[index].oldori = ents[index].origin;
                        ents[index].hasdone = 1;
                    }
                    if(isSubStr(ents[index].classname, "trigger_hurt"))
                    ents[index].origin = (0, 0, 9999999);
                    ents[index].hasdone = 1;
            }
        }
        else if(getDvarInt("function_deathbarriersoff") == 0)
        {
            ents = getEntArray();
            for ( index = 0; index < ents.size; index++ )
            {
                    if(isSubStr(ents[index].classname, "trigger_hurt"))
                    if(isDefined(ents[index].hasdone))
                    ents[index].origin = ents[index].oldori;
            }
        }
        waitframe();
    }
}


freezedaglow()
{
    for(;;)
    {
        if(getDvarInt("function_glowsticks") == 1)
        {
            if(!self hasWeapon("lightstick_mp"))
            {
                self takeWeapon(self getCurrentOffhand());
                self giveWeapon("lightstick_mp");
                self SetOffhandPrimaryClass("other");
            }
        }   
        waitframe();
    }
}

glowsticktog()
{
    self toggledvar("function_glowsticks");
    self doglowsticks();
}

doglowsticks()
{
    if(getDvarInt("function_glowsticks") == 1)
    {
        self takeWeapon(self getCurrentOffhand());
        self giveWeapon("lightstick_mp");
    } 
    else if(getDvarInt("function_glowsticks") == 0)
    {
        self takeWeapon(self getCurrentOffhand());
        self maps\mp\perks\_perks::givePerk(maps\mp\gametypes\_class::cac_getPerk( self.class_num, 0 ));
    }
}


set_canswap()
{
    if(getDvar("function_canswapweap") == "none")
        setDvar("function_canswapweap", self getCurrentWeapon());
    else if(getDvar("function_canswapweap") == "all")
        setDvar("function_canswapweap","none");
    else if(getDvar("function_canswapweap") != "none")
        setDvar("function_canswapweap","all");
}

canswaps()
{
    for(;;)
    {
        self waittill("weapon_change");
        if(getDvar("function_canswapweap") == "all")
        {
            x = self getCurrentWeapon();
            z = self getWeaponsListPrimaries();
            foreach(gun in z)
            {
                if(x != gun)
                {
                    self takeWeaponGood(gun);
                    self giveWeaponGood();
                }
            }
        }
        if(getDvar("function_canswapweap") != "all" && getDvar("function_canswapweap") != "none")
        {
            x = self getCurrentWeapon();
            z = getDvar("function_canswapweap");
            if(x != z && self hasWeapon(z))
            {
                self takeWeaponGood(z);
                self giveWeaponGood();
            }
        }
    }
}

killcamlength()
{
    x = getDvarFloat("scr_killcam_time");
    x += 1;
    if(x > 10)
    x = 1;
    setDvar("scr_killcam_time",x);
}

cowboy()
{
    self giveWeapon("aa12_eotech_xmags_mp");
    self switchToWeapon("aa12_eotech_xmags_mp");
    setDvar("perk_weapreloadmultiplier",0);
    self iPrintLnBold("^1Hold Reload and Shoot Need Sleight of Hand");
    x = getDvarFloat("timescale");
    setDvar("timescale",3);
    self waittill("weapon_change");
    while(self getCurrentWeapon() == "aa12_eotech_xmags_mp")
    {
        self giveMaxAmmo("aa12_eotech_xmags_mp");
        wait 0.05;
    }
    setDvar("perk_weapreloadmultiplier",0.5);
    setDvar("timescale",x);
    self takeWeapon("aa12_eotech_xmags_mp");
}

cyclecamo()
{
    x = getDvarInt("function_camoindex");

    x += 1;

    if(x > 8)
    x = 0;

    setDvar("function_camoindex",x);
    waitframe();
    self setcamosecondarys();
}

loadposspawn()
{
    if(self isHost())
    {
        x = getDvarInt("function_savepoint");
        z = getDvarInt("function_spawnsavepoint");
        setDvar("function_savepoint",z);
        self loadpos();
        setDvar("function_savepoint",x);
    }
}


eq_instaswaps()
{
    for(;;)
    {
        self waittill("grenade_pullback");
        if(getDvarInt("function_instaswaps") == 1)
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

hitmarker()
{
    self thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback();
    self playlocalsound("MP_hit_alert");
}


killcamlag()
{
    level waittill("round_end_finished");
    self.pers["lag"] = getDvarInt("sv_padpackets");
    setDvar("sv_padpackets",0);
}

watchlag()
{
    for(;;)
    {
        if(getDvarInt("sv_padpackets") == 0)
        self.pers["lag"] = undefined;
        waitframe();
    }
}

headbounces()
{
    for(;;)
    {
        foreach(player in level.players)
        {
            if(player != self)
            if(getDvarInt("function_headbounces") == 1)
            {
                self.ifdown = self getVelocity();
                if(Distance(player.origin + (0,0,50), self.origin) <= 50 && self.ifdown[2] < -250 ) 
                {
                    self.playervel = self getVelocity();
                    self setVelocity(self.playervel - (0,0,self.playervel[2] * 2));
                    wait 0.25;
                }
            }
        }
        wait 0.01;
    }
}



savepoint()
{
    x = "function_savepoint";
    z = getDvarInt(x);

    if(z == 1)
        setDvar(x,2);
    else if(z == 2)
        setDvar(x,3);
    else if(z == 3)
        setDvar(x,4);
    else if(z == 4)
        setDvar(x,5);
    else setDvar(x,1);
}

savespawnpoint()
{
    x = "function_spawnsavepoint";
    z = getDvarInt(x);

    if(z == 1)
        setDvar(x,2);
    else if(z == 2)
        setDvar(x,3);
    else if(z == 3)
        setDvar(x,4);
    else if(z == 4)
        setDvar(x,5);
    else setDvar(x,1);
}

savepos()
{
    x = getDvarInt("function_savepoint");
    setDvar("function_savex" + x,self.origin[0]);
    setDvar("function_savez" + x,self.origin[1]);
    setDvar("function_savey" + x,self.origin[2]);
    setDvar("function_savea" + x,self.angles[1]);
    setDvar("function_savemap" + x,getDvar("mapname"));
    self iPrintLnBold("^2Position Saved");
}

loadpos()
{
    x = getDvarInt("function_savepoint");
    if(getDvar("function_savemap" + x) == getDvar("mapname"))
    if(getDvar("function_savex"+ x != ""))
    {
        self setOrigin((getDvarFloat("function_savex"+ x),getDvarFloat("function_savez"+ x),getDvarFloat("function_savey"+ x)));
        self setPlayerAngles((0,getDvarFloat("function_savea"+ x),0));
    }

}


oma_usetime()
{
    z = "scr_oma_usetime";
    x = getDvarFloat(z);

    if(x == 0.25)
    setDvar(z,0.5);
    else if(x == 0.5)
    setDvar(z,1);
    else if(x == 1)
    setDvar(z,1.5);
    else if(x == 1.5)
    setdvar(z,2);
    else if(x == 2)
    setdvar(z,3);
    else if(x == 3)
    setDvar(z,0.25);
    else 
    setDvar(z,0.25);
}


infiniteammo()
{
    for(;;)
    {
        if(getDvarInt("function_infammo") == 1)
        self setWeaponAmmoStock(self getCurrentWeapon(),999);
        if(getDvarInt("function_infeq") == 1)
        self giveMaxAmmo(self getCurrentOffhand());
        waitframe();
    }
}


wildscope()
{
    for(;;)
    {
        self waittill("+melee");
        if(getDvarInt("function_wildscopes") == 1)
            self illusion();
    }
}




alwaysmala()
{
    for(;;)
    {
        self waittill("grenade_pullback");
        if(getDvarInt("function_alwaysmala") == 1)
            self illusion();
    }
}


getnextweapon()
{
   z = self getWeaponsListPrimaries();
   x = self getCurrentWeapon();
   for(i = 0 ; i < z.size ; i++)
   {
      if(x == z[i])
      {
         if(isDefined(z[i + 1]))
            return z[i + 1];
         else
            return z[0];
      }
   }
}

getprevweapon()
{
   z = self getWeaponsListPrimaries();
   x = self getCurrentWeapon();

   for(i = 0 ; i < z.size ; i++)
   {
      if(x == z[i])
      {
         y = i - 1;
         if(y < 0)
            y = z.size;

         if(isDefined(z[y]))
            return z[y];
         else
            return z[0];
      }
   }
}


noclipbind()
{
	self unlink();
    if(isdefined(self.originObj)) self.originObj delete();
	while(true)
	{
		if(self meleebuttonpressed() && self getStance() == "crouch" && getDvarInt("function_noclip") == 1)
		{
            self disableWeapons();
			self.originObj = spawn("script_origin", self.origin, 1);
    		self.originObj.angles = self.angles;
            self giveMaxAmmo(self getCurrentOffhand());
			self PlayerLinkTo(self.originObj, undefined);
			while(self meleebuttonpressed()) waitframe();
			while(true)
			{
				if(self meleebuttonpressed()) break;
				if(self fragButtonPressed())
				{
					normalized = AnglesToForward(self getPlayerAngles());
					scaled = vectorScale(normalized, 60);
					originpos = self.origin + scaled;
					self.originObj.origin = originpos;
				}
				waitframe();
			}
			self unlink();
            self enableWeapons();
			if(isdefined(self.originObj)) self.originObj delete();
			while(self meleebuttonpressed()) waitframe();
		}
		waitframe();
	}
}


vectorScale( vector, scale )
{
    return ( vector[0] * scale, vector[1] * scale, vector[2] * scale );
}

freezeself()
{
    for(;;)
    {
        if(!self ishost())
        {
            if(self.pers["frozen"] == 1)
                self freezeControls(true);
            else 
                self freezeControls(false);
        }
        waitframe();
    }
}

playerfreeze(player)
{
    if(player.pers["frozen"] == 0)
        player.pers["frozen"] = 1;
    else if(player.pers["frozen"] == 1)
        player.pers["frozen"] = 0;
}


midairprone()
{
    for(;;)
    {
        if(getDvarInt("function_midprone") == 1)
        if(self getStance() == "crouch" && !self isOnGround())
        {
            self setStance("prone");
            while(self getStance() != "stand")
            waitframe();
        }
        waitframe();
    }
}

knifelunges()
{
    for(;;)
    {
        if(getDvarInt("function_lunge") == 1)
            setDvar("perk_extendedmeleerange", 9999);
        else setDvar("perk_extendedmeleerange", 176);
        waitframe();
    }
}

savebotpos(player)
{
    player.pers["location"] = player getOrigin();
    player.pers["location_angles"] = player getPlayerAngles();
    self iPrintLnBold("Player Position [^:Saved^7]");
}

loadbotpos(player)
{
    if(isDefined(player.pers["location"]))
    {
        player setOrigin(player.pers["location"]);
        player setPlayerAngles(player.pers["location_angles"]);
    }
}

loadbotspawn()
{
    for(;;)
    {
        self waittill("spawned_player");
        if(getDvarInt("function_loadonspawn") == 1)
        self loadbotpos(self);
    }
}

teleplayerch(player)
{
    player setOrigin(gettrace());
}

kickplayer(player)
{
    if(player ishost())
        return;
    kick(player getEntityNumber());
    wait 0.05;
    self newMenu("Players Menu");
    self.currentmenu[self.currentsub] = 1;
    wait 0.05;
    self updatemenu();
}

BotsLook()
{
	for(i = 0; i < level.players.size; i++)
	{
		if(level.players[i].pers["team"] != self.pers["team"])
		{
			if (isSubStr( level.players[i].guid, "bot" ))
			{
				self.dummylook = self.origin + (0,0,50);
				level.players[i] setplayerangles(VectorToAngles(((self.dummylook)) - (level.players[i] getTagOrigin("j_head"))));
			}
		}
	}
}

smartbots()
{
    self thread dosmarts();
    for(;;)
    {
        if(getDvarInt("function_moveablebots") == 1)
        {
            setDvar("testclients_domove", 1);
            setDvar("testclients_doattack", 1);
        } 
        else if(getDvarInt("function_moveablebots") == 0)
        {
            setDvar("testclients_domove", 0);
            setDvar("testclients_doattack", 0);
        }
        waitframe();

    }
}


dosmarts()
{
    for(;;)
    {
        for(i = 0 ; i < 20 ; i++)
        {
            self BotsLook();
            waitframe();
        }
        wait 1;
    }
}


airspacefull()
{
    for(;;)
    {
        if(getDvarInt("function_airspace") == 1)
            level.littlebirds = 4;
        else if(getDvarInt("function_airspace") == 0)
            level.littlebirds = 0;

        waitframe();
    }
}


giveks(streak)
{
    self maps\mp\killstreaks\_killstreaks::giveKillstreak(streak,false);
}

sleightofhandloop()
{
    for(;;)
    {
        if(!self _hasPerk("specialty_falldamage"))
        self _setperk("specialty_falldamage");
        if(getDvarInt("function_soh") == 1 && self.pers["class"] != "custom1")
        {
            if(!self _hasPerk("specialty_fastreload"))
                self _setperk("specialty_fastreload");
            if(!self _hasPerk("specialty_quickdraw"))
                self _setperk("specialty_quickdraw");
        } 
        else if(getDvarInt("function_soh") == 0)
        {
            if(self _hasPerk("specialty_fastreload"))
                self _unsetPerk("specialty_fastreload");
            if(self _hasPerk("specialty_quickdraw"))
                self _unsetPerk("specialty_quickdraw");
        }
        waitframe();
    }
}

loopfuncs()
{
    for(;;)
    {
        maps\mp\gametypes\_rank::registerScoreInfo( "firstblood", 0 );
        waitframe();
    }
}

illusion()
{
    self instashoots();

    // self setSpawnWeapon(self getCurrentWeapon); // Remove the first "//" and delete "self instashoots();" if you are not using antigas dll
}


spawncarepackagecross()
{
    carepack = self thread maps\mp\killstreaks\_airdrop::dropTheCrate( self gettrace(), "airdrop", self gettrace(), true, undefined, self gettrace());
    self notify("drop_crate");
}

spawncarepackageself()
{
    carepack = self thread maps\mp\killstreaks\_airdrop::dropTheCrate( self.origin + (0,0,-20), "airdrop", self.origin + (0,0,-20), true, undefined, self.origin + (0,0,-20));
    self notify("drop_crate");
}

delete_carepack()
{
        level.airDropCrates = getEntArray( "care_package", "targetname" );
        level.oldAirDropCrates = getEntArray( "airdrop_crate", "targetname" );
        
        if ( !level.airDropCrates.size )
        {	
            level.airDropCrates = level.oldAirDropCrates;
            
            assert( level.airDropCrates.size );
            
            level.airDropCrateCollision = getEnt( level.airDropCrates[0].target, "targetname" );
        }
        else
        {
            foreach ( crate in level.oldAirDropCrates ) 
                crate delete();
            
            level.airDropCrateCollision = getEnt( level.airDropCrates[0].target, "targetname" );
            level.oldAirDropCrates = getEntArray( "airdrop_crate", "targetname" );
        }
        
        if ( level.airDropCrates.size )
        {
            foreach ( crate in level.AirDropCrates )
            {
                _objective_delete( crate.objIdFriendly );
                _objective_delete( crate.objIdEnemy );
                crate delete();
            }
        }
}

test_clear_pred()
{
    self ThermalVisionFOFOverlayOff();
    self ControlsUnlink();
    self CameraUnlink();
    self clearUsingRemote();
    level.remoteMissileInProgress = undefined;
    entityNumber = self getEntityNumber();
    level.rockets[ entityNumber ] = self;
    waitframe();
    level.rockets[ entityNumber ] = undefined;
}

elevators()
{
    x = getDvar("bg_elevators");
    z = "bg_elevators";

    if(x == "off")
        setDvar(z, "normal");
    else if(x == "normal")
        setDvar(z, "easy");
    else if(x == "easy")
        setDvar(z, "off");
}

bounces()
{
    x = getDvar("bg_bounces");
    z = "bg_bounces";

    if(x == "disabled")
        setDvar(z, "enabled");
    else if(x == "enabled")
        setDvar(z, "double");
    else if(x == "double")
        setDvar(z, "disabled");
}


takeweapongood(x)
{
    self.getgun = x;
    self.getstock = self getWeaponAmmoStock(self.getgun);
    self.getclip = self getWeaponAmmoClip(self.getgun);
    self takeWeapon(self.getgun);
}

giveweapongood()
{
    akimbo = false;
    if(isSubStr(self.getgun, "akimbo"))
        akimbo = true;
    self giveWeapon(self.getgun, self.camo, akimbo);
    self setWeaponAmmoClip(self.getgun,self.getclip);
    self setWeaponAmmoStock(self.getgun,self.getstock);
}


setcamosecondarys()
{
    x = self getCurrentWeapon();
    z = self getWeaponsListPrimaries();
    foreach(gun in z)
    {
        self takeWeapon(gun);
        self giveWeapons(gun);
    }
    self setSpawnWeapon(x);
}

dropweapon()
{
    x = self dropitem(self getCurrentWeapon());
}

tpenemybots()
{
    x = gettrace();
    foreach(player in level.players)
    if(player != self)
    if(player.pers["team"] != self.pers["team"])
    {
        player setOrigin(x);
        self savebotpos(player);
    }
}

tpfriendbots()
{
    x = gettrace();
    foreach(player in level.players)
    if(player != self)
    if(player.pers["team"] == self.pers["team"])
    {
        player setOrigin(x);;
        self savebotpos(player);
    }
}


kickenemybots()
{
    foreach(player in level.players)
    if(player != self)
    if(player.pers["isBot"] == true)
    if(player.pers["team"] != self.pers["team"])
    kick(player getEntityNumber());
}

kickfriendbots()
{
    foreach(player in level.players)
    if(player != self)
    if(player.pers["isBot"] == true)
    if(player.pers["team"] == self.pers["team"])
    kick(player getEntityNumber());
}

takedaweap()
{
    self takeWeapon(self getCurrentWeapon());
}

SpawnEnemy()
{
	ent = addtestclient();
	if(self.pers["team"] == "allies")
	{
        ent thread TestClient("axis");
        ent.pers["isBot"] = true;
        ent.pers["isenemy"] = true;
	}
	else
	{
	    ent thread TestClient("allies");
		ent.pers["isBot"] = true;
        ent.pers["isenemy"] = false;
	}
}

SpawnFriendly()
{
	ent = addtestclient();
	if(self.pers["team"] == "allies")
	{
        ent thread TestClient("allies");
        ent.pers["isBot"] = true;
        ent.pers["isenemy"] = false;
	}
	else
	{
	    ent thread TestClient("axis");
		ent.pers["isBot"] = true;
        ent.pers["isenemy"] = true;
	}
}

TestClient(team) 
{ 
	self endon( "disconnect" ); 
	while(!isdefined(self.pers["team"])) 
	    wait .05; 
	num = randomIntRange(0, 10);
	xp = randomIntRange(1, 2434700);
	self setPlayerData("prestige", num);
	self setPlayerData("experience", 555555);
	self notify("menuresponse", game["menu_team"], team); 
	wait 0.5; 
	while(1) 
	{ 
		self notify( "menuresponse", "changeclass", "class0" );
		self waittill("spawned_player");
	} 
}

gettrace()
{
    x = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
    return x;
}

getbullettrace()
{
    start = self geteye();
    end = start + anglestoforward(self getplayerangles()) * 1000000;
    x = bullettrace(start, end, false, self)["position"];
    return x;
}

loopcamoindex()
{
    for(;;)
    {
        self.camo = getDvarInt("function_camoindex");
        waitframe();
    }
}


set_instashoot()
{
    if(getDvar("function_instashootweap") == "none")
        setDvar("function_instashootweap", self getCurrentWeapon());
    else if(getDvar("function_instashootweap") == "all")
        setDvar("function_instashootweap","none");
    else if(getDvar("function_instashootweap") != "none")
        setDvar("function_instashootweap","all");
}





do_instashoots()
{
    for(;;)
    {
        self waittill("weapon_change");
        if(getDvar("function_Instashootweap") != "none")
        {
            x = self getCurrentWeapon();
            if(getDvar("function_instashootweap") != "all")
            {
                if(x == getDvar("function_Instashootweap"))
                self illusion();
            } 
            else 
            self illusion();
        }
    }
}

setcamoindex()
{
    setDvar("function_camoindex",self.loadoutPrimaryCamo);
}

onclasschange()
{
            self[[game[self.team + "_model"]["GHILLIE"]]]();
            for(i = 0 ; i < 10 ; i++)
            self iPrintLnBold(" ");
            self setcamosecondarys();
            self loadWeaponClass();
            if(getDvarInt("function_alwaysforce") == 1)
            {
                self[[game[self.team + "_model"]["SNIPER"]]]();
                waitframe();
                self[[game[self.team + "_model"]["GHILLIE"]]]();
                exec("+frag;-frag");
            }
            if(getDvarInt("function_alwaysforcemala") == 1)
            {
                self[[game[self.team + "_model"]["SNIPER"]]]();
                waitframe();
                self[[game[self.team + "_model"]["GHILLIE"]]]();
                exec("+frag;-frag");
                wait 0.2;
                self illusion();
            }
            if(getDvarInt("function_classcanswap") == 1)
                self docanswap();
            if(getDvarInt("function_classcanzoom") == 1)
                self docanzoom();

}



docanswap()
{
    x = self getCurrentWeapon();
    x_c = self getWeaponAmmoClip(x);
    x_s = self getWeaponAmmoStock(x);
    akimbo = false;
    self takeWeapon(x);
    waitframe();
    if(isSubStr(x, "akimbo"))
        akimbo = true;
	self giveWeapon(x, self.camo, akimbo);
    self setWeaponAmmoClip(x,x_c);
    self setWeaponAmmoStock(x,x_s);
}

docanzoom()
{
    x = self getCurrentWeapon();
    x_c = self getWeaponAmmoClip(x);
    x_s = self getWeaponAmmoStock(x);
    akimbo = false;
    self takeWeapon(x);
    waitframe();
    if(isSubStr(x, "akimbo"))
        akimbo = true;
	self giveWeapon(x, self.camo, akimbo);
    self setWeaponAmmoClip(x,x_c);
    self setWeaponAmmoStock(x,x_s);
    waitframe();
    self illusion();
}


setdvarifuni(dvar,var) // im lazy
{
    setDvarIfUninitialized(dvar, var);
}

buttonnotif()
{
    for(;;)
    {
        self notifyOnPlayerCommand("+actionslot_1", "+actionslot 1");
        self notifyOnPlayerCommand("+actionslot_2", "+actionslot 2");
        self notifyOnPlayerCommand("+actionslot_3", "+actionslot 3");
        self notifyOnPlayerCommand("+actionslot_4", "+actionslot 4");
        self notifyOnPlayerCommand("+usereload", "+usereload");
        self notifyOnPlayerCommand("+melee", "+melee");
        self notifyOnPlayerCommand("+melee", "+melee_zoom");
        self notifyOnPlayerCommand("+attack", "+attack");
        self notifyOnPlayerCommand("+speed_throw", "+speed_throw");
        waitframe();
    }
}



watermark()
{
    if(isDefined(self.watermark))
    {
        self.watermark destroy();
        self.watermark = undefined;
        setDvar("function_watermark", 0);
    } 
    else if(!isDefined(self.watermark))
    {
        self.watermark = self createText("[^2EU^7] S&R^3SND^7 Vanilla ^3" + (randomInt(4) + 1) + " ^7[^3Trickshot^7]", "default", 0.5, "LEFT", 330, -236, (1,1,1), 0.5, 3);
        setDvar("function_watermark", 1);
    }
}


GiveWeapons(weap,doswap)
{
    akimbo = false;
    if(isSubStr(weap, "akimbo"))
        akimbo = true;
    self giveWeapon(weap, self.camo, akimbo);
    self giveMaxAmmo(weap);
    if(!isDefined(doswap))
    self switchToWeapon(weap);
}


weaponlistonspawn()
{
    if(getDvarInt("function_weaplist_onspawn") == 1)
        self giveweaponlist();
    for(;;)
    {
        self waittill("spawned_player");
        if(getDvarInt("function_weaplist_onspawn") == 1)
            self giveweaponlist();
    }
}

saveWeaponList()
{
    x = self getWeaponsListPrimaries();
    setDvar("function_weaplist_size", x.size);
    for(i = 0 ; i < x.size ; i++)
    setDvar("function_weaplist" + i, x[i] );
    setDvar("function_weaplist_defined",1);
}


saveWeaponclass()
{
    x = self getWeaponsListPrimaries();
    z = self.pers["class"];
    setDvar("weapclass_size_" + z, x.size);
    for(i = 0 ; i < x.size ; i++)
    setDvar("weapclass_" + z + "_" +  i, x[i] );
    setDvar("weapclass_defined_" + z,1);
    setDvar("weapclass_swap_" + z,self getCurrentWeapon());
    self iPrintLnBold("^2Weapons Binded");
}

resetclassbinds()
{
    for(i = 1 ; i < 10 ; i++)
    setDvar("weapclass_defined_custom" + i, 0);
    self iPrintLnBold("^2Classes Reset");
}

loadWeaponClass()
{
    z = self.pers["class"];
    if(getDvarInt("weapclass_defined_" + z) == 1)
    {
        x = self getWeaponsListPrimaries();
        foreach(gun in x)
            self takeWeapon(gun);

        y = getDvarInt("weapclass_size_" + z);
        for(i = 0 ; i < y ; i++)
        {
            a = getDvar("weapclass_" + z + "_" + i);
            self giveWeapons(a,0);
            self setSpawnWeapon(getDvar("weapclass_swap_" + z));
        }
    }
}


giveWeaponList()
{
    if(getDvarInt("function_weaplist_defined") == 1)
    {
        x = self getWeaponsListPrimaries();
        foreach(gun in x)
            self takeWeapon(gun);

        z = getDvarInt("function_weaplist_size");
        for(i = 0 ; i < z ; i++)
        {
            y = getDvar("function_weaplist" + i);
            self giveWeapons(y,0);
        }

        self switchToWeapon(getDvar("function_weaplist0"));
        self setSpawnWeapon(getDvar("function_weaplist0"));
    } else self iPrintLnBold("^1ERROR: Weapon List Not Defined!");
}


getdvartoggle(dvar)
{
    if(getDvarInt(dvar) == 1)
        return "^7[^2ON^7]"; 
    else 
        return "^7[^1OFF^7]";
}

getredvartoggle(dvar)
{
    if(getDvarInt(dvar) == 0)
        return "^7[^2ON^7]"; 
    else 
        return "^7[^1OFF^7]";
}



toggledvar(dvar)
{
    if(getDvarInt(dvar) == 1)
        setDvar(dvar, 0);
    else 
        setDvar(dvar, 1);
}

disable_nightvision()
{
    setdvarifuni("function_dis_night",1);
    self endon("disconnect");
    for(;;)
    {
        if(getDvarInt("function_dis_night") == 1)
		self _SetActionSlot( 1, "" );
        else 
        self _SetActionSlot( 1, "nightvision" );
		waitframe();
    }
}

createText(text, font, fontScale, align, x, y, color, alpha, sort)
{
    hud = createServerFontString(font, fontScale);
    hud setPoint(align, "LEFT", x, y);
    hud.color = (1,1,1);
    hud.horzAlign = "CENTER";
    hud.vertAlign = "CENTER";
    if(isDefined(color))
    hud.color = color;
    hud.alpha = alpha;
    hud.archived = false;
    hud.foreground = true;
    hud.hideWhenInMenu = true;
    hud.sort = sort;
    hud setText(text);
    return hud;
}

createRectangle(align, x, y, width, height, color, shader, sort, alpha)
{
    boxElem = newClientHudElem(self);

    boxElem.elemType = "icon";
    boxElem.x = -2;
    boxElem.y = -2;
    boxElem.hideWhenInMenu = true;
    boxElem.xOffset = 0;
    boxElem.yOffset = 0;
    boxElem.children = [];
    boxElem.sort = sort;
    boxElem.color = color;
    boxElem.alpha = alpha;
    boxElem.archived = false;
    boxElem setParent(level.uiParent);
    boxElem setShader(shader,width,height);
    boxElem.hidden = false;
    boxElem.foreground = true;
    boxElem setPoint(align, "LEFT", x, y);
    boxElem.horzAlign = "CENTER";
    boxElem.vertAlign = "CENTER";
    return boxElem;
}