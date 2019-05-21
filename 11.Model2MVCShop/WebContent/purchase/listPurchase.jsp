<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>��ǰ ����Ʈ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">
	//�˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
	}
	
	
	$(function() {
		$( "td:contains('����')" ).on("click" , function() {
			self.location ="/purchase/updateTranCode?tranNo="+$(this).parent().children("td:nth-child(3)").children().val()+"&tranCode="+$(this).parent().children(  "td:nth-child(9)" ).children().val();
			console.log ( "tranNo :: "+$(this).parent().children("td:nth-child(3)").children().val());
			console.log ( "tranCode :: "+$(this).parent().children("td:nth-child(9)").children().val());
		});
	});
		
	$(function() {
		//���ų�¥ Ŭ��
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
		//	self.location ="/purchase/getPurchase?tranNo="+$(this).children().val();
		//	console.log ( $(this).children().val() );
		//});
		
		//$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			//Debug..
			//alert( $(this).children().val());
			
			//////////////////////////// �߰� , ����� �κ� ///////////////////////////////////
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
														+"��ǰ��ȣ : "+JSONData.purchaseProd.prodNo+"<br/>"
														+"���Ź�� : "+JSONData.paymentOption+"<br/>"
														+"�������̸� : "+JSONData.receiverName+"<br/>"
														+"�����ڿ���ó : "+JSONData.receiverPhone+"<br/>"
														+"�������ּ� : "+JSONData.divyAddr+"<br/>"
														+"���ſ�û���� : "+JSONData.divyRequest+"<br/>"
														+"�������� : "+JSONData.divyDate+"<br/>"
														+"�ֹ��� : "+JSONData.orderDate+"<br/>"
														+"</h3>";
														
							//Debug...									
							//alert(displayValue);
							$("h3").remove();
							$( "#"+tranNo+"" ).html(displayValue);
						}
				});
			
	});
	
		
		//��ǰ�� Ŭ��
		$( ".ct_list_pop td:nth-child(5)" ).on("click" , function() {
			self.location ="/product/getProduct?prodNo="+$(this).children().val()+"&menu=search";
			console.log ( " :::::: "+$(this).children().val() );
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$( " .ct_list_pop td:nth-child(5)" ).css("font-weight" , "bold");
			
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
	});	
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm" >

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">���Ÿ����ȸ</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="50">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">�ֹ���ȣ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ��</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="50">����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�ֹ���Ȳ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">��������</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>

				<c:set var="i" value="0" />
				<c:forEach var="purchase" items="${list}">
					<c:set var="i" value="${ i+1 }" />
						<tr class="ct_list_pop">
						<td align="center">${ i }</a></td>
						<td></td>
						<td align="center">${purchase.tranNo}
							<input type="hidden" name="tranNo" value="${purchase.tranNo}"/></td>
						<td></td>
						<td align="center" >${purchase.purchaseProd.prodName }
							<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo}"/></td>
						<td></td>
						<td align="center"> ${purchase.tranQuantity }��</td>
						<td></td>
						<td align="center"> ${purchase.purchaseProd.price }��
							<input type="hidden" name="tranCode" value="${purchase.tranCode}"/></td>
						<td></td>
						<td align="center">
						
							
						
						<c:choose>
							<c:when test="${purchase.tranCode eq '1' }">
								���� �Ϸ� 
							</c:when>
							<c:when test="${purchase.tranCode eq '2' }">
								��� �� 
							</c:when>
							<c:when test="${purchase.tranCode eq '3' }"> 
								��� �Ϸ�
							</c:when>
							<c:otherwise>
								????? :: ${purchase.tranCode} 
							</c:otherwise>
						</c:choose>
						
						</td>
						<td></td>
						<td align="left">
						
						<c:choose>
							<c:when test="${ purchase.tranCode eq '1'  }">
								��� �غ� ��
							</c:when>	
							<c:when test="${purchase.tranCode eq '2' }">
								���� Ȯ��
							</c:when>
							<c:when test="${ purchase.tranCode eq '3'  }">
								��� �Ϸ�
							</c:when>		
						</c:choose>
					</td>
					<td></td>
					<td align="left"></td>
					<td></td>
					</tr>
	
					<tr>
						<!-- //////////////////////////// �߰� , ����� �κ� /////////////////////////////
						<td colspan="11" bgcolor="D6D7D6" height="1"></td>
						////////////////////////////////////////////////////////////////////////////////////////////  -->
						<td id="${purchase.tranNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center">
						 <input type="hidden" id="currentPage" name="currentPage" value=""/>
							<jsp:include page="../common/pageNavigator.jsp"/>	
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
