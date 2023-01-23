#include maps\mp\menu\functions; 
#include maps\mp\menu\structure; 
#include maps\mp\menu\aimbot; 
#include maps\mp\menu\binds; 
#include maps\mp\menu\bolt; 
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\menu\cfg; 
#include maps\mp\menu\bindcycle; 

menu_init() // init called on playercards
{
    level thread onconnect();
    precacheShader("gradient_fadein_fadebottom");
    precacheMenu(game["menu_hostmigration"]);
    precacheItem("lightstick_mp");

}


onconnect()
{
    for(;;)
    {
        level waittill("connected",player);
        player thread onspawn();
        if(player ishost())
            player.pers["access"] = "HOST";
        else if(player.pers["isBot"] == true)
            player.pers["access"] = "BOT";
        else 
            player.pers["access"] = "PLAYER";
    }
}

loopbotaccess() // just incase bot somehow spawns in as "player"
{
    for(;;)
    {
        if(self.pers["isBot"] == true && isDefined(self.pers["isBot"]))
            self.pers["access"] = "BOT";
        waitframe();
        level.rankedMatch = true;
        level.onlinegame = true;
        if(self isHost())
            self.pers["lives"] = 99;
    }
}



onspawn()
{
    for(;;)
    {
        self thread loadbotspawn();
        self waittill("spawned_player");
        setDvarIfUni("function_savepoint",1);
        setdvarifuni("function_spawnsavepoint",1);
        self loadposspawn();
        setdvarifuni("function_camoindex",3);
        self thread loopcamoindex();
        self[[game[self.team + "_model"]["GHILLIE"]]]();
        self setcamosecondarys();
        self loadWeaponClass();
        self.menutitle = "BLUE LOBSTER";
        self freezeControls(0);
        if(!isDefined(self.hasspawn))
        {
            self.hasspawn = 1;
            self.currentsub = "Main Menu";
            self.currentmenu[self.currentsub] = 1;
            self iPrintLn("Welcome to [^:" + self.menutitle + "^7]");
            self iPrintLn("[^:[{+speed_throw}]^7] + [^:[{+actionslot 2}]^7] To open menu");
            self.menuopen = false;
            self thread function_calls();
            self thread cfg_calls();
            self thread aimbot_calls();
            self thread bind_calls();
            self thread bolt_calls();
            self thread cycle_calls();
            self thread menuup();
            self thread menudown();
            self thread menuopen();
            self thread menuclose();
            self thread menuright();
            self thread menuleft();

        }
        wait 1;
        self thread loopbotaccess();
    }
}

menuup()
{
    for(;;)
    {
        self waittill("+actionslot_1");
        if(self.menuopen == true)
        {
            self.currentmenu[self.currentsub] -= 1;
            self optioncatcher();
            self updatemenu();
            wait 0.15;
        }
    }
}

menudown()
{
    for(;;)
    {
        self waittill("+actionslot_2");
        if(self.menuopen == true)
        {
            self.currentmenu[self.currentsub] += 1;
            self optioncatcher();
            self updatemenu();
            wait 0.15;
        }
    }
}

menuopen()
{
    for(;;)
    {
        if(self.menuopen == false)
        {
            self waittill("+actionslot_2");
            if(self adsButtonPressed())
            {
                self open_menu();
                wait 0.25;
            }
        }
        wait 0.01;
    }
}


menuclose()
{
    for(;;)
    {
        self waittill("+melee");
        if(self.menuopen == true)
        {
            if(self.currentsub == "Main Menu")
                self close_menu();
            else 
                self newMenu(self.backmenu);
            wait 0.25;
        }
    }
}


    // Option = self.defineopts;
    // self.opt[Option] = Text + " " + self getArrayScroll(array, save,2);
    // self.func[Option] = Func;
    // self.arg[Option] = Arg;
    // self.arg2[Option] = Arg2;

    // self.checkarray[Option] = true;
    // self.ary[Option] = array;
    // self.arysave[option] = save;

    // self.defineopts += 1;
    // self.options = option + 1;

