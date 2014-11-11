<%@ page trimDirectiveWhitespaces="true" contentType="text/html; charset=UTF-8"%>

<html>
<head>
<meta charset=utf-8>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<script>
$( document ).ready(function() {
    $("#sender").val("lu");
   // $("#receiver").val("");
    
    $(document).keypress(function(e) {
        if(e.which == 13) {
        	sendmessage();
        }
    });
	$("#sendbtn").click(sendmessage);	
    setInterval(fetchdata, 3000);
});

$(function(){
  $('.textarea').css({ height: $(window).innerHeight()*0.5 });
  $(window).resize(function(){
    $('.textarea').css({ height: $(window).innerHeight()*0.5 });
  });
});

function sendmessage(){
	var sender = $("#sender").val();
    var receiver = $("#receiver").val();
	var message = $("#tobesent").val();
	$.ajax({
		  url: "chatlog",
		  contentType: "application/json; charset=utf-8",
		  data:{"sender":sender,"receiver":receiver,"message":message,"type":"send"},
		  success:function(data){
			  var meg = $("#tobesent").val(); 
			  $("#tobesent").val("");
			  $("#logtxt").html($("#logtxt").html()+"<br/>"+sender+": "+meg);
			  var psconsole = $('#logtxt');
			    if(psconsole.length)
			       psconsole.scrollTop(psconsole[0].scrollHeight - psconsole.height());
		  }
		});
}

function fetchdata(){
	var user = $("#sender").val();
	$.ajax({
		  url: "chatlog",
		  contentType: "application/json; charset=utf-8",
		  data:{"username":user,"type":"fetch"},
		  success:function(data){
			  if(data.length>0) {
			  	$("#logtxt").html(($("#logtxt").html()+"<br/>"+data).replace(/\n/g, "<br/>"));
			  	var psconsole = $('#logtxt');
			    if(psconsole.length)
			       psconsole.scrollTop(psconsole[0].scrollHeight - psconsole.height());
			  }
		  }
	});
}



</script>

</head>
<body style="overflow:hidden">
<div class="wrap">
	<div class="container-fluid">
		<h2>Welcome to My Online Chating System</h2>
	
	
		<div class="input-group">
		  <span class="input-group-addon">To</span>
		  <input id="receiver" type="text" class="form-control" placeholder="Username">
		</div>
		<div class="input-group">
		  <span class="input-group-addon">From</span>
		  <input id="sender" type="text" class="form-control" placeholder="Username">
		</div>
		<div id="logtxt" class="textarea"></div>
		<div class="push" >
		<!--  textarea id="logtxt" class="form-control" ></textarea-->
		
		</div>
	</div>
</div>
<footer class="footer" >
	<div class="container-fluid ">
	  <input type="text" class="form-control input-lg" rows="3" id="tobesent" placeholder="Write a message here...">
	</div>
</footer>


<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</body>
<style>
*{
margin:0
}
html, body{
  height: 100%
 }
.wrap{ 
  min-height: 100%;
  height: auto !important;
  height: 100%;
  margin: 0 auto -60px;
  max-height: 
 }
.push, .footer {
  height: 60px
 }
.footer{
  background-color: #f5f5f5
 }  
.textarea{
  overflow:auto;
}
</style>
</html>
