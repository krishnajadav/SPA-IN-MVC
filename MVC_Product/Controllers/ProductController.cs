using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using MVC_Product.Models;

namespace MVC_Product.Controllers
{
    public class ProductController : Controller
    {
        // GET: Product

        TestMVCEntities context = new TestMVCEntities();

        public Page Page { get; private set; }

      

        public ActionResult ProductInfo()
        {
            return View();
        }




        public JsonResult GetProductsData()
        {
            var alldata = context.products.ToList();

            var result = from x in alldata
                         select new[]
                         {
                                Convert.ToString(x.pid),
                                Convert.ToString(x.pname),
                                Convert.ToString(x.pprice),
                                Convert.ToString(x.pimage),
                                Convert.ToString(x.pisdemand),
                                Convert.ToString(x.pcname),
                                Convert.ToString(x.psupply)

                         };


            return Json(new
            {
                aaData = result
            },
          JsonRequestBehavior.AllowGet);

        }




        



        public JsonResult GetProductsCategoryData()
        {
            var alldata = context.product_category.ToList();

            List<SelectListItem> Categories = new List<SelectListItem>();

            for (int i = 0; i < alldata.Count; i++)
            {
                Categories.Add(new SelectListItem
                {
                    Value = context.product_category.ToList()[i].pcid.ToString(),
                    Text = context.product_category.ToList()[i].pcname
                });
            }
            return Json(Categories,JsonRequestBehavior.AllowGet);

        }




        public JsonResult InupProductMain(HttpPostedFileBase Image, string id, string pname, string pprice, string pcname, string pisdemand, string psupply, string imgname)
        {
            try
            {
                string fileName = "";

                if (Image != null)
                {
                    fileName = Image.FileName;

                    if (Image.ContentLength > 0)
                    {
                        string Path = Server.MapPath("~/Content/Images/") + fileName;
                        Image.SaveAs(Path);
                    }
                }
                else
                {
                    fileName = imgname;
                }

                bool isdemand = Convert.ToBoolean(Convert.ToInt32(pisdemand));

                context.InUPProductMain(Convert.ToInt32(id), pname, Convert.ToDecimal(pprice), fileName, pcname, isdemand, psupply);

                return Json(1, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(0, JsonRequestBehavior.AllowGet);
            }

        }
        public JsonResult GetProductsCategoriyWiseData(string Pcname)
        {
           
            var result = from x in context.products where x.pcname.Equals(Pcname) select new {x.pname,x.pid};


            List<SelectListItem> Products = new List<SelectListItem>();

           foreach(var c in result)
            {
                Products.Add(new SelectListItem
                {
                    Value = c.pid.ToString(),
                    Text = c.pname.ToString()
                });
            }
              
           
            return Json(Products, JsonRequestBehavior.AllowGet);

        }




        public JsonResult deleteRecord(int ID)
        {
            try
            {
                var data = context.products.Where(x => x.pid == ID).FirstOrDefault();
                context.products.Remove(data);
                context.SaveChanges();
                return Json(1, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(0, JsonRequestBehavior.AllowGet);
            }
        }




    }
}