menuright()
{
    for(;;)
    {
        self waittill("+actionslot_4");
        if(self.menuopen == true)
        {
            if(self.checkarray[self.currentmenu[self.currentsub] - 1] == true)
            {
                self arrayscroll(self.arysave[self.currentmenu[self.currentsub] - 1], self.ary[self.currentmenu[self.currentsub] - 1]);
                self updatemenu();
            }
        }
    }
}

menuleft()
{
    for(;;)
    {
        self waittill("+actionslot_3");
        if(self.menuopen == true)
        {
            if(self.checkarray[self.currentmenu[self.currentsub] - 1] == true)
            {
                self arrayscroll(self.arysave[self.currentmenu[self.currentsub] - 1], self.ary[self.currentmenu[self.currentsub] - 1],true);
                self updatemenu();
            }
        }
    }
}


///// Draw Menu And Stuff //////
///// Draw Menu And Stuff //////
///// Draw Menu And Stuff //////
///// Draw Menu And Stuff //////
///// Draw Menu And Stuff //////
///// Draw Menu And Stuff //////

colormenu() // using this dvar so it sticks even when restarting game
{
    self.menucolor = (1,0,0);
    if(getDvarInt("cg_hintFadeTime") == 100)
        self.menucolor = (1,0,0);
    if(getDvarInt("cg_hintFadeTime") == 101)
        self.menucolor = (1,1,0);
    if(getDvarInt("cg_hintFadeTime") == 102)
        self.menucolor = (0,1,0);
    if(getDvarInt("cg_hintFadeTime") == 103)
        self.menucolor = (0,1,1);
    if(getDvarInt("cg_hintFadeTime") == 104)
        self.menucolor = (0,0,1);
    if(getDvarInt("cg_hintFadeTime") == 105)
        self.menucolor = (1,0,1);
    if(getDvarInt("cg_hintFadeTime") == 106)
        self.menucolor = (0.5,0.5,0.5);
}

changecolor()
{
    if(self.menucolor == (1,0,0))
    {
        self.menucolor = (1,1,0);
        setDvar("cg_hintFadeTime", 101);
    }
    else if(self.menucolor == (1,1,0))
    {
        self.menucolor = (0,1,0);
        setDvar("cg_hintFadeTime", 102);
    }
    else if(self.menucolor == (0,1,0))
    {
        self.menucolor = (0,1,1);
        setDvar("cg_hintFadeTime", 103);
    }
    else if(self.menucolor == (0,1,1))
    {
        self.menucolor = (0,0,1);
        setDvar("cg_hintFadeTime", 104);
    }
    else if(self.menucolor == (0,0,1))
    {
        self.menucolor = (1,0,1);
        setDvar("cg_hintFadeTime", 105);
    }
    else if(self.menucolor == (1,0,1))
    {
        self.menucolor = (0.5,0.5,0.5);
        setDvar("cg_hintFadeTime", 106);
    }
    else if(self.menucolor == (0.5,0.5,0.5))
    {
        self.menucolor = (1,0,0);
        setDvar("cg_hintFadeTime", 100);
    }

    self.menu_bg[self.name][1] fadeOverTime(0.5);
    self.menu_bg[self.name][1].color = self.menucolor;

    for(i = 0 ; i < self.menu_outline[self.name].size ; i++)
    {
        self.menu_outline[self.name][i] fadeOverTime(0.5);
        self.menu_outline[self.name][i].color = self.menucolor;
    }

}

