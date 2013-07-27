using EssoCommon;
using EssoContract;
using EssoModel;
using Sunny.DataManipulation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace EssoDA
{
    public class ProductDA : IProduct
    {
        public List<ProductModel> GetProductTopFive()
        {
            List<ProductModel> listModel = new List<ProductModel>();
            try
            {
                SqlHelper helper = new SqlHelper();
                DataSet ds = new DataSet();
                ds.Tables.Add("ProductTopFive");
                helper.FillDataset("P_PRODUCT_GET_LAST_FIVE", ds.Tables["ProductTopFive"]);
                for (int i = 0; i < ds.Tables["ProductTopFive"].Rows.Count; i++)
                {
                    listModel.Add(new ProductModel()
                        {
                            PRODUCT_ID = int.Parse(ds.Tables["ProductTopFive"].Rows[i]["PRODUCT_ID"].ToString()),
                            PRODUCT_NAME = ds.Tables["ProductTopFive"].Rows[i]["PRODUCT_NAME"].ToString(),
                            PRODUCT_IMG_AD = ds.Tables["ProductTopFive"].Rows[i]["PRODUCT_IMG_AD"].ToString(),
                            PRODUCT_VERSION = int.Parse(ds.Tables["ProductTopFive"].Rows[i]["PRODUCT_VERSION"].ToString())
                        });
                }
            }
            catch (Exception ex)
            {
                CommonHelper.LogException(new List<string>() { "[Date]--->" + DateTime.Now, "[Message]--->" + ex.Message, "[StackTrace]--->" + ex.StackTrace, CommonHelper.LogLine });
                listModel.Add(new ProductModel() { PRODUCT_DESC = @"[ERROR]: " + ex.Message.Substring(0, ex.Message.Length > 1000 ? 999 : ex.Message.Length) });
            }
            return listModel;
        }

        public List<ProductModel> GetProductByRowNumber(string productCategory, int lastRow)
        {
            List<ProductModel> listModel = new List<ProductModel>();
            try
            {
                SqlHelper helper = new SqlHelper();
                DataSet ds = new DataSet();
                ds.Tables.Add("GetProductByRowNumber");
                helper.FillDataset("P_PRODUCT_S_BY_ROWNUMBER", ds.Tables["GetProductByRowNumber"], productCategory, lastRow);
                for (int i = 0; i < ds.Tables["GetProductByRowNumber"].Rows.Count; i++)
                {
                    listModel.Add(new ProductModel()
                    {
                        PRODUCT_ID = int.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_ID"].ToString()),
                        PRODUCT_CATEGORY = productCategory,
                        PRODUCT_NAME = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_NAME"].ToString(),
                        PRODUCT_TITLE = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_TITLE"].ToString(),
                        PRODUCT_DESC = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_DESC"].ToString(),
                        PRODUCT_IMG1 = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG1"].ToString(),
                        PRODUCT_IMG2 = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG2"].ToString(),
                        PRODUCT_IMG_AD = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_AD"].ToString(),
                        PRODUCT_PRICE = decimal.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_PRICE"].ToString()),
                        PRODUCT_VERSION = int.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_VERSION"].ToString()),
                        PRODUCT_CREATE_ON = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_CREATE_ON"].ToString(),
                        PRODUCT_IMG_IS_AD =
                        (ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_IS_AD"] == null
                        || string.IsNullOrEmpty(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_IS_AD"].ToString()))
                        ? 0 : int.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_IS_AD"].ToString())
                    });
                }
            }
            catch (Exception ex)
            {
                CommonHelper.LogException(new List<string>() { "[Date]--->" + DateTime.Now, "[Message]--->" + ex.Message, "[StackTrace]--->" + ex.StackTrace, CommonHelper.LogLine });
                listModel.Add(new ProductModel() { PRODUCT_DESC = @"[ERROR]: " + ex.Message.Substring(0, ex.Message.Length > 1000 ? 999 : ex.Message.Length) });
            }
            return listModel;
        }
    }
}
