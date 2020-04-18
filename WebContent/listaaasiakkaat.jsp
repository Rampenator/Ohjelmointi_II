<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Asiakkaat</title>
</head>
<body>

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg .tg-0lax{font-weight:bold;background-color:#98e0f5;color:#330001;text-align:left;vertical-align:top}
.tg .tg-1lax{font-weight:bold;background-color:#98e0f5;color:#330001;text-align:right;vertical-align:top}
 tr:nth-child(even) {background-color: #f2f2f2;
</style>

<table class="tg" id="testi">
	<thead>
		<tr>	
			<th class="tg-1lax" colspan="2">Hakusana:</th>
			<th class="tg-0lax"><input type="text" id="hakusana"></th>
			<th class="tg-0lax"><input type="button" value="Hae" id="hakunappi"></th>
		</tr>
		<tr>
	    	<th class="tg-0lax">Etunimi</th>
	    	<th class="tg-0lax">Sukunimi</th>
	    	<th class="tg-0lax">Puhelin</th>
	    	<th class="tg-0lax">Sähköposti</th>
	  	</tr>
	</thead>
	<tbody>	
	</tbody>  	
</table>

<script>

$(document).ready(function() { //Kun dokumentti valmistuu tee...
	haeAsiakkaat();
	$("#hakunappi").click(function() {
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event) {
		if(event.which==13) { //Ajetaan haku enterillä
			haeAsiakkaat();
		}
	});
	$("#hakusana").focus();//viedään kursori hakusana-kenttään sivun latauksen yhteydessä
});

function haeAsiakkaat() {
	//tehdään functio, joka hakee datan eli asiakkaat back endista
	//ajaxin avulla voidaan ladata osa sivusta lataamatta koko sivua uudestaan
	//Listaus täytyy tyhjentää
	$("#testi tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), //hakusana mukaan autot kutsuun
		type:"GET", dataType:"json",
		success:function(result) {//Funktio palauttaa tiedot json-objektina
		
		$.each(result.asiakkaat, function(i, field) {
			var htmlStr;
			htmlStr+="<tr>";
			htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="</tr>";
        	$("#testi tbody").append(htmlStr);
		});
	}});	
}


</script>
</body>
</html>