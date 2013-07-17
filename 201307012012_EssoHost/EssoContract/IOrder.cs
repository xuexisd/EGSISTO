using EssoModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace EssoContract
{
    [ServiceContract]
    public interface IOrder
    {
        [OperationContract]
        [WebInvoke(UriTemplate = "Order/AddOrder", Method = "POST"
           , BodyStyle = WebMessageBodyStyle.Bare, ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json)]
        OrderModel AddOrder(List<OrderAddModel> order);

        [OperationContract]
        [WebGet(UriTemplate = "Order/GetOrderByOwner?owner={owner}", BodyStyle = WebMessageBodyStyle.Bare
            , ResponseFormat = WebMessageFormat.Json)]
        OrderModel GetOrderByOwner(string owner);

        [OperationContract]
        [WebGet(UriTemplate = "Order/GetOrderProductByOrderNumber?orderNumber={orderNumber}", BodyStyle = WebMessageBodyStyle.Bare
            , ResponseFormat = WebMessageFormat.Json)]
        OrderModel GetOrderProductByOrderNumber(string orderNumber);
    }
}
