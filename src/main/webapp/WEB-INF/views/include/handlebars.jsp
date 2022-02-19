<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script id="dummyData" type="text/x-handlebars-template">
<div>
	<h1>과일</h1>
	{{#items}}
	<dl>
		<dt>{{title}}</dt>
		<dt>{{english}}</dt>
		<dt>{{color}}</dt>
	</dl>
	{{/items}}
</div>
</script>

<!-- dummyData에 들어갈 자료 -->
<script type="text/javascript">
	
	//handlebar 탬플릿을 담는다
	var dummy = $("#dummyData").html();
	
	console.log("더미:"+ dummy);
	
	//handlebr 탬플릿에 탬플릿 구조를 컴파일 시킨다
	var template = Handlebars.compile(dummy);
	
	var data = {
			items:[
				{title : "사과", english : "Apple", color : "red"},
				{title : "바나나", english : "Banana", color: "yellow"},
				{title : "멜론", english : "Melon", color : "green"},
				{title : "포도", english : "Grape", color : "purple" }
			]
	}
	
	var item = template(data);
	
	$('body').append(item);
	
	
	{{#each.}}
	<li data-reply_no = {{reply_no}} class="replyLi" style="list-style:none;">
		<div class="card border-dark mb-3" style="width:100%; height:100%;">
			<div class="card-body text-dark">
				<p class="card-text reply_text"> {{reply_text}} </p>
			</div>

			<div class="card-header">
				<div class="row">
					<div class="col-3">
						<img src="${login.member_image}" class="img-fluid img-thumbnail img-rounded" style="width:100%; height:80%;">
						<p class="reply_writer" style="text-align:center;"> {{reply_writer}}</p>
					</div>
					
					<div class="col-9" style="align-self:center;">
						<div style="text-align:center;">
							<button type="button" id="modalBtn" class="btn btn-xs btn-success" data-toggle="modal" data-target="#modifyModal" style="margin:10px;">수정</button>
	 					</div>
					</div>

				</div>	
			</div>
		</div>
	</li>
	</hr>
	{{/each}}
	
	
	
		{{#each.}}
		<li data-reply_no = {{reply_no}} class="replyLi" style="list-style:none;">
		
			<div class="row">

				<div class="card border-dark mb-3" style="width:100%; height:100%;">
				
					<div class="card-body text-dark">
						<textarea class="card-text reply_text" rows="7" disabled="disabled" style="resize:none; width:100%;">{{reply_text}}</textarea>	
					</div>

					<div class="card-header">
						<div class="row">
							<div class="col-3">
								<img src="${login.member_image}" class="img-fluid img-thumbnail img-rounded" style="width:100%; height:80%;">
								<p class="reply_writer" style="text-align:center;"> {{reply_writer}}</p>
							</div>
						
							<div class="col-9" style="align-self:center;">
								<div style="text-align:center;">
									<button type="button" id="modalBtn" class="btn btn-xs btn-success" data-toggle="modal" data-target="#modifyModal" style="margin:10px;">수정</button>
		 						</div>
							</div>

						</div>	
					</div>
				</div>
		 	</div>
	  </li>
	</hr>
		{{/each}}
	
</script>







</body>
</html>