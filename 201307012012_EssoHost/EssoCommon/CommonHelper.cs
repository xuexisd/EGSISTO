using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Configuration;

namespace EssoCommon
{
    public class CommonHelper
    {
        public const string LogLine = @"========================================================================";
        public static void LogException(List<string> exceptionContent)
        {
            string filePath = ConfigurationManager.AppSettings["EssoHostPath"].ToString();
            string fileName = "Log_" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt";
            string fullFilePath = filePath + fileName;
            if (!File.Exists(fullFilePath))
            {
                File.Create(fullFilePath).Close();
            }
            File.AppendAllLines(fullFilePath, exceptionContent, UTF8Encoding.UTF8);
        }
    }
}