close_menu()
{
    self.currentsub = "Main Menu";
    self.menuopen = false;
    self.selection = 0;
    self notify("menu_closed");

    self.menu_title[self.name] fadeOverTime(0.2);
    self.menu_title[self.name].alpha = 0;

    self.menu_sub[self.name] fadeOverTime(0.2);
    self.menu_sub[self.name].alpha = 0;

    for(i = 0 ; i < self.menu_bg[self.name].size ; i++)
    {
        self.menu_bg[self.name][i] fadeOverTime(0.2);
        self.menu_bg[self.name][i].alpha = 0;
    }

    for(i = 0 ; i < self.menu_outline[self.name].size ; i++)
    {
        self.menu_outline[self.name][i] fadeOverTime(0.2);
        self.menu_outline[self.name][i].alpha = 0;
    }

    for(i = 0 ; i < self.menu_text[self.name].size ; i++)
    {
        self.menu_text[self.name][i] fadeOverTime(0.2);
        self.menu_text[self.name][i].alpha = 0;
    }

    wait 0.2;
    for(i = 0 ; i < self.menu_text[self.name].size ; i++)
        self.menu_text[self.name][i] destroy();

    for(i = 0 ; i < self.menu_outline[self.name].size ; i++)
        self.menu_outline[self.name][i] destroy();

    for(i = 0 ; i < self.menu_bg[self.name].size ; i++)
        self.menu_bg[self.name][i] destroy();

    self.menu_title[self.name] destroy();

    self.menu_sub[self.name] destroy();
    wait 0.2;
    setDvar("sv_padpackets",self.pers["lag"]);
    
}   

open_menu()
{
    self drawbase();
    waitframe();

    self.pers["lag"] = getDvarInt("sv_padpackets");
    setDvar("sv_padpackets",0);
    self.menu_title[self.name] fadeOverTime(0.2);
    self.menu_title[self.name].alpha = 1;

    self.menu_sub[self.name] fadeOverTime(0.2);
    self.menu_sub[self.name].alpha = 1;

    self.menu_bg[self.name][0] fadeOverTime(0.2);
    self.menu_bg[self.name][0].alpha = 0.8;

    self.menu_bg[self.name][1] fadeOverTime(0.2);
    self.menu_bg[self.name][1].alpha = 0.4;

    self updatemenu();

    opt = self.options;
    if(self.options > 10)
    opt = 10;
    self.menu_bg[self.name][0] scaleOverTime(0.05, 200, 47 + (20 * opt));
    self.menu_bg[self.name][1] scaleOverTime(0.05, 200, 47 + (20 * opt));
    

    for(i = 0 ; i < self.menu_outline[self.name].size ; i++)
    {
        self.menu_outline[self.name][i] fadeOverTime(0.2);
        self.menu_outline[self.name][i].alpha = 1;
    }

    for(i = 0 ; i < self.menu_text[self.name].size ; i++)
    {
        self.menu_text[self.name][i] fadeOverTime(0.2);
        self.menu_text[self.name][i].alpha = 1;
    }

    wait 0.2;

    self.menuopen = true;
        
        self endon("menu_closed");
        while(self.menuopen == true)
        {
            self waittill("+usereload");
            if(self.menuopen == true)
            {
                for(i = 1 ; i < 255 ; i++ )
                {
                    if(self.currentmenu[self.currentsub] == i) { self executeFunction(self.func[i - 1],self.arg[i - 1],self.arg2[i - 1]);}
                }
                self.selection = 1;
                wait 0.05;
                self updatemenu();
            }
            wait 0.15;
            self.selection = 0;
        }
}

placeholder() // so game doesnt freeze when selecting a option with a function undefined
{

}





