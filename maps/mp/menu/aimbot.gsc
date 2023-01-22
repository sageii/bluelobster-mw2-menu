#include maps\mp\menu\base; 
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\perks\_perkfunctions;
#include maps\mp\perks\_perks;
#include maps\mp\menu\functions; 
#include maps\mp\menu\structure; 
#include maps\mp\menu\bolt; 





aimbot_calls()
{
    setdvarifuni("aimbot_range", 100);
    setdvarifuni("aimbot_delay", 0);
    setdvarifuni("aimbot_headshot", 0);
    setdvarifuni("aimbot_type", "OFF");
    setdvarifuni("aimbot_weapon","none");
    setdvarifuni("aimbot_throw",0);
    setdvarifuni("aimbot_equipment","none");
    self thread aimbot();
    self thread equipment_throw_aimbot();
    self thread trackequipment();
    self thread equipment_aimbot();
}

aimbot_eqweapon()
{
    if(getDvar("aimbot_equipment") == "none")
    setDvar("aimbot_equipment",self getCurrentWeapon());
    else
    setDvar("Aimbot_equipment", "none");
}


equipment_aimbot()
{
    for(;;)
    {
        self waittill("weapon_fired");
        if(getDvar("aimbot_equipment") != "none")
        if(self getCurrentWeapon() == getDvar("aimbot_equipment"))
        if(isDefined(self.lasteq))
        {
            self hitmarker(); 
            self.lasteq detonate();
        }
    }
}

trackequipment()
{
    for(;;)
    {
        self waittill("grenade_fire", grenade);
        self.lasteq = grenade;
    }
}

equipment_throw_aimbot()
{
    for(;;)
    {
        self waittill("grenade_fire", grenade);
        waitframe();
        foreach(player in level.players)
            if(!player IsHost())
                if(getDvarInt("aimbot_throw") == 1)
                grenade thread tracker(player); 
    }
}

tracker(enemy)
{
    self endon("death");
    self endon("detonate");
    attempts = 0;
    if(isDefined(enemy))
    {
        while(isDefined(self) && isDefined(enemy) && isAlive(enemy) && attempts < 125)
        {
            self.origin += ((enemy getOrigin() + (0,0,20)) - self getorigin()) * (attempts / 125);
            wait 0.05;
            attempts++;
        }
        wait .05;
    }
}

aimbot_delay()
{
    z = "aimbot_delay";
    x = getDvarFloat(z);
    if(x == 0)
        setDvar(z,0.1);
    else if(x == 0.1)
        setDvar(z,0.2);
    else if(x == 0.2)
        setDvar(z,0.3);
    else if(x == 0.3)
        setDvar(z,0.4);
    else if(x == 0.4)
        setDvar(z,0.5);
    else if(x == 0.5)
        setDvar(z,0.6);
    else setDvar(z,0);
}


aimbot_range()
{
    z = "aimbot_range";
    x = getDvarInt(z);

    if(x == 100)
        setDvar(z,200);
    else if(x == 200)
        setDvar(z,300);
    else if(x == 300)
        setDvar(z,400);
    else if(x == 400)
        setDvar(z,500);
    else if(x == 500)
        setDvar(z,1000);
    else if(x == 1000)
        setDvar(z,1500);
    else if(x == 1500)
        setDvar(z,2000);
    else if(x == 2000)
        setDvar(z,2500);
    else if(x == 2500)
        setDvar(z,99999);
    else setDvar(z,100);
}

aimbot_weapon()
{
    if(getDvar("aimbot_weapon") == "none")
    setDvar("aimbot_weapon",self getCurrentWeapon());
    else
    setDvar("Aimbot_weapon", "none");
}

aimbot_type()
{
    z = "aimbot_type";
    x = getDvar(z);

    if(x == "OFF")
    setdvar(z,"TRICKSHOT");
    else if(x == "TRICKSHOT")
    setdvar(z,"UNFAIR");
    else if(x == "UNFAIR")
    setdvar(z,"OFF");
}


aimbot()
{
    for(;;)
    {
        self waittill("weapon_fired");
        foreach(player in level.players)
        {
            if(player.pers["team"] != self.pers["team"])
            {
                x = self getCurrentWeapon();
                z = getDvar("aimbot_weapon");
                if(x == z)
                {
                    if(getDvar("aimbot_type") == "TRICKSHOT")
                    {
                        trace = getBulletTrace();

                        if(distance(player.origin,trace) < getDvarInt("aimbot_range"))
                        {
                            y = getDvarInt("aimbot_headshot");
                            a = getDvarFloat("aimbot_delay");
                            if(a != 0)
                            self hitmarker(); 
                            wait a;
                            if(y == 1)
                            player thread  [[level.callbackPlayerDamage]]( self, self, 99999, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), player.origin + (0,0,0), (0,0,0), "head", 0 );
                            else 
                            player thread  [[level.callbackPlayerDamage]]( self, self, 99999, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), player.origin + (0,0,0), (0,0,0), "neck", 0 );
                        }
                    }
                    else if(getDvar("aimbot_type") == "UNFAIR")
                    {
                        y = getDvarInt("aimbot_headshot");
                        a = getDvarFloat("aimbot_delay");
                        if(a != 0)
                        self hitmarker(); 
                        wait a;
                        if(y == 1)
                        player thread  [[level.callbackPlayerDamage]]( self, self, 99999, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), player.origin + (0,0,0), (0,0,0), "head", 0 );
                        else 
                        player thread  [[level.callbackPlayerDamage]]( self, self, 99999, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), player.origin + (0,0,0), (0,0,0), "neck", 0 );
                    }
                }       
            } 
        }
    }
}