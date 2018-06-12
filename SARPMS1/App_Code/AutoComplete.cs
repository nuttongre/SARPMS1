using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Configuration;

/// <summary>
/// Summary description for AutoComplete
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class AutoComplete : System.Web.Services.WebService
{
    [WebMethod]
    public string[] GetUnitInfo(string prefixText)
    {
        string sql = "Select Distinct(TotalP) TotalP From CostsDetail Where TotalP like '{0}%'";

        Connection Conn = new Connection();
        DataView dv = Conn.Select(string.Format(sql, prefixText));

        string[] items = new string[dv.Count];
        int i = 0;
        foreach (DataRow dr in dv.Table.Rows)
        {
            items.SetValue(dr["TotalP"].ToString(), i);
            i++;
        }
        return items;
    }

    [WebMethod]
    public string[] GetBudgetType(string prefixText)
    {
        string sql = "Select Distinct(REPLACE(REPLACE(BudgetTypeOtherName,')',''),'อื่น ๆ (','')) BudgetTypeOtherName "
            + " From CostsDetail "
            + " Where BudgetTypeCode = '88f2efd0-b802-4528-8ca8-aae8d8352649' "
            + " And REPLACE(REPLACE(BudgetTypeOtherName,')',''),'อื่น ๆ (','') <> '' "
            + " And REPLACE(REPLACE(BudgetTypeOtherName,')',''),'อื่น ๆ (','') like '{0}%' ";

        Connection Conn = new Connection();
        DataView dv = Conn.Select(string.Format(sql, prefixText));

        string[] items = new string[dv.Count];
        int i = 0;
        foreach (DataRow dr in dv.Table.Rows)
        {
            items.SetValue(dr["BudgetTypeOtherName"].ToString(), i);
            i++;
        }
        return items;
    }

    [WebMethod]
    public string[] GetVersion(string prefixText)
    {
        string sql = "Select Distinct(Version) Version From LogSchoolSar Where Version like '{0}%' Order By Version Desc";

        Connection Conn = new Connection();
        DataView dv = Conn.Select(string.Format(sql, prefixText));

        string[] items = new string[dv.Count];
        int i = 0;
        foreach (DataRow dr in dv.Table.Rows)
        {
            items.SetValue(dr["Version"].ToString(), i);
            i++;
        }
        return items;
    }

    [WebMethod]
    public string[] GetIPaddress(string prefixText)
    {
        string sql = "Select Distinct(IPaddress) IPaddress From LogSchoolSar Where IPaddress like '{0}%'";

        Connection Conn = new Connection();
        DataView dv = Conn.Select(string.Format(sql, prefixText));

        string[] items = new string[dv.Count];
        int i = 0;
        foreach (DataRow dr in dv.Table.Rows)
        {
            items.SetValue(dr["IPaddress"].ToString(), i);
            i++;
        }
        return items;
    }

    [WebMethod]
    public string[] GetSchoolName(string prefixText)
    {
        string sql = "Select SchoolName From LogSchoolSar Where SchoolName like '{0}%' Order By SchoolName Desc";

        Connection Conn = new Connection();
        DataView dv = Conn.Select(string.Format(sql, prefixText));

        string[] items = new string[dv.Count];
        int i = 0;
        foreach (DataRow dr in dv.Table.Rows)
        {
            items.SetValue(dr["SchoolName"].ToString(), i);
            i++;
        }
        return items;
    }
}

