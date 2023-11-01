<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<c:if test="${empty CartProductDto}">
	<p>장바구니가 비어있습니다.</p>
</c:if>
<c:if test="${not empty CartProductDto}">

	<h2>장바구니 이름 : 의 장바구니</h2>
	<div class="table d-flex justify-content-center">
		<table border="1">
			<tr>
				<th width="200">pdtId</th>
				<th width="200">장바구니 상품 번호</th>
				<th width="400">상품썸네일</th>
				<th width="200">상품명</th>
				<th width="200">사이즈</th>
				<th width="200">가격</th>
				<th width="200">수량</th>
				<th width="200">삭제</th>
			</tr>
			<c:forEach items="${CartProductDto }" var="Dto">
				<tr data-cartItemId="${Dto.cartItemId}">
					<td>${Dto.pdtId }</td>
					<td>${Dto.cartItemId }</td>
					<td><img width="400" height="300" src="${pageContext.request.contextPath }/upload/${Dto.pdtThum}"></td>
					<td>${Dto.pdtName }</td>
					<td >${Dto.pickSize}</td>
					<td class="pdtPrice">${Dto.pdtPrice}</td>
					<td><input type="number" min="1" class="form-control quantity" id="quantity" value="${Dto.quantity}" name="quantity" required="required" /></td>
					<td><button onclick="deleteItem(${Dto.cartItemId})">삭제</button></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<p class="sum">총 금액: ?</p>

	<form action="" method="post">
		<input type="submit" value="주문하기">
	</form>
</c:if>
<script>

calculateTotal();

function deleteItem(cartItemId) {	
	const rowToDelete = document.querySelector('tr[data-cartItemId="' + cartItemId + '"]');
	$.ajax({
		type:"POST",
		url:"../cart/delete",
		data: {cartItemId : cartItemId},
		success:function(response){
		    if (rowToDelete) {
		        rowToDelete.parentNode.removeChild(rowToDelete);
		        calculateTotal();
		    }
		}
	});
}



$('.quantity').on('input', function() {
    const row = $(this).closest('tr');
    console.log(row);
    const cartItemId = row.data('cartitemid');
    console.log(cartItemId);
    const newQuantity = $(this).val();
    console.log(newQuantity);
    const pickSize = row.find('td:eq(4)').text();
    console.log(pickSize);
    const pdtId = row.find('td:eq(0)').text();
    console.log(pdtId);
    
    // 서버에 수량을 업데이트하기 위한 Ajax 요청을 만듭니다.
    $.ajax({
        type: "POST",
        url: "../cart/modify", // 실제 서버 엔드포인트로 대체하세요
        data: {
            cartItemId: cartItemId,
            newQuantity: newQuantity,
            pickSize: pickSize,
            pdtId: pdtId
        },
        success: function(data) {
            if (data.result === "success") {
                // 서버로부터 수정 성공 시
                calculateTotal();
            } else if (data.result === "fail") {
                // 재고 초과 시 적절한 처리 (예: 오류 메시지 표시)
                alert("재고가 부족합니다.");
                // 이전 수량으로 복원하거나 다른 조치를 취할 수 있음
                // 예: 수량 입력 필드를 이전 값으로 되돌리기
                $(this).val(data.previousQuantity);
            }
        }
    });
});


function calculateTotal() {
    // Initialize totalAmount to 0
    let totalAmount = 0;

    // Iterate through all elements with class "pdtPrice" and "quantity"
    $('.pdtPrice').each(function (index) {
        const price = parseFloat($(this).text().replace(/[^0-9.-]+/g, ""));
        const quantity = parseInt($('.quantity').eq(index).val(), 10);

        // Calculate the total amount for this row and add it to totalAmount
        const rowTotal = price * quantity;
        totalAmount += rowTotal;
    });

    // Update the element with class "sum" to display the total amount
    $('.sum').text('총 금액: ' + totalAmount);
}

</script>



<%@ include file="../include/footer.jsp"%>