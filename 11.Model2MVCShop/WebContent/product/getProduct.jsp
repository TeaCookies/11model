<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
			
			$(function() {
				$( "button:contains('목록')" ).on("click" , function() {
					$(self.location).attr("href","/product/listProduct?menu=${ param.menu}");
				});
				
				$( "button:contains('구매')" ).on("click" , function() {
					self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
				});
			});
			
	</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">상품상세조회</h3>
    	</div>
	
	
	      <div class="row marketing">
	        <div class="col-lg-4">
	          <img src="../images/uploadFiles/${product.fileName}" width="400" height="400" 
	    		      onerror="this.src='http://placehold.it/400x400'"/>
	        </div>
	        
	        <div class="col-lg-1">
	        </div>
	
	        <div class="col-lg-7">
	          <div class="row">
		  		<div class="col-xs-4 col-md-3"><strong>상품번호</strong></div>
				<div class="col-xs-8 col-md-4">${ product.prodNo }</div>
			</div>
			
			<hr/>
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3 "><strong>상품명</strong></div>
				<div class="col-xs-8 col-md-8">${ product.prodName }</div>
			</div>
			
			<hr/>
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3 "><strong>상품상세정보</strong></div>
				<div class="col-xs-8 col-md-8">${ product.prodDetail }</div>
			</div>
			
			<hr/>
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3"><strong>제조일자</strong></div>
				<div class="col-xs-8 col-md-4">${ product.manuDate }</div>
			</div>
			
			<hr/>
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3"><strong>가격</strong></div>
				<div class="col-xs-8 col-md-4">${ product.price }원</div>
			</div>
			
			<hr/>
			
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3"><strong>적립금</strong></div>
				<div class="col-xs-8 col-md-4"><fmt:formatNumber value="${ product.price*(5/100) }" pattern="0"/>원</div>
			</div>
			
			
			<hr/>
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3 "><strong>등록일자</strong></div>
				<div class="col-xs-8 col-md-4">${ product.regDate }</div>
			</div>
          
        </div>
      </div>
		
		<hr/>
				  			<% System.out.println( "테스트@@@@@@@@@@@"+ request.getParameter("menu")); %>
		<div class="row">
	  		<div class="col-md-12 text-center ">
		  		<c:if test="${ param.menu ne 'manage' && product.prodQuantity != 0}">
		  				<button type="button" class="btn btn-primary">구매</button>
		  		</c:if>
		  		<c:if test="${ product.prodQuantity == 0}">
   						<a href="#" class="btn btn-danger" role="button">품절</a>
   				</c:if>
	  			<button type="button" class="btn btn-defalut">목록</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>