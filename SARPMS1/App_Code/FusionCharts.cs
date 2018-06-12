using System;
using System.Data;
using System.Text;

namespace Graph
{
	/// <summary>
	/// Summary description for FusionCharts.
	/// </summary>
	public class FusionCharts
	{
		/// <summary>
		/// encodes the dataURL before it's served to FusionCharts
		/// If you have parameters in your dataURL, you'll necessarily need to encode it
		/// </summary>
		/// <param name="dataURL">dataURL to be fed to chart</param>
		/// <param name="noCacheStr">Whether to add aditional string to URL to disable caching of data</param>
		/// <returns>Encoded dataURL, ready to be consumed by FusionCharts</returns>
		public static string EncodeDataURL (string dataURL, bool noCacheStr)
		{
			string result = dataURL;
			if (noCacheStr)
			{
				result += (dataURL.IndexOf("?") != -1) ? "&" : "?";
				//Replace : in time with _, as FusionCharts cannot handle : in URLs
				result += "FCCurrTime=" + DateTime.Now.ToString().Replace(":", "_");
			}

			return System.Web.HttpUtility.UrlEncode(result);
		}

		/// <summary>
		/// Generate html code for rendering chart
		/// This function assumes that you've already included the FusionCharts JavaScript class in your page
		/// </summary>
		/// <param name="chartSWF">SWF File Name (and Path) of the chart which you intend to plot</param>
		/// <param name="strURL">If you intend to use dataURL method for this chart, pass the URL as this parameter. Else, set it to "" (in case of dataXML method)</param>
		/// <param name="strXML">If you intend to use dataXML method for this chart, pass the XML data as this parameter. Else, set it to "" (in case of dataURL method)</param>
		/// <param name="chartId">Id for the chart, using which it will be recognized in the HTML page. Each chart on the page needs to have a unique Id.</param>
		/// <param name="chartWidth">Intended width for the chart (in pixels)</param>
		/// <param name="chartHeight">Intended height for the chart (in pixels)</param>
		/// <param name="debugMode">Whether to start the chart in debug mode</param>
		/// <param name="registerWithJS">Whether to ask chart to register itself with JavaScript</param>
		/// <returns>JavaScript + HTML code required to embed a chart</returns>
		public static string RenderChart(string chartSWF, string strURL, string strXML, string chartId, 
			string chartWidth, string chartHeight, bool debugMode, bool registerWithJS)
		{
			StringBuilder builder = new StringBuilder();

			builder.AppendFormat("<!-- START Script Block for Chart {0} -->" + Environment.NewLine, chartId);
			builder.AppendFormat("<div id='{0}Div' align='center'>" + Environment.NewLine, chartId );
			builder.Append("Chart." + Environment.NewLine);
			builder.Append("</div>" + Environment.NewLine);
			builder.Append("<script type=\"text/javascript\">" + Environment.NewLine);
			builder.AppendFormat("var chart_{0} = new FusionCharts(\"{1}\", \"{0}\", \"{2}\", \"{3}\", \"{4}\", \"{5}\");" + Environment.NewLine, chartId, chartSWF, chartWidth, chartHeight, boolToNum(debugMode), boolToNum(registerWithJS));
			if (strXML.Length == 0)
			{
				builder.AppendFormat("chart_{0}.setDataURL(\"{1}\");" + Environment.NewLine, chartId, strURL);
			}
			else
			{
				builder.AppendFormat("chart_{0}.setDataXML(\"{1}\");" + Environment.NewLine, chartId, strXML);
			}
			
			
			builder.AppendFormat("chart_{0}.render(\"{1}Div\");" + Environment.NewLine, chartId, chartId);
			builder.Append("</script>" + Environment.NewLine);
			builder.AppendFormat("<!-- END Script Block for Chart {0} -->" + Environment.NewLine, chartId);
			return builder.ToString();
		}

		/// <summary>
		/// Renders the HTML code for the chart. This
		/// method does NOT embed the chart using JavaScript class. Instead, it uses
		/// direct HTML embedding. So, if you see the charts on IE 6 (or above), you'll
		/// see the "Click to activate..." message on the chart.
		/// </summary>
		/// <param name="chartSWF">SWF File Name (and Path) of the chart which you intend to plot</param>
		/// <param name="strURL">If you intend to use dataURL method for this chart, pass the URL as this parameter. Else, set it to "" (in case of dataXML method)</param>
		/// <param name="strXML">If you intend to use dataXML method for this chart, pass the XML data as this parameter. Else, set it to "" (in case of dataURL method)</param>
		/// <param name="chartId">Id for the chart, using which it will be recognized in the HTML page. Each chart on the page needs to have a unique Id.</param>
		/// <param name="chartWidth">Intended width for the chart (in pixels)</param>
		/// <param name="chartHeight">Intended height for the chart (in pixels)</param>
		/// <param name="debugMode">Whether to start the chart in debug mode</param>
		/// <returns></returns>
		public static string RenderChartHTML(string chartSWF, string strURL, string strXML, string chartId, 
			string chartWidth, string chartHeight, bool debugMode)
		{
			//Generate the FlashVars string based on whether dataURL has been provided
			//or dataXML.
			StringBuilder strFlashVars = new StringBuilder();
			string flashVariables = String.Empty;
			if (strXML.Length == 0)
			{
				//DataURL Mode
				flashVariables = String.Format("&chartWidth={0}&chartHeight={1}&debugMode={2}&dataURL={3}", chartWidth, chartHeight, boolToNum(debugMode),strURL);
			}
			else
				//DataXML Mode
			{
				flashVariables = String.Format("&chartWidth={0}&chartHeight={1}&debugMode={2}&dataXML={3}", chartWidth,chartHeight,boolToNum(debugMode),strXML);
			}
			
			strFlashVars.AppendFormat("<!-- START Code Block for Chart {0} -->" + Environment.NewLine, chartId);
			strFlashVars.AppendFormat("<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0\" width=\"{0}\" height=\"{1}\" name=\"{2}\">" + Environment.NewLine, chartWidth,chartHeight, chartId);
			strFlashVars.Append("<param name=\"allowScriptAccess\" value=\"always\" />" + Environment.NewLine);
			strFlashVars.AppendFormat("<param name=\"movie\" value=\"{0}\"/>" + Environment.NewLine, chartSWF);
			strFlashVars.AppendFormat("<param name=\"FlashVars\" value=\"{0}\" />" + Environment.NewLine, flashVariables);
			strFlashVars.Append("<param name=\"quality\" value=\"high\" />" + Environment.NewLine);
			strFlashVars.AppendFormat("<embed src=\"{0}\" FlashVars=\"{1}\" quality=\"high\" width=\"{2}\" height=\"{3}\" name=\"{4}\"  allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />" + Environment.NewLine, chartSWF,flashVariables,chartWidth,chartHeight,chartId);
			strFlashVars.Append("</object>" + Environment.NewLine);
			strFlashVars.AppendFormat("<!-- END Code Block for Chart {0} -->" + Environment.NewLine, chartId);
											
			return strFlashVars.ToString();
		}

		/// <summary>
		/// Transform the meaning of boolean value in integer value
		/// </summary>
		/// <param name="value">true/false value to be transformed</param>
		/// <returns>1 if the value is true, 0 if the value is false</returns>
		private static int boolToNum(bool value)
		{
			return value ? 1 : 0;			
		}

	}

    /// <summary>
    /// Summary description for Functions.
    /// </summary>
    public class Functions
    {
        //If you're using UTF-8 characters in your XML, you need to use this 
        //streamwriter object to output the XML.		
        private System.IO.StreamWriter writer = new System.IO.StreamWriter(System.Web.HttpContext.Current.Response.OutputStream, System.Text.Encoding.UTF8);

        //escapeXML function helps you escape special characters in XML
        public static string EscapeXML(string item, bool forDataURL)
        {
            //Convert ' to &apos; if dataURL
            if (forDataURL)
            {
                item = item.Replace("'", "&apos;");
            }
            else
            {
                //Else for dataXML 		
                //Convert % to %25
                item = item.Replace("%", "%25");
                //Convert ' to %26apos;
                item = item.Replace("'", "%26apos;");
                //Convert & to %26
                item = item.Replace("&", "%26");
            }
            //Common replacements
            item = item.Replace("<", "&lt;");
            item = item.Replace(">", "&gt;");
            //We've not considered any special characters here. 
            //You can add them as per your language and requirements.
            //Return
            return item;
        }

        //getPalette method returns a value between 1-5 depending on which
        //paletter the user wants to plot the chart with. 
        //Here, we just read from Session variable and show it
        //In your application, you could read this configuration from your 
        //User Configuration Manager, database, or global application settings
        public static string GetPalette()
        {
            string palette = String.Empty;
            if (System.Web.HttpContext.Current.Session["palette"] == null ||
                System.Web.HttpContext.Current.Session["palette"].ToString() == String.Empty)
                palette = "2";
            else
                palette = System.Web.HttpContext.Current.Session["palette"].ToString();

            return palette;
        }

        //getAnimationState returns 0 or 1, depending on whether we've to																								
        //animate chart. Here, we just read from Session variable and show it
        //In your application, you could read this configuration from your 
        //User Configuration Manager, database, or global application settings
        public static string GetAnimationState()
        {
            string animation = String.Empty;
            if (System.Web.HttpContext.Current.Session["animation"] != null &&
                System.Web.HttpContext.Current.Session["animation"].ToString() != "0")
                animation = "1";
            else
                animation = "0";
            return animation;
        }

        //getCaptionFontColor function returns a color code for caption. Basic
        //idea to use this is to demonstrate how to centralize your cosmetic 
        //attributes for the chart
        public static string getCaptionFontColor
        {
            get
            {
                //Return a hex color code without #
                return "666666";
                //FFC30C - Yellow Color
            }
        }

        public static string GetDecimal(decimal value)
        {
            string result = value.ToString("F");
            if (result.IndexOf(",") > -1)
                result = result.Replace(",", ".");
            return result;
        }

        public static string GetMonthName(int monthNumber)
        {
            string result = String.Empty;
            switch (monthNumber)
            {
                case 1:
                    result = "January";
                    break;
                case 2:
                    result = "February";
                    break;
                case 3:
                    result = "March";
                    break;
                case 4:
                    result = "April";
                    break;
                case 5:
                    result = "May";
                    break;
                case 6:
                    result = "June";
                    break;
                case 7:
                    result = "July";
                    break;
                case 8:
                    result = "August";
                    break;
                case 9:
                    result = "September";
                    break;
                case 10:
                    result = "October";
                    break;
                case 11:
                    result = "November";
                    break;
                case 12:
                    result = "December";
                    break;
                default:
                    break;
            }

            return result;
        }

        //If you've UTF-8 characters in your XML, you should use this
        //method to output the XML.
        public void Write(string stringForOutput)
        {
            writer.Write(stringForOutput);
            writer.Flush();
        }
    }
}
