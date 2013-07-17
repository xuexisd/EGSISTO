using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EssoModel
{
    public class OrderProductModel
    {
        public int ORDER_PRODUCT_ID { get; set; }
        public string ORDER_NUMBER { get; set; }
        public int PRODUCT_ID { get; set; }
        public string ORDER_PRODUCT_NAME { get; set; }
        public decimal ORDER_PRODUCT_PRICE { get; set; }
        public int ORDER_PRODUCT_QUANTITY { get; set; }
        public string ORDER_PRODUCT_REMARKS { get; set; }
        public string ORDER_PRODUCT_CREATE_DT { get; set; }
        public string ORDER_PRODUCT_LASTUPDATE_DT { get; set; }
    }
}
