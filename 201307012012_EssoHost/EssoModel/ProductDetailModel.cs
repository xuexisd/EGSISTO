using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EssoModel
{
    public class ProductDetailModel
    {
        public int PRODUCT_DETAIL_ID { get; set; }
        public int PRODUCT_ID { get; set; }
        public decimal PRODUCT_DETAIL_PRICE { get; set; }
        public string PRODUCT_DETAIL_SIZE { get; set; }
        public string PRODUCT_DETAIL_TEMPERATURE { get; set; }
    }
}
