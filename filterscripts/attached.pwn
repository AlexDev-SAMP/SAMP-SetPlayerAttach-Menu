/*
	�����ѹʤ�Ի��: v1
	FilterScript ������ҧ�� Dennis12
	�������� Alex
*/

#define FILTERSCRIPT

// INC
#include <a_samp>
#include <Pawn.CMD>

#if defined FILTERSCRIPT

enum D12_ATTACHED_OBJECT {
	objectID,
	objectSlot,
	objectBone,
	Float: objectPos[3],
	Float: objectRot[3],
	Float: objectScale[3]
};
new D12_AO[MAX_PLAYERS][MAX_PLAYER_ATTACHED_OBJECTS][D12_ATTACHED_OBJECT];

enum { D_EDITOBJECT, D_CLEARSLOT, D_EDITSLOT };

public OnFilterScriptInit()
{
	print("ʤ�Ի���ǡ�ͧ������ҧ�� Dennis12( D12 ). new Edit byAlex");
	print("�ҡ��ͧ��ä������������ ��������� [/help] ���");
	return 1;
}

public OnFilterScriptExit()
{
	print("�ͺ�س����� 'D12 ATTACHMENTS OBJECT EDITOR'!"); 
	return 1;
}
public OnPlayerSpawn(playerid) {
	SendClientMessage(playerid,0xFF0000FF,"[D12 ��觷��Ṻ�Һ�óҸԡ���ѵ��]");
	SendClientMessage(playerid,0xFF0000FF,"ʤ�Ի���ǡ�ͧ������ҧ�� Dennis12.");
	return 1; 
}

// Commmands
CMD:attach(playerid)
{
	new szStr[256];
	format(szStr, 256, "Slot 0[objectid: %d]\nSlot 1[objectid: %d]\nSlot 2[objectid: %d]\nSlot 3[objectid: %d]\nSlot 4[objectid: %d]\nSlot 5[objectid: %d]\nSlot 6[objectid: %d]\nSlot 7[objectid: %d]\nSlot 8[objectid: %d]\nSlot 9[objectid: %d]",
	D12_AO[playerid][0][objectID], D12_AO[playerid][1][objectID],D12_AO[playerid][2][objectID],D12_AO[playerid][3][objectID],D12_AO[playerid][4][objectID],D12_AO[playerid][5][objectID],D12_AO[playerid][6][objectID],D12_AO[playerid][7][objectID],D12_AO[playerid][8][objectID],D12_AO[playerid][9][objectID]);
	ShowPlayerDialog(playerid, D_EDITSLOT, DIALOG_STYLE_LIST, "[ ���ҧ Slot ] Attach Object:",szStr,"���","¡��ԡ");
	return true;
}

CMD:saveattach(playerid, params[])
{
	new 
		File: attach,
	    writeAttach[ 512 ],
		writeObjects;  
	    
	if(!fexist("attach.pwn")) {
		attach = fopen("attach.pwn", io_write);
		fclose(attach);
	} attach = fopen("attach.pwn", io_append);
	
	if(isnull(params)) return SendClientMessage(playerid,0xFF0000FF,"�س��ͧ��¹�����ç������ͺѹ�֡�ç��âͧ�س"), SendClientMessage(playerid,0xFFFF00AA,"/saveattach <project name>");  
	
	for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
		if(D12_AO[playerid][i][objectID] != 0) {
			format(writeAttach, 512, "\nDENNIS12 ATTACHED OBJECT CREATOR\n\n//Slot %d | Project Name: %s\nSetPlayerAttachedObject(playerid, %d, %d, %d, %f, %f, %f, %f, %f, %f, %f, %f, %f);\r\n",
			      D12_AO[playerid][i][objectSlot], params, D12_AO[playerid][i][objectSlot], D12_AO[playerid][i][objectID],D12_AO[playerid][i][objectBone],D12_AO[playerid][i][objectPos][0],D12_AO[playerid][i][objectPos][1],D12_AO[playerid][i][objectPos][2],D12_AO[playerid][i][objectRot][0],D12_AO[playerid][i][objectRot][1],D12_AO[playerid][i][objectRot][2],
			      D12_AO[playerid][i][objectScale][0],D12_AO[playerid][i][objectScale][1],D12_AO[playerid][i][objectScale][2]);
			
			fwrite(attach, writeAttach); 
			writeObjects ++; 
		}
	}
	if(!writeObjects) return SendClientMessage(playerid,0xFF0000FF,"��������÷��س����ö���͡��");
	
	fclose(attach);
	SendClientMessage(playerid, -1, writeAttach),SendClientMessage(playerid, 0xFFFF00AA, "[Attached Object Editor]"),SendClientMessage(playerid, 0xFFFF00AA, "�ͺ�硵���Ṻ�Ҷ١�ѹ�֡������� attach.pwn"),SendClientMessage(playerid, 0xFFFF00AA, "��� 'Ṻ' ����ö����� scriptfiles -> Attach.pwn"); 
	return true;
}

