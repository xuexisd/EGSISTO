using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EssoModel
{
    public class OrderAddModel
    {
        public int PRODUCT_ID { get; set; }
        public string ORDER_PRODUCT_NAME { get; set; }
        public decimal ORDER_PRODUCT_PRICE { get; set; }
        public int ORDER_PRODUCT_QUANTITY { get; set; }
        public string ORDER_PRODUCT_REMARKS { get; set; }
        public string ORDER_OWNER { get; set; }
    }
}
