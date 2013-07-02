using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EssoModel
{
    public class UserModel
    {
        public Guid USER_ID { get; set; }
        public string USER_NAME { get; set; }
        public string USER_PWD { get; set; }
        public string USER_FULLNAME { get; set; }
        public string USER_GENDER { get; set; }
        public string USER_BIRTHDAY { get; set; }
        public string USER_EMAIL { get; set; }
        public string USER_PHONENUM { get; set; }
    }
}
