using System;
using System.Configuration;
using System.Web;
using System.Web.Configuration;
using System.Globalization;
using System.Data;
using System.Collections;

public class Program
{
    private static Setting _settings;
    public static Setting Settings { get { if (_settings == null) _settings = new Setting(); return _settings; } set { _settings = value; } }

    public static string ProductID { get { return "27"; } }
    public static string Version { get { return "1.0"; } }//normal
    public static string Date { get { return new DateTime(2011, 12, 22).ToShortDateString(); } }
}
public class Setting
{
    private Hashtable _items;
    public Setting()
    {
        this._items = new Hashtable();
    }
    private bool ValidateLicense()
    {
        try
        {
            if (Star.Product.ProductKey.ProductID == null)
                Star.Product.ProductKey.ProductID = Program.ProductID;

            Star.Web.LicenseControl.LicenseHandler license = new Star.Web.LicenseControl.LicenseHandler();
            license.ProcessRequest(HttpContext.Current);

            return true;
        }
        catch
        {
            return false;
        }
    }
    public bool IsValid
    {
        get
        {
            string isValid = (string)this._items["IsValid"];
            if (String.IsNullOrEmpty(isValid))
            {
                isValid = ValidateLicense().ToString();
                this._items.Add("IsValid", isValid);
            }
            return Convert.ToBoolean(isValid);
        }
    }
}
public sealed class Configurations
{
    private static ApplicationSettings _application;
    private static ClientSettings _client;

    public Configurations()
    {
    }
    public static void Initialize()
    {
        _application = new ApplicationSettings();
        _client = new ClientSettings();

    }
    public void Reload()
    {
        _application = new ApplicationSettings();
       _client = new ClientSettings();
    }
    public static ApplicationSettings Application { get { if (_application == null) _application = new ApplicationSettings(); return _application; } }
    public static ClientSettings Client { get { if (_client == null) _client = new ClientSettings(); return _client; } }
}
public sealed class ApplicationSettings
{
    public const string CACHE_KEY = "cfg";
    private string _singleSignOnURL;
    private DataRow settings;
    public ApplicationSettings():base()
    {
        LoadSettings();
    }
    private void LoadSettings()
    {
        Connection Conn = new Connection();
        DataView dv = Conn.Select("*", "CONFIGURATIONS", "");
        if (dv.Count > 0)
        {
            settings = dv.Table.Rows[0];
        }
    }
    public void Reload()
    {
        this.LoadSettings();
    }
    
   
   
    public string StylesFolder
    {
        get
        {
            return ValidatePath((string)settings["StylesDir"]);
        }
    }
    public string RegisterYear
    {
        get { return ConfigurationManager.AppSettings["YearRegister"]; }
    }
    public string PersonalizeManagerServiceURL
    {
        get
        {
            return String.Format(ConfigurationManager.AppSettings["PersonalizeServiceURL"], "ScriptManager");
        }
    }
    public string PersonalizeControlServiceURL
    {
        get
        {
            return String.Format(ConfigurationManager.AppSettings["PersonalizeServiceURL"], "Gadget");
        }
    }


    public string SingleSignOnURL
    {
        get
        {
            if (String.IsNullOrEmpty(_singleSignOnURL))
            {
                HttpHandlersSection section = (HttpHandlersSection)ConfigurationManager.GetSection("system.web/httpHandlers");
                if (section == null) return "";
                string url = "";

                if (section.Handlers.Count > 0)
                {
                    for (int i = 0; i < section.Handlers.Count; i++)
                    {
                        if (section.Handlers[i].Type.ToLower() == "singlesignon")
                        {
                            url = section.Handlers[i].Path;
                            break;
                        }

                    }
                    if (!String.IsNullOrEmpty(url))
                    {
                        if (!url.StartsWith("~/")) url = "~/" + url;
                    }
                }
                _singleSignOnURL = url;
            }
            _singleSignOnURL = _singleSignOnURL.Replace("*", Guid.NewGuid().ToString());
            return _singleSignOnURL;
        }
    }
    public string OfflineURL { get { return ""; } }
    public bool Online
    {
        get
        {
            return Convert.ToBoolean(settings["Online"]);
        }
    }
    private string ValidatePath(string path)
    {
        if (!path.EndsWith("/")) path += "/";
        return path;
    }
    public string TempFolder { get { return ValidatePath((string)settings["TEMPDIR"]); } }
    public string FilesUploadFolder { get { return ValidatePath((string)settings["UploadDir"]); } }
    public string[] AllowedExtensions { get { return ConfigurationManager.AppSettings["AllowedExtensions"].Split(','); } }
    public int MaxUploadFileSize { get { return 0; } }
    public int PageSize { get { return Convert.ToInt32(settings["PageSize"]); } }
    public int PageButtonCount { get { return Convert.ToInt32(settings["PageButtonCount"]); } }
    public string EmptyDataText { get { return (string)settings["EmptyDataText"]; } }
}
public sealed class ClientSettings
{
    private string _cookiePrefix;
    public ClientSettings()
    {
        _cookiePrefix = ConfigurationManager.AppSettings["cookiePrefix"];
    }
    public string CookiePrefix { get { return _cookiePrefix; } set { _cookiePrefix = value; } }
    /// <summary>
    ///  get or set the value of settings.
    /// </summary>
    /// <param name="key">The key of the settings collection.</param>
    /// <returns>The value of the settings.</returns>

