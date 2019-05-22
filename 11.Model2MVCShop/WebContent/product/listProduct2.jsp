<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
	}
	
	
	 $(function() {
		$( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
			fncGetList(1);
		});
		
		
		
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			self.location ="/product/getProduct?prodNo="+ $(this).children().val()+"&menu=${param.menu}";
				console.log ( $(this).children().val() );
				console.log (":::"+ $( ".ct_list_pop td:nth-child(9)").html() );
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
			
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
		$( "td:contains('����ϱ�')" ).on("click" , function() {
		//	self.location ="/purchase/updateTranCode?prodNo="+$(this).parent().children("td:nth-child(3)").children().val()+"&tranCode="+$(this).parent().children("td:nth-child(9)").children().val();
			self.location ="/purchase/updateTranCode?tranNo="+$(this).parent().children("td:nth-child(3)").children("input:nth-child(2)").val()+"&tranCode="+$(this).parent().children("td:nth-child(9)").children().val();
			console.log ( "Ȯ��1 :: "+$(this).parent().children("td:nth-child(3)").children().val() );
			console.log ( "Ȯ��2 :: "+$(this).parent().children("td:nth-child(3)").children("input:nth-child(2)").val() );
			console.log ( "Ȯ��3 :: "+$(this).parent().children("td:nth-child(9)").children().val() );
		
		});
		
		$( "#price:contains('����')" ).on("click" , function() {
			self.location ="/product/listProduct?menu=${param.menu}";
			console.log ( "/product/listProduct?menu=${param.menu}");
		});
	//	$( "td:contains('����')" ).on("click" , function() {
	//		self.location ="/product/getProduct?prodNo="+$( ".ct_list_pop td:nth-child(3)" ).children().val()+"&menu=${param.menu}";
	//		console.log ( "/product/listProduct?menu=${param.menu}");
	//	});
				
			
	 });	
	
		
</script>
</head>



<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>
		       <c:if test="${ param.menu eq 'manage' }">
		       			��ǰ����
		       	</c:if>
		       <c:if test="${ param.menu ne 'manage' }">
		       			��ǰ�����ȸ
		       	</c:if>	       
	       </h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="left">No</th>
            <th align="left" >��ǰ��</th>
            <c:if test="${ param.menu eq 'manage' }">
		            <th align="left" >���� ����</th>
		            <th align="left" >�ֹ���ȣ</th>
            </c:if>
            <th align="left">����</th>
            <th align="left">�����</th>
            <th align="left">�������</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="left">${ i }</td>
			  <td align="left"  title="Click : ��ǰ���� Ȯ��">${product.prodName} 
<!--					<input type="hidden" value="${product.prodNo}"/>
					<input type="hidden" value="${ product.prodTranNo }"/>		-->
					<% System.out.println("Ȯ��            2        :  "+ request.getAttribute("list")); %>
			  </td>
			   <c:if test="${ param.menu eq 'manage' }">
				  <td align="left">${product.prodQuantity}��</td>
				  <td align="left"> ${ product.prodTranNo }</td>
			  </c:if>
			  <td align="left">${product.price}��</td>
			  <td align="left">${product.manuDate}</td>
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${product.prodName} "></i>
			  	<input type="hidden" value="${product.prodName} ">
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>
</html>
