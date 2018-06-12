using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Star.Security.Cryptography;

/// <summary>
/// Summary description for ProfileService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class ProfileService : System.Web.Services.WebService {

    public ProfileService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    [WebMethod]
    public Int32 setProfile(string EmpID, string txtName, string txtEmail, string txtTel, string UpdateUser)
    {
        Connection Conn = new Connection();
        Int32 i = Conn.Update("Employee", "WHERE EmpID = '" + EmpID + "' ", "EmpName, Email, Tel, UpdateUser, UpdateDate",
                txtName, txtEmail, txtTel, UpdateUser, DateTime.Now);
        return i;
    }
    [WebMethod]
    public Int32 setPassword(string EmpID, string Password)
    {
        Connection Conn = new Connection();
        Int32 i = Conn.Update("Employee", "WHERE EmpID = '" + EmpID + "' ", "Pwd", Text.Encrypt(Password));
        return i;
    }
}
