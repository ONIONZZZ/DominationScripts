#include <sourcemod>
#include <timers>

#pragma newdecls required

/**
 * Don't actually know if this plugin even works
 * This is to stop the maps restarting when 
 * the map is meant to change.
 */

public Plugin myinfo = 
{
    name = "JB - Map Enforcer",
    author = "ONIONZZZ",
    description = "Enforces next map",
    version = "1.2.0",
    url = "https://dominationservers.com"
};

public void OnPluginStart()
{
    HookEvent("round_end", Event_RoundEnd);
}

public Action Event_RoundEnd(Handle event, const char[] name, bool dontBroadcast)
{
    int timeleft;
    
    if (GetMapTimeLeft(timeleft)) {
        if (timeleft < 1) {
            CreateTimer(4.5, enforceMap, _, TIMER_FLAG_NO_MAPCHANGE);
        }
    }
    
    return Plugin_Continue;
}

public Action enforceMap(Handle timer)
{
    char nextMap[PLATFORM_MAX_PATH];
    GetNextMap(nextMap, sizeof(nextMap));
            
    ServerCommand("changelevel %s", nextMap);
}