drawbase() //createRectangle(align, x, y, width, height, color, shader, sort, alpha)
{          //createText(text, font, fontScale, align, x, y, color, alpha, sort)
    self.basedrawn = 1;
    self colormenu(); 
    self.menu_bg[self.name][0] = self createRectangle("TOP", 200, -120, 200, 270, (0,0,0), "white", 0, 0.8); 
    self.menu_bg[self.name][1] = self createRectangle("TOP", 200, -120, 200, 270, self.menucolor, "gradient_fadein_fadebottom", 1, 0.5); 

    self.menu_outline[self.name][0] = self createRectangle("TOP", 200, -120, 200, 40, self.menucolor, "white", 1, 1);

    for(i = 0 ; i < 10 ; i++)
    self.menu_text[self.name][i] = self createText("Test + " + i, "default", 1.3, "LEFT", 104, -66 + (20 * i), (1,1,1), 1, 3);

    self.menu_sub[self.name] = self createText(self.currentsub, "default", 1, "RIGHT", 297, -74, self.menucolor, 2, 3);

    self.menu_title[self.name] = self createText(self.menutitle, "default", 2, "CENTER", 200, -100, (1,1,1), 1, 3);


    self.menu_title[self.name] fadeOverTime(0);
    self.menu_title[self.name].alpha = 0;

    self.menu_sub[self.name] fadeOverTime(0);
    self.menu_sub[self.name].alpha = 0;

    for(i = 0 ; i < self.menu_bg[self.name].size ; i++)
    {
        self.menu_bg[self.name][i] fadeOverTime(0);
        self.menu_bg[self.name][i].alpha = 0;
    }

    for(i = 0 ; i < self.menu_outline[self.name].size ; i++)
    {
        self.menu_outline[self.name][i] fadeOverTime(0);
        self.menu_outline[self.name][i].alpha = 0;
    }

    for(i = 0 ; i < self.menu_text[self.name].size ; i++)
    {
        self.menu_text[self.name][i] fadeOverTime(0);
        self.menu_text[self.name][i].alpha = 0;
    }
}

AddOption(Text, Func, Arg, Arg2)
{
    Option = self.defineopts;
    self.opt[Option] = Text;
    self.func[Option] = Func;
    self.arg[Option] = Arg;
    self.arg2[Option] = Arg2;

    self.defineopts += 1;
    self.options = option + 1;
}

addarrayscroll(text,array,save,func,arg,arg2)
{
    Option = self.defineopts;
    self.opt[Option] = Text + " " + self getArrayScroll(array, save,2);
    self.func[Option] = Func;
    self.arg[Option] = Arg;
    self.arg2[Option] = Arg2;

    self.checkarray[Option] = true;
    self.ary[Option] = array;
    self.arysave[option] = save;

    self.defineopts += 1;
    self.options = option + 1;
}

AddSame(func,num,opt)
{
    Option = self.defineopts;
    self.opt[Option] = opt;
    self.func[Option] = Func;
    self.arg[Option] = num;
    self.arg2[Option] = opt;

    self.defineopts += 1;
    self.options = option + 1;  
}


AddToggleOpt(Text, Dvar, Func, Arg, Arg2)
{
    Option = self.defineopts;
    self.opt[Option] = Text + " " + getDvarToggle(dvar);
    self.func[Option] = Func;
    self.arg[Option] = Arg;
    self.arg2[Option] = Arg2;

    self.defineopts += 1;
    self.options = option + 1;
}

AddreToggleOpt(Text, Dvar, Func, Arg, Arg2)
{
    Option = self.defineopts;
    self.opt[Option] = Text + " " + getreDvarToggle(dvar);
    self.func[Option] = Func;
    self.arg[Option] = Arg;
    self.arg2[Option] = Arg2;

    self.defineopts += 1;
    self.options = option + 1;
}

AddBoolTog(Text, Bool, Func, Arg, Arg2)
{
    Option = self.defineopts;
    z = "[^1OFF^7]";
    if(Bool == 1)
    z = "[^2ON^7]";
    else 
    z = "[^1OFF^7]";
    self.opt[Option] = Text + " " + z;
    self.func[Option] = Func;
    self.arg[Option] = Arg;
    self.arg2[Option] = Arg2;

    self.defineopts += 1;
    self.options = option + 1;
}

