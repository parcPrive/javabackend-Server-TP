<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<div class="container">
	<h2 class="pb-2 border-bottom">상품 등록</h2>
	<!-- <form action="../member/insert-process" method="post" class="" id="joinForm" name="member" enctype="multipart/form-data"> -->
	<form action="../product/insert-process" method="post"
		class="text-bg-dark" enctype="multipart/form-data">
		<div class="row d-flex justify-content-center mt-5">
			<div class="col-6">
				<div class="mb-3">
					<div class="row">
						<div class="col-6">
							<label for="pdtName" class="form-label mt-5">상품이름</label> <input
								type="text" class="form-control" id="pdtName" placeholder=""
								name="pdtName" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row d-flex justify-content-center">
			<div class="col-6">
				<div class="mb-3">
					<div class="row">
						<div class="col-6">
							<label for="pdtCty" class="form-label">상품카테고리</label> <input
								type="text" class="form-control" id="pdtCty" placeholder=""
								name="pdtCty" list="datalistOptions" />
							<datalist id="datalistOptions">
								<option value="상의">
								<option value="하의">
								<option value="신발">
								<option value="모자">
							</datalist>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row d-flex justify-content-center">
			<div class="col-6">
				<div class="mb-3">
					<div class="row">
						<div class="col-6">
							<label for="pdtPrice" class="form-label">상품가격</label> <input
								type="number" class="form-control" id="pdtPrice" placeholder=""
								name="pdtPrice" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row d-flex justify-content-center">
			<div class="col-6">
				<div class="mb-3">
					<div class="row">
						<div class="col-6">
							<label for="pdtColor" class="form-label">상품색상</label> <input
								type="text" class="form-control" id="pdtColor" placeholder=""
								name="pdtColor" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row d-flex justify-content-center">
			<div class="col-6">
				<div class="mb-3">
					<div class="row">
						<div class="col-6">
							<label for="pdtCount" class="form-label">상품수량</label> <input
								type="number" class="form-control" id="pdtCount" placeholder=""
								name="pdtCount" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row d-flex justify-content-center">
			<div class="col-6">
				<div class="mb-3">
					<label for="pdtThum" class="form-label">상품썸네일</label> <input
						type="file" class="form-control" id="pdtThum"
						placeholder="png,jpg,gif" name="pdtThum"
						accept="image/gif, image/jpeg, image/png, image/jpg" />
				</div>
			</div>
		</div>
		<div class="row d-flex justify-content-center">
			<div class="col-6">
				<div class="mb-3">
					<label class="form-label">미리보기</label>
					<div class="preview"></div>
				</div>
			</div>
		</div>
		<div class="row d-flex justify-content-center">
			<div class="col-6">
				<div class="mb-3">
					<label for="pdtImage" class="form-label">상품 이미지 추가</label> <input
						type="file" class="form-control" id="pdtImage"
						placeholder="이미지 추가는 메인이미지를 포함 4개까지 가능" name="pdtImage"
						accept="image/gif, image/jpeg, image/png, image/jpg" multiple />
				</div>
			</div>
		</div>
		<div class="row d-flex justify-content-center mb-3">
			<div class="col-6">
				<div class="mb-3">
					<label for="pdtContent" class="form-label">상품내용</label>
					<textarea class="form-control" id="pdtContent" name="pdtContent"
						rows="8"></textarea>
				</div>
			</div>
		</div>
		<div class="mt-5 mb-5 d-flex justify-content-center">
			<div class="">
				<button type="submit" class="btn btn-primary mb-5" id="btnSubmit"
					onclick="uploadFiles()">상품등록</button>
				<button type="reset" class="btn btn-secondary mb-5">취소</button>
			</div>
		</div>
	</form>
</div>

<script>
	/* 썸네일 미리보기 */
	$("#pdtThum")
			.on(
					"change",
					function(e) {
						const file = e.target.files[0];
						console.log(e.target.files);
						console.log(file.name);
						const ext = file.name.substring(file.name
								.lastIndexOf(".") + 1);
						console.log(ext);
						if (!(ext === "png" || ext === "jpg" || ext === "gif" || ext === "jpeg")) {
							alert("png,jpg,gif,jpeg만 쓸 수 있습니다.");
							$("#profile").val("");
							return false;
						} else {
							const reader = new FileReader();
							reader.onload = function(e) {
								$(".preview").html(
										`<img src="\${e.target.result}">`);
							}
							reader.readAsDataURL(file);
						}
					});

	/* 파일 이미지 여러개 추가 */
	function uploadFiles() {
		const input = document.getElementById('pdtImage');
		const files = input.files;

		if (files.length > 0) {
			const formData = new FormData();
			for (let i = 0; i < files.length; i++) {
				formData.append(i, files[i]);
				console.log(formData);
			}
		}
	}
</script>
<%@ include file="../include/footer.jsp"%>