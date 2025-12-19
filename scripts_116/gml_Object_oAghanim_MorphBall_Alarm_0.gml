if (MorphTo)
{
    image_index++;
    
    if (image_index >= image_number)
    {
        image_index = image_number - 1;
        MorphTo = false;
        Move = true;
    }
    else
    {
        alarm[0] = MorphAniDelay;
    }
}
else if (MorphFrom)
{
    image_index--;
    
    if (image_index <= 0)
    {
        image_index = 0;
        MorphFrom = false;
        oBoss_Aghanim.State = UnknownEnum.Value_1;
        instance_destroy(self);
    }
    else
    {
        alarm[0] = MorphAniDelay;
    }
}

enum UnknownEnum
{
    Value_1 = 1
}
