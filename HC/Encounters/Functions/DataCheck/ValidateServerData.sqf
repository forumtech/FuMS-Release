//ValidateServerData.sqf
// Horbin
// 2/22/15
// Inputs ServerData array
// OUTPUTS true or false
private ["_dat","_abort","_msg","_dat2","_sec","_dat3","_start"];
_dat = FuMS_ServerData;
_abort = false;
_msg = "";
_start = time;
while {true} do
{
	if (isNil "FuMS_ServerData") exitWith {_abort=true; _msg = format ["No ServerData passed to Headless Client"];};
    if (TypeName _dat != "ARRAY") exitWith{_abort = true;_msg = format ["Format error in ServerData.sqf found expected 7 sections"];};
	if (count _dat != 7) exitWith{_abort = true;_msg = format ["Format error in ServerData.sqf found %1 expected 7 fields", count _dat];};
    
    _dat2 = _dat select 0; //Map definition
	_sec = "Map Definition:";
    if (TypeName _dat2 != "ARRAY") exitWith {_abort = true;_msg = format ["%1 expected array of 2 entries, found %2",_sec, _dat2];}; 
    if ((count _dat2) != 3) exitWith {_abort = true;_msg = format ["%1 found %2, expected 3 entries",_sec, count _dat2];}; 
    _dat3 = _dat2 select 0; // Map Center
    if (TypeName _dat3 != "ARRAY") exitWith {_abort = true;_msg = format ["%1 Map center should be a 3 element array, found %2",_sec, _dat3];}; 
    if (count _dat3 != 3) exitWith {_abort = true;_msg = format ["%1 Map center should be a 3 element array, found %2",_sec, _dat3];}; 
    _dat3 = _dat2 select 1; // Map range
    if (TypeName _dat3 != "SCALAR") exitWith {_abort = true;_msg = format ["%1 Map Range should be a number, found %2",_sec, _dat3];}; 
    _dat3 = _dat2 select 2; // Admin Control
    if (TypeName _dat3 != "BOOL") exitWith {_abort = true;_msg = format ["%1 Admin Control should be true or false, found %2",_sec, _dat3];}; 
    
    _sec = "Exclusion Areas:";
    _dat2 = _dat select 1; // Exclusion Areas
    if (!isNil "_dat2") then
    {
        if (TypeName _dat2 != "ARRAY")exitWith {_abort = true;_msg = format ["%1  should be 3D location pairs [[x,y,z],[x1,y1,z1]], found %2",_sec, _dat2];}; 
        {
            if (TypeName _x != "ARRAY") exitWith {_abort = true;_msg = format ["%1  should be 3D location pairs [[x,y,z],[x1,y1,z1]], found %2",_sec, _x];}; 
            if (count _x != 2) exitWith {_abort = true;_msg = format ["%1  should be 3D location pairs [[x,y,z],[x1,y1,z1]], found %2",_sec, _x];}; 
            if (count (_x select 0)  != 3 or count (_x select 1) != 3) exitWith {_abort = true;_msg = format ["%1  should be 3D location pairs [[x,y,z],[x1,y1,z1]], found %2",_sec, _x];};         
        }foreach _dat2; // each should be a 3D array pair
    };
    if (_abort) exitWith{};
    
    _sec = "Default Areas:";
    _dat2 = _dat select 2; //Default Areas
    if (!isNil "_dat2") then
    {
          if (TypeName _dat2 != "ARRAY")exitWith {_abort = true;_msg = format ["%1  should be 3D location pairs [[x,y,z],[x1,y1,z1]], found %2",_sec, _dat2];}; 
        {
            if (TypeName _x != "ARRAY") exitWith {_abort = true;_msg = format ["%1  should be a 3D location [x,y,z], found %2",_sec, _x];};         
            if (count _x != 3) exitWith {_abort = true;_msg = format ["%1  should be a 3D location [x,y,z], found %2",_sec, _x];};           
        }foreach _dat2; // each should be a 3D array pair
    };
    if (_abort) exitWith{};
    
    _sec = "Active Themes:";
    _dat2 = _dat select 3; //Active Themes
    if (TypeName _dat2 != "ARRAY")exitWith {_abort = true;_msg = format ["%1  should be array of Theme names, found %2",_sec, _dat2];}; 
    if (count _dat2 == 0) exitWith {_abort = true;_msg = format ["%1  No Themes enabled!",_sec];};         
    {
      if (TypeName _x != "STRING") exitWith {_abort = true;_msg = format ["%1 should be a text string, found %2",_sec, _x];};             
    } foreach _dat2;
    if (_abort) exitWith{};
    
    _sec = "Radio Chatter:";
    _dat2 = _dat select 4; // Radio Chatter
    if (isNil "_dat2") exitWith {_abort = true;_msg = format ["%1  Missing RadioChatter variables. See orignial BaseServer.sqf",_sec];};  
    if (TypeName _dat2 != "ARRAY")exitWith {_abort = true;_msg = format ["%1  should array of settings, found %2",_sec, _dat2];}; 
    if (count _dat2 != 6) exitWith {_abort = true;_msg = format ["%1  Missing RadioChatter variables. Expecting 6, found %2",_sec,_dat2];};      
    if (TypeName (_dat2 select 0) != "BOOL" ) exitWith {_abort = true;_msg = format ["%1 exepecting bool value of true or false, found %2",_sec,_dat2 select 0];};   
    if (TypeName (_dat2 select 1) != "BOOL" ) exitWith {_abort = true;_msg = format ["%1 exepecting bool value of true or false, found %2",_sec,_dat2 select 1];};   
    if (TypeName (_dat2 select 2) != "BOOL" ) exitWith {_abort = true;_msg = format ["%1 exepecting bool value of true or false, found %2",_sec,_dat2 select 2];};   
    if (TypeName (_dat2 select 3) != "BOOL" ) exitWith {_abort = true;_msg = format ["%1 exepecting bool value of true or false, found %2",_sec,_dat2 select 3];};   
    if (TypeName (_dat2 select 4) != "BOOL" ) exitWith {_abort = true;_msg = format ["%1 exepecting bool value of true or false, found %2",_sec,_dat2 select 4];};   
    if (TypeName (_dat2 select 5) != "SCALAR" ) exitWith {_abort = true;_msg = format ["%1 exepecting numeric value, found %2",_sec,_dat2 select 5];};   
    
    _sec = "Soldier Defaults:";
    _dat2 = _dat select 5; // Soldier Defaults
    if (TypeName _dat2 != "ARRAY")exitWith {_abort = true;_msg = format ["%1  should array of settings, found %2",_sec, _dat2];}; 
    if (count _dat2 != 4) exitWith {_abort = true;_msg = format ["%1  Missing variables. Expecting 4, found %2",_sec,_dat2];};      
    if (TypeName (_dat2 select 0) != "SCALAR" ) exitWith {_abort = true;_msg = format ["%1 exepecting numeric value, found %2",_sec,_dat2 select 0];};   
    if (TypeName (_dat2 select 1) != "SCALAR" ) exitWith {_abort = true;_msg = format ["%1 exepecting numeric value, found %2",_sec,_dat2 select 1];};   
    if (TypeName (_dat2 select 2) != "BOOL" ) exitWith {_abort = true;_msg = format ["%1 exepecting bool value of true or false, found %2",_sec,_dat2 select 2];};   
    if (TypeName (_dat2 select 3) != "ARRAY" ) exitWith {_abort = true;_msg = format ["%1 exepecting array of 8 values, found %2",_sec,_dat2 select 3];};    
    if (count (_dat2 select 3) != 8 ) exitWith {_abort = true;_msg = format ["%1 exepecting array of 8 values, found %2",_sec,_dat2 select 3];};    
    {
        if (TypeName (_x) != "SCALAR" ) exitWith {_abort = true;_msg = format ["%1 exepecting numeric value in skills array, found %2",_sec,_x];};      
    }foreach (_dat2 select 3);
    if (_abort) exitWith {};
    
    _sec = "Loot Defaults:";
    _dat2 = _dat select 6; // Loot Defautls
    if (TypeName _dat2 != "ARRAY")exitWith {_abort = true;_msg = format ["%1  should array of settings, found %2",_sec, _dat2];}; 
    if (count _dat2 !=5) exitWith {_abort = true;_msg = format ["%1  Missing variables. Expecting 5, found %2",_sec,_dat2];};      
    if (TypeName (_dat2 select 0) != "SCALAR" ) exitWith {_abort = true;_msg = format ["%1 exepecting numeric value, found %2",_sec,_dat2 select 0];};   
    if (TypeName (_dat2 select 1) != "BOOL" ) exitWith {_abort = true;_msg = format ["%1 exepecting bool value of true or false, found %2",_sec,_dat2 select 1];};   
    if (TypeName (_dat2 select 2) != "BOOL" ) exitWith {_abort = true;_msg = format ["%1 exepecting bool value of true or false, found %2",_sec,_dat2 select 2];};   
    if (TypeName (_dat2 select 3) != "ARRAY" ) exitWith {_abort = true;_msg = format ["%1 exepecting array of text values, found %2",_sec,_dat2 select 3];}; 
    {
        if (TypeName _x != "STRING") exitWith {_abort = true;_msg = format ["%1 container types should be text strings, found %2",_sec,_x];};    
    }foreach (_dat2 select 3);
    if (_abort) exitWith {};  
    if (TypeName (_dat2 select 4) != "ARRAY" ) exitWith {_abort = true;_msg = format ["%1 exepecting array of text values found %2",_sec,_dat2 select 3];}; 
    {
        if (TypeName _x != "STRING") exitWith {_abort = true;_msg = format ["%1 vehicle types should be text strings, found %2",_sec,_x];};    
    }foreach (_dat2 select 3);
    if (_abort) exitWith {};  
    if (true) exitWith{};
};
if (_abort) then
{
    diag_log format ["-------------------------------------------------------------------------------------"];
    diag_log format ["----------------            Fulcrum Mission System                    -----------------"];
    diag_log format ["-------------------------------------------------------------------------------------"];
    diag_log format ["##FuMsnInit: ERROR in FuMS_ServerData"];
    diag_log format ["Recommend verifying data in file BaseServerData.sqf on your server!"];            
    diag_log format ["                          Fulcrum Mission System offline!"];
    diag_log format ["REASON: %1",_msg];
    diag_log format ["-------------------------------------------------------------------------------------"];
    diag_log format ["-------------------------------------------------------------------------------------"];      
    FuMS_DataValidation = "\FuMS\Themes\BaseServerData.sqf";
    publicVariableServer "FuMS_DataValidation";
}else { diag_log format ["------ Server Data validation complete %1 secs-----", time - _start];};
_abort
