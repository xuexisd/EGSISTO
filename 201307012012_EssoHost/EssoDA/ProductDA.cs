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
                    #region ALL
                    //listModel.Add(new ProductModel()
                    //{
                    //    PRODUCT_ID = int.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_ID"].ToString()),
                    //    PRODUCT_CATEGORY = productCategory,
                    //    PRODUCT_NAME = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_NAME"].ToString(),
                    //    PRODUCT_TITLE = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_TITLE"].ToString(),
                    //    PRODUCT_DESC = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_DESC"].ToString(),
                    //    PRODUCT_IMG1 = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG1"].ToString(),
                    //    PRODUCT_IMG2 = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG2"].ToString(),
                    //    PRODUCT_IMG_AD = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_AD"].ToString(),
                    //    PRODUCT_PRICE = decimal.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_PRICE"].ToString()),
                    //    PRODUCT_VERSION = int.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_VERSION"].ToString()),
                    //    PRODUCT_CREATE_ON = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_CREATE_ON"].ToString(),
                    //    PRODUCT_IMG_IS_AD =
                    //    (ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_IS_AD"] == null
                    //    || string.IsNullOrEmpty(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_IS_AD"].ToString()))
                    //    ? 0 : int.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_IS_AD"].ToString()),
                    //    PRODUCT_SIZE = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_SIZE"].ToString(),
                    //    PRODUCT_TEMPERATURE = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_TEMPERATURE"].ToString(),
                    //    PRODUCT_REMARKS = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_REMARKS"].ToString()
                    //});
                    #endregion
                    listModel.Add(new ProductModel()
                    {
                        PRODUCT_ID = int.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_ID"].ToString()),
                        PRODUCT_CATEGORY = productCategory,
                        PRODUCT_NAME = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_NAME"].ToString(),
                        PRODUCT_TITLE = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_TITLE"].ToString(),
                        PRODUCT_IMG1 = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG1"].ToString(),
                        PRODUCT_PRICE = decimal.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_PRICE"].ToString())
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

        public List<ProductModel> GetProductHome()
        {
            List<ProductModel> listModel = new List<ProductModel>();
            try
            {
                SqlHelper helper = new SqlHelper();
                DataSet ds = new DataSet();
                ds.Tables.Add("GetProductHome");
                helper.FillDataset("P_PRODUCT_S_HOME", ds.Tables["GetProductHome"]);
                for (int i = 0; i < ds.Tables["GetProductHome"].Rows.Count; i++)
                {
                    #region ALL
                    //listModel.Add(new ProductModel()
                    //{
                    //    PRODUCT_ID = int.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_ID"].ToString()),
                    //    PRODUCT_CATEGORY = productCategory,
                    //    PRODUCT_NAME = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_NAME"].ToString(),
                    //    PRODUCT_TITLE = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_TITLE"].ToString(),
                    //    PRODUCT_DESC = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_DESC"].ToString(),
                    //    PRODUCT_IMG1 = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG1"].ToString(),
                    //    PRODUCT_IMG2 = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG2"].ToString(),
                    //    PRODUCT_IMG_AD = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_AD"].ToString(),
                    //    PRODUCT_PRICE = decimal.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_PRICE"].ToString()),
                    //    PRODUCT_VERSION = int.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_VERSION"].ToString()),
                    //    PRODUCT_CREATE_ON = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_CREATE_ON"].ToString(),
                    //    PRODUCT_IMG_IS_AD =
                    //    (ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_IS_AD"] == null
                    //    || string.IsNullOrEmpty(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_IS_AD"].ToString()))
                    //    ? 0 : int.Parse(ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_IMG_IS_AD"].ToString()),
                    //    PRODUCT_SIZE = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_SIZE"].ToString(),
                    //    PRODUCT_TEMPERATURE = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_TEMPERATURE"].ToString(),
                    //    PRODUCT_REMARKS = ds.Tables["GetProductByRowNumber"].Rows[i]["PRODUCT_REMARKS"].ToString()
                    //});
                    #endregion
                    listModel.Add(new ProductModel()
                    {
                        PRODUCT_ID = int.Parse(ds.Tables["GetProductHome"].Rows[i]["PRODUCT_ID"].ToString()),
                        PRODUCT_CATEGORY = ds.Tables["GetProductHome"].Rows[i]["PRODUCT_CATEGORY"].ToString(),
                        PRODUCT_NAME = ds.Tables["GetProductHome"].Rows[i]["PRODUCT_NAME"].ToString(),
                        PRODUCT_TITLE = ds.Tables["GetProductHome"].Rows[i]["PRODUCT_TITLE"].ToString(),
                        PRODUCT_IMG1 = ds.Tables["GetProductHome"].Rows[i]["PRODUCT_IMG1"].ToString(),
                        PRODUCT_PRICE = decimal.Parse(ds.Tables["GetProductHome"].Rows[i]["PRODUCT_PRICE"].ToString())
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

        public ProductModel GetProductById(string pId)
        {
            ProductModel model = new ProductModel();
            try
            {
                SqlHelper helper = new SqlHelper();
                DataSet ds = new DataSet();
                ds.Tables.Add("GetProductById");
                helper.FillDataset("P_PRODUCT_S_HOME", ds.Tables["GetProductById"]);

                if (ds.Tables["GetProductById"].Rows.Count == 1)
                {
                    model.PRODUCT_ID = int.Parse(ds.Tables["GetProductById"].Rows[0]["PRODUCT_ID"].ToString());
                    model.PRODUCT_CATEGORY = ds.Tables["GetProductById"].Rows[0]["PRODUCT_CATEGORY"].ToString();
                    model.PRODUCT_NAME = ds.Tables["GetProductById"].Rows[0]["PRODUCT_NAME"].ToString();
                    model.PRODUCT_TITLE = ds.Tables["GetProductById"].Rows[0]["PRODUCT_TITLE"].ToString();
                    model.PRODUCT_DESC = ds.Tables["GetProductById"].Rows[0]["PRODUCT_DESC"].ToString();
                    model.PRODUCT_IMG1 = ds.Tables["GetProductById"].Rows[0]["PRODUCT_IMG1"].ToString();
                    model.PRODUCT_IMG2 = ds.Tables["GetProductById"].Rows[0]["PRODUCT_IMG2"].ToString();
                    model.PRODUCT_IMG_AD = ds.Tables["GetProductById"].Rows[0]["PRODUCT_IMG_AD"].ToString();
                    model.PRODUCT_PRICE = decimal.Parse(ds.Tables["GetProductById"].Rows[0]["PRODUCT_PRICE"].ToString());
                    model.PRODUCT_VERSION = int.Parse(ds.Tables["GetProductById"].Rows[0]["PRODUCT_VERSION"].ToString());
                    model.PRODUCT_CREATE_ON = ds.Tables["GetProductById"].Rows[0]["PRODUCT_CREATE_ON"].ToString();
                    model.PRODUCT_IMG_IS_AD =
                    (ds.Tables["GetProductById"].Rows[0]["PRODUCT_IMG_IS_AD"] == null
                    || string.IsNullOrEmpty(ds.Tables["GetProductById"].Rows[0]["PRODUCT_IMG_IS_AD"].ToString()))
                    ? 0 : int.Parse(ds.Tables["GetProductById"].Rows[0]["PRODUCT_IMG_IS_AD"].ToString());
                    model.PRODUCT_SIZE = ds.Tables["GetProductById"].Rows[0]["PRODUCT_SIZE"].ToString();
                    model.PRODUCT_TEMPERATURE = ds.Tables["GetProductById"].Rows[0]["PRODUCT_TEMPERATURE"].ToString();
                    model.PRODUCT_REMARKS = ds.Tables["GetProductById"].Rows[0]["PRODUCT_REMARKS"].ToString();
                }
            }
            catch (Exception ex)
            {
                CommonHelper.LogException(new List<string>() { "[Date]--->" + DateTime.Now, "[Message]--->" + ex.Message, "[StackTrace]--->" + ex.StackTrace, CommonHelper.LogLine });
                model.PRODUCT_DESC = @"[ERROR]: " + ex.Message.Substring(0, ex.Message.Length > 1000 ? 999 : ex.Message.Length);
            }
            return model;
        }
    }
}
