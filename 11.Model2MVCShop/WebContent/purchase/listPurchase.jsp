<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	//검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
	}
	
	
	$(function() {
		$( "td:contains('수취')" ).on("click" , function() {
			self.location ="/purchase/updateTranCode?tranNo="+$(this).parent().children("td:nth-child(3)").children().val()+"&tranCode="+$(this).parent().children(  "td:nth-child(9)" ).children().val();
			console.log ( "tranNo :: "+$(this).parent().children("td:nth-child(3)").children().val());
			console.log ( "tranCode :: "+$(this).parent().children("td:nth-child(9)").children().val());
		});
	});
		
	$(function() {
		//구매날짜 클릭
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
		//	self.location ="/purchase/getPurchase?tranNo="+$(this).children().val();
		//	console.log ( $(this).children().val() );
		//});
		
		//$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			//Debug..
			//alert( $(this).children().val());
			
			//////////////////////////// 추가 , 변경된 부분 ///////////////////////////////////
			//self.location ="/user/getUser?userId="+$(this).text().trim();
			////////////////////////////////////////////////////////////////////////////////////////////
			var tranNo = $(this).children().val();
			$.ajax( 
					{
						url : "/purchase/json/getPurchase/"+tranNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							
							//Debug...
							//alert(status);
							//Debug...
							//alert("JSONData : \n"+JSONData);

							var displayValue = "<h3>"
														+"상품번호 : "+JSONData.purchaseProd.prodNo+"<br/>"
														+"구매방법 : "+JSONData.paymentOption+"<br/>"
														+"구매자이름 : "+JSONData.receiverName+"<br/>"
														+"구매자연락처 : "+JSONData.receiverPhone+"<br/>"
														+"구매자주소 : "+JSONData.divyAddr+"<br/>"
														+"구매요청사항 : "+JSONData.divyRequest+"<br/>"
														+"배송희망일 : "+JSONData.divyDate+"<br/>"
														+"주문일 : "+JSONData.orderDate+"<br/>"
														+"</h3>";
														
							//Debug...									
							//alert(displayValue);
							$("h3").remove();
							$( "#"+tranNo+"" ).html(displayValue);
						}
				});
		});		

	
		
		//상품명 클릭
		$( ".ct_list_pop td:nth-child(5)" ).on("click" , function() {
			self.location ="/product/getProduct?prodNo="+$(this).children().val()+"&menu=search";
			console.log ( $(this).children().val() );
		});
		
		//취소
	//	$( "span:contains('취소')" ).on("click" , function() {
//		$(".ct_list_pop td:nth-child(15)").on("click" , function() {
//			var tranNo = $(  	$('.ct_list_pop td:nth-child(3)')[ $('.ct_list_pop td:nth-child(15)').index(this) ]    ).text().trim();
		//	alert( 	tranNo	);
		//	alert( 	$(  	$('.ct_list_pop td:nth-child(3)')[ $('.ct_list_pop td:nth-child(15)').index(this) ]    ).children().val()	);
//			self.location ="/purchase/cancelPurchase?tranNo="+tranNo;
	//	});
		$(".ct_list_pop td:nth-child(15):contains('취소')").on("click" , function() {
			var tranNo = $(  	$('.ct_list_pop td:nth-child(3)')[ $('.ct_list_pop td:nth-child(15)').index(this) ]    ).text().trim();
	//		alert( 	tranNo	);
		//	alert( 	$(  	$('.ct_list_pop td:nth-child(3)')[ $('.ct_list_pop td:nth-child(15)').index(this) ]    ).children().val()	);
			self.location ="/purchase/cancelPurchase?tranNo="+tranNo;
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$( " .ct_list_pop td:nth-child(5)" ).css("font-weight" , "bold");
			
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
	});	
	
</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>구매목록조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    		  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >주문번호</th>
            <th align="left">상품명</th>
            <th align="left">수량</th>
            <th align="left">가격</th>
            <th align="left">주문현황</th>
            <th align="left">정보수정</th>
            <th align="left">취소</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : 회원정보 확인">${purchase.tranNo}
							<input type="hidden" name="tranNo" value="${purchase.tranNo}"/></td>
			  <td align="left">${purchase.purchaseProd.prodName }
							<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo}"/></td>
			  <td align="left">${purchase.tranQuantity }개</td>
			  <td align="left"> ${purchase.purchaseProd.price }원
							<input type="hidden" name="tranCode" value="${purchase.tranCode}"/></td>
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${user.userId}"></i>
			  	<input type="hidden" value="${user.userId}">
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>