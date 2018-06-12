using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

/// <summary>
/// Represents the current Database Connection
/// </summary>
/// 
using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Management;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;

/// <summary>
/// Summary description for Connection
/// </summary>
public class Connection : IDo.Data.Common
{
    public Connection()
        : base()
    {
        this.Provider = ConfigurationManager.ConnectionStrings["Connection"].ProviderName;
        this.Owner = ConfigurationManager.AppSettings["DBOwner"];
        this.UserName = ConfigurationManager.AppSettings["DBUsername"];
        if (Convert.ToBoolean(ConfigurationManager.AppSettings["PasswordEncrypt"]))
        {
            this.Password = Star.Security.Cryptography.Text.Decrypt(ConfigurationManager.AppSettings["DBPassword"], ConfigurationManager.AppSettings["DBUsername"]);
        }
        else
        {
            this.Password = ConfigurationManager.AppSettings["DBPassword"];
        }
        this.ConnectionString = String.Format(ConfigurationManager.ConnectionStrings["Connection"].ConnectionString, this.UserName, this.Password);
    }

    public Connection(string connectionName)
        : base()
    {
        this.Provider = ConfigurationManager.ConnectionStrings[connectionName].ProviderName;
        this.Owner = ConfigurationManager.AppSettings["DBOwner"];
        this.UserName = ConfigurationManager.AppSettings["DBUsername"];
        if (Convert.ToBoolean(ConfigurationManager.AppSettings["PasswordEncrypt"]))
        {
            this.Password = Star.Security.Cryptography.Text.Decrypt(ConfigurationManager.AppSettings["DBPassword"], ConfigurationManager.AppSettings["DBUsername"]);
        }
        else
        {
            this.Password = ConfigurationManager.AppSettings["DBPassword"];
        }
        this.ConnectionString = String.Format(ConfigurationManager.ConnectionStrings[connectionName].ConnectionString, this.UserName, this.Password);
    }

    public Connection(string connectionstring, string provider)
        : base(connectionstring, provider)
    {

    }

    public Connection(string connectionstring, DataProvider provider)
    {
        this.Provider = "System.Data." + provider.ToString();
        this.ConnectionString = connectionstring;
    }

    public enum DatabaseType { SQL = 1, Oracle = 2, Access = 3, Excel = 4 }

    public string Path { set { this.ConnectionString = string.Format(this.ConnectionString, value); } }

    public Connection(DatabaseType databaseType)
    {
        switch (databaseType)
        {
            case DatabaseType.Access:
                this.Provider = ConfigurationManager.ConnectionStrings["DBAccess"].ProviderName;
                this.ConnectionString = ConfigurationManager.ConnectionStrings["DBAccess"].ConnectionString;
                break;
            case DatabaseType.Excel:
                this.Provider = ConfigurationManager.ConnectionStrings["DBExcel"].ProviderName;
                this.ConnectionString = ConfigurationManager.ConnectionStrings["DBExcel"].ConnectionString;
                break;
            default:
                this.Provider = ConfigurationManager.ConnectionStrings["Connection"].ProviderName;
                this.Owner = ConfigurationManager.AppSettings["DBOwner"];
                this.UserName = ConfigurationManager.AppSettings["DBUsername"];
                if (Convert.ToBoolean(ConfigurationManager.AppSettings["PasswordEncrypt"]))
                    this.Password = Star.Security.Cryptography.Text.Decrypt(ConfigurationManager.AppSettings["DBPassword"], ConfigurationManager.AppSettings["DBUsername"]);
                else
                    this.Password = ConfigurationManager.AppSettings["DBPassword"];

                this.ConnectionString = String.Format(ConfigurationManager.ConnectionStrings["Connection"].ConnectionString, this.UserName, this.Password);
                break;
        }

    }

    public object ExecuteScalar(string commandText, CommandType commandType, DataProvider provider)
    {
        object result;
        switch (provider)
        {
            case DataProvider.SqlClient:
                result = ExecuteScalarSQL(commandText, commandType);
                break;
            default:
                result = ExecuteScalarOLE(commandText, commandType);
                break;
        }
        return result;

    }

    private object ExecuteScalarSQL(string commandText, CommandType commandType)
    {
        using (SqlConnection conn = new SqlConnection(this.ConnectionString))
        {
            using (SqlCommand cmd = conn.CreateCommand())
            {
                cmd.CommandType = commandType;
                cmd.CommandText = commandText;

                conn.Open();
                SqlTransaction trans = conn.BeginTransaction();
                try
                {
                    cmd.Transaction = trans;
                    object result = cmd.ExecuteScalar();
                    trans.Commit();
                    return result;
                }
                catch (SqlException ex)
                {
                    trans.Rollback();
                    throw ex;
                }
                finally
                {
                    conn.Close();
                }
            }
        }

    }

    private object ExecuteScalarOLE(string commandText, CommandType commandType)
    {
        using (OleDbConnection conn = new OleDbConnection(this.ConnectionString))
        {
            using (OleDbCommand cmd = conn.CreateCommand())
            {
                cmd.CommandType = commandType;
                cmd.CommandText = commandText;

                conn.Open();
                OleDbTransaction trans = conn.BeginTransaction();
                try
                {
                    cmd.Transaction = trans;
                    object result = cmd.ExecuteScalar();
                    trans.Commit();
                    return result;
                }
                catch (OleDbException ex)
                {
                    trans.Rollback();
                    throw ex;
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }

    private string GetFieldName(string paramField)
    {
        if (!string.IsNullOrEmpty(paramField))
        {
            paramField = paramField.Trim();
            if (paramField.IndexOf(".") > -1)
            {
                paramField = paramField.Substring(paramField.LastIndexOf(".") + 1);
            }
            paramField = paramField.Replace("[", "");
            paramField = paramField.Replace("]", "");
        }
        return paramField;
    }

    public DataView Call(string commandName, string outputParamName, out object outputValue, string paramNames, params object[] values)
    {
        DataView defaultView;
        using (SqlConnection connection = new SqlConnection(this.ConnectionString))
        {
            using (SqlCommand command = connection.CreateCommand())
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = commandName;
                command.CommandTimeout = 0;
                string[] strArray = paramNames.Split(new char[] { ',' });
                for (int i = 0; i < values.Length; i++)
                {
                    if (!string.IsNullOrEmpty(strArray[i]))
                    {
                        command.Parameters.AddWithValue("@" + this.GetFieldName(strArray[i]), (values[i] is string) ? values[i].ToString().Trim() : values[i]);

                    }
                }
                command.Parameters.Add("@" + outputParamName, SqlDbType.Int).Direction = ParameterDirection.Output;
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    DataTable dataTable = new DataTable();
                    try
                    {
                        adapter.Fill(dataTable);
                        outputValue = command.Parameters["@" + outputParamName].Value;
                        defaultView = dataTable.DefaultView;
                    }
                    catch (SqlException exception)
                    {
                        throw exception;
                    }
                    finally
                    {
                        connection.Close();
                        dataTable.Dispose();
                    }
                }
            }
        }
        return defaultView;
    }
    public DataView Call(string commandName, string paramNames, params object[] values)
    {
        DataView defaultView;
        using (SqlConnection connection = new SqlConnection(this.ConnectionString))
        {
            using (SqlCommand command = connection.CreateCommand())
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = commandName;
                command.CommandTimeout = 0;
                string[] strArray = paramNames.Split(new char[] { ',' });
                for (int i = 0; i < values.Length; i++)
                {
                    if (!string.IsNullOrEmpty(strArray[i]))
                    {
                        command.Parameters.AddWithValue("@" + this.GetFieldName(strArray[i]), (values[i] is string) ? values[i].ToString().Trim() : values[i]);
                    }
                }
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    DataTable dataTable = new DataTable();
                    try
                    {
                        adapter.Fill(dataTable);
                        defaultView = dataTable.DefaultView;
                    }
                    catch (SqlException exception)
                    {
                        throw exception;
                    }
                    finally
                    {
                        connection.Close();
                        dataTable.Dispose();
                    }
                }
            }
        }
        return defaultView;
    }
    public int Execute(string commandName, string paramNames, params object[] values)
    {
        int num3;
        using (SqlConnection connection = new SqlConnection(this.ConnectionString))
        {
            using (SqlCommand command = connection.CreateCommand())
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = commandName;
                command.CommandTimeout = 0;
                string[] strArray = paramNames.Split(new char[] { ',' });
                for (int i = 0; i < values.Length; i++)
                {
                    object obj2 = (values[i] is string) ? values[i].ToString().Trim() : values[i];
                    if (obj2 == null)
                    {
                        obj2 = DBNull.Value;
                    }
                    if (!string.IsNullOrEmpty(strArray[i]))
                    {
                        command.Parameters.AddWithValue("@" + this.GetFieldName(strArray[i]), obj2);
                    }
                }
                int num2 = 0;
                connection.Open();
                SqlTransaction transaction = connection.BeginTransaction();
                try
                {
                    command.Transaction = transaction;
                    num2 = command.ExecuteNonQuery();
                    transaction.Commit();
                    num3 = num2;
                }
                catch (SqlException exception)
                {
                    transaction.Rollback();
                    throw exception;
                }
                finally
                {
                    connection.Close();
                }
            }
        }
        return num3;
    }

}

