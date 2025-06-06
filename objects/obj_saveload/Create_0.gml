
scr_image("loading",-50,0,0,0,0);
GameSave = {};
GameSave.Stars = [];
GameSave.PlayerFleet = [];
GameSave.EnemyFleet = [];
GameSave.Ini = {};
GameSave.Controller = {};
GameSave.EventLog = [];

menu=0;// 1 : save, 2: load
save_part=0;
load_part=0;
save_number=0;
/// set to true before calling alarm[0] to run autosave behaviour
autosaving=false;
/// number of frames between load sections to draw the progress bar
trickle=0;
txt="";
hide=0;
bar=0;
slow=0;
saves=0;
highlighting=0;
spr_screen=0;
first_open=0;
max_ini=0;
reset=0;
splash=choose(0,1,2,3,4);

debug="";

top=0;

if (instance_exists(obj_controller)){
    if (obj_controller.zoomed=1){
        with(obj_controller){scr_zoom();}
    }
}


var i;i=-1;saves=0;
repeat(201){i+=1;
    save[i]=0;save_turn[i]=0;
    save_chapter[i]="";
    save_master[i]="";
    save_marines[i]=0;
    save_date[i]="";
    save_time[i]=0;
    screen_exists[i]=false;
    spr_screen[i]=0;
    save_seed[i]=0;
}
i=0;
repeat(100){i+=1;
    if (file_exists(string(PATH_save_files, i))){
        saves+=1;save[saves]=i;
    }
    if (!file_exists(string(PATH_save_files, i))) and (i>0) and (max_ini=0) then max_ini=i;
    if (file_exists(string(PATH_save_files, i + 1))) and (max_ini>0) then max_ini=0;}
first_open=saves+1;




img1=-1;
img2=-1;
img3=-1;
img4=-1;




if (file_exists("saves.ini")){
    ini_open("saves.ini");

    i=-1;
    repeat(200){i+=1;
        if (save[i]>=0){
            if (ini_section_exists(string(save[i]))){
                save_turn[save[i]]=ini_read_real(string(save[i]),"turn",0);
                save_chapter[save[i]]=ini_read_string(string(save[i]),"chapter_name","Error");
                save_master[save[i]]=ini_read_string(string(save[i]),"master_name","Error");
                save_marines[save[i]]=ini_read_real(string(save[i]),"marines",0);
                save_date[save[i]]=ini_read_string(string(save[i]),"date","Error");
                save_time[save[i]]=ini_read_real(string(save[i]),"time",0);
                save_seed[save[i]]=ini_read_real(string(save[i]),"seed",0);
                
                /*if (file_exists(working_directory + "\screen"+string(save[i])+".png")){
                    screen_exists[i]=true;
                    spr_screen[save[i]]=sprite_add(working_directory + "\screen"+string(save[save[i]])+".png",1,0,0,0,0);
                }*/
            }
            if (!ini_section_exists(string(i))){
                save_turn[i]=-50;
                save_chapter[i]="Unknown Save Data";
                save_master[i]="Unknown";
                save_marines[i]=-50;
                save_date[i]="";
                save_time[i]=0;
            }
        }
    }
    
    
    if (file_exists(string(PATH_save_previews, save[1]))) {
        img1 = sprite_add(string(PATH_save_previews, save[1]), 1, 0, 0, 0, 0);
    }
    if (file_exists(string(PATH_save_previews, save[2]))) {
        img2 = sprite_add(string(PATH_save_previews, save[2]), 1, 0, 0, 0, 0);
    }
    if (file_exists(string(PATH_save_previews, save[3]))) {
        img3 = sprite_add(string(PATH_save_previews, save[3]), 1, 0, 0, 0, 0);
    }
    if (file_exists(string(PATH_save_previews, save[4]))) {
        img4 = sprite_add(string(PATH_save_previews, save[4]), 1, 0, 0, 0, 0);
    }
    
    
    ini_close();
}

/* */
/*  */
