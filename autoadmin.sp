#include <sourcemod>
#include <multicolors>
#include <cstrike>
#include <gadmin>

#pragma newdecls required

int     ratio = 3 // 1:3

public Plugin myinfo = 
{
    name = "JB - Auto Admin",
    author = "ONIONZZZ",
    description = "Domination Servers Jailbreak",
    version = "0.0.1",
    url = "https://dominationservers.com"
};

public void OnPluginStart()
{
    HookEvent("player_team",    OnPlayerTeam);
}

public Action OnPlayerTeam(Handle event, const char[] name, bool dontBroadcast)
{
    int client  = GetClientOfUserId(GetEventInt(event, "userid"));
    int team    = GetEventInt(event, "team");
    

    if (!IsValidClient(client)) {
        return Plugin_Handled;
    }
    
    if (team != CS_TEAM_CT) {
        return Plugin_Handled;
    }
    
    int cts = countCts();
    int ts  = countTs();
    
    if (ts < 6) {
        return Plugin_Handled;
    }
    
    if (cts > ts / ratio && cts > ts / ratio + 1) {
        CPrintToChat(client, "{darkred}[{default}DS{darkred}] [default}Your team has been automatically swapped because there are currently too many {blue}CTs{default}. Ratio is 1{blue}CT {default}to 3{red}T{default}.");
        CS_SwitchTeam(client, CS_TEAM_T);
    }
    
    return Plugin_Continue;
}

public int countCts()
{
    int cts;
    
    for (int i = 1; i <= MaxClients; i++) {
        if (IsValidClient(i) && GetClientTeam(i) == CS_TEAM_CT) {
            cts++;
        }
    }
    
    return cts;
}

public int countTs()
{
    int ts;
    
    for (int i = 1; i <= MaxClients; i++) {
        if (IsValidClient(i) && GetClientTeam(i) == CS_TEAM_CT) {
            ts++;
        }
    }
    
    return ts;
}
