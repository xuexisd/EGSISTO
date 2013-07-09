using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EssoModel
{
    public class ProductModel
    {
        public int PRODUCT_ID { get; set; }
        public string PRODUCT_CATEGORY { get; set; }
        public string PRODUCT_NAME { get; set; }
        public string PRODUCT_TITLE { get; set; }
        public string PRODUCT_DESC { get; set; }
        public string PRODUCT_IMG1 { get; set; }
        public string PRODUCT_IMG2 { get; set; }
        public decimal PRODUCT_PRICE { get; set; }
        public int PRODUCT_VERSION { get; set; }
        public string PRODUCT_CREATE_ON { get; set; }
    }
}
