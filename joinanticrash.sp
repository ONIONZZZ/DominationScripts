// Only issue with this is, I assume, they could have their client index overwritten if someone joins at the same time,
// so you might have to push their steamid rather than client index.
// This, funnily enough, works well, but ^

// THIS WAS MADE / USED FOR THE MINIGAMES SERVER

#pragma newdecls required;

int clientConnected[MAXPLAYERS+1];

public Plugin myinfo = {
    name = "Join Anti-Crash",
    author = "ONIONZZZ",
    description = "Stops clients from crashing on join",
    version = "1.0.0",
    url = "https://dominationservers.com"
};

public bool OnClientConnect(int client, char[] rejectmsg, int maxlen)
{
    clientConnected[client] = clientConnected[client] + 1;

    if (clientConnected[client] > 1) {
        return true;
    }

    ClientCommand(client, "retry");

    return true;
}

public void OnClientDisconnect(int client)
{
    if (clientConnected[client] > 1) {
        clientConnected[client] = 0;
    }
}
