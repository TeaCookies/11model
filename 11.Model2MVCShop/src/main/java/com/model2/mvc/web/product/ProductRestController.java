package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.UploadFile;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 판매관리 Controller
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.GET )
	public Map addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		Map map = new HashMap();
		map.put("message","addProduct OK");
		
		return map;
	}
	
	
	
	//확인
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Map addUser( @RequestBody Product product, MultipartHttpServletRequest mtfRequest ) throws Exception {

		System.out.println("/product/addProduct : POST");

		//Business Logic
		product.setFileName(UploadFile.saveFile(mtfRequest.getFile("file"),uploadPath));
		productService.addProduct(product);
		
		Map map = new HashMap();
		map.put("message","ok");
		map.put("product", product);
		
		return map;
	}
	


	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET)
	public Product getProduct( @PathVariable int prodNo , 
								@CookieValue(value="history", required=false)  Cookie cookie ,
								HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		//Business Logic
		// Model 과 View 연결
		
		if ( cookie != null ) {
			if ( !( cookie.getValue().contains(Integer.toString(prodNo)) ) ) {
				cookie.setValue(cookie.getValue()+","+Integer.toString(prodNo));
				cookie.setPath("/");
				response.addCookie(cookie);
			}
		}else {
			response.addCookie(new Cookie("history", Integer.toString(prodNo)));
		}
	

		return productService.getProduct(prodNo);
	}
	
	

	@RequestMapping( value="json/updateProduct/{prodNo}", method=RequestMethod.GET)
	public Product updateProduct( @PathVariable  int prodNo ) throws Exception{

		System.out.println("/product/updateProductView : GET");
		System.out.println("■■■■ 확인 : "+prodNo);
		//Business Logic
		
		return productService.getProduct(prodNo);
	}
	
	

	@RequestMapping( value="json/updateProduct" , method=RequestMethod.POST)
	public Product updateProduct( @RequestBody Product product) throws Exception{

		System.out.println("/product/updateProduct : POST");
		System.out.println("■■■■ 확인 : "+product.getProdNo());
		//Business Logic

		productService.updateProduct(product);

		
		return product;
	}
	
	

	@RequestMapping( value="json/listProduct" )
	public Map listProduct(@RequestBody  Search search ) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("message","prodOK");
		
		return map;
	}
	
	
}