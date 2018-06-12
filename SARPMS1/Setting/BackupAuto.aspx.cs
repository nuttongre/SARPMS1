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
using System.Text;
using System.Text.RegularExpressions;
using System.IO;

public partial class BackupAuto : System.Web.UI.Page
{
    Connection Conn = new Connection();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BackupData();
            DataBind();
        }
    }
    public override void DataBind()
    {
        string[] files;
        string path = ConfigurationManager.AppSettings["BackupData"];
        if (!Directory.Exists(path))
            Directory.CreateDirectory(path);
        files = Directory.GetDirectories(path);

        ICollection ic = default(ICollection);
        ic = (ICollection)files;
        ArrayList alFiles = new ArrayList();
        alFiles.AddRange(files);
        alFiles = SortDesc(alFiles);

        gwbackup.DataSource = alFiles;
        gwbackup.DataBind();
    }
    protected string FileName(object file)
    {
        return new DirectoryInfo(file.ToString()).Name;
    }
    protected string FileSize(object file)
    {
        return BTC.GetSize((long)Folder.Size(file.ToString(), false));
        //return FileManager.GetSize((long)Size(file.ToString(), false));
    }
    protected string CreateDate(object file)
    {
        return new DirectoryInfo(file.ToString()).CreationTime.ToString("dd-MMMM-yyyy HH:mm");
    }
    void BackupData()
    {
        string path = string.Format("{0}{1}\\", ConfigurationManager.AppSettings["BackupData"], DateTime.Now.ToString("yyyy-MM-dd HH-mm-") + CurrentUser.UserName.Trim());
        if (!Directory.Exists(Path.GetDirectoryName(path)))
            Directory.CreateDirectory(Path.GetDirectoryName(path));

        StringBuilder script = new StringBuilder();
        Regex reg = new Regex(@"(Initial Catalog=|Database=){1}([\w-]+)[;]?");
        string dbName = reg.Match(ConfigurationManager.ConnectionStrings["Connection"].ConnectionString).Groups[2].Value;

        script.AppendFormat("INSERT INTO Statistic (UseId,MenuId,Action,URL,CreateDate) values ('{2}','056','4','Backup.aspx',getdate()); ", dbName, path, CurrentUser.ID);
        //script.AppendFormat("INSERT INTO EventLog (UserId, Code, Detail, IPAddress, EventGroup) VALUES ('{0}', {1}, '{2}', '{3}', 2); ", CurrentUser.ID, 5, "", Request.UserHostAddress);
        script.Append("DECLARE @name VARCHAR(50) DECLARE @path VARCHAR(256) DECLARE @fileName VARCHAR(256) DECLARE @fileDate VARCHAR(20) ");
        script.AppendFormat("SET @path = N'{0}'  SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) DECLARE db_cursor CURSOR FOR  ", path);
        script.AppendFormat("SELECT name FROM master.dbo.sysdatabases WHERE name IN ('{0}')  OPEN db_cursor  FETCH NEXT FROM db_cursor INTO @name ", dbName);
        script.Append("WHILE @@FETCH_STATUS = 0  BEGIN SET @fileName = @path + @name + '_' + @fileDate + '.BAK' BACKUP DATABASE @name TO DISK = @fileName ;");
        script.Append("FETCH NEXT FROM db_cursor INTO @name END CLOSE db_cursor DEALLOCATE db_cursor ;");

        int result = 0;
        result = Conn.ExecuteNonTransAction(script.ToString());

        if (result > 0)
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "BackUpComplete", "alert('สำรองข้อมูลเสร็จสมบูรณ์');", true);
        else
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "BackUpNotComplete", "alert('เกิดข้อผิดพลาดในการสำรองข้อมูล');", true);
        DataBind();
    }
    private ArrayList SortAsc(ArrayList itemsArray)
    {
        SortedList sl = new SortedList();
        ArrayList asc = new ArrayList();
        foreach (string s in itemsArray)
        {
            sl.Add(s, "dummy");
        }
        foreach (string s in sl.Keys)
        {
            asc.Add(s);
        }
        return asc;
    }

    private ArrayList SortDesc(ArrayList itemsArray)
    {
        ArrayList asc = SortAsc(itemsArray);
        ArrayList desc = new ArrayList();
        for (int x = asc.Count - 1; x >= 0; x--)
        {
            desc.Add(asc[x]);
        }
        return desc;
    }

    private double sizeInBytes;
    public double Size(string directory, bool deep)
    {
        DirectoryInfo dir = new DirectoryInfo(directory);
        foreach (FileInfo f in dir.GetFiles())
        {
            sizeInBytes += f.Length;
        }
        if (deep)
        {
            foreach (DirectoryInfo d in dir.GetDirectories())
            {
                Size(d.FullName, deep);
            }
        }
        double bytes = sizeInBytes;
        sizeInBytes = 0;
        return bytes;
    }
}
//public class Folder
//{
//    private static double sizeInBytes;
//    public static double Size(string directory, bool deep)
//    {
//        DirectoryInfo dir = new DirectoryInfo(directory);
//        foreach (FileInfo f in dir.GetFiles())
//        {
//            sizeInBytes += f.Length;
//        }
//        if (deep)
//        {
//            foreach (DirectoryInfo d in dir.GetDirectories())
//            {
//                Size(d.FullName, deep);
//            }
//        }
//        double bytes = sizeInBytes;
//        sizeInBytes = 0;
//        return bytes;
//    }
//}
