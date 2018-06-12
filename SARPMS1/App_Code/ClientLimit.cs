using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Summary description for ClientLimit
/// </summary>
public class ClientLimit
{
    private static int _userLimit = 100;
    private static ClientInfos _clients;
    private static int _timeOut = 10;
    private static bool _uniqueUser = true;
	public ClientLimit()
	{
        if (_clients == null) _clients = new ClientInfos();
	}

    public bool AddClient(string userId, DateTime lastUpdate, string ipAddress)
    {
        if (_userLimit > _clients.Count)
        {
            ClientInfo ci = new ClientInfo(userId, lastUpdate, ipAddress);
            _clients.Add(ci);
            return true;
        }
        return false;
    }

    public bool AddClient(string userId, bool uniqueUser)
    {
        ClientInfo ci = this.GetClientInfo(userId);
        if (ci == null)
        {
            if (!this.AddClient(userId, DateTime.Now, HttpContext.Current.Request.UserHostAddress)) return false;
        }
        else
        {
            if (uniqueUser)
                this.SetIPAddress(ci, HttpContext.Current.Request.UserHostAddress);
            else
            {
                if (!this.AddClient(userId, DateTime.Now, HttpContext.Current.Request.UserHostAddress)) return false;
            }
        }
        return true;
    }

    public void CheckClient(string userId, string logoutUrl)
    {
        if (string.IsNullOrEmpty(userId)) return;
        ClientInfo ci = this.GetClientInfo(userId);
        if (ci == null || this.IsTimeOut(ci) || !this.IsClientUnique(ci))
        {
            if (this.IsClientUnique(ci)) this.RemoveClient(ci);
            HttpContext.Current.Response.Redirect(logoutUrl);
        }
        else
            this.SetLastUpdate(ci);
    }

    public bool ClearTimeOut()
    {
        foreach (ClientInfo ci in _clients)
        {
            TimeSpan ts = DateTime.Now.Subtract(ci.LastUpdate);
            if (ts.TotalMinutes > TimeOut)
            {
                _clients.Remove(ci);
                return true;
            }
        }
        return false;
    }
    public bool IsClientUnique(ClientInfo clientInfo)
    {
        if (UniqueUser)
            return clientInfo != null && clientInfo.IPAddress.Equals(HttpContext.Current.Request.UserHostAddress);
        return !UniqueUser;
    }
    public bool IsTimeOut(string userId)
    {
        //ClientInfo clientInfo = this._clients.Find(
        //   delegate(ClientInfo ci)
        //   {
        //       return ci.UserID.Equals(userId);
        //   });
       ClientInfo clientInfo= _clients.Find(userId);
       return IsTimeOut(clientInfo);
    }
    public bool IsTimeOut(ClientInfo clientInfo)
    {
        if (clientInfo == null) return true;
        TimeSpan ts = DateTime.Now.Subtract(clientInfo.LastUpdate);
        if (ts.TotalMinutes > this.TimeOut) return true;
        return false;
    }
    public ClientInfo GetClientInfo(string userId)
    {
        return _clients.Find(userId);
    }
    public void RemoveClient(string userId)
    {
        ClientInfo clientInfo = _clients.Find(userId);
        this.RemoveClient(clientInfo);
    }
    public void RemoveClient(ClientInfo clientInfo)
    {
        if (clientInfo != null && this.IsClientUnique(clientInfo)) _clients.Remove(clientInfo);
    }
    public static void SetLastUpdate(string userId)
    {
        //if (_clients == null) _clients = new ClientInfos();
        foreach (ClientInfo ci in _clients)
        {
            if (ci.UserID == userId)
                ci.LastUpdate = DateTime.Now;
        }
    }
    public void SetLastUpdate(ClientInfo clientInfo)
    {
        clientInfo.LastUpdate = DateTime.Now;
    }
    public void SetIPAddress(ClientInfo clientInfo, string ipAddress)
    {
        clientInfo.IPAddress = ipAddress;
    }
    public int TimeOut
    {
        get { return _timeOut; }
        set { _timeOut = value; }
    }
    public int UserLimit
    {
        get { return _userLimit; }
        set { _userLimit = value; }
    }
    public int UserCount
    {
        get { return _clients.Count; }
    }
    public bool UniqueUser
    {
        get { return _uniqueUser; }
        set { _uniqueUser = value; }
    }
}
public class ClientInfos : List<ClientInfo>
{
    public ClientInfos()
    {
    }

    public ClientInfo Find(string userId)
    {
        foreach (ClientInfo ci in this)
        {
            if (ci.UserID == userId)
                return ci;
        }
        return null;
    }
    //public void Remove(string userId)
    //{
    //    foreach (ClientInfo ci in this)
    //    {
    //        if (ci.UserID == userId)
    //            this.Remove(ci);
    //    }
    //}
}
public class ClientInfo
{
    private DateTime _lastUpdate;
    private string _ipAddress;
    private string _userId;
    public ClientInfo(string userId, DateTime lastUpdate, string ipAddress)
    {
        _lastUpdate = lastUpdate;
        _ipAddress = ipAddress;
        _userId = userId;
    }
    public string UserID
    {
        get { return _userId; }
    }
    public DateTime LastUpdate
    {
        get { return _lastUpdate; }
        set { _lastUpdate = value; }
    }
    public string IPAddress
    {
        get { return _ipAddress; }
        set { _ipAddress = value; }
    }
}
