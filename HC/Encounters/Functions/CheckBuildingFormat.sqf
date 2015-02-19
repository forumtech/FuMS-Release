//CheckBuildingFormat.sqf
// Horbin
// 2/18/15
// Inputs: Building mission data element
// "name", [location], rotation, keep
// Output: true if datatypes are correct

private ["_data","_valid","_type","_offset","_rotation","_keep"];
_data = _this select 0;    
_valid = false;
_type = _data select 0;
_offset = _data select 1;
_rotation = _data select 2;
_keep = _data select 3;
if (count _data == 4) then
{
    if (TypeName _type == "STRING" and TypeName _offset == "ARRAY" and TypeName _rotation == "SCALAR" and TypeName _keep == "SCALAR") then
    {
        _valid = true;
    };
};
_valid
