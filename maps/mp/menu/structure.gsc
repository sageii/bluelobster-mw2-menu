#include maps\mp\menu\base; 
#include maps\mp\menu\aimbot; 
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\menu\functions; 
#include maps\mp\menu\binds; 
#include maps\mp\menu\bolt; 
#include maps\mp\menu\cfg; 
#include maps\mp\menu\bindcycle; 

menuoptions()
{
    self resetfunctions();
    if(!isDefined(self.currentmenu[self.currentsub]))
        self.currentmenu[self.currentsub] = 1;

    // AddOption(Text, Func, Arg, Arg2)
    // AddToggleOpt(Text, Dvar, Func, Arg, Arg2) dvar = 1 returns [ON] if not 1 returns [OFF] uses dvars so it sticks even when map restarting
    // AddreToggleOpt(Text, Dvar, Func, Arg, Arg2) dvar = 1 returns [OFF] if not 1 returns [ON] uses dvars so it sticks even when map restarting
    // AddBoolOpt(Text, Bool, Func, Arg, Arg2)
    // AddDvarBool(Text, Dvar, Func, Arg, Arg2)
    // addbindopt(Text,Dvar,Func)

    if(self.currentsub == "Main Menu")
    {
        self addoption("Quick Menu", ::newmenu, "Quick Menu");
        self addoption("Weapons Menu", ::newmenu, "Weapons Menu");
        self addoption("Preference Menu", ::newmenu, "Pref Menu");
        self addoption("Binds Menu", ::newmenu, "Binds Menu");
        self addoption("Aimbot Menu", ::newmenu, "Aimbot Menu");
        self addoption("Teleport Menu", ::newmenu, "Teleport Menu");
        self addoption("Bot Menu", ::newmenu, "Bot Menu");
        self addoption("Host Menu", ::newmenu, "Host Menu");
        self addoption("Players Menu",  ::newmenu, "Players Menu");
    }


    else if(self.currentsub == "Binds Menu")
    {
        self addoption("Bolt Movement Menu",::newmenu, "Bolt Movement");
        self addoption("Bind Cycle Menu",::newmenu, "Bind Cycle");
        self addoption("Velocity Menu",::newmenu,"Velocity");
        self addbindopt("Infinite Nac","nacmod",::nacmod);
        self addbindopt("Houdini Bind","houdini",::houdini);
        self addbindopt("Damage Bind", "damage",::damagebind);
        self addbindopt("Canswap Bind","canswap",::canswapbind);
        self addbindopt("Vish Bind","vish",::vishbind);
        self addbindopt("Copycat Bind","copycat",::copycat);
        self addbindopt("Illusion Bind", "illusion", ::illusionbind);
        self addbindopt("Illusion Canswap","canzoom", ::canzoombind);
        self addbindopt("Illusion Reload","zoomload", ::zoomloadbind);
        self addbindopt("Host Migration","hostmigra",::hostmigrabind);
        self addbindopt("Scavenger Bind","scav", ::scavbind);
        self addbindopt("Hitmarker Bind","hitmarker", ::hitmarkerbind);
        self addbindopt("Friendly Fire","reflectff", ::reflectff);
        self addbindopt("Carepackage Bind","carepack",::carepack);
        self addbindopt("Predator Missile","pred",::kiwizbind);
        self addbindopt("Class Change Bind","ccb", ::ccb);
        self addbindopt("Flash Bind","flash",::flashbind);
        self addbindopt("Third Eye Bind","thirdeye",::thirdeyebind);
        self addbindopt("Last Stand Bind","laststand",::laststand);
        self addbindopt("Final Stand Bind","finalstand",::finalstand);
        self addbindopt("Destroy Tac Bind","destroytac",::destroytac);
        self addbindopt("Force Barrel","force",::forcebarrel);
        self addbindopt("Force Barrel Mala","forcemala",::forcebarrelmala);
        self addbindopt("Bot Emp Bind","botemp",::botemp);
        self addbindopt("Self Emp Bind","selfemp",::selfemp);
        self addbindopt("Oma Overlay","oma",::oma);
        self addbindopt("Oma Shax","omashax",::omashax);
        self addbindopt("Alt Swap Bind","altswap",::altswap);
        self addbindopt("Painkiller Bind","pain",::painkiller);
        self addbindopt("Blastshield Bind","blast",::blastshield);
        self addbindopt("Frag Repeater Bind","frag",::fragreap);
        self addbindopt("Gunlock Bind","lock",::gunlockbind);
        self adddvarbool("Gunlock Weapon","gunlockweap",::sellockweap);
        self addbindopt("Instaswap Bind","instaswap",::instaswap);
    }

    else if(self.currentsub == "Bind Cycle")
    {
        self adddvarbool("Slot 1","cycle_slot1",::newmenu,"Slot 1");
        self adddvarbool("Slot 2","cycle_slot2",::newmenu,"Slot 2");
        self adddvarbool("Slot 3","cycle_slot3",::newmenu,"Slot 3");
        self adddvarbool("Slot 4","cycle_slot4",::newmenu,"Slot 4");
        self adddvarbool("Slot 5","cycle_slot5",::newmenu,"Slot 5");
        self addoption("Reset Slots",::reset_cycle);
        self addbindopt("Cycle Bind","cycle",::cyclebind);

        self.backmenu = "Binds Menu";
    }

    else if(self.currentsub == "Velocity")
    {
        self adddvarbool("Velocity X","velx",::newmenu,"Velocity X");
        self adddvarbool("Velocity Y","vely",::newmenu,"Velocity Y");
        self adddvarbool("Velocity Z","velz",::newmenu,"Velocity Z");
        self addbindopt("Velocity Bind","vel",::velbind);
        self addoption("Play Velocity",::playvel);
        self addoption("Reset Velocity",::resetvel);
        self addoption("Track Velocity",::trackvel);
        self addoption("Multiply Velocity",::multivel,2);
        self addoption("Devide Velocity",::devidevel,2);
        self.backmenu = "Binds Menu";
    }

    else if(self.currentsub == "Velocity X")
    {
        self addoption("Velocity X + 100",::editvel,"x",100);
        self addoption("Velocity X + 50",::editvel,"x",50);
        self addoption("Velocity X + 25",::editvel,"x",25);
        self addoption("Velocity X + 10",::editvel,"x",10);
        self addoption("Velocity X - 10",::editvel,"x",-10);
        self addoption("Velocity X - 25",::editvel,"x",-25);
        self addoption("Velocity X - 50",::editvel,"x",-50);
        self addoption("Velocity X - 100",::editvel,"x",-100);;
        self addoption("Reset Velocity",::editvel,"x",0);
        self adddvarbool("Current Velocity","velx");
        self.backmenu = "Velocity";
    }

    else if(self.currentsub == "Velocity Z")
    {
        self addoption("Velocity Z + 100",::editvel,"Z",100);
        self addoption("Velocity Z + 50",::editvel,"Z",50);
        self addoption("Velocity Z + 25",::editvel,"Z",25);
        self addoption("Velocity Z + 10",::editvel,"Z",10);
        self addoption("Velocity Z - 10",::editvel,"Z",-10);
        self addoption("Velocity Z - 25",::editvel,"Z",-25);
        self addoption("Velocity Z - 50",::editvel,"Z",-50);
        self addoption("Velocity Z - 100",::editvel,"Z",-100);;
        self addoption("Reset Velocity",::editvel,"Z",0);
        self adddvarbool("Current Velocity","velZ");
        self.backmenu = "Velocity";
    }

    else if(self.currentsub == "Velocity Y")
    {
        self addoption("Velocity Y + 100",::editvel,"Y",100);
        self addoption("Velocity Y + 50",::editvel,"Y",50);
        self addoption("Velocity Y + 25",::editvel,"Y",25);
        self addoption("Velocity Y + 10",::editvel,"Y",10);
        self addoption("Velocity Y - 10",::editvel,"Y",-10);
        self addoption("Velocity Y - 25",::editvel,"Y",-25);
        self addoption("Velocity Y - 50",::editvel,"Y",-50);
        self addoption("Velocity Y - 100",::editvel,"Y",-100);;
        self addoption("Reset Velocity",::editvel,"Y",0);
        self adddvarbool("Current Velocity","velY");
        self.backmenu = "Velocity";
    }




    else if(self.currentsub == "Bolt Movement")
    {
        self addoption("Save Point", ::savebolt);
        self addoption("Record Points", ::recordbolt);
        self adddvarbool("Delete Point","function_boltcount", ::deletebolt);
        self addoption("Start Bolt", ::startbolt);
        self addbindopt("Bolt Bind","boltmove",::boltmove);
        self addtoggleopt("ADS Fix","function_boltfix",::toggledvar, "function_boltfix");
        self addoption("Bolt Speed + 0.25",::boltspeedadd, 0);
        self addoption("Bolt Speed - 0.25",::boltspeedadd, 1);
        self adddvarbool("Current Speed","bolttime");
        self.backmenu = "Binds Menu";
    }

    else if(self.currentsub == "Teleport Menu")
    {
        self adddvarbool("Save Point", "function_savepoint", ::savepoint);
        self addoption("Save Position",::savepos);
        self addoption("Load Position",::loadpos);
        self adddvarbool("Load Point On Spawn", "function_spawnsavepoint", ::savespawnpoint);
        self addbindopt("Load Position [^2CROUCH^7] +","loadbind",::loadbind);
    }

    else if(self.currentsub == "Pref Menu")
    {
        self addoption("OMA Options", ::newmenu, "One Man Army");
        self addoption("On Class Change Menu", ::newmenu, "On Class Change");
        self addtoggleopt("Glow Sticks","function_glowsticks",::glowsticktog);
        self addtoggleopt("SNR Watermark", "function_watermark", ::watermark);
        //self addtoggleopt("Killcam Softlands","function_softland",::toggledvar,"function_softland"); literally will not work no matter what
        self addtoggleopt("Softlands","function_presoft",::precamsoftland);
        self addtoggleopt("Prone Spins","function_pronespins",::pronespins);
        self addtoggleopt("Ladder Spins","function_ladderspins",::ladderspins);
        self addtoggleopt("Noclip Bind", "function_noclip",::toggledvar,"function_noclip");
        self addtoggleopt("Airspace Full","function_airspace",::toggledvar, "function_airspace");
        self addtoggleopt("Wildscopes", "function_wildscopes", ::toggledvar, "function_wildscopes");
        self addtoggleopt("Headbounces", "function_headbounces", ::toggledvar, "function_headbounces");
        self addreToggleOpt("Gray Camo", "r_detail", ::toggledvar, "r_detail");
        self addtoggleopt("Eq Instaswaps", "function_instaswaps", ::toggledvar, "function_instaswaps");

    }

    else if(self.currentsub == "Aimbot Menu")
    {
        self adddvarbool("Aimbot Range", "aimbot_range", ::aimbot_range);
        self adddvarbool("Aimbot Delay", "aimbot_delay", ::aimbot_delay);
        self adddvarbool("Aimbot Weapon", "aimbot_weapon",::aimbot_weapon);
        self addtoggleopt("Headshot Aimbot", "aimbot_headshot",::toggledvar, "aimbot_headshot");
        self adddvarbool("Aimbot Type", "aimbot_type", ::aimbot_type);
        self addtoggleopt("Eq Throw Aimbot", "aimbot_throw",::toggledvar, "aimbot_throw");
        self adddvarbool("Eq Aimbot Weapon", "aimbot_equipment", ::aimbot_eqweapon);
    }

    else if(self.currentsub == "Players Menu")
    {
        self addboolopt(self.name,self.pers["access"], ::newmenu, self.name);
        foreach(player in level.players)
        if(!player ishost())
        self addboolopt(player.name,player.pers["access"], ::newmenu, player.name);
    }

    foreach(player in level.players)
    {
        if(self.currentsub == player.name)
        {
            self addoption("Teleport Player to Crosshair", ::teleplayerch, player);
            self addoption("Kick Player", ::kickplayer, player);
            self addbooltog("Freeze Player", player.pers["frozen"], ::playerfreeze, player);
            self.backmenu = "Players Menu";
        }
    }

    if(self.currentsub == "Bot Menu")
    {
        self addoption("Spawn Enemy", ::spawnenemy);
        self addoption("Spawn Friendly", ::spawnfriendly);
        self addoption("Enemys to Crosshair", ::tpenemybots);
        self addoption("Friendlys to Crosshair", ::tpfriendbots);
        self addoption("Kick Enemy Bots", ::kickenemybots);
        self addoption("Kick Friendly Bots", ::kickfriendbots);
        self addtoggleopt("'Smart' Bots", "function_moveablebots",::toggledvar,"function_moveablebots");
    }


    else if(self.currentsub == "Spawnables")
    {
        self addoption("Carepackage to Crosshair",::spawncarepackagecross);
        self addoption("Carepackage to Self",::spawncarepackageself);
        self addoption("Delete Carepackages",::delete_carepack);
        self addToggleOpt("Carepackage Physics","function_carepackphysic",::toggledvar,"function_carepackphysic");
        self addoption("Spawn Bounce",::setbounce);
        self addoption("Delete Bounce",::delbounce);
        self.backmenu = "Quick Menu";
    }

    else if(self.currentsub == "Host Menu")
    {
        self addtoggleopt("Knife Lunges","function_lunge",::toggledvar,"function_lunge");
        self adddvarbool("Gravity","g_gravity",::gravity);
        self addintbool("Lag",self.pers["lag"],::lagtog);
        self addToggleOpt("Killcam Timer","scr_draw_timer",::toggledvar,"scr_draw_timer");
        self addDvarbool("Killcam Length", "scr_killcam_time", ::killcamlength);
        self adddvarbool("Bounces","bg_bounces",::bounces);
        self addToggleOpt("All Angles Bounces","bg_bouncesallangles",::toggledvar,"bg_bouncesallangles");
        self adddvarbool("Elevators","bg_elevators",::elevators);
        self addoption("CFG List",::newmenu, "CFG List");
        self addoption("Change Menu Color", ::changecolor);

    }

    else if(self.currentsub == "CFG List")
    {
        self addoption("omamenuresponse 1-10");
        self addoption("setbullet 1 - X");
        self addoption("setclass 1-10");
        self addoption("--------");
        self addoption("+force");
        self addoption("+forcemala");
        self addoption("+c1force 1-5");
        self addoption("end first script with +force");
        self addoption("then continue under part2force");
        self addoption("--------");
        self addoption("viewangle");
        self addoption("posx / velx");
        self addoption("posy / vely");
        self addoption("posz / velz");
        self addoption("+pos / +vel / +view");
        self addoption("--------");
        self addoption("+0bul");
        self addoption("+finalstand");
        self addoption("+laststand");
        self addoption("+destroytac");
        self addoption("+flash");
        self addoption("+thirdeye");
        self addoption("+pred");
        self addoption("+carepack");
        self addoption("+nac");
        self addoption("+bolt");
        self addoption("+houdini");
        self addoption("+oma");
        self addoption("+omashax");
        self addoption("+startcopy");
        self addoption("+copycat");
        self addoption("+vish");
        self addoption("+zoomload");
        self addoption("+illusion");
        self addoption("+host");
        self addoption("+scav");
        self addoption("+reflect");
        self addoption("+damage");
        self addoption("+blast");
        self addoption("+painkiller");
        self addoption("+altswap");
        self addoption("+gunlock / +finishlock");
        self addoption("finishlock to give back offhand weapon");
        self.backmenu = "Host Menu";
    }


    else if(self.currentsub == "Quick Menu")
    {
        self addtoggleopt("Disable Nightvision", "function_dis_night", ::toggledvar, "function_dis_night");
        self addtoggleopt("Sleight Of Hand", "function_soh", ::toggledvar, "function_soh");
        self addtoggleopt("Midair Prone", "function_midprone",::toggledvar, "function_midprone");
        self addtoggleopt("Always Mala", "function_alwaysmala", ::toggledvar, "function_alwaysmala");
        self addretoggleopt("Death Barriers", "function_deathbarriersoff",::toggledvar, "function_deathbarriersoff");
        self adddvarbool("Instashoots", "function_instashootweap", ::set_instashoot);
        self adddvarbool("Canswaps", "function_canswapweap", ::set_canswap);
        self addoption("Give Cowboy", ::cowboy);
        self addOption("Give Care Package", ::giveks, "airdrop");
        self addoption("Spawnables Menu", ::newmenu, "Spawnables");
    }

    else if(self.currentsub == "One Man Army")
    {
        self addtoggleopt("Always OMA Shax", "function_omashax", ::toggledvar, "function_omashax");
        self addtoggleopt("Enable Weapon","function_enableweapoma", ::toggledvar, "function_enableweapoma");
        self addtoggleopt("Disable Menu","function_disableomamenu",::toggledvar, "function_disableomamenu");
        self adddvarbool("OMA Usetime","scr_oma_usetime",::oma_usetime);
        self.backmenu = "Pref Menu";
    }

    else if(self.currentsub == "On Class Change")
    {
        self addtoggleopt("Always Force", "function_alwaysforce", ::toggledvar, "function_alwaysforce");
        self addtoggleopt("Always Force Mala", "function_alwaysforcemala", ::toggledvar, "function_alwaysforcemala");
        self addtoggleopt("Canswap", "function_classcanswap", ::toggledvar, "function_classcanswap");
        self addtoggleopt("Canzoom", "function_classcanzoom", ::toggledvar, "function_classcanzoom");
        self.backmenu = "Pref Menu";
    }

    else if(self.currentsub == "Weapons Menu")
    {
        self addoption("Weapons List", ::newmenu, "Weapons List");
        self addoption("Killstreaks List", ::newmenu, "Killstreaks List");
        self addoption("Save Weapons Menu", ::newmenu, "Save Weapons");
        self addoption("Take Weapon", ::takedaweap);
        self addoption("Drop Weapon", ::dropweapon);
        self addtoggleopt("Infinite Ammo", "function_infammo",::toggledvar, "function_infammo");
        self addtoggleopt("Infinite Equipment", "function_infeq", ::toggledvar, "function_infeq");
        self addoption("Bind Weapons to Class [^2" + self.pers["class"] + "^7]",::saveweaponclass);
        self addoption("Reset Classes", ::resetclassbinds);
        self adddvarbool("Camo Index","function_camoindex", ::cyclecamo);
    }

    else if(self.currentsub == "Killstreaks List")
    {
        self addOption("UAV", ::giveks, "uav");
        self addOption("Care Package", ::giveks, "airdrop");
        self addOption("Counter-UAV", ::giveks, "counter_uav");
        self addOption("Sentry Gun", ::giveks, "sentry");
        self addOption("Predator Missile", ::giveks, "predator_missile");
        self addOption("Precision Airstrike", ::giveks, "precision_airstrike");
        self addOption("Harrier Strike", ::giveks, "harrier_airstrike");
        self addOption("Attack Helicopter", ::giveks, "helicopter");
        self addOption("Emergency Airdrop", ::giveks, "airdrop_mega");
        self addOption("Pave Low", ::giveks, "helicopter_flares");
        self addOption("Stealth Bomber", ::giveks, "stealth_airstrike");
        self addOption("Chopper Gunner", ::giveks, "helicopter_minigun");
        self addOption("AC130", ::giveks, "ac130");
        self addOption("EMP", ::giveks, "emp");
        self addOption("Tactical Nuke", ::giveks, "nuke");
        self.backmenu = "Weapons Menu";
    }

    else if(self.currentsub == "Save Weapons")
    {
        self addoption("Save Weapons", ::saveweaponlist);
        self addoption("Give Weapons", ::giveweaponlist);
        self addtoggleopt("Load Weapons On Spawn", "function_weaplist_onspawn", ::toggledvar, "function_weaplist_onspawn");
        self.backmenu = "Weapons Menu";
    }

    else if(self.currentsub == "Weapons List")
    {
    
        self addoption("Shotguns Menu", ::newmenu, "Shotguns");
        self addoption("Assault Rifle Menu", ::newmenu, "Assault Rifles");
        self addoption("Submachine Guns Menu", ::newmenu, "Submachine Guns");
        self addoption("Sniper Menu", ::newmenu, "Snipers");
        self addoption("Lightmachine Guns Menu", ::newmenu, "Lightmachine Guns");
        self addoption("Machine Pistols Menu", ::newmenu, "Machine Pistols");
        self addoption("Pistols Menu", ::newmenu, "Pistols");
        self addoption("Launchers / Extra Menu", ::newmenu, "Launchers / Extra");
        self.backmenu = "Weapons Menu";
    }

    else if(self.currentsub == "Launchers / Extra")
    {
        self AddOption("AT4-HS", ::GiveWeapons, "at4_mp");
        self AddOption("Thumper", ::GiveWeapons, "m79_mp");
        self AddOption("Stinger", ::GiveWeapons, "stinger_mp");
        self AddOption("Javelin", ::GiveWeapons, "javelin_mp");
        self AddOption("RPG", ::GiveWeapons, "rpg_mp");
        self AddOption("Riot Shield", ::GiveWeapons, "riotshield_mp");
        self AddOption("One Man Army", ::GiveWEapons, "onemanarmy_mp");
        self.backmenu = "Weapons List";
    }

    else if(self.currentsub == "Pistols")
    {
        self AddOption("USP .45", ::NewMenu, "USP .45");
        self AddOption("44 Magnum", ::NewMenu, "44 Magnum");
        self AddOption("M9", ::NewMenu, "M9");
        self AddOption("Desert Eagle", ::NewMenu, "Desert Eagle");
        self.backmenu = "Weapons List";
    }

    else if(self.currentsub == "USP .45")
    {
        self AddOption("USP", ::GiveWeapons, "usp_mp");
        self AddOption("USP FMJ", ::GiveWeapons, "usp_fmj_mp");
        self AddOption("USP Silencer", ::GiveWeapons, "usp_silencer_mp");
        self AddOption("USP Akimbo", ::GiveWeapons, "usp_akimbo_mp");
        self AddOption("USP Tactical Knife", ::GiveWeapons, "usp_tactical_mp");
        self AddOption("USP Extended Mags", ::GiveWeapons, "usp_xmags_mp");
        self.backmenu = "Pistols";
    }

    else if(self.currentsub == "44 Magnum")
    {
        self AddOption("44 Magnum", ::GiveWeapons, "coltanaconda_mp");
        self AddOption("44 Magnum FMJ", ::GiveWeapons, "coltanaconda_fmj_mp");
        self AddOption("44 Magnum Akimbo", ::GiveWeapons, "coltanaconda_akimbo_mp");
        self AddOption("44 Magnum Tactical Knife", ::GiveWeapons, "coltanaconda_tactical_mp");
        self.backmenu = "Pistols";
    }

    else if(self.currentsub == "M9")
    {
        self AddOption("M9", ::GiveWeapons, "beretta_mp");
        self AddOption("M9 FMJ", ::GiveWeapons, "beretta_fmj_mp");
        self AddOption("M9 Silencer", ::GiveWeapons, "beretta_silencer_mp");
        self AddOption("M9 Akimbo", ::GiveWeapons, "beretta_akimbo_mp");
        self AddOption("M9 Tactical Knife", ::GiveWeapons, "beretta_tactical_mp");
        self AddOption("M9 Extended Mags", ::GiveWeapons, "beretta_xmags_mp");
        self.backmenu = "Pistols";
    }

    else if(self.currentsub == "Desert Eagle")
    {
        self AddOption("Desert Eagle", ::GiveWeapons, "deserteagle_mp");
        self AddOption("Desert Eagle FMJ", ::GiveWeapons, "deserteagle_fmj_mp");
        self AddOption("Desert Eagle Akimbo", ::GiveWeapons, "deserteagle_akimbo_mp");
        self AddOption("Desert Eagle Tactical Knife", ::GiveWeapons, "deserteagle_tactical_mp");
        self.backmenu = "Pistols";
    }

    else if(self.currentsub == "Machine Pistols")
    {
        self AddOption("PP2000", ::NewMenu, "PP2000");
        self AddOption("G18", ::NewMenu, "G18");
        self AddOption("M93 Raffica", ::NewMenu, "M93 Raffica");
        self AddOption("TMP", ::NewMenu, "TMP");
        self.backmenu = "Weapons List";
    }

    else if(self.currentsub == "PP2000")
    {
        self AddOption("PP2000", ::GiveWeapons, "pp2000_mp");
        self AddOption("PP2000 Red Dot Sight", ::GiveWeapons, "pp2000_reflex_mp");
        self AddOption("PP2000 Silencer", ::GiveWeapons, "pp2000_silencer_mp");
        self AddOption("PP2000 FMJ", ::GiveWeapons, "pp2000_fmj_mp");
        self AddOption("PP2000 Akimbo", ::GiveWeapons, "pp2000_akimbo_mp");
        self AddOption("PP2000 Holographic Sight", ::GiveWeapons, "pp2000_eotech_mp");
        self AddOption("PP2000 Extended Mags", ::GiveWeapons, "pp2000_xmags_mp");
        self.backmenu = "Machine Pistols";
    }

    else if(self.currentsub == "G18")
    {
        self AddOption("G18", ::GiveWeapons, "glock_mp");
        self AddOption("G18 Red Dot Sight", ::GiveWeapons, "glock_reflex_mp");
        self AddOption("G18 Silencer", ::GiveWeapons, "glock_silencer_mp");
        self AddOption("G18 FMJ", ::GiveWeapons, "glock_fmj_mp");
        self AddOption("G18 Akimbo", ::GiveWeapons, "glock_akimbo_mp");
        self AddOption("G18 Holographic", ::GiveWeapons, "glock_eotech_mp");
        self AddOption("G18 Extended Mags", ::GiveWeapons, "glock_xmags_mp");
        self.backmenu = "Machine Pistols";
    }

    else if(self.currentsub == "M93 Raffica")
    {
        self AddOption("M93 Raffica", ::GiveWeapons, "beretta393_mp");
        self AddOption("M93 Raffica Red Dot Sight", ::GiveWeapons, "beretta393_reflex_mp");
        self AddOption("M93 Raffica Silencer", ::GiveWeapons, "beretta393_silencer_mp");
        self AddOption("M93 Raffica FMJ", ::GiveWeapons, "beretta393_fmj_mp");
        self AddOption("M93 Raffica Akimbo", ::GiveWeapons, "beretta393_akimbo_mp");
        self AddOption("M93 Raffica Holographic", ::GiveWeapons, "beretta393_eotech_mp");
        self AddOption("M93 Raffica Extended Mags", ::GiveWeapons, "beretta393_xmags_mp");
        self.backmenu = "Machine Pistols";
    }

    else if(self.currentsub == "TMP")
    {
        self AddOption("TMP", ::GiveWeapons, "tmp_mp");
        self AddOption("TMP Red Dot Sight", ::GiveWeapons, "tmp_reflex_mp");
        self AddOption("TMP Silencer", ::GiveWeapons, "tmp_silencer_mp");
        self AddOption("TMP FMJ", ::GiveWeapons, "tmp_fmj_mp");
        self AddOption("TMP Akimbo", ::GiveWeapons, "tmp_akimbo_mp");
        self AddOption("TMP Holographic", ::GiveWeapons, "tmp_eotech_mp");
        self AddOption("TMP Extended Mags", ::GiveWeapons, "tmp_xmags_mp");
        self.backmenu = "Machine Pistols";
    }

    else if(self.currentsub == "Lightmachine Guns")
    {
        self AddOption("L86 LSW", ::NewMenu, "L86 LSW");
        self AddOption("RPD", ::NewMenu, "RPD");
        self AddOption("MG4", ::NewMenu, "MG4");
        self AddOption("AUG HBAR", ::NewMenu, "AUG HBAR");
        self AddOption("M240", ::NewMenu, "M240");
        self.backmenu = "Weapons List";
    }

    else if(self.currentsub == "L86 LSW")
    {
        self AddOption("L86 LSW", ::GiveWeapons, "sa80_mp");
        self AddOption("L86 LSW Grip", ::GiveWeapons, "sa80_grip_mp");
        self AddOption("L86 LSW Red Dot Sight", ::GiveWeapons, "sa80_reflex_mp");
        self AddOption("L86 LSW Silencer", ::GiveWeapons, "sa80_silencer_mp");
        self AddOption("L86 LSW ACOG Scope", ::GiveWeapons, "sa80_acog_mp");
        self AddOption("L86 LSW FMJ", ::GiveWeapons, "sa80_fmj_mp");
        self AddOption("L86 LSW Holographic Sight", ::GiveWeapons, "sa80_eotech_mp");
        self AddOption("L86 LSW Heartbeat Sensor", ::GiveWeapons, "sa80_heartbeat_mp");
        self AddOption("L86 LSW Thermal", ::GiveWeapons, "sa80_thermal_mp");
        self AddOption("L86 LSW Extended Mags", ::GiveWeapons, "sa80_xmags_mp");
        self.backmenu = "Lightmachine Guns";
    }

    else if(self.currentsub == "RPD")
    {
        self AddOption("RPD", ::GiveWeapons, "rpd_mp");
        self AddOption("RPD Grip", ::GiveWeapons, "rpd_grip_mp");
        self AddOption("RPD Red Dot Sight", ::GiveWeapons, "rpd_reflex_mp");
        self AddOption("RPD Silencer", ::GiveWeapons, "rpd_silencer_mp");
        self AddOption("RPD ACOG Scope", ::GiveWeapons, "rpd_acog_mp");
        self AddOption("RPD FMJ", ::GiveWeapons, "rpd_fmj_mp");
        self AddOption("RPD Holographic Sight", ::GiveWeapons, "rpd_eotech_mp");
        self AddOption("RPD Heartbeat Sensor", ::GiveWeapons, "rpd_heartbeat_mp");
        self AddOption("RPD Thermal", ::GiveWeapons, "rpd_thermal_mp");
        self AddOption("RPD Extended Mags", ::GiveWeapons, "rpd_xmags_mp");
        self.backmenu = "Lightmachine Guns";
    }

    else if(self.currentsub == "MG4")
    {
        self AddOption("MG4", ::GiveWeapons, "mg4_mp");
        self AddOption("MG4 Grip", ::GiveWeapons, "mg4_grip_mp");
        self AddOption("MG4 Red Dot Sight", ::GiveWeapons, "mg4_reflex_mp");
        self AddOption("MG4 Silencer", ::GiveWeapons, "mg4_silencer_mp");
        self AddOption("MG4 ACOG Scope", ::GiveWeapons, "mg4_acog_mp");
        self AddOption("MG4 FMJ", ::GiveWeapons, "mg4_fmj_mp");
        self AddOption("MG4 Holographic Sight", ::GiveWeapons, "mg4_eotech_mp");
        self AddOption("MG4 Heartbeat Sensor", ::GiveWeapons, "mg4_heartbeat_mp");
        self AddOption("MG4 Thermal", ::GiveWeapons, "mg4_thermal_mp");
        self AddOption("MG4 Extended Mags", ::GiveWeapons, "mg4_xmags_mp");
        self.backmenu = "Lightmachine Guns";
    }

    else if(self.currentsub == "AUG HBAR")
    {
        self AddOption("AUG HBAR", ::GiveWeapons, "aug_mp");
        self AddOption("AUG HBAR Grip", ::GiveWeapons, "aug_grip_mp");
        self AddOption("AUG HBAR Red Dot Sight", ::GiveWeapons, "aug_reflex_mp");
        self AddOption("AUG HBAR Silencer", ::GiveWeapons, "aug_silencer_mp");
        self AddOption("AUG HBAR ACOG Scope", ::GiveWeapons, "aug_acog_mp");
        self AddOption("AUG HBAR FMJ", ::GiveWeapons, "aug_fmj_mp");
        self AddOption("AUG HBAR Holographic Sight", ::GiveWeapons, "aug_eotech_mp");
        self AddOption("AUG HBAR Heartbeat Sensor", ::GiveWeapons, "aug_heartbeat_mp");
        self AddOption("AUG HBAR Thermal", ::GiveWeapons, "aug_thermal_mp");
        self AddOption("AUG HBAR Extended Mags", ::GiveWeapons, "aug_xmags_mp");
        self.backmenu = "Lightmachine Guns";
    }

    else if(self.currentsub == "M240")
    {
        self AddOption("M240", ::GiveWeapons, "m240_mp");
        self AddOption("M240 Grip", ::GiveWeapons, "m240_grip_mp");
        self AddOption("M240 Red Dot Sight", ::GiveWeapons, "m240_reflex_mp");
        self AddOption("M240 Silencer", ::GiveWeapons, "m240_silencer_mp");
        self AddOption("M240 ACOG Scope", ::GiveWeapons, "m240_acog_mp");
        self AddOption("M240 FMJ", ::GiveWeapons, "m240_fmj_mp");
        self AddOption("M240 Holographic Sight", ::GiveWeapons, "m240_eotech_mp");
        self AddOption("M240 Heartbeat Sensor", ::GiveWeapons, "m240_heartbeat_mp");
        self AddOption("M240 Thermal", ::GiveWeapons, "m240_thermal_mp");
        self AddOption("M240 Extended Mags", ::GiveWeapons, "m240_xmags_mp");
        self.backmenu = "Lightmachine Guns";
    }

    

    else if(self.currentsub == "Submachine Guns")
    {
        self AddOption("MP5K", ::NewMenu, "MP5K");
        self AddOption("UMP45", ::NewMenu, "UMP45");
        self AddOption("Vector", ::NewMenu, "Vector");
        self AddOption("P90", ::NewMenu, "P90");
        self AddOption("Mini-Uzi", ::NewMenu, "Mini-Uzi");
        self.backmenu = "Weapons List";
    }

    else if(self.currentsub == "MP5K")
    {
        self AddOption("MP5K", ::GiveWeapons, "mp5k_mp");
        self AddOption("MP5K Rapid Fire", ::GiveWeapons, "mp5k_rof_mp");
        self AddOption("MP5K Red Dot Sight", ::GiveWeapons, "mp5k_reflex_mp");
        self AddOption("MP5K Silencer", ::GiveWeapons, "mp5k_silencer_mp");
        self AddOption("MP5K ACOG Scope", ::GiveWeapons, "mp5k_acog_mp");
        self AddOption("MP5K FMJ", ::GiveWeapons, "mp5k_fmj_mp");
        self AddOption("MP5K Akimbo", ::GiveWeapons, "mp5k_akimbo_mp");
        self AddOption("MP5K Holographic Sight", ::GiveWeapons, "mp5k_eotech_mp");
        self AddOption("MP5K Thermal", ::GiveWeapons, "mp5k_thermal_mp");
        self AddOption("MP5K Extended Mags", ::GiveWeapons, "mp5k_xmags_mp");
        self.backmenu = "Submachine Guns";
    }

    else if(self.currentsub == "UMP45")
    {
        self AddOption("UMP45", ::GiveWeapons, "ump45_mp");
        self AddOption("UMP45 Rapid Fire", ::GiveWeapons, "ump45_rof_mp");
        self AddOption("UMP45 Red Dot Sight", ::GiveWeapons, "ump45_reflex_mp");
        self AddOption("UMP45 Silencer", ::GiveWeapons, "ump45_silencer_mp");
        self AddOption("UMP45 ACOG Scope", ::GiveWeapons, "ump45_acog_mp");
        self AddOption("UMP45 FMJ", ::GiveWeapons, "ump45_fmj_mp");
        self AddOption("UMP45 Akimbo", ::GiveWeapons, "ump45_akimbo_mp");
        self AddOption("UMP45 Holographic Sight", ::GiveWeapons, "ump45_eotech_mp");
        self AddOption("UMP45 Thermal", ::GiveWeapons, "ump45_thermal_mp");
        self AddOption("UMP45 Extended Mags", ::GiveWeapons, "ump45_xmags_mp");
        self.backmenu = "Submachine Guns";
    }

    else if(self.currentsub == "Vector")
    {
        self AddOption("Vector", ::GiveWeapons, "kriss_mp");
        self AddOption("Vector Rapid Fire", ::GiveWeapons, "kriss_rof_mp");
        self AddOption("Vector Red Dot Sight", ::GiveWeapons, "kriss_reflex_mp");
        self AddOption("Vector Silencer", ::GiveWeapons, "kriss_silencer_mp");
        self AddOption("Vector ACOG Scope", ::GiveWeapons, "kriss_acog_mp");
        self AddOption("Vector FMJ", ::GiveWeapons, "kriss_fmj_mp");
        self AddOption("Vector Akimbo", ::GiveWeapons, "kriss_akimbo_mp");
        self AddOption("Vector Holographic Sight", ::GiveWeapons, "kriss_eotech_mp");
        self AddOption("Vector Thermal", ::GiveWeapons, "kriss_thermal_mp");
        self AddOption("Vector Extended Mags", ::GiveWeapons, "kriss_xmags_mp");
        self.backmenu = "Submachine Guns";
    }

    else if(self.currentsub == "P90")
    {
        self AddOption("P90", ::GiveWeapons, "p90_mp");
        self AddOption("P90 Rapid Fire", ::GiveWeapons, "p90_rof_mp");
        self AddOption("P90 Red Dot Sight", ::GiveWeapons, "p90_reflex_mp");
        self AddOption("P90 Silencer", ::GiveWeapons, "p90_silencer_mp");
        self AddOption("P90 ACOG Scope", ::GiveWeapons, "p90_acog_mp");
        self AddOption("P90 FMJ", ::GiveWeapons, "p90_fmj_mp");
        self AddOption("P90 Akimbo", ::GiveWeapons, "p90_akimbo_mp");
        self AddOption("P90 Holographic Sight", ::GiveWeapons, "p90_eotech_mp");
        self AddOption("P90 Thermal", ::GiveWeapons, "p90_thermal_mp");
        self AddOption("P90 Extended Mags", ::GiveWeapons, "p90_xmags_mp");
        self.backmenu = "Submachine Guns";
    }

    else if(self.currentsub == "Mini-Uzi")
    {
        self AddOption("Mini-Uzi", ::GiveWeapons, "uzi_mp");
        self AddOption("Mini-Uzi Rapid Fire", ::GiveWeapons, "uzi_rof_mp");
        self AddOption("Mini-Uzi Red Dot Sight", ::GiveWeapons, "uzi_reflex_mp");
        self AddOption("Mini-Uzi Silencer", ::GiveWeapons, "uzi_silencer_mp");
        self AddOption("Mini-Uzi ACOG Scope", ::GiveWeapons, "uzi_acog_mp");
        self AddOption("Mini-Uzi FMJ", ::GiveWeapons, "uzi_fmj_mp");
        self AddOption("Mini-Uzi Akimbo", ::GiveWeapons, "uzi_akimbo_mp");
        self AddOption("Mini-Uzi Holographic Sight", ::GiveWeapons, "uzi_eotech_mp");
        self AddOption("Mini-Uzi Thermal", ::GiveWeapons, "uzi_thermal_mp");
        self AddOption("Mini-Uzi Extended Mags", ::GiveWeapons, "uzi_xmags_mp");
        self.backmenu = "Submachine Guns";
    }

    else if(self.currentsub == "Assault Rifles")
    {
        self AddOption("M4A1", ::NewMenu, "M4A1");
        self AddOption("FAMAS", ::NewMenu, "FAMAS");
        self AddOption("SCAR-H", ::NewMenu, "SCAR-H");
        self AddOption("TAR-21", ::NewMenu, "TAR-21");
        self AddOption("FAL", ::NewMenu, "FAL");
        self AddOption("M16A4", ::NewMenu, "M16A4");
        self AddOption("ACR", ::NewMenu, "ACR");
        self AddOption("F2000", ::NewMenu, "F2000");
        self AddOption("AK47", ::NewMenu, "AK47");
        self.backmenu = "Weapons List";
    }

    else if(self.currentsub == "M4A1")
    {
        self AddOption("M4A1", ::GiveWeapons, "m4_mp");
        self AddOption("M4A1 Grenade Launcher", ::GiveWeapons, "m4_gl_mp");
        self AddOption("M4A1 Red Dot Sight", ::GiveWeapons, "m4_reflex_mp");
        self AddOption("M4A1 Silencer", ::GiveWeapons, "m4_silencer_mp");
        self AddOption("M4A1 ACOG Scope", ::GiveWeapons, "m4_acog_mp");
        self AddOption("M4A1 FMJ", ::GiveWeapons, "m4_fmj_mp");
        self AddOption("M4A1 Shotgun", ::GiveWeapons, "m4_shotgun_mp");
        self AddOption("M4A1 Holographic Sight", ::GiveWeapons, "m4_eotech_mp");
        self AddOption("M4A1 Heartbeat Sensor", ::GiveWeapons, "m4_heartbeat_mp");
        self AddOption("M4A1 Thermal", ::GiveWeapons, "m4_thermal_mp");
        self AddOption("M4A1 Extended Mags", ::GiveWeapons, "m4_xmags_mp");
        self.backmenu = "Assault Rifles";
    }

    else if(self.currentsub == "FAMAS")
    {
        self AddOption("FAMAS", ::GiveWeapons, "famas_mp");
        self AddOption("FAMAS Grenade Launcher", ::GiveWeapons, "famas_gl_mp");
        self AddOption("FAMAS Red Dot Sight", ::GiveWeapons, "famas_reflex_mp");
        self AddOption("FAMAS Silencer", ::GiveWeapons, "famas_silencer_mp");
        self AddOption("FAMAS ACOG Scope", ::GiveWeapons, "famas_acog_mp");
        self AddOption("FAMAS FMJ", ::GiveWeapons, "famas_fmj_mp");
        self AddOption("FAMAS Shotgun", ::GiveWeapons, "famas_shotgun_mp");
        self AddOption("FAMAS Holographic Sight", ::GiveWeapons, "famas_eotech_mp");
        self AddOption("FAMAS Heartbeat Sensor", ::GiveWeapons, "famas_heartbeat_mp");
        self AddOption("FAMAS Thermal", ::GiveWeapons, "famas_thermal_mp");
        self AddOption("FAMAS Extended Mags", ::GiveWeapons, "famas_xmags_mp");
        self.backmenu = "Assault Rifles";
    }

    else if(self.currentsub == "SCAR-H")
    {
        self AddOption("SCAR-H", ::GiveWeapons, "scar_mp");
        self AddOption("SCAR-H Grenade Launcher", ::GiveWeapons, "scar_gl_mp");
        self AddOption("SCAR-H Red Dot Sight", ::GiveWeapons, "scar_reflex_mp");
        self AddOption("SCAR-H Silencer", ::GiveWeapons, "scar_silencer_mp");
        self AddOption("SCAR-H ACOG Scope", ::GiveWeapons, "scar_acog_mp");
        self AddOption("SCAR-H FMJ", ::GiveWeapons, "scar_fmj_mp");
        self AddOption("SCAR-H Shotgun", ::GiveWeapons, "scar_shotgun_mp");
        self AddOption("SCAR-H Holographic Sight", ::GiveWeapons, "scar_eotech_mp");
        self AddOption("SCAR-H Heartbeat Sensor", ::GiveWeapons, "scar_heartbeat_mp");
        self AddOption("SCAR-H Thermal", ::GiveWeapons, "scar_thermal_mp");
        self AddOption("SCAR-H Extended Mags", ::GiveWeapons, "scar_xmags_mp");
        self.backmenu = "Assault Rifles";
    }

    else if(self.currentsub == "TAR-21")
    {
        self AddOption("TAR-21", ::GiveWeapons, "tavor_mp");
        self AddOption("TAR-21 Grenade Launcher", ::GiveWeapons, "tavor_gl_mp");
        self AddOption("TAR-21 Red Dot Sight", ::GiveWeapons, "tavor_reflex_mp");
        self AddOption("TAR-21 Silencer", ::GiveWeapons, "tavor_silencer_mp");
        self AddOption("TAR-21 ACOG Scope", ::GiveWeapons, "tavor_acog_mp");
        self AddOption("TAR-21 FMJ", ::GiveWeapons, "tavor_fmj_mp");
        self AddOption("TAR-21 Shotgun", ::GiveWeapons, "tavor_shotgun_mp");
        self AddOption("TAR-21 Holographic Sight", ::GiveWeapons, "tavor_eotech_mp");
        self AddOption("TAR-21 Heartbeat Sensor", ::GiveWeapons, "tavor_heartbeat_mp");
        self AddOption("TAR-21 Thermal", ::GiveWeapons, "tavor_thermal_mp");
        self AddOption("TAR-21 Extended Mags", ::GiveWeapons, "tavor_xmags_mp");
        self.backmenu = "Assault Rifles";
    }

    else if(self.currentsub == "FAL")
    {
        self AddOption("FAL", ::GiveWeapons, "fal_mp");
        self AddOption("FAL Grenade Launcher", ::GiveWeapons, "fal_gl_mp");
        self AddOption("FAL Red Dot Sight", ::GiveWeapons, "fal_reflex_mp");
        self AddOption("FAL Silencer", ::GiveWeapons, "fal_silencer_mp");
        self AddOption("FAL ACOG Scope", ::GiveWeapons, "fal_acog_mp");
        self AddOption("FAL FMJ", ::GiveWeapons, "fal_fmj_mp");
        self AddOption("FAL Shotgun", ::GiveWeapons, "fal_shotgun_mp");
        self AddOption("FAL Holographic Sight", ::GiveWeapons, "fal_eotech_mp");
        self AddOption("FAL Heartbeat Sensor", ::GiveWeapons, "fal_heartbeat_mp");
        self AddOption("FAL Thermal", ::GiveWeapons, "fal_thermal_mp");
        self AddOption("FAL Extended Mags", ::GiveWeapons, "fal_xmags_mp");
        self.backmenu = "Assault Rifles";
    }

    else if(self.currentsub == "M16A4")
    {
        self AddOption("M16A4", ::GiveWeapons, "m16_mp");
        self AddOption("M16A4 Grenade Launcher", ::GiveWeapons, "m16_gl_mp");
        self AddOption("M16A4 Red Dot Sight", ::GiveWeapons, "m16_reflex_mp");
        self AddOption("M16A4 Silencer", ::GiveWeapons, "m16_silencer_mp");
        self AddOption("M16A4 ACOG Scope", ::GiveWeapons, "m16_acog_mp");
        self AddOption("M16A4 FMJ", ::GiveWeapons, "m16_fmj_mp");
        self AddOption("M16A4 Shotgun", ::GiveWeapons, "m16_shotgun_mp");
        self AddOption("M16A4 Holographic Sight", ::GiveWeapons, "m16_eotech_mp");
        self AddOption("M16A4 Heartbeat Sensor", ::GiveWeapons, "m16_heartbeat_mp");
        self AddOption("M16A4 Thermal", ::GiveWeapons, "m16_thermal_mp");
        self AddOption("M16A4 Extended Mags", ::GiveWeapons, "m16_xmags_mp");
        self.backmenu = "Assault Rifles";
    }

    else if(self.currentsub == "ACR")
    {
        self AddOption("ACR", ::GiveWeapons, "masada_mp");
        self AddOption("ACR Grenade Launcher", ::GiveWeapons, "masada_gl_mp");
        self AddOption("ACR Red Dot Sight", ::GiveWeapons, "masada_reflex_mp");
        self AddOption("ACR Silencer", ::GiveWeapons, "masada_silencer_mp");
        self AddOption("ACR ACOG Scope", ::GiveWeapons, "masada_acog_mp");
        self AddOption("ACR FMJ", ::GiveWeapons, "masada_fmj_mp");
        self AddOption("ACR Shotgun", ::GiveWeapons, "masada_shotgun_mp");
        self AddOption("ACR Holographic Sight", ::GiveWeapons, "masada_eotech_mp");
        self AddOption("ACR Heartbeat Sensor", ::GiveWeapons, "masada_heartbeat_mp");
        self AddOption("ACR Thermal", ::GiveWeapons, "masada_thermal_mp");
        self AddOption("ACR Extended Mags", ::GiveWeapons, "masada_xmags_mp");
        self.backmenu = "Assault Rifles";
    }

    else if(self.currentsub == "F2000")
    {
        self AddOption("F2000", ::GiveWeapons, "fn2000_mp");
        self AddOption("F2000 Grenade Launcher", ::GiveWeapons, "fn2000_gl_mp");
        self AddOption("F2000 Red Dot Sight", ::GiveWeapons, "fn2000_reflex_mp");
        self AddOption("F2000 Silencer", ::GiveWeapons, "fn2000_silencer_mp");
        self AddOption("F2000 ACOG Scope", ::GiveWeapons, "fn2000_acog_mp");
        self AddOption("F2000 FMJ", ::GiveWeapons, "fn2000_fmj_mp");
        self AddOption("F2000 Shotgun", ::GiveWeapons, "fn2000_shotgun_mp");
        self AddOption("F2000 Holographic Sight", ::GiveWeapons, "fn2000_eotech_mp");
        self AddOption("F2000 Heartbeat Sensor", ::GiveWeapons, "fn2000_heartbeat_mp");
        self AddOption("F2000 Thermal", ::GiveWeapons, "fn2000_thermal_mp");
        self AddOption("F2000 Extended Mags", ::GiveWeapons, "fn2000_xmags_mp");
        self.backmenu = "Assault Rifles";
    }

    else if(self.currentsub == "AK47")
    {
        self AddOption("AK47", ::GiveWeapons, "ak47_mp");
        self AddOption("AK47 Grenade Launcher", ::GiveWeapons, "ak47_gl_mp");
        self AddOption("AK47 Red Dot Sight", ::GiveWeapons, "ak47_reflex_mp");
        self AddOption("AK47 Silencer", ::GiveWeapons, "ak47_silencer_mp");
        self AddOption("AK47 ACOG Scope", ::GiveWeapons, "ak47_acog_mp");
        self AddOption("AK47 FMJ", ::GiveWeapons, "ak47_fmj_mp");
        self AddOption("AK47 Shotgun", ::GiveWeapons, "ak47_shotgun_mp");
        self AddOption("AK47 Holographic Sight", ::GiveWeapons, "ak47_eotech_mp");
        self AddOption("AK47 Heartbeat Sensor", ::GiveWeapons, "ak47_heartbeat_mp");
        self AddOption("AK47 Thermal", ::GiveWeapons, "ak47_thermal_mp");
        self AddOption("AK47 Extended Mags", ::GiveWeapons, "ak47_xmags_mp");
        self.backmenu = "Assault Rifles";
    }



    else if(self.currentsub == "Snipers")
    {
        self AddOption("Intervention", ::NewMenu, "Intervention");
        self AddOption("Barrett .50cal", ::NewMenu, "Barrett .50cal");
        self AddOption("WA2000", ::NewMenu, "WA2000");
        self AddOption("M21 EBR", ::NewMenu, "M21 EBR");
        self.backmenu = "Weapons List";
    }

    else if(self.currentsub == "Intervention")
    {
    	self AddOption("Intervention", ::GiveWeapons, "cheytac_mp");
    	self AddOption("Intervention Silencer", ::GiveWeapons, "cheytac_silencer_mp");
    	self AddOption("Intervention ACOG Scope", ::GiveWeapons, "cheytac_acog_mp");
    	self AddOption("Intervention FMJ", ::GiveWeapons, "cheytac_fmj_mp");
    	self AddOption("Intervention Heartbeat Sensor", ::GiveWeapons, "cheytac_heartbeat_mp");
    	self AddOption("Intervention Thermal", ::GiveWeapons, "cheytac_thermal_mp");
    	self AddOption("Intervention Extended Mags", ::GiveWeapons, "cheytac_xmags_mp");
        self.backmenu = "Snipers";
    }

    else if(self.currentsub == "Barrett .50cal")
    {
    	self AddOption("Barrett .50cal", ::GiveWeapons, "barrett_mp");
    	self AddOption("Barrett .50cal Silencer", ::GiveWeapons, "barrett_silencer_mp");
    	self AddOption("Barrett .50cal ACOG Scope", ::GiveWeapons, "barrett_acog_mp");
    	self AddOption("Barrett .50cal FMJ", ::GiveWeapons, "barrett_fmj_mp");
    	self AddOption("Barrett .50cal Heartbeat Sensor", ::GiveWeapons, "barrett_heartbeat_mp");
    	self AddOption("Barrett .50cal Thermal", ::GiveWeapons, "barrett_thermal_mp");
    	self AddOption("Barrett .50cal Extended Mags", ::GiveWeapons, "barrett_xmags_mp");
        self.backmenu = "Snipers";
    }

    else if(self.currentsub == "WA2000")
    {
    	self AddOption("WA2000", ::GiveWeapons, "wa2000_mp");
    	self AddOption("WA2000 Silencer", ::GiveWeapons, "wa2000_silencer_mp");
    	self AddOption("WA2000 ACOG Scope", ::GiveWeapons, "wa2000_acog_mp");
    	self AddOption("WA2000 FMJ", ::GiveWeapons, "wa2000_fmj_mp");
    	self AddOption("WA2000 Heartbeat Sensor", ::GiveWeapons, "wa2000_heartbeat_mp");
    	self AddOption("WA2000 Thermal", ::GiveWeapons, "wa2000_thermal_mp");
    	self AddOption("WA2000 Extended Mags", ::GiveWeapons, "wa2000_xmags_mp");
        self.backmenu = "Snipers";
    }

    else if(self.currentsub == "M21 EBR")
    {
    	self AddOption("M21 EBR", ::GiveWeapons, "m21_mp");
    	self AddOption("M21 EBR Silencer", ::GiveWeapons, "m21_silencer_mp");
    	self AddOption("M21 EBR ACOG Scope", ::GiveWeapons, "m21_acog_mp");
    	self AddOption("M21 EBR FMJ", ::GiveWeapons, "m21_fmj_mp");
    	self AddOption("M21 EBR Heartbeat Sensor", ::GiveWeapons, "m21_heartbeat_mp");
    	self AddOption("M21 EBR Thermal", ::GiveWeapons, "m21_thermal_mp");
    	self AddOption("M21 EBR Extended Mags", ::GiveWeapons, "m21_xmags_mp");
        self.backmenu = "Snipers";
    }


    else if(self.currentsub == "Shotguns")
    {
        self AddOption("SPAS-12", ::NewMenu, "SPAS-12");
        self AddOption("AA-12", ::NewMenu, "AA-12");
        self AddOption("Striker", ::NewMenu, "Striker");
        self AddOption("Ranger", ::NewMenu, "Ranger");
        self AddOption("M1014", ::NewMenu, "M1014");
        self AddOption("Model 1887", ::NewMenu, "Model 1887");
        self.backmenu = "Weapons List";

    }

    else if(self.currentsub == "SPAS-12")
    {
        self AddOption("SPAS-12", ::GiveWeapons, "spas12_mp");
        self AddOption("SPAS-12 Red Dot Sight", ::GiveWeapons, "spas12_reflex_mp");
        self AddOption("SPAS-12 Silencer", ::GiveWeapons, "spas12_silencer_mp");
        self AddOption("SPAS-12 Grip", ::GiveWeapons, "spas12_grip_mp");
        self AddOption("SPAS-12 FMJ", ::GiveWeapons, "spas12_fmj_mp");
        self AddOption("SPAS-12 Holographic Sight", ::GiveWeapons, "spas12_eotech_mp");
        self AddOption("SPAS-12 Extended Mags", ::GiveWeapons, "spas12_xmags_mp");
        self.backmenu = "Shotguns";
    }

    else if(self.currentsub == "AA-12")
    {
        self AddOption("AA-12", ::GiveWeapons, "aa12_mp");
        self AddOption("AA-12 Red Dot Sight", ::GiveWeapons, "aa12_reflex_mp");
        self AddOption("AA-12 Silencer", ::GiveWeapons, "aa12_silencer_mp");
        self AddOption("AA-12 Grip", ::GiveWeapons, "aa12_grip_mp");
        self AddOption("AA-12 FMJ", ::GiveWeapons, "aa12_fmj_mp");
        self AddOption("AA-12 Holographic Sight", ::GiveWeapons, "aa12_eotech_mp");
        self AddOption("AA-12 Extended Mags", ::GiveWeapons, "aa12_xmags_mp");
        self.backmenu = "Shotguns";
    }

    else if(self.currentsub == "Ranger")
    {
        self AddOption("Ranger", ::GiveWeapons, "ranger_mp");
        self AddOption("Ranger Akimbo", ::GiveWeapons, "ranger_akimbo_mp");
        self AddOption("Ranger FMJ", ::GiveWeapons, "ranger_fmj_mp");
        self.backmenu = "Shotguns";
    }

    else if(self.currentsub == "Striker")
    {
        self AddOption("Striker", ::GiveWeapons, "striker_mp");
        self AddOption("Striker Red Dot Sight", ::GiveWeapons, "striker_reflex_mp");
        self AddOption("Striker Silencer", ::GiveWeapons, "striker_silencer_mp");
        self AddOption("Striker Grip", ::GiveWeapons, "striker_grip_mp");
        self AddOption("Striker FMJ", ::GiveWeapons, "striker_fmj_mp");
        self AddOption("Striker Holographic Sight", ::GiveWeapons, "striker_eotech_mp");
        self AddOption("Striker Extended Mags", ::GiveWeapons, "striker_xmags_mp");
        self.backmenu = "Shotguns";
    }

    else if(self.currentsub == "M1014")
    {
        self AddOption("M1014", ::GiveWeapons, "m1014_mp");
        self AddOption("M1014 Red Dot Sight", ::GiveWeapons, "m1014_reflex_mp");
        self AddOption("M1014 Silencer", ::GiveWeapons, "m1014_silencer_mp");
        self AddOption("M1014 Grip", ::GiveWeapons, "m1014_grip_mp");
        self AddOption("M1014 FMJ", ::GiveWeapons, "m1014_fmj_mp");
        self AddOption("M1014 Holographic Sight", ::GiveWeapons, "m1014_eotech_mp");
        self AddOption("M1014 Extended Mags", ::GiveWeapons, "m1014_xmags_mp");
        self.backmenu = "Shotguns";
    }

    else if(self.currentsub == "Model 1887")
    {
        self AddOption("Model 1887", ::GiveWeapons, "model1887_mp");
        self AddOption("Model 1887 Akimbo", ::GiveWeapons, "model1887_akimbo_mp");
        self AddOption("Model 1887 FMJ", ::GiveWeapons, "model1887_fmj_mp");
        self.backmenu = "Shotguns";
    }


    for(i = 1 ; i < 6 ; i++)
    {
        if(self.currentsub == "Slot "+ i)
        {
            self addsame(::set_cycle,i,"OFF");
            self addsame(::set_cycle,i,"painkiller");
            self addsame(::set_cycle,i,"altswap");
            self addsame(::set_cycle,i,"scav");
            self addsame(::set_cycle,i,"hitmarker");
            self addsame(::set_cycle,i,"reflect");
            self addsame(::set_cycle,i,"damage");
            self addsame(::set_cycle,i,"vish");
            self addsame(::set_cycle,i,"illusion");
            self addsame(::set_cycle,i,"zoomload");
            self addsame(::set_cycle,i,"canswap");
            self addsame(::set_cycle,i,"canzoom");
            self addsame(::set_cycle,i,"omashax");
            self addsame(::set_cycle,i,"oma");
            self addsame(::set_cycle,i,"bolt");
            self addsame(::set_cycle,i,"houdini");
            self addsame(::set_cycle,i,"nac");
            self addsame(::set_cycle,i,"carepack");
            self addsame(::set_cycle,i,"pred");
            self addsame(::set_cycle,i,"thirdeye");
            self addsame(::set_cycle,i,"flash");
            self addsame(::set_cycle,i,"laststand");
            self addsame(::set_cycle,i,"finalstand");
            self addsame(::set_cycle,i,"destroytac");
            self addsame(::set_cycle,i,"class1");
            self addsame(::set_cycle,i,"class2");
            self addsame(::set_cycle,i,"class3");
            self addsame(::set_cycle,i,"botemp");
            self addsame(::set_cycle,i,"selfemp");
            self addsame(::set_cycle,i,"forcemala");
            self addsame(::set_cycle,i,"force");
            self addsame(::set_cycle,i,"fragreap");
            self addsame(::set_cycle,i,"instaswap");
            self addsame(::set_cycle,i,"gunlock");
            self addsame(::set_cycle,i,"vel");
            self.backmenu = "Bind Cycle";
        }
    }
}