using EssoCommon;
using EssoContract;
using EssoModel;
using Sunny.DataManipulation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EssoDA
{
    //[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class UserDA : IUser
    {
        public UserModel GetUserDetail(string userName, string userPWD)
        {
            UserModel model = new UserModel();
            try
            {
                SqlHelper helper = new SqlHelper();
                var sqlReader = helper.ExecuteReader("P_USER_DETAIL_GET", userName, userPWD);
                model = (new ModelHelper<UserModel>()).SqlReaderToModelWithString(sqlReader);
            }
            catch (Exception ex)
            {
                model.USER_PWD = @"[ERROR]: " + ex.Message.Substring(0, ex.Message.Length > 190 ? 190 : ex.Message.Length);
            }
            if (string.IsNullOrEmpty(model.USER_NAME) && string.IsNullOrEmpty(model.USER_PWD))
                model = null;
            return model;
        }

        public UserModel RegisterUser(UserModel user)
        {
            SqlHelper helper = new SqlHelper();
            UserModel model = new UserModel();

            try
            {
                int i = 0; i = i / i;
                if (IsExistUser(user.USER_NAME) == 0)
                {
                    helper.ExecuteNonQuery("P_User_I", user.USER_NAME, user.USER_PWD, user.USER_FULLNAME, user.USER_GENDER, user.USER_BIRTHDAY, user.USER_EMAIL, user.USER_PHONENUM);

                    var sqlReader = helper.ExecuteReader("P_USER_DETAIL_GET", user.USER_NAME, user.USER_PWD);
                    model = (new ModelHelper<UserModel>()).SqlReaderToModelWithString(sqlReader);
                }
                else
                {
                    model = null;
                }
            }
            catch (Exception ex)
            {
                CommonHelper.LogException(new List<string>() { "[Date]--->" + DateTime.Now, "[Message]--->" + ex.Message, "[StackTrace]--->" + ex.StackTrace, CommonHelper.LogLine });
                model.USER_PWD = @"[ERROR]: " + ex.Message.Substring(0, ex.Message.Length > 190 ? 190 : ex.Message.Length);
            }
            return model;
        }

        public int IsExistUser(string userName)
        {
            int retIsExist = 99;
            SqlHelper helper = new SqlHelper();
            var sqlReader = helper.ExecuteReader("P_User_IsExist", userName);
            while (sqlReader.Read())
            {
                retIsExist = sqlReader[0].ToString().Equals("0") ? 0 : 1;
            }
            if (!sqlReader.IsClosed)
                sqlReader.Close();

            return retIsExist;
        }
    }
}
