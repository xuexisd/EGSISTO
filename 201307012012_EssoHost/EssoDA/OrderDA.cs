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
    public class OrderDA : IOrder
    {
        public OrderModel AddOrder(List<OrderAddModel> order)
        {
            SqlHelper helper = new SqlHelper();
            Guid orderGuid = Guid.NewGuid();
            OrderModel retModel = new OrderModel();

            try
            {
                //1. add order
                decimal totalPrice = 0;
                foreach (OrderAddModel model in order)
                {
                    totalPrice += (model.ORDER_PRODUCT_PRICE * model.ORDER_PRODUCT_QUANTITY);
                }
                helper.ExecuteNonQuery("P_ORDER_I", orderGuid, order[0].ORDER_OWNER, totalPrice);

                //2. add product list in order.
                var sqlReader = helper.ExecuteReader("P_ORDER_S_BY_ORDER_GUID", orderGuid);
                if (sqlReader.HasRows)
                {
                    retModel = (new ModelHelper<OrderModel>()).SqlReaderToModelWithString(sqlReader);
                    foreach (OrderAddModel model in order)
                    {
                        helper.ExecuteNonQuery("P_ORDER_PRODUCT_I", retModel.ORDER_NUMBER, model.PRODUCT_ID
                            , model.ORDER_PRODUCT_NAME, model.ORDER_PRODUCT_PRICE, model.ORDER_PRODUCT_QUANTITY, model.ORDER_PRODUCT_REMARKS);
                    }
                }
                else
                    retModel = null;

            }
            catch (Exception ex)
            {
                CommonHelper.LogException(new List<string>() { "[Date]--->" + DateTime.Now, "[Message]--->" + ex.Message, "[StackTrace]--->" + ex.StackTrace, CommonHelper.LogLine });
                retModel.ORDER_STATUS = @"[ERROR]: " + ex.Message.Substring(0, ex.Message.Length > 50 ? 49 : ex.Message.Length);
            }
            return retModel;
        }

        public List<OrderModel> GetOrderByOwner(string owner)
        {
            List<OrderModel> listModel = new List<OrderModel>();
            try
            {
                SqlHelper helper = new SqlHelper();
                DataSet ds = new DataSet();
                ds.Tables.Add("GetOrderByOwner");
                helper.FillDataset("P_ORDER_S_BY_OWNER", ds.Tables["GetOrderByOwner"]);
                for (int i = 0; i < ds.Tables["GetOrderByOwner"].Rows.Count; i++)
                {
                    listModel.Add(new OrderModel()
                    {
                        ORDER_ID = int.Parse(ds.Tables["GetOrderByOwner"].Rows[i]["ORDER_ID"].ToString()),
                        ORDER_GUID = Guid.Parse(ds.Tables["GetOrderByOwner"].Rows[i]["ORDER_GUID"].ToString()),
                        ORDER_NUMBER = ds.Tables["GetOrderByOwner"].Rows[i]["ORDER_NUMBER"].ToString(),
                        ORDER_TOTAL_PRICE = decimal.Parse(ds.Tables["GetOrderByOwner"].Rows[i]["ORDER_TOTAL_PRICE"].ToString()),
                        ORDER_STATUS = ds.Tables["GetOrderByOwner"].Rows[i]["ORDER_STATUS"].ToString(),
                        ORDER_OWNER = ds.Tables["GetOrderByOwner"].Rows[i]["ORDER_OWNER"].ToString(),
                        ORDER_CREATE_DT = ds.Tables["GetOrderByOwner"].Rows[i]["ORDER_CREATE_DT"].ToString()
                        //ORDER_LASTUPDATE_DT = ds.Tables["GetOrderByOwner"].Rows[i]["ORDER_LASTUPDATE_DT"].ToString()
                    });
                }
            }
            catch (Exception ex)
            {
                CommonHelper.LogException(new List<string>() { "[Date]--->" + DateTime.Now, "[Message]--->" + ex.Message, "[StackTrace]--->" + ex.StackTrace, CommonHelper.LogLine });
                listModel.Add(new OrderModel() { ORDER_STATUS = @"[ERROR]: " + ex.Message.Substring(0, ex.Message.Length > 50 ? 49 : ex.Message.Length) });
            }

            return listModel;
        }

        public List<OrderProductModel> GetOrderProductByOrderNumber(string orderNumber)
        {
            List<OrderProductModel> listModel = new List<OrderProductModel>();

            try
            {
                SqlHelper helper = new SqlHelper();
                DataSet ds = new DataSet();
                ds.Tables.Add("GetOrderProductByOrderNumber");
                helper.FillDataset("P_ORDER_PRODUCT_S_BY_ORDER_NUMBER", ds.Tables["GetOrderProductByOrderNumber"]);
                for (int i = 0; i < ds.Tables["GetOrderProductByOrderNumber"].Rows.Count; i++)
                {
                    listModel.Add(new OrderProductModel()
                    {
                        ORDER_PRODUCT_ID = int.Parse(ds.Tables["GetOrderProductByOrderNumber"].Rows[i]["ORDER_PRODUCT_ID"].ToString()),
                        ORDER_NUMBER = ds.Tables["GetOrderProductByOrderNumber"].Rows[i]["ORDER_NUMBER"].ToString(),
                        PRODUCT_ID = int.Parse(ds.Tables["GetOrderProductByOrderNumber"].Rows[i]["PRODUCT_ID"].ToString()),
                        ORDER_PRODUCT_NAME = ds.Tables["GetOrderProductByOrderNumber"].Rows[i]["ORDER_PRODUCT_NAME"].ToString(),
                        ORDER_PRODUCT_PRICE = decimal.Parse(ds.Tables["GetOrderProductByOrderNumber"].Rows[i]["ORDER_PRODUCT_PRICE"].ToString()),
                        ORDER_PRODUCT_QUANTITY = int.Parse(ds.Tables["GetOrderProductByOrderNumber"].Rows[i]["ORDER_PRODUCT_QUANTITY"].ToString()),
                        ORDER_PRODUCT_REMARKS = ds.Tables["GetOrderProductByOrderNumber"].Rows[i]["ORDER_PRODUCT_REMARKS"].ToString(),
                        ORDER_PRODUCT_CREATE_DT = ds.Tables["GetOrderProductByOrderNumber"].Rows[i]["ORDER_PRODUCT_CREATE_DT"].ToString()
                        //ORDER_PRODUCT_LASTUPDATE_DT = ds.Tables["GetOrderProductByOrderNumber"].Rows[i]["ORDER_PRODUCT_LASTUPDATE_DT"].ToString()
                    });
                }
            }
            catch (Exception ex)
            {
                CommonHelper.LogException(new List<string>() { "[Date]--->" + DateTime.Now, "[Message]--->" + ex.Message, "[StackTrace]--->" + ex.StackTrace, CommonHelper.LogLine });
                listModel.Add(new OrderProductModel() { ORDER_PRODUCT_REMARKS = @"[ERROR]: " + ex.Message.Substring(0, ex.Message.Length > 500 ? 490 : ex.Message.Length) });
            }

            return listModel;
        }
    }
}
