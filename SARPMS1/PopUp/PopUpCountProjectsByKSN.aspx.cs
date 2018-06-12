using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class PopUpCountProjectsByKSN : System.Web.UI.Page
{
    BTC btc = new BTC();
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBind();           
        }
    }
    public override void DataBind()
    {
        string StrSql = "";
        if (Request.QueryString["mode"] == "P1")
        {
            StrSql = @" Select Distinct(p.ProjectsCode) ProjectsCode, p.ProjectsName, 
                 p.SetBudget, p.Sort 
                 From Projects p, dtPrimePolicy dt
                 Where p.DelFlag = 0 And p.ProjectsCode = dt.ProjectsCode 
                 And dt.PrimePolicyID = '{0}' ";
        }

        if (Request.QueryString["mode"] == "P2")
        {
            StrSql = @" Select Distinct(p.ProjectsCode) ProjectsCode, p.ProjectsName, 
                 p.SetBudget, p.Sort 
                 From Projects p, dtPoliciesMinister dt
                 Where p.DelFlag = 0 And p.ProjectsCode = dt.ProjectsCode 
                 And dt.PoliciesMinisterID = '{0}' ";
        }

        if (Request.QueryString["mode"] == "P3")
        {
            StrSql = @" Select Distinct(p.ProjectsCode) ProjectsCode, p.ProjectsName, 
                 p.SetBudget, p.Sort 
                 From Projects p, dtPolicyKSN dt
                 Where p.DelFlag = 0 And p.ProjectsCode = dt.ProjectsCode 
                 And dt.PolicyKSNID = '{0}' ";
        }

        if (Request.QueryString["mode"] == "P4")
        {
            StrSql = @" Select Distinct(p.ProjectsCode) ProjectsCode, p.ProjectsName, 
                 p.SetBudget, p.Sort 
                 From Projects p
                 Where p.DelFlag = 0 
                 And p.StrategicPlanID = '{0}' ";
        }

        if (Request.QueryString["mode"] == "P5")
        {
            StrSql = @" Select Distinct(p.ProjectsCode) ProjectsCode, p.ProjectsName, 
                 p.SetBudget, p.Sort 
                 From Projects p
                 Where p.DelFlag = 0 
                 And p.CorporateStrategyID = '{0}' ";
        }

        if (Request.QueryString["mode"] == "P6")
        {
            StrSql = @" Select Distinct(p.ProjectsCode) ProjectsCode, p.ProjectsName, 
                 p.SetBudget, p.Sort 
                 From Projects p, dtFourthAssessment dt
                 Where p.DelFlag = 0 And p.ProjectsCode = dt.ProjectsCode 
                 And dt.FourthAssessmentIndicatorID = '{0}' ";
        }

        if (Request.QueryString["mode"] == "P7")
        {
            StrSql = @" Select Distinct(p.ProjectsCode) ProjectsCode, p.ProjectsName, 
                 p.SetBudget, p.Sort 
                 From Projects p, dtSuffice dt
                 Where p.DelFlag = 0 And p.ProjectsCode = dt.ProjectsCode 
                 And dt.SufficeIndicatorID = '{0}' ";
        }

        if (Request.QueryString["mode"] == "P8")
        {
            StrSql = @" Select Distinct(p.ProjectsCode) ProjectsCode, p.ProjectsName, 
                 p.SetBudget, p.Sort 
                 From Projects p, dtNewStandard dt
                 Where p.DelFlag = 0 And p.ProjectsCode = dt.ProjectsCode 
                 And dt.StandardCode = '{0}' ";
        }
                   
        DataView dv = Conn.Select(string.Format(StrSql + " Order By p.Sort ", Request.QueryString["id"]));

        GridView1.DataSource = dv;
        GridView1.DataBind();
    }
    public string GetBudget(decimal setBudget, decimal Budget)
    {
        if (Budget > setBudget)
        {
            return "<span style=\"color:red;\">" + Budget.ToString("#,##0.00") + "</span>";
        }
        else
        {
            return "<span>" + Budget.ToString("#,##0.00") + "</span>";
        }
    }
}
