using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EssoModel
{
    public class OrderModel
    {
        public int ORDER_ID { get; set; }
        public Guid ORDER_GUID { get; set; }
        public string ORDER_NUMBER { get; set; }
        public decimal ORDER_TOTAL_PRICE { get; set; }
        public string ORDER_STATUS { get; set; }
        public string ORDER_OWNER { get; set; }
        public string ORDER_CREATE_DT { get; set; }
        public string ORDER_LASTUPDATE_DT { get; set; }
    }
}
