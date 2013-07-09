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
    public interface IProduct
    {
        [OperationContract]
        [WebGet(UriTemplate = "Product/GetProductTopFive", BodyStyle = WebMessageBodyStyle.Bare
            , ResponseFormat = WebMessageFormat.Json)]
        List<ProductModel> GetProductTopFive();
    }
}