CMD:clearattach(playerid)
{
	new szStr[ 256 ]; 
	format(szStr,256,"Clear Slots\nSlot 0[objectid: %d]\nSlot 1[objectid: %d]\nSlot 2[objectid: %d]\nSlot 3[objectid: %d]\nSlot 4[objectid: %d]\nSlot 5[objectid: %d]\nSlot 6[objectid: %d]\nSlot 7[objectid: %d]\nSlot 8[objectid: %d]\nSlot 9[objectid: %d]",
	D12_AO[playerid][0][objectID], D12_AO[playerid][1][objectID],D12_AO[playerid][2][objectID],D12_AO[playerid][3][objectID],D12_AO[playerid][4][objectID],D12_AO[playerid][5][objectID],D12_AO[playerid][6][objectID],D12_AO[playerid][7][objectID],D12_AO[playerid][8][objectID],D12_AO[playerid][9][objectID]);
	ShowPlayerDialog(playerid, D_CLEARSLOT, DIALOG_STYLE_LIST, "[���ҧ] Clear Slots:",szStr,"ź","¡��ԡ");
	return true; 
}

CMD:editattach(playerid)
{
	new szStr[ 256 ]; 
	format(szStr,256,"Slot 0[objectid: %d]\nSlot 1[objectid: %d]\nSlot 2[objectid: %d]\nSlot 3[objectid: %d]\nSlot 4[objectid: %d]\nSlot 5[objectid: %d]\nSlot 6[objectid: %d]\nSlot 7[objectid: %d]\nSlot 8[objectid: %d]\nSlot 9[objectid: %d]",
	D12_AO[playerid][0][objectID], D12_AO[playerid][1][objectID],D12_AO[playerid][2][objectID],D12_AO[playerid][3][objectID],D12_AO[playerid][4][objectID],D12_AO[playerid][5][objectID],D12_AO[playerid][6][objectID],D12_AO[playerid][7][objectID],D12_AO[playerid][8][objectID],D12_AO[playerid][9][objectID]);
	ShowPlayerDialog(playerid, D_EDITOBJECT, DIALOG_STYLE_LIST, "[���ҧ] Edit Slots:",szStr,"���","¡��ԡ");
	return true;
}

CMD:action(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	
	return 1; 
}

CMD:clearfile(playerid)
{
	new File: attach; 	
	
	if(fexist("attach.pwn")) {
		attach = fopen("attach.pwn", io_write); 
		fwrite(attach,""); 
		fclose(attach); 
		SendClientMessage(playerid,0xFFFF00AA,"���Ṻ.pwn �١��ҧ"); 
	} else SendClientMessage(playerid, 0xFF0000FF, "��辺��� attach.pwn ������� scriptfiles");
	return true; 
}

CMD:help(playerid)
{
	new dialog[373];
	dialog[0] = EOS; 
	strcat(dialog,"{FFFFFF}Attachments Object Editor\n\n"); 
	strcat(dialog,"{FFFFFF}/attach      -> ���͵Դ�ѵ����ҡѺ��ͧ㴪�ͧ˹�觨ҡ 9 ��ͧ\n");
	strcat(dialog,"{FFFFFF}/editattach  -> ��������ѵ�ط��Ṻ��\n");
	strcat(dialog,"{FFFFFF}/clearattach -> ����ź�ѵ���˹��� 9 ��ͧ\n"); 
	strcat(dialog,"{FFFFFF}/saveattach  -> ���ͺѹ�֡�����׺˹�Ңͧ�سŧ� [scriptfiles/attach.pwn]\n");
	strcat(dialog,"{FFFFFF}/clearfile   -> ���ź�����Ңͧ���Ṻ.pwn"); 
	ShowPlayerDialog(playerid, 69, DIALOG_STYLE_MSGBOX,"Attachments Editor Help",dialog,"��ŧ",""); 
	return true;
}

public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[]) {
	switch(dialogid) {
		case D_EDITOBJECT: {
			if(!response) return true;
			switch(listitem) {
				case 0 .. 9: {
					if(D12_AO[playerid][listitem][objectID] == 0) return SendClientMessage(playerid,0xFF0000FF,"�س������ѵ�صԴ����Ѻ��ͧ���"); 
					EditAttachedObject(playerid, listitem); 
					new string[ 64 ]; 
					format(string, sizeof(string), "�س���ѧ����ѵ�ط��Ṻ��㹪�ͧ %d.", listitem);
					SendClientMessage(playerid,0xFFFF00AA,string); 
				}
			}
		}
		case D_CLEARSLOT: {
			if(!response) return true;
			switch(listitem) {
				case 0: {
					for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) { 
						if(D12_AO[playerid][i][objectID] != 0) RemovePlayerAttachedObject(playerid, i); 
						D12_AO[playerid][i][objectID] = 0; 
					}
					SendClientMessage(playerid,0xFFFF00AA,"���Ṻ�������١ź����");
				}
				case 1 .. 10: {
					if(D12_AO[playerid][listitem-1][objectID] == 0) return SendClientMessage(playerid,0xFF0000FF,"�س������ѵ�صԴ����Ѻ��ͧ���"); 
					D12_AO[playerid][listitem-1][objectID] = 0; 
					
					if(IsPlayerAttachedObjectSlotUsed(playerid, listitem-1)) 
						RemovePlayerAttachedObject(playerid, listitem-1); 
						
					new string[64]; 
					format(string, sizeof(string), "�سź�ѵ�ط��Ṻ��� slot %d.",listitem-1); 
					SendClientMessage(playerid,0xFF0000FF,string); 
				}
			}
		}
		case D_EDITSLOT: {
			if(!response) return true;
			switch(listitem) {
				case 0 .. 9: {
					if(D12_AO[playerid][listitem][objectID] != 0) return SendClientMessage(playerid,-1,"�س���ѵ�ط��Ṻ�ҡѺ��ͧ����������� �� [/clearattach]."); 
					new szTitle[20], szString[64];
					SetPVarInt(playerid,"selectedSlot", listitem);
					format(szTitle, sizeof(szTitle),"Editing Slot: %d", GetPVarInt(playerid,"selectedSlot"));
					format(szString,sizeof(szString),"Type the object ID you want to attach for slot %d", GetPVarInt(playerid,"selectedSlot"));
					ShowPlayerDialog(playerid,D_EDITSLOT+1,DIALOG_STYLE_INPUT,szTitle,szString,"��ŧ","¡��ԡ");
					SetPVarInt(playerid,"editSlotStep",0);
				}
			}
		}
		case D_EDITSLOT+1: {
			if(!response) return DeletePVar(playerid,"objectID"), DeletePVar(playerid,"objectBone");
			switch(GetPVarInt(playerid,"editSlotStep")) {
				case 0: {
					if(isnull(inputtext) || strval(inputtext) < 0) return SendClientMessage(playerid,0xFF0000FF,"objectid ���١��ͧ"); 
					SetPVarInt(playerid,"objectID", strval(inputtext));
					SetPVarInt(playerid,"editSlotStep", 1);
					ShowPlayerDialog(playerid,D_EDITSLOT+1,DIALOG_STYLE_LIST,"[���͡��ǹ�ͧ��ҧ���] Select Bone","��д١�ѹ��ѧ\n�����\nᢹ��͹������\n��ᢹ���\n��ͫ���\n��͢��\n�鹢ҫ���\n�鹢Ң��\n��ҫ���\n��Ң��\n��ͧ���\n��ͧ����\n����ᢹ����\n����ᢹ���\n��д١�˻����ҫ��� (����)\n��д١�˻����Ң�� (����)\n��\n����","Select","�Դ");
				}
				case 1: {
					switch(listitem) {
						case 0 .. 17: {
							SetPVarInt(playerid, "objectBone", listitem+1);
							SetPVarInt(playerid, "editSlotStep", 2);
							ShowPlayerDialog(playerid,D_EDITSLOT+1,DIALOG_STYLE_MSGBOX,"Save Settings","�س��ͧ������ҧ�ѵ�ص����õ�駤�Ңͧ�س�������","��","�����");
						}
					}
				}
				case 2: {
				    new slot = GetPVarInt(playerid,"selectedSlot");
                    D12_AO[playerid][slot][objectID] 	 = GetPVarInt(playerid,"objectID");
					D12_AO[playerid][slot][objectSlot]   = GetPVarInt(playerid,"selectedSlot");
					D12_AO[playerid][slot][objectBone]   = GetPVarInt(playerid,"objectBone");
					D12_AO[playerid][slot][objectPos][0] = 0.0;
					D12_AO[playerid][slot][objectPos][1] = 0.0;
					D12_AO[playerid][slot][objectPos][2] = 0.0;
					D12_AO[playerid][slot][objectRot][0] = 0.0;
					D12_AO[playerid][slot][objectRot][1] = 0.0;
					D12_AO[playerid][slot][objectRot][2] = 0.0;
					D12_AO[playerid][slot][objectScale][0] = 1.0;
					D12_AO[playerid][slot][objectScale][1] = 1.0;
					D12_AO[playerid][slot][objectScale][2] = 1.0;
					
					SetPlayerAttachedObject(playerid,D12_AO[playerid][slot][objectSlot],D12_AO[playerid][slot][objectID],D12_AO[playerid][slot][objectBone],D12_AO[playerid][slot][objectPos][0],D12_AO[playerid][slot][objectPos][1],D12_AO[playerid][slot][objectPos][2],D12_AO[playerid][slot][objectRot][0],D12_AO[playerid][slot][objectRot][1],D12_AO[playerid][slot][objectRot][2],D12_AO[playerid][slot][objectScale][0],D12_AO[playerid][slot][objectScale][1],D12_AO[playerid][slot][objectScale][2]);
					EditAttachedObject(playerid, D12_AO[playerid][slot][objectSlot]);
				}
			}
		}
	}
	return true;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	switch(response) {
		case 0: {
			D12_AO[playerid][index][objectID]   = 0; 
			D12_AO[playerid][index][objectBone] = 0; 
			D12_AO[playerid][index][objectSlot] = 0;
			
			if(IsPlayerAttachedObjectSlotUsed(playerid, index)) RemovePlayerAttachedObject(playerid, index);

			SendClientMessage(playerid,0xFFFF00AA,"Object not saved."); 
		}
		case 1: {
			D12_AO[playerid][index][objectPos][0]   = fOffsetX;
			D12_AO[playerid][index][objectPos][1]   = fOffsetY;
			D12_AO[playerid][index][objectPos][2]   = fOffsetZ;
            D12_AO[playerid][index][objectRot][0]   = fRotX;
            D12_AO[playerid][index][objectRot][1]   = fRotY;
            D12_AO[playerid][index][objectRot][2]   = fRotZ;
            D12_AO[playerid][index][objectScale][0] = fScaleX;
            D12_AO[playerid][index][objectScale][1] = fScaleY;
            D12_AO[playerid][index][objectScale][2] = fScaleZ;

			if(IsPlayerAttachedObjectSlotUsed(playerid, index)) RemovePlayerAttachedObject(playerid, index);
			   
            SetPlayerAttachedObject(playerid,D12_AO[playerid][index][objectSlot],D12_AO[playerid][index][objectID],D12_AO[playerid][index][objectBone],D12_AO[playerid][index][objectPos][0],D12_AO[playerid][index][objectPos][1],D12_AO[playerid][index][objectPos][2],D12_AO[playerid][index][objectRot][0],D12_AO[playerid][index][objectRot][1],D12_AO[playerid][index][objectRot][2],D12_AO[playerid][index][objectScale][0],D12_AO[playerid][index][objectScale][1],D12_AO[playerid][index][objectScale][2]);
		
			SendClientMessage(playerid,0xFFFF00AA,"Object saved."); 
		}
	}
	return true;
}
#endif
