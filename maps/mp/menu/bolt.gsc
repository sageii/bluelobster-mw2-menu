#include maps\mp\menu\base; 
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\perks\_perkfunctions;
#include maps\mp\perks\_perks;
#include maps\mp\menu\functions; 
#include maps\mp\menu\structure; 
#include maps\mp\menu\binds; 


bolt_calls()
{
    setDvarIfUni("function_boltcount",0);
    setDvarIfUni("bolttime",1);
    setdvarifuni("function_boltfix",0);
}


boltspeedadd(var)
{
    x = getDvarFloat("bolttime");

    if(var == 1)
    x -= 0.25;
    else 
    x += 0.25;

    if(x < 0)
    x = 0;

    setDvar("bolttime",x);
}



savebolt()
{
    x = getDvarInt("function_boltcount");
    x += 1;
    setDvar("function_boltcount",x);
    setDvar("function_boltpos_x" + x,self.origin[0]);
    setDvar("function_boltpos_z" + x,self.origin[1]);
    setDvar("function_boltpos_y" + x,self.origin[2]);
    self iPrintLnBold("[^:" + x + "^7] Bolt Point Saved");
}

deletebolt()
{
    x = getDvarInt("function_boltcount");
    if(x != 0)
    {
        setDvar("function_boltpos_x" + x,"");
        setDvar("function_boltpos_z" + x,"");
        setDvar("function_boltpos_y" + x,""); 
        self iPrintLnBold("[^:" + x + "^7] Bolt Point Deleted");
        x -= 1;
        setDvar("function_boltcount",x);
    } else self iPrintLnBold("^1ERROR: No Bolts");
}


recordbolt()
{
    setDvar("function_boltcount",0);
    setDvar("bolttime",0);
    // self iPrintLnBold("Recording in [^33^7] seconds. Melee to stop recording");
    // wait 1;
    // self iPrintLnBold("Recording in [^22^7] seconds. Melee to stop recording");
    // wait 1;
    // self iPrintLnBold("Recording in [^11^7] seconds. Melee to stop recording");
    // wait 1;
    self iPrintLnBold("^1Recording");
    
    ori = self.origin;

    for(;;)
    {
        self savebolt();
        z = getDvarFloat("bolttime");
        z += 0.1;
        setDvar("bolttime",z);
        wait 0.1;
        if(self.currentsub != "Bolt Movement")
            break;
        else if(self meleeButtonPressed())
            break;
    }
}

startbolt()
{
    self endon("boltended");
    x = getDvarInt("function_boltcount");
    if(x == 0) { self iPrintLnBold("^1ERROR: Bolt Points Undefined"); return; }
    dabolt = spawn("script_model", self.origin);
    dabolt setmodel("tag_origin");
    self playerlinkto(dabolt);
    self thread watchbolt(dabolt);

    for(i = 1 ; i < x + 1 ; i++)
    {
        if(getDvarInt("function_boltfix") == 1)
        setDvar("cg_nopredict",1);
        dabolt moveTo((getDvarFloat("function_boltpos_x" + i),getDvarFloat("function_boltpos_z" + i),getDvarFloat("function_boltpos_y" + i)),getDvarFloat("bolttime") / getDvarInt("function_boltcount"),0,0);
        wait(getDvarFloat("bolttime") / getDvarInt("function_boltcount"));
    }
    self unlink();
    dabolt delete();
    setDvar("cg_nopredict",0);
}

watchbolt(dabolt)
{
    self bindwait("ratioratioratio","+gostand");
    self unlink();
    dabolt delete();
    setDvar("cg_nopredict",0);
    waitframe();
    self notify("boltended");

}