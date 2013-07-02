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
    }
}
