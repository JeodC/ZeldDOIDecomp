global.CatacombGraveHeadings = ["My body below, rests cold and still, and some day too, yours surely will.", "Death is a debt to nature due,\\which I have paid...\\and now must you!", "Weep not for me, for soon I will be back for thee.", "If this stone you stop to read, the corpse below on you will feed.", "As you are, I once was. As I am, you will be.", "^I'm watching you.", "^I see dead people.", "^I know what you did."];

function SignCreate(arg0, arg1, arg2, arg3 = false)
{
    var _SignInst = instance_create_layer(arg0, arg1, "Objs_" + GetFloorLevelString(arg0, arg1), oSign);
    _SignInst.Dialogue = arg2;
    ds_grid_set(_SignInst.DB_Script, 1, 0, _SignInst.Dialogue);
    _SignInst.Hidden = arg3;
    
    if (arg3)
    {
        instance_destroy(_SignInst.WallObj);
        _SignInst.WallObj = -4;
    }
}