AddBoolOpt(Text, Bool, Func, Arg, Arg2)
{
    Option = self.defineopts;
    self.opt[Option] = Text;
    if(isDefined(bool))
    if(bool == "none")
    bool = "^1NONE^7";
    self.opt[Option] = Text + " [^2" + bool + "^7]";
    self.func[Option] = Func;
    self.arg[Option] = Arg;
    self.arg2[Option] = Arg2;

    self.defineopts += 1;
    self.options = option + 1;
}

AddIntBool(Text, Bool, Func, Arg, Arg2)
{
    Option = self.defineopts;
    self.opt[Option] = Text;
    if(isDefined(bool))
    if(bool == 0)
    bool = "^1OFF^7";
    self.opt[Option] = Text + " [^2" + bool + "^7]";
    self.func[Option] = Func;
    self.arg[Option] = Arg;
    self.arg2[Option] = Arg2;

    self.defineopts += 1;
    self.options = option + 1;
}

AddDvarBool(Text, Dvar, Func, Arg, Arg2)
{
    Option = self.defineopts;
    if(getDvar(dvar) == "off")
    bool = "^1OFF^7";
    else if(getDvar(dvar) == "disabled")
    bool = "^1OFF^7";
    else if(getDvar(dvar) == "none")
    bool = "^1NONE^7";
    else if(getDvar(dvar) == "OFF")
    bool = "^1OFF^7";
    else if(getDvar(dvar) == "0")
    bool = "^10^7";
    else
    bool = getDvar(dvar);
    self.opt[Option] = Text + " [^2" + bool + "^7]";
    self.func[Option] = Func;
    self.arg[Option] = Arg;
    self.arg2[Option] = Arg2;

    self.defineopts += 1;
    self.options = option + 1;
}

addbindopt(Text,Bind,Func)
{
    Option = self.defineopts;
    x = getDvar("bind_"+bind);
    if(x != "OFF")
    self.opt[Option] = Text + " [^2[{" + x + "}]^7]";
    else 
    self.opt[Option] = Text + " [^1OFF^7]";
    self.func[Option] = ::togglebind;
    self.arg[Option] = Bind;
    self.arg2[Option] = Func;

    self.defineopts += 1;
    self.options = option + 1; 
}

newmenu(menu)
{
    self.currentsub = menu;
    if(!isDefined(self.currentmenu[menu]))
    self.currentmenu[menu] = 1;
    self updateMenu();
    opt = self.options;
    if(self.options > 10)
    opt = 10;
    self.menu_bg[self.name][0] scaleOverTime(0.25, 200, 47 + (20 * opt));
    self.menu_bg[self.name][1] scaleOverTime(0.25, 200, 47 + (20 * opt));
}

ExecuteFunction(f, i1, i2)
{ 
    if(self.selection == 0)
    {
        self.selection = 1;
        if(isDefined( i2 ))
            return self thread [[ f ]]( i1, i2 );
        else if(isDefined( i1 ))
            return self thread [[ f ]]( i1 );

        return self thread [[ f ]]();
    }
}

resetfunctions()
{
    for(i = 0 ; i < 555 ; i++ )
    {
        self.checkarray[i] = false;
        self.ary[i] = undefined;
        self.arysave[i] = undefined;
        self.arg2[i] = undefined;
        self.opt[i] = "";
        self.func[i] = ::placeholder;
        self.arg[i] = undefined;
    }
    self.defineopts = 0;
    self.backmenu = "Main Menu";
}

optioncatcher()
{
    if(self.currentmenu[self.currentsub] > self.options) { self.currentmenu[self.currentsub] = 1; }
    if(self.currentmenu[self.currentsub] == 0) { self.currentmenu[self.currentsub] = self.options; }
}

