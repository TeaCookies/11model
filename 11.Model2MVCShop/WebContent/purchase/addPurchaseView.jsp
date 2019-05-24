<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


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
	<script type="text/javascript" src="/resources/events.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css">
	
<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	function fncAddPurchase(){
		//Form 유효성 검증		
		var quantity=$("input[name='tranQuantity']").val();
		var mileage=$("#mileage").val();
	
		if(quantity == null || quantity.length<1){
			alert("구매 수량을 입력해주세요.");
			return;
		}
		if(quantity > ${product.prodQuantity}){
			alert("${product.prodQuantity}개 이하로 입력해주세요.");
			return;
		}
		if(mileage > ${purchase.buyer.mileage }){
			alert("${product.prodQuantity}원 이하로 입력해주세요.");
			return;
		}
		
		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
	}
	
	$(function() {	
		 $( "#tranQuantity" ).keyup(function( ) {
			var price =  ${purchase.purchaseProd.price } ;
			var quantity = $("#tranQuantity").val() ;
			$( '#tranPrice').val( price  * quantity );
		 }); 
		 
// 		 $( "#mileage" ).keyup(function( ) {
// 			var mileage =  $( "#mileage" ).val() ;
// 			var usermileage = ${purchase.buyer.mileage };
// 			alert("${product.prodQuantity}원 이하로 입력해주세요.");
// 			if(mileage > usermileage){
// 				alert("${product.prodQuantity}원 이하로 입력해주세요.");
// 				return;
// 			}
// 		 }); 
		 
		$( "button:contains('구매')" ).on("click" , function() {
			fncAddPurchase();
		});

		$( "button:contains('취소')" ).on("click" , function() {
			history.go(-1);
		});
	});
	
	
	$(function() {		
		$( "#divyDate" ).datepicker({
			dateFormat: 'yy-mm-dd',
	        prevText: '이전 달',
	        nextText: '다음 달',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        yearSuffix: '년'

		});
	
	});
	

</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">주문결제</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodNo" name="prodNo" placeholder="상품번호" value="${purchase.purchaseProd.prodNo }" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품명" value="${purchase.purchaseProd.prodName }" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="제조일자" value="${purchase.purchaseProd.manuDate}" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="tranPrice" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="tranPrice" name="tranPrice" placeholder="가격" value="" readonly>
		    </div>
		  </div>
		  		  
		   <div class="form-group">
		    <label for="tranQuantity" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 수량</label>
		    <div class="col-sm-4">
		      <input type="number" class="form-control" id="tranQuantity" name="tranQuantity" placeholder="수량">
		    </div>
		  </div>
		  		  
		   <div class="form-group">
		    <label for="mileage" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 적립금 사용</label>
		    <div class="col-sm-4">
		      <input type="number" class="form-control" id=""mileage"" name="mileage" placeholder="적립금 사용">
		       <span id="mileage" >보유 적립금 : ${purchase.buyer.mileage }원 </span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="buyerId" name="buyerId" placeholder="구매자 아이디" value="${purchase.buyer.userId }" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 구매방법</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="paymentOption" id="paymentOption">
				  	<option value="010" >현금구매</option>
					<option value="011" >신용구매</option>
				</select>
		    </div>
		  </div>

		   <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 구매자이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="구매자이름" value="${purchase.buyer.userName }" >
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 구매자연락처</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="구매자연락처" value="${purchase.buyer.phone }" >
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 구매자주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="구매자주소" value="${purchase.buyer.addr }" >
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="구매요청사항">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="배송희망일자" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" >구매</button>
			  <button type="button" class="btn btn-defalut">취소</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>

</html>