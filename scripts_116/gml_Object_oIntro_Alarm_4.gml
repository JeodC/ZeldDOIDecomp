State = UnknownEnum.Value_1;
MsgBox(Dialogue[DialogueIndex]);
DialogueActive = true;
DialogueIndex++;
global.DB_Inst.CenterText = true;
global.DB_Inst.ShowBox = false;

enum UnknownEnum
{
    Value_1 = 1
}