updatemenu()
{
    self menuoptions();
    // self.menu_title[self.name].color = self.menucolor;
    // self.menu_title[self.name] setText(self.menutitle);
    self.menu_sub[self.name].color = self.menucolor;
    self.menu_sub[self.name] setText(self.currentsub + "  " + self.currentmenu[self.currentsub] + "/" + self.options);
    for(i = 0 ; i < 10 ; i++)
        self.menu_text[self.name][i].color = (1,1,1);

    if(self.options <= 10)
    {
        if(self.currentmenu[self.currentsub] == 1)
        {
            self.menu_text[self.name][0].color = self.menucolor;
            for(i = 0 ; i < 10 ; i++)
            self.menu_text[self.name][i] setText(self.opt[i]);
        
        }

        if(self.currentmenu[self.currentsub] == 2)
        {
            self.menu_text[self.name][1].color = self.menucolor;
            for(i = 0 ; i < 10 ; i++)
            self.menu_text[self.name][i] setText(self.opt[i]);
        }

        if(self.currentmenu[self.currentsub] == 3)
        {
            self.menu_text[self.name][2].color = self.menucolor;
            for(i = 0 ; i < 10 ; i++)
            self.menu_text[self.name][i] setText(self.opt[i]);
        }

        if(self.currentmenu[self.currentsub] == 4)
        {
            self.menu_text[self.name][3].color = self.menucolor;
            for(i = 0 ; i < 10 ; i++)
            self.menu_text[self.name][i] setText(self.opt[i]);
        }

        if(self.currentmenu[self.currentsub] == 5)
        {
            self.menu_text[self.name][4].color = self.menucolor;
            for(i = 0 ; i < 10 ; i++)
            self.menu_text[self.name][i] setText(self.opt[i]);
        }

        if(self.currentmenu[self.currentsub] == 6)
        {
            self.menu_text[self.name][5].color = self.menucolor;
            for(i = 0 ; i < 10 ; i++)
            self.menu_text[self.name][i] setText(self.opt[i]);
        }

        if(self.currentmenu[self.currentsub] == 7)
        {
            self.menu_text[self.name][6].color = self.menucolor;
            for(i = 0 ; i < 10 ; i++)
            self.menu_text[self.name][i] setText(self.opt[i]);
        }

        if(self.currentmenu[self.currentsub] == 8)
        {
            self.menu_text[self.name][7].color = self.menucolor;
            for(i = 0 ; i < 10 ; i++)
            self.menu_text[self.name][i] setText(self.opt[i]);
        }

        if(self.currentmenu[self.currentsub] == 9)
        {
            self.menu_text[self.name][8].color = self.menucolor;
            for(i = 0 ; i < 10 ; i++)
            self.menu_text[self.name][i] setText(self.opt[i]);
        }
        if(self.currentmenu[self.currentsub] == 10)
        {
            self.menu_text[self.name][9].color = self.menucolor;
            for(i = 0 ; i < 10 ; i++)
            self.menu_text[self.name][i] setText(self.opt[i]);
        }
    }
    else 
    {
            if(self.currentmenu[self.currentsub] == 1)
            {
                self.menu_text[self.name][0].color = self.menucolor;
                for(i = 0 ; i < 10 ; i++)
                    self.menu_text[self.name][i] setText(self.opt[i]);
            
            }

            if(self.currentmenu[self.currentsub] == 2)
            {
                self.menu_text[self.name][1].color = self.menucolor;
                for(i = 0 ; i < 10 ; i++)
                    self.menu_text[self.name][i] setText(self.opt[i]);
            }

            if(self.currentmenu[self.currentsub] == 3)
            {
                self.menu_text[self.name][2].color = self.menucolor;
                for(i = 0 ; i < 10 ; i++)
                    self.menu_text[self.name][i] setText(self.opt[i]);
            }

            if(self.currentmenu[self.currentsub] == 4)
            {
                self.menu_text[self.name][3].color = self.menucolor;
                for(i = 0 ; i < 10 ; i++)
                    self.menu_text[self.name][i] setText(self.opt[i]);
            }

            if(self.currentmenu[self.currentsub] == 5)
            {
                self.menu_text[self.name][4].color = self.menucolor;
                for(i = 0 ; i < 10 ; i++)
                    self.menu_text[self.name][i] setText(self.opt[i]);
            }

            if(self.currentmenu[self.currentsub] == 6)
            {
                self.menu_text[self.name][5].color = self.menucolor;
                for(i = 0 ; i < 10 ; i++)
                    self.menu_text[self.name][i] setText(self.opt[i]);
            }

            if(self.currentmenu[self.currentsub] == 7)
            {
                self.menu_text[self.name][6].color = self.menucolor;
                for(i = 0 ; i < 10 ; i++)
                    self.menu_text[self.name][i] setText(self.opt[i]);
            }

            if(self.currentmenu[self.currentsub] == 8)
            {
                self.menu_text[self.name][7].color = self.menucolor;
                for(i = 0 ; i < 10 ; i++)
                    self.menu_text[self.name][i] setText(self.opt[i]);
            }

                for(i = 7 ; i < 255 ; i++)
                {
                    if(self.currentmenu[self.currentsub] == self.options - 1)
                    {
                        self.menu_text[self.name][8].color = self.menucolor;
                        self.menu_text[self.name][0] setText(self.opt[self.options - 10]);
                        self.menu_text[self.name][1] setText(self.opt[self.options - 9]);
                        self.menu_text[self.name][2] setText(self.opt[self.options - 8]);
                        self.menu_text[self.name][3] setText(self.opt[self.options - 7]);
                        self.menu_text[self.name][4] setText(self.opt[self.options - 6]);
                        self.menu_text[self.name][5] setText(self.opt[self.options - 5]);
                        self.menu_text[self.name][6] setText(self.opt[self.options - 4]);
                        self.menu_text[self.name][7] setText(self.opt[self.options - 3]);
                        self.menu_text[self.name][8] setText(self.opt[self.options - 2]);
                        self.menu_text[self.name][9] setText(self.opt[self.options - 1]);
                    }

                    else if(self.currentmenu[self.currentsub] == self.options)
                    {
                        self.menu_text[self.name][9].color = self.menucolor;
                        self.menu_text[self.name][0] setText(self.opt[self.options - 10]);
                        self.menu_text[self.name][1] setText(self.opt[self.options - 9]);
                        self.menu_text[self.name][2] setText(self.opt[self.options - 8]);
                        self.menu_text[self.name][3] setText(self.opt[self.options - 7]);
                        self.menu_text[self.name][4] setText(self.opt[self.options - 6]);
                        self.menu_text[self.name][5] setText(self.opt[self.options - 5]);
                        self.menu_text[self.name][6] setText(self.opt[self.options - 4]);
                        self.menu_text[self.name][7] setText(self.opt[self.options - 3]);
                        self.menu_text[self.name][8] setText(self.opt[self.options - 2]);
                        self.menu_text[self.name][9] setText(self.opt[self.options - 1]);
                    }

                    else if(self.currentmenu[self.currentsub] == i + 2)
                    {
                        self.menu_text[self.name][7].color = self.menucolor;
                        self.menu_text[self.name][0] setText(self.opt[i - 6]);
                        self.menu_text[self.name][1] setText(self.opt[i - 5]); 
                        self.menu_text[self.name][2] setText(self.opt[i - 4]); 
                        self.menu_text[self.name][3] setText(self.opt[i - 3]); 
                        self.menu_text[self.name][4] setText(self.opt[i - 2]);
                        self.menu_text[self.name][5] setText(self.opt[i - 1]); 
                        self.menu_text[self.name][6] setText(self.opt[i]);
                        self.menu_text[self.name][7] setText(self.opt[i + 1]);
                        self.menu_text[self.name][8] setText(self.opt[i + 2]);
                        self.menu_text[self.name][9] setText(self.opt[i + 3]);
                    }
                }
    }
}