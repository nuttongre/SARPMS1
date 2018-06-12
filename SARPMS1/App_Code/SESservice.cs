using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for SESservice
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
    
public class SESservice : System.Web.Services.WebService {

    public SESservice () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public DataSet getDvStrategies(string StudyYear) {
        Connection Conn = new Connection();
        string strSql = @" Select StrategiesCode, 'กลยุทธ์ที่ ' + Cast(Sort As nVarChar) + '.  ' + StrategiesName FullName, Sort From Strategies 
        Where DelFlag = 0 And StudyYear = '{0}' Order By Sort ";
        DataView dv = Conn.Select(string.Format(strSql, StudyYear));

        DataSet ds = new DataSet();
        ds.Tables.Add(dv.ToTable("Strategies"));
        return ds;
    }

    [WebMethod]
    public DataSet getDvProject(string StudyYear, string StrategiesCode)
    {
        Connection Conn = new Connection();
        string strSql = @" Select ProjectsCode, ProjectsName FullName, Sort 
        From Projects Where DelFlag = 0 And StudyYear = '{0}' ";
        if(!string.IsNullOrEmpty(StrategiesCode))
        {
            strSql += " And StrategiesCode = '" + StrategiesCode + "' ";
        }
        DataView dv = Conn.Select(string.Format(strSql + " Order By Sort ", StudyYear));

        DataSet ds = new DataSet();
        ds.Tables.Add(dv.ToTable("Project"));
        return ds;
    }

    [WebMethod]
    public DataSet getDvActivity(string StudyYear, string StrategiesCode, string ProjectCode)
    {
        Connection Conn = new Connection();
        string strSql = @" Select ActivityCode, ActivityName FullName, Sort 
        From Activity Where DelFlag = 0 And StudyYear = '{0}' ";
        if (!string.IsNullOrEmpty(StrategiesCode))
        {
            strSql += " And StrategiesCode = '" + StrategiesCode + "' ";
        }
        if (!string.IsNullOrEmpty(ProjectCode))
        {
            strSql += " And ProjectsCode = '" + ProjectCode + "' ";
        }
        DataView dv = Conn.Select(string.Format(strSql + " Order By Sort ", StudyYear));

        DataSet ds = new DataSet();
        ds.Tables.Add(dv.ToTable("Activity"));
        return ds;
    }

    [WebMethod]
    public DataSet getDvActivityDetail(string ActivityCode)
    {
        Connection Conn = new Connection();
        string strSql = @" Select A.ActivityName, A.StudyYear, A.Term, A.SDate, A.EDate, A.Status,
        AD.ActivityDetailCode, AD.TDay, AD.ActivityCode, AD.ActivityDetail, AD.CostsType,
        AD.TotalStatement, AD.TotalPersonnel, AD.TotalFinance, AD.DelFlag, AD.Sort, AD.ActivityStatus, Sum(ACD.TotalMoney) As TotalMoney
        From ActivityDetail AD Inner Join ActivityCostsDetail ACD On AD.ActivityDetailCode = ACD.ActivityDetailCode
        Inner Join Activity A On AD.ActivityCode = A.ActivityCode
        Where AD.ActivityCode = '{0}'
        Group By A.ActivityName, A.StudyYear, A.Term, A.SDate, A.EDate, A.Status,
        AD.ActivityDetailCode, AD.TDay, AD.ActivityCode, AD.ActivityDetail, AD.CostsType,
        AD.TotalStatement, AD.TotalPersonnel, AD.TotalFinance, AD.DelFlag, AD.Sort, AD.ActivityStatus
        Order By AD.Sort ";
        DataView dv = Conn.Select(string.Format(strSql, ActivityCode));

        DataSet ds = new DataSet();
        ds.Tables.Add(dv.ToTable("ActivityDetail"));
        return ds;
    }

    [WebMethod]
    public DataSet getDvActivityCostsDetail(string ActivityDetailCode)
    {
        Connection Conn = new Connection();
        string strSql = @" Select ACD.ActivityDetailCode, ACD.ActivityCode, ACD.EntryCostsCode, ACD.TotalMoney, ACD.TotalDD, ACD.Cost,
        ACD.ItemID, ACD.ListNo, CD.ListName, CD.BudgetTypeCode, CD.TotalP, CD.TotalD As aAmount, CD.TotalG As aCost, CD.TotalMoney, CD.TotalMoney2,
        BudgetTypeName = Case CD.BudgetTypeCode When '88f2efd0-b802-4528-8ca8-aae8d8352649' Then CD.BudgetTypeOtherName Else BT.BudgetTypeName End
        From ActivityCostsDetail ACD Inner Join CostsDetail CD On ACD.ItemID = CD.ItemID
        Inner Join BudgetType BT On CD.BudgetTypeCode = BT.BudgetTypeCode
        Where ACD.ActivityDetailCode = '{0}'
        Order By ACD.ListNo, BT.Sort ";
        DataView dv = Conn.Select(string.Format(strSql, ActivityDetailCode));

        DataSet ds = new DataSet();
        ds.Tables.Add(dv.ToTable("ActivityCostsDetail"));
        return ds;
    }
}
