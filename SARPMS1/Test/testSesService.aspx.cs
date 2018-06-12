using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Test_testSesService : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getddlStrategies();
            getddlProject(ddlStrategies.SelectedValue);
            getddlActivity(ddlStrategies.SelectedValue, ddlProject.SelectedValue);
            getddlActivityDetail(ddlActivity.SelectedValue);
        }
    }
    private void getddlStrategies()
    {
        ServiceReference1.SESserviceSoapClient SesSevice = new ServiceReference1.SESserviceSoapClient();
        DataSet ds = SesSevice.getDvStrategies("2560");
        DataView dv = ds.Tables[0].DefaultView;
        ddlStrategies.DataSource = dv;
        ddlStrategies.DataTextField = "FullName";
        ddlStrategies.DataValueField = "StrategiesCode";
        ddlStrategies.DataBind();
        ddlStrategies.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        ddlStrategies.SelectedIndex = 0;
    }
    private void getddlProject(string StrategiesCode)
    {
        ServiceReference1.SESserviceSoapClient SesSevice = new ServiceReference1.SESserviceSoapClient();
        DataSet ds = SesSevice.getDvProject("2560", StrategiesCode);
        DataView dv = ds.Tables[0].DefaultView;
        ddlProject.DataSource = dv;
        ddlProject.DataTextField = "FullName";
        ddlProject.DataValueField = "ProjectsCode";
        ddlProject.DataBind();
        ddlProject.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        ddlProject.SelectedIndex = 0;
    }
    private void getddlActivity(string StrategiesCode, string ProjectCode)
    {
        ServiceReference1.SESserviceSoapClient SesSevice = new ServiceReference1.SESserviceSoapClient();
        DataSet ds = SesSevice.getDvActivity("2560", StrategiesCode, ProjectCode);
        DataView dv = ds.Tables[0].DefaultView;
        ddlActivity.DataSource = dv;
        ddlActivity.DataTextField = "FullName";
        ddlActivity.DataValueField = "ActivityCode";
        ddlActivity.DataBind();
        ddlActivity.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        ddlActivity.SelectedIndex = 0;
    }
    private void getddlActivityDetail(string ActivityCode)
    {
        ServiceReference1.SESserviceSoapClient SesSevice = new ServiceReference1.SESserviceSoapClient();
        DataSet ds = SesSevice.getDvActivityDetail(ActivityCode);
        DataView dv = ds.Tables[0].DefaultView;
        ddlActivityDetail.DataSource = dv;
        ddlActivityDetail.DataTextField = "Sort";
        ddlActivityDetail.DataValueField = "ActivityDetailCode";
        ddlActivityDetail.DataBind();
        ddlActivityDetail.Items.Insert(0, new ListItem("-ทั้งหมด-", ""));
        ddlActivityDetail.SelectedIndex = 0;
    }
    public override void DataBind()
    {
        ServiceReference1.SESserviceSoapClient SesSevice = new ServiceReference1.SESserviceSoapClient();
        DataSet ds = SesSevice.getDvActivityCostsDetail(ddlActivityDetail.SelectedValue);
        DataView dv = ds.Tables[0].DefaultView;

        GridViewBudget.DataSource = dv;
        GridViewBudget.DataBind();
    }
    protected void ddlStrategies_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlProject(ddlStrategies.SelectedValue);
    }
    protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlActivity(ddlStrategies.SelectedValue, ddlProject.SelectedValue);
    }
    protected void ddlActivity_SelectedIndexChanged(object sender, EventArgs e)
    {
        getddlActivityDetail(ddlActivity.SelectedValue);
    }
    protected void ddlActivityDetail_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataBind();
    }
}