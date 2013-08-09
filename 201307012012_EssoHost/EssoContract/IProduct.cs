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

        [OperationContract]
        [WebGet(UriTemplate = "Product/GetProductByRowNumber?productCategory={productCategory}&lastRow={lastRow}", BodyStyle = WebMessageBodyStyle.Bare
            , ResponseFormat = WebMessageFormat.Json)]
        List<ProductModel> GetProductByRowNumber(string productCategory, int lastRow);

        [OperationContract]
        [WebGet(UriTemplate = "Product/GetProductHome", BodyStyle = WebMessageBodyStyle.Bare
            , ResponseFormat = WebMessageFormat.Json)]
        List<ProductModel> GetProductHome();

        [OperationContract]
        [WebGet(UriTemplate = "Product/GetProductById?pId={pId}", BodyStyle = WebMessageBodyStyle.Bare
            , ResponseFormat = WebMessageFormat.Json)]
        ProductModel GetProductById(string pId);
    }
}
