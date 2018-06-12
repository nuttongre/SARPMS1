using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;

public enum UserCreateStatus
{
    UnknowError=0,
    Success = 1,
    DuplicateUserName = 2,
    DuplicateEmail = 3,
    ProviderError = 4,
    InvalidUserName=5,
    InvalidPassword=6,
    InvalidAnswer=7

}
public enum UserLoginStatus
{
    UnknowError=0,
    Succeed=1,
    WrongPassword=2,
    InvalidUserName=3
}
public class UserProvider
{
    private static int _minAnswerLength = 5;
    private static int _maxAnswerLength = 30;
    private static bool _uniqueEmail = false;
    private static bool _requireEmail = false;
    private static int _minPasswordLength=5;
    private static int _maxPasswordLength=32;
    private static int _minUsernameLength=3;
    private static int _maxUsernameLength=256;
    private static bool _enablePasswordReset=true;
    private static bool _enablePasswordRetrieval=true;
    private static int _passwordSaltLength = 32;
    private static string getPasswordSalt(string username)
    {        
        return Star.Security.Cryptography.Text.Encrypt(username.ToLower());
    }
    private static User _anonymous;
    public static void Initialize()
    {
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["MinAnswerLength"])) _minAnswerLength = Convert.ToInt32(ConfigurationManager.AppSettings["MinAnswerLength"]);
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["MaxAnswerLength"])) _maxAnswerLength = Convert.ToInt32(ConfigurationManager.AppSettings["MaxAnswerLength"]);
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["UniqueEmail"])) _uniqueEmail = Convert.ToBoolean(ConfigurationManager.AppSettings["UniqueEmail"]);
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["RequireEmail"])) _requireEmail = Convert.ToBoolean(ConfigurationManager.AppSettings["RequireEmail"]);
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["MinPasswordLength"])) _minPasswordLength =Convert.ToInt32(ConfigurationManager.AppSettings["MinPasswordLength"]);
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["MaxPasswordLength"])) _maxPasswordLength =Convert.ToInt32( ConfigurationManager.AppSettings["MaxPasswordLength"]);
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["MinUserNameLength"])) _minUsernameLength =Convert.ToInt32( ConfigurationManager.AppSettings["MinUserNameLength"]);
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["MaxUserNameLength"])) _maxUsernameLength =Convert.ToInt32( ConfigurationManager.AppSettings["MaxUserNameLength"]);
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["EnablePasswordRetrieval"])) _enablePasswordRetrieval =Convert.ToBoolean( ConfigurationManager.AppSettings["EnablePasswordRetrieval"]);
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["EnablePasswordReset"])) _enablePasswordReset = Convert.ToBoolean(ConfigurationManager.AppSettings["EnablePasswordReset"]);
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["PasswordSaltLength"])) _passwordSaltLength = Convert.ToInt32(ConfigurationManager.AppSettings["PasswordSaltLength"]);
    }

    public static bool EnablePasswordReset { get { return _enablePasswordReset; } set { _enablePasswordReset = value; } }
    public static bool RequireEmail { get { return _requireEmail; } set { _requireEmail = value; } }
    public static bool UniqueEmail { get { return _uniqueEmail; } set { _uniqueEmail = value; } }
    public static int MinPasswordLength { get { return _minPasswordLength; } set { _minPasswordLength = value; } }
    public static int MaxPasswordLength { get { return _maxPasswordLength; } set { _maxPasswordLength = value; } }
    public static int MinAnswerLength { get { return _minAnswerLength; } set { _minAnswerLength = value; } }
    public static int MaxAnswerLength { get { return _maxAnswerLength; } set { _maxAnswerLength = value; } }
    public static int MinUserNameLength { get { return _minUsernameLength; } set { _minUsernameLength = value; } }
    public static int MaxUserNameLength { get { return _maxUsernameLength; } set { _maxUsernameLength = value; } }
    public static bool EnablePasswordRetrieval { get { return _enablePasswordRetrieval; } set { _enablePasswordRetrieval = value; } }
    public static User Anonymous
    {
        get
        {
            if (_anonymous == null)
            {
                _anonymous = new User("Anonymous");
            }
            return _anonymous;
        }
    }
    public static void CheckTimeOut()
    {   //ผู้ใช้งานระบบ หมดเวลา โดยไม่ทำงานระบบ หรือ ออกจากระบบโดยไม่กดออกจากโปรแกรม
        ClientLimit cl = new ClientLimit();
        cl.CheckClient(CurrentUser.ID, FormsAuthentication.DefaultUrl);
    }
    public static bool ValidateUser(string username, string password, bool savemyinfo, bool autosignin)
    {
        Connection Conn = new Connection();
        string strSql = @"Select E.EmpID, E.EmpName, E.SchoolID, E.DeptCode, E.UserRoleID, 
        MD.MainDeptCode, MSD.MainSubDeptCode, UR.UserRoleName, UR.RoleLevel
        From Employee E Inner Join Department D On E.DeptCode = D.DeptCode
        Inner Join MainSubDepartment MSD On D.MainSubDeptCode = MSD.MainSubDeptCode 
        Inner Join MainDepartment MD On MSD.MainDeptCode = MD.MainDeptCode
		Inner Join UserRole UR On E.UserRoleID = UR.UserRoleID
        Where E.UserName = '{0}' And E.Pwd = '{1}' And E.DelFlag = '0' And E.Hideflag = 0 ";
        DataView dv = Conn.Select(string.Format(strSql, username, password));

        if (dv.Count == 0) return false;

        //เช็คจำนวนผู้ใช้-----------------------------------------------------------
        ClientLimit cl = new ClientLimit();
        if (!cl.AddClient(dv[0]["EmpID"].ToString(), true)) return false;
        //---------------------------------------------------------------------

            FormsAuthentication.SetAuthCookie(username, false);
            Configurations.Client["my_id", true] = dv[0]["EmpID"].ToString();
            Configurations.Client["my_firstname", true]= dv[0]["EmpName"].ToString();
            Configurations.Client["my_deptid", true] = dv[0]["DeptCode"].ToString();
            Configurations.Client["my_maindeptid", true] = dv[0]["MainDeptCode"].ToString();
            Configurations.Client["my_mainsubdeptid", true] = dv[0]["MainSubDeptCode"].ToString();
            Configurations.Client["my_schoolid", true] = dv[0]["SchoolID"].ToString();
            Configurations.Client["my_userroleid", true] = dv[0]["UserRoleID"].ToString();
            Configurations.Client["my_rolelevel", true] = dv[0]["RoleLevel"].ToString();
            Configurations.Client["my_lastlogin", true] = DateTime.Now.ToString("d/M/yyyy HH:mm");
            if (savemyinfo)
            {
                Configurations.Client["starSSOuser", true] = username;
                Configurations.Client["starSSOpwd", true] = password;
            }
            Configurations.Client["starSSOsave", true] = savemyinfo.ToString().ToLower();
            Configurations.Client["starSSOauto", true] = autosignin.ToString().ToLower();
            return true;
        
    }
    public static bool Exists(string username)
    {
        if (new Connection().Count("UserName", "MEMBERSHIP", "WHERE UserName='" + username + "'") > 0) return true;
        return false;
    }
    public static string GetPassword(string username, string secretAnswer)
    {
        if (!_enablePasswordRetrieval) throw new Exception("Cannot Retrieve Password while the parameter EnablePasswordRetrieval is false.");
        Connection Conn = new Connection();
        DataView dv = Conn.Select("PASSWORD", "MEMBERSHIP", "WHERE (USERNAME='"+username+"') AND (SECRETANSWER='"+Star.Security.Cryptography.Text.Encrypt(secretAnswer, getPasswordSalt(username))+"') ");
        if (dv.Count > 0)
        {
            return dv[0]["PASSWORD"].ToString();
        }
        return "";
    }
    public static string GetSecretAnswer(string username, string password)
    {
        Connection Conn = new Connection();
        string salt = getPasswordSalt(username);
        DataView dv = Conn.Select("SECRETANSWER", "MEMBERSHIP", "WHERE USERNAME='"+username+"' AND PASSWORD='"+Star.Security.Cryptography.Text.Encrypt(password, salt)+"'");
        if (dv.Count > 0)
        {
            return Star.Security.Cryptography.Text.Decrypt(dv[0]["SECRETANSWER"].ToString(), salt);
        }
        return "";
    }
    public static bool ChangePassword(string username, string secretAnswer, string newPassword)
    {
        if (!UserProvider.EnablePasswordReset) throw new Exception("Cannot Change Password while the parameter EnablePasswordReset is false.");
        try
        {
            string salt = getPasswordSalt(username);

            int rowEffected = new Connection().Update("MEMBERSHIP", "WHERE (USERNAME='" + username + "') AND (SECRETANSWER='" + Star.Security.Cryptography.Text.Encrypt(secretAnswer, getPasswordSalt(username)) + "')", "PASSWORD, PASSWORDSALT", Star.Security.Cryptography.Text.Encrypt(newPassword, salt), salt);
            if (rowEffected > 0) return true;
            return false;
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    public static bool ChangePassword(string oldPassword, string newPassword)
    {
        if (!UserProvider.EnablePasswordReset) throw new Exception("Cannot Change Password while the parameter EnablePasswordReset is false.");
        try
        {
            string salt =getPasswordSalt(CurrentUser.UserName);
            int rowEffected = new Connection().Update("MEMBERSHIP", "WHERE (USERNAME='" + CurrentUser.UserName + "') AND (PASSWORD='" + Star.Security.Cryptography.Text.Encrypt(oldPassword, getPasswordSalt(CurrentUser.UserName)) + "')", "PASSWORD, PASSWORDSALT", Star.Security.Cryptography.Text.Encrypt(newPassword, salt), salt);
            if (rowEffected > 0) return true;
            return false;
        }
        catch (Exception e)
        {
            throw e;
        }
    }


    public static UserCreateStatus CreateUser(string username, string password,  string firstname, string lastname, string email, bool enabled, params string[] roles)
    {
        if (username.Length < _minUsernameLength || username.Length > _maxUsernameLength) return UserCreateStatus.InvalidUserName;
        if (password.Length < _minPasswordLength || password.Length > _maxPasswordLength) return UserCreateStatus.InvalidPassword;

        if (Exists(username)) return UserCreateStatus.DuplicateUserName;

        Connection Conn = new Connection();
        if (!String.IsNullOrEmpty(email))
        {
            if (_uniqueEmail && Conn.Count("USERNAME", "MEMBERSHIP", "WHERE EMAIL='" + email + "'") > 0) return UserCreateStatus.DuplicateEmail;
        }
        try
        {
            password = Star.Security.Cryptography.Text.Encrypt(password, getPasswordSalt(username));
            Conn.AddNew("MEMBERSHIP", "USERNAME, PASSWORD, FIRSTNAME, LASTNAME, CREATEDATE, LASTLOGINDATE, SECRETQUESTION, SECRETANSWER, EMAIL, ENABLED", username, password, firstname, lastname, DateTime.Now, DateTime.Now, "", "", email, enabled);
            string[] sql = new string[roles.Length];
            for (int i = 0; i < roles.Length; i++)
            {
                sql[i] = "INSERT INTO USERINROLE (USERID, ROLEID) VALUES(SELECT USERID FROM MEMBERSHIP WHERE USERNAME='" + username + "', " + roles[i] + ")";
            }
            Conn.Execute(sql);
            return UserCreateStatus.Success;
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    public static UserCreateStatus CreateUser(string username, string password, params string[] roles)
    {
        if (username.Length < _minUsernameLength || username.Length > _maxUsernameLength) return UserCreateStatus.InvalidUserName;
        if (password.Length < _minPasswordLength || password.Length > _maxPasswordLength) return UserCreateStatus.InvalidPassword;

        if (Exists(username)) return UserCreateStatus.DuplicateUserName;

        Connection Conn = new Connection();
        
        try
        {
            password = Star.Security.Cryptography.Text.Encrypt(password, getPasswordSalt(username));
            Conn.AddNew("MEMBERSHIP", "USERNAME, PASSWORD, FIRSTNAME, LASTNAME, CREATEDATE, LASTLOGINDATE, SECRETQUESTION, SECRETANSWER, EMAIL, ENABLED", username, password, "", "", DateTime.Now, DateTime.Now, "", "", "", true);
            string[] sql = new string[roles.Length];
            for (int i = 0; i < roles.Length; i++)
            {
                sql[i] = "INSERT INTO USERINROLE (USERID, ROLEID) VALUES(SELECT USERID FROM MEMBERSHIP WHERE USERNAME='"+username+"', " + roles[i] + ")";
            }
            Conn.Execute(sql);
            return UserCreateStatus.Success;
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    public static void UpdateUser(string userid, string username, string firstname, string lastname, string email, bool enabled, params string[] roles)
    {

        try
        {
            Connection Conn = new Connection();

            Conn.Update("MEMBERSHIP", "WHERE USERID='" + userid + "'", "USERNAME, FIRSTNAME, LASTNAME, EMAIL, ENABLED", username, firstname, lastname, email, enabled);
            string[] sql = new string[roles.Length+1];
            sql[0] = "DELETE USERINROLE WHERE USERID='"+userid+"'";
            for (int i = 1; i < sql.Length; i++)
            {
                sql[i] = "INSERT INTO USERINROLE (USERID, ROLEID) VALUES('" + userid + "', " + roles[i-1] + ")";
            }
            Conn.Execute(sql);

        }
        catch (Exception e)
        {
            throw e;
        }

    }
    public static void UpdateUser(User user)
    {

        try
        {
            Connection Conn = new Connection();
            Conn.Update("MEMBERSHIP", "WHERE USERID='" + user.ID + "'", "USERNAME, FIRSTNAME, LASTNAME, EMAIL, ENABLED", user.UserName,  user.FirstName, user.LastName, user.Email, user.Enabled);
            string[] sql = new string[user.Roles.Length + 1];
            sql[0] = "DELETE USERINROLE WHERE USERID='" + user.ID + "'";
            for (int i = 1; i < user.Roles.Length; i++)
            {
                sql[i] = "INSERT INTO USERINROLE (USERID, ROLEID) VALUES('" + user.ID + "', " + user.Roles[i] + ")";
            }
            Conn.Execute(sql);

        }
        catch (Exception e)
        {
            throw e;
        }

    }
    public static void CreateAuthenticate(string username)
    {
        FormsAuthentication.SetAuthCookie(username, true);
        User user = new User(username);
        if (user == null) return;
        Configurations.Client["my_id", true] = user.ID;
        Configurations.Client["my_firstname", true] = user.FirstName;
        Configurations.Client["my_lastname", true] = user.LastName;
        Configurations.Client["my_roles", true] = String.Join(",", user.Roles);
        Configurations.Client["my_deptid", true] = user.DeptID;
        Configurations.Client["my_maindeptid", true] = user.MainDeptID;
        Configurations.Client["my_mainsubdeptid", true] = user.MainSubDeptID;
        Configurations.Client["my_schoolid", true] = user.SchoolID;
        Configurations.Client["my_userroleid", true] = user.UserRoleID;
        Configurations.Client["my_rolelevel", true] = user.RoleLevel.ToString();
        Configurations.Client["my_email", true] = user.Email;
        Configurations.Client["my_lastlogin", true] = user.LastLoginDate.ToString("d/MM/yyyy HH:mm");
    }
    public static int Delete(params string[] username)
    {
        string sql = "WHERE (USERNAME='";
        sql += String.Join("') OR (USERNAME='", username);
        sql += "')";
        try
        {
            return new Connection().Delete("MEMBERSHIP", sql);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

}
public class User
{
    private string _id;
    private string _username;
    private string _firstname;
    private string _lastname;
    private string _email;
    private string _secretQuestion;
    private DateTime _createdate;
    private DateTime _lastlogindate;
    private string[] _roles;
    private string _deptid;
    private string _maindeptid;
    private string _mainsubdeptid;
    private string _schoolid;
    private string _userroleid;
    private Int32 _rolelevel;
    private bool _enabled;

    public User()
    {

    }
    public string ID { get { return _id; } set { _id = value; } }
    public string UserName { get { return _username; } set { _username = value; } }
    public string FirstName { get { return _firstname; } set { _firstname = value; } }
    public string LastName { get { return _lastname; } set { _lastname = value; } }
    public string Email { get { return _email; } set { _email = value; } }
    public string SecretQuestion{ get { return _secretQuestion; } set { _secretQuestion = value; } }
    public DateTime CreateDate { get { return _createdate; } set { _createdate = value; } }
    public DateTime LastLoginDate { get { return _lastlogindate; } set { _lastlogindate = value; } }
    public string[] Roles { get { return _roles; } set { _roles= value; } }
    public string DeptID { get { return _deptid; } set { _deptid = value; } }
    public string MainDeptID { get { return _maindeptid; } set { _maindeptid = value; } }
    public string MainSubDeptID { get { return _mainsubdeptid; } set { _mainsubdeptid = value; } }
    public string SchoolID { get { return _schoolid; } set { _schoolid = value; } }
    public string UserRoleID { get { return _userroleid; } set { _userroleid = value; } }
    public Int32 RoleLevel { get { return _rolelevel; } set { _rolelevel = value; } }
    public bool Enabled { get { return _enabled; } set { _enabled = value; } }

    public User(string username)
    {
        //Connection Conn = new Connection();
        //DataView dv = Conn.Select("USERID, USERNAME, FIRSTNAME, LASTNAME, EMAIL, CREATEDATE, ENABLED, (SELECT TOP 1 S.LOGINDATE FROM LOGINSTATS S WHERE S.USERID=USERID ORDER BY S.LOGINDATE DESC) AS LASTLOGINDATE", "MEMBERSHIP", "WHERE USERNAME='" + username + "'");
        //if (dv.Count > 0)
        //{
        //    this._id = dv[0]["USERID"].ToString();
        //    this._username = dv[0]["UserName"].ToString();
        //    this._firstname = dv[0]["FirstName"].ToString();
        //    this._lastname = dv[0]["LastName"].ToString();
        //    this._email = dv[0]["Email"].ToString();
        //    this._lastlogindate = Convert.ToDateTime(Convert.IsDBNull(dv[0]["LastLoginDate"]) ? DateTime.Now : dv[0]["LASTLOGINDATE"]);
        //    this._createdate = Convert.ToDateTime(dv[0]["CreateDate"]);
        //    this._enabled = Convert.ToBoolean(dv[0]["Enabled"]);
        //    this._roles = UserRoles.GetRolesForUser(this._id);
        //}
    }
    public User(string id, string username, string email, DateTime createdate, DateTime lastlogindate, string[] roles)
    {
        this._id = id;
        this._username = username;
        this._email = email;
        this._lastlogindate = lastlogindate;
        this._createdate = createdate;
        this._roles = roles;
        this._deptid = DeptID;
        this._maindeptid = MainDeptID;
        this._mainsubdeptid = MainSubDeptID;
        this._schoolid = SchoolID;
        this._userroleid = UserRoleID;
        this._rolelevel = RoleLevel;
    }
}
public class UserCollection : Collection<User>
{

}
public class CurrentUser
{
    public static string ID { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return UserProvider.Anonymous.ID; return Configurations.Client["my_id", true]; } }
    public static string UserName { get { return HttpContext.Current.User.Identity.Name; } }
    public static string Initial { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return ""; return Configurations.Client["my_initial", true]; } }
    public static string FirstName { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return ""; return Configurations.Client["my_firstname", true]; } }
    public static string LastName { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return ""; return Configurations.Client["my_lastname", true]; } }
    public static string DeptID { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return ""; return Configurations.Client["my_deptid", true]; } }
    public static string MainDeptID { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return ""; return Configurations.Client["my_maindeptid", true]; } }
    public static string MainSubDeptID { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return ""; return Configurations.Client["my_mainsubdeptid", true]; } }
    public static string SchoolID { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return ""; return Configurations.Client["my_schoolid", true]; } }
    public static string UserRoleID { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return ""; return Configurations.Client["my_userroleid", true]; } }
    public static string[] Roles { get {  if(String.IsNullOrEmpty(CurrentUser.UserName)) return new string[0]; return Configurations.Client["my_roles", true].Split(','); } }
    public static Int32 RoleLevel { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return 0; return Convert.ToInt32(Configurations.Client["my_rolelevel", true]); } }
    public static string Email { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return ""; return Configurations.Client["my_email", true]; } }
    public static DateTime LastLoginDate { get { if (String.IsNullOrEmpty(CurrentUser.UserName)) return DateTime.Now; return DateTime.Parse(Configurations.Client["my_lastlogin", true]); } }
}
public class UserRoles
{
    private string _id;
    private string _name;
    private int _level;
    public const string CACHE_KEY = "UserRoles";
    public UserRoles()
    {

    }
    public string ID { get { return _id; } set { _id = value; } }
    public string Name { get { return _name; } set { _name = value; } }
    public int Level { get { return _level; } set { _level = value; } }
    public UserRoles(string id, string name, int level)
    {
        this._id = id;
        this._name = name;
        this._level = level;
    }
    public static UserRoles[] GetAllRoles()
    {
        DataView dv =GetAllRolesCache();

        UserRoles[] roles = new UserRoles[dv.Count];
        if (dv.Count > 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                roles[i] = new UserRoles(dv[i]["RoleID"].ToString(),
                    dv[i]["RoleName"].ToString(),
                    Convert.ToInt16(dv[i]["RoleLevel"])
                    );
            }
        }
        return roles;

    }
    public static DataView GetAllRolesCache()
    {
        DataView dv = (DataView)HttpContext.Current.Cache[CACHE_KEY];
        if (dv == null)
        {
            Connection Conn = new Connection();
            dv = Conn.Select("*", "ROLES", "ORDER BY ROLELEVEL, ROLENAME");
            HttpContext.Current.Cache.Insert(CACHE_KEY, dv, null, DateTime.Now.AddHours(1), System.Web.Caching.Cache.NoSlidingExpiration);
        }
        return dv;
    }
    public static UserRoles GetRoleById(string id)
    {
        Connection Conn = new Connection();
        DataView dv = new DataView();
        UserRoles role = null;
        dv = GetAllRolesCache();
        DataRow[] rows=dv.Table.Select("RoleID='" + id + "'");
        if (rows.Length > 0)
        {
            role = new UserRoles(rows[0]["RoleID"].ToString(),
                rows[0]["RoleName"].ToString(),
                Convert.ToInt16(rows[0]["RoleLevel"])
);
        }
        return role;
    }
    public static UserRoles GetRoleByName(string rolename)
    {
        Connection Conn = new Connection();
        
        UserRoles role = null;
        DataView dv = GetAllRolesCache();
        DataRow[] rows = dv.Table.Select("RoleName='" + rolename + "'");
        if (rows.Length > 0)
        {
            role = new UserRoles(rows[0]["RoleID"].ToString(),
                rows[0]["RoleName"].ToString(),
                Convert.ToInt16(rows[0]["RoleLevel"])
);
        }
        return role;
    }
    public static string[] GetRolesForUser()
    {
        if (!String.IsNullOrEmpty(CurrentUser.UserName))
        {
            return CurrentUser.Roles;
        }
        else
        {
            return UserProvider.Anonymous.Roles;
        }
    }
    public static string[] GetRolesForUser(string userid)
    {
        Connection Conn = new Connection();
        DataView dv = Conn.Select("ROLEID", "USERINROLE", "WHERE USERID='" + userid + "' ORDER BY ROLEID");
        string[] roles = new string[dv.Count];

        if (dv.Count > 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                roles[i] = dv[i]["RoleID"].ToString();
            }
        }
        else
        {
           roles = UserProvider.Anonymous.Roles;
        }
        return roles;

    }
    public static bool IsUserInRole(string userid, string roleid)
    {
        if (new Connection().Count("RoleID", "USERINROLE", "WHERE USERID='" + userid + "' AND RoleID=" + roleid + "") > 0) return true;
        return false;
    }
    public static string[] UsersInRole(string roleid)
    {
        Connection Conn = new Connection();
        DataView dv = Conn.Select("U.UserName", "USERINROLE", "WHERE ROLEID='" + roleid + "'");
        string[] users = new string[dv.Count];

        if (dv.Count > 0)
        {
            for (int i = 0; i < dv.Count; i++)
            {
                users[i] = dv[i]["UserName"].ToString();
            }
        }

        return users;
    }
    public static bool IsGranted(string username, string[] compareValues, bool allowedAnonymous)
    {
        User user = new User(username);
        if (user == null) return false;
        for (int i = 0; i < user.Roles.Length; i++)
        {
            if (Star.Text.ArrayExtension.ExistsInArray(user.Roles[i], compareValues)) return true;
        }
        if (!allowedAnonymous) return false;
        return Star.Text.ArrayExtension.ExistsInArray(UserProvider.Anonymous.Roles[0], compareValues);
    }
    public static bool IsGranted(string[] roles, string[] compareValues, bool allowedAnonymous)
    {
        for (int i = 0; i < roles.Length; i++)
        {
            if (Star.Text.ArrayExtension.ExistsInArray(roles[i], compareValues)) return true;
        }
        if (!allowedAnonymous) return false;
        return Star.Text.ArrayExtension.ExistsInArray(UserProvider.Anonymous.Roles[0], compareValues);
    }
    public static bool IsGranted(string username, string[] compareValues)
    {
        User user = new User(username);
        if (user == null) return false;
        for (int i = 0; i < user.Roles.Length; i++)
        {
            if (Star.Text.ArrayExtension.ExistsInArray(user.Roles[i], compareValues)) return true;
        }
        return Star.Text.ArrayExtension.ExistsInArray(UserProvider.Anonymous.Roles[0], compareValues);

    }
    public static bool IsGranted(string[] roles, string[] compareValues)
    {
        for (int i = 0; i < roles.Length; i++)
        {
            if (Star.Text.ArrayExtension.ExistsInArray(roles[i], compareValues)) return true;
        }
        return Star.Text.ArrayExtension.ExistsInArray(UserProvider.Anonymous.Roles[0], compareValues);

       
    }
    public static void Reload()
    {
        HttpContext.Current.Cache.Remove(CACHE_KEY);
    }
}
public class Authentication
{
    public static bool IsUserAllowedToPath(string username, string virtualPath)
    {

        return true;
    }
    public static bool IsUserAllowedToFile(string username, string filename)
    {

        return true;
    }

}
