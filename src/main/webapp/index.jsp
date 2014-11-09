<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<script>
$( document ).ready(function() {
    $("#sender").val("Linfeng");
    $("#receiver").val("Lu");
    
    $(document).keypress(function(e) {
        if(e.which == 13) {
        	sendmessage();
        }
    });
    
	$("#sendbtn").click(sendmessage);
	
    setInterval(fetchdata, 3000);
	 
    
});

function sendmessage(){
	var sender = $("#sender").val();
    var receiver = $("#receiver").val();
	var message = $("#tobesent").val();
	$.ajax({
		  url: "chatlog",
		  data:{"sender":sender,"receiver":receiver,"message":message,"type":"send"},
		  success:function(data){
			  var meg = $("#tobesent").val(); 
			  $("#tobesent").val("");
			  $("#logtxt").val($("#logtxt").val()+"\n"+sender+": "+meg);
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
		  data:{"username":user,"type":"fetch"},
		  success:function(data){
			  if(data.length>0) {
			  	$("#logtxt").val($("#logtxt").val()+"\n"+data);
			  	var psconsole = $('#logtxt');
			    if(psconsole.length)
			       psconsole.scrollTop(psconsole[0].scrollHeight - psconsole.height());
			  }
		  }
	});
}



</script>

</head>
<body>
<h2>Welcome to My Online Chating System</h2>
To: <input id="receiver" type="text"/><br>
From: <input id="sender" type="text"/><br>
<textarea id="logtxt" rows="30" cols="200"></textarea>
<textarea id="tobesent" rows="15" cols="150"></textarea>
<input id="sendbtn" type="button" value="Send"/>
</body>
</html>