public enum DataProvider
{
    OleDb = 0,
    SqlClient = 1,
    OracleClient = 2
}


/*
public class Connection : Star.Data.SqlClient
{
    public Connection():base()
    {
        this.Owner = ConfigurationManager.AppSettings["DBOwner"];
        this.UserName = ConfigurationManager.AppSettings["DBUsername"];
        if (Convert.ToBoolean(ConfigurationManager.AppSettings["PasswordEncrypt"]))
        {
            this.Password = Star.Security.Cryptography.Text.Decrypt(ConfigurationManager.AppSettings["DBPassword"], ConfigurationManager.AppSettings["DBPassword"]);
        }
        else
        {
            this.Password = ConfigurationManager.AppSettings["DBPassword"];
        }
        this.ConnectionString = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
    }

    public Connection(string connectionstring) : base(connectionstring)
    {
        this.Owner = ConfigurationManager.AppSettings["DBOwner"];
        this.UserName = ConfigurationManager.AppSettings["DBUsername"];
        if (Convert.ToBoolean(ConfigurationManager.AppSettings["PasswordEncrypt"]))
            this.Password = Star.Security.Cryptography.Text.Decrypt(ConfigurationManager.AppSettings["DBPassword"], ConfigurationManager.AppSettings["DBPassword"]);
        else
            this.Password = ConfigurationManager.AppSettings["DBPassword"];
    }
}

public class ScriptSQL
{
    public int Execute(string commandString)
    {
        string UserName = ConfigurationManager.AppSettings["DBUsername"];
        string Password = ConfigurationManager.AppSettings["DBPassword"];
        if (Convert.ToBoolean(ConfigurationManager.AppSettings["PasswordEncrypt"]))
        {
            Password = Star.Security.Cryptography.Text.Decrypt(ConfigurationManager.AppSettings["DBPassword"], ConfigurationManager.AppSettings["DBUsername"]);
        }
        string connectionString = String.Format(ConfigurationManager.ConnectionStrings["Connection"].ConnectionString, UserName, Password);

        SqlConnection sqlCon = new SqlConnection(connectionString);
        sqlCon.Open();

        SqlCommand sqlCmd = new SqlCommand(commandString, sqlCon);
        int result = 0;
        sqlCmd.CommandTimeout = 5000;
        try
        {
            result = sqlCmd.ExecuteNonQuery();
        }
        catch
        {
        }
        sqlCon.Close();
        return result;
    }
    public DataView Select(string commandString)
    {
        string UserName = ConfigurationManager.AppSettings["DBUsername"];
        string Password = ConfigurationManager.AppSettings["DBPassword"];
        if (Convert.ToBoolean(ConfigurationManager.AppSettings["PasswordEncrypt"]))
        {
            Password = Star.Security.Cryptography.Text.Decrypt(ConfigurationManager.AppSettings["DBPassword"], ConfigurationManager.AppSettings["DBUsername"]);
        }
        string connectionString = String.Format(ConfigurationManager.ConnectionStrings["Connection"].ConnectionString, UserName, Password);

        SqlConnection sqlCon = new SqlConnection(connectionString);
        sqlCon.Open();

        SqlDataReader sqlReader = null;
        SqlCommand sqlCmd = new SqlCommand(commandString, sqlCon);
        DataTable dt = new DataTable();
        sqlCmd.CommandTimeout = 5000;
        try
        {
            sqlReader = sqlCmd.ExecuteReader();
            dt.Load(sqlReader);
        }
        catch
        {
        }
        sqlCon.Close();
        return dt.DefaultView;
    }
}

*/
