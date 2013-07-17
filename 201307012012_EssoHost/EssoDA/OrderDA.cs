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
    public class OrderDA : IOrder
    {
        public OrderModel AddOrder(List<OrderAddModel> order)
        {
            SqlHelper helper = new SqlHelper();
            Guid orderGuid = Guid.NewGuid();
            OrderModel retModel = new OrderModel();

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

            return retModel;
        }

        public OrderModel GetOrderByOwner(string owner)
        {
            throw new NotImplementedException();
        }

        public OrderModel GetOrderProductByOrderNumber(string orderNumber)
        {
            throw new NotImplementedException();
        }
    }
}