    public string this[string key]
    {
        get
        {
            return GetValue(key);
        }
        set
        {
            SetValue(key, value);
        }
    }
    /// <summary>
    ///  Get value of settings.
    /// </summary>
    /// <param name="key">The key of the settings collection.</param>
    /// <param name="encrypted">If this value was protected by encryption the encrypted param must be true. otherwise false.</param>
    /// <returns>The value of the settings.</returns>
    public  string this[string key, bool encrypted]
    {
        get
        {
            return GetValue(key, encrypted);
        }
        set
        {
            SetValue(key, value, encrypted);
        }
    }
   
    private string GetValue(string key)
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies[this._cookiePrefix + key];
        if (cookie != null)
        {
            return cookie.Value;
        }
        else
        {
            SetValue(key, "");
        }
        return String.Empty;
    }
    private string GetValue(string key, bool decrypt)
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies[this._cookiePrefix+key];

        if (cookie != null)
        {
            if (decrypt) cookie = Star.Security.Cryptography.Cookie.Decrypt(cookie);

            return cookie.Value;
        }
        else
        {
            SetValue(key, "", decrypt);
        }
        return String.Empty;
    }

    private void SetValue(string key, object value)
    {
        HttpCookie cookie = new HttpCookie(this._cookiePrefix+key);
        cookie.Value = value.ToString();
        cookie.Secure = false;
        cookie.Expires = DateTime.MaxValue;
        cookie.Path = "/";
        if (HttpContext.Current.Request.Cookies[key] == null)
        {
            HttpContext.Current.Response.Cookies.Add(cookie);
        }
        else
        {
            HttpContext.Current.Response.SetCookie(cookie);
        }
    }
    private void SetValue(string key, object value, bool encrypt)
    {
        HttpCookie cookie = new HttpCookie(this._cookiePrefix+key);
        cookie.Value = value.ToString();
        cookie.Secure = false;
        cookie.Expires = DateTime.MaxValue;
        cookie.Path = "/";
        if (encrypt) cookie = Star.Security.Cryptography.Cookie.Encrypt(cookie);
        if (HttpContext.Current.Request.Cookies[key] == null)
        {
            HttpContext.Current.Response.Cookies.Add(cookie);
        }
        else
        {
            HttpContext.Current.Response.SetCookie(cookie);
        }
    }
    /// <summary>
    /// Clear all settings from the settingscollection.
    /// </summary>
    public  void Clear()
    {
        HttpContext.Current.Response.Cookies.Clear();
    }
    /// <summary>
    /// Remove specified settings from the settingscollection.
    /// </summary>
    /// <param name="key">The specified key of the settings.</param>
    public  void Remove(string key)
    {
        HttpContext.Current.Response.Cookies.Remove(key);
    }
}
public  class Cookie
{
    public static string GetValue2(string key)
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies[key];
        if (cookie != null)
        {
            return cookie.Value;
        }
        else
        {
            SetValue2(key, "");
        }
        return String.Empty;
    }
    public static void SetValue2(string key, object value)
    {
        HttpCookie cookie = new HttpCookie(key);
        cookie.Value = value.ToString();
        cookie.Secure = false;
        cookie.Expires = DateTime.MaxValue;
        cookie.Path = "/";
        if (HttpContext.Current.Request.Cookies[key] == null)
        {
            HttpContext.Current.Response.Cookies.Add(cookie);
        }
        else
        {
            HttpContext.Current.Response.SetCookie(cookie);
        }
    }
}