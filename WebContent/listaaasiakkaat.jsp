<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakkaat</title>
</head>
<body>

<table class="tg" id="testi">
	<thead>
		<tr>
			<th colspan="5" class="tg-1lax"><span id="uusiAsiakas">Lis�� uusi asiakas</span></th>
		</tr>
		<tr>	
			<th class="tg-1lax" colspan="3">Hakusana:</th>
			<th class="tg-0lax"><input type="text" id="hakusana"></th>
			<th class="tg-0lax"><input type="button" value="Hae" id="hakunappi"></th>
		</tr>
		<tr>
	    	<th class="tg-0lax">Etunimi</th>
	    	<th class="tg-0lax">Sukunimi</th>
	    	<th class="tg-0lax">Puhelin</th>
	    	<th class="tg-0lax">S�hk�posti</th>
	    	<th class="tg-0lax"></th>
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
		if(event.which==13) { //Ajetaan haku enterill�
			haeAsiakkaat();
		}
	});
	$("#hakusana").focus();//vied��n kursori hakusana-kentt��n sivun latauksen yhteydess�
	
	$("#uusiAsiakas").click(function() {//Vied��n k�ytt�j� uudelle sivulle, jossa asiakkaita voi lis�t�
		document.location="lisaaasiakas.jsp";
	});
});

//tehd��n functio, joka hakee datan eli asiakkaat back endista
//ajaxin avulla voidaan ladata osa sivusta lataamatta koko sivua uudestaan
function haeAsiakkaat() {
	$("#testi tbody").empty();//Listaus t�ytyy tyhjent��
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), //hakusana mukaan autot kutsuun
		type:"GET", dataType:"json",
		success:function(result) {//Funktio palauttaa tiedot json-objektina
			$.each(result.asiakkaat, function(i, field) {
				var htmlStr;
			//	htmlStr+="<tr>";
				htmlStr+="<tr id='rivi_"+field.sposti+"'>";
				htmlStr+="<td>"+field.etunimi+"</td>";
	        	htmlStr+="<td>"+field.sukunimi+"</td>";
	        	htmlStr+="<td>"+field.puhelin+"</td>";
	        	htmlStr+="<td>"+field.sposti+"</td>";
	        	htmlStr+="<td><span class='poista' onclick=poista('"+field.sposti+"')>Poista</span></td>"; 
	        	htmlStr+="</tr>";
	        	$("#testi tbody").append(htmlStr);
		});
	}});
}
function poista(sposti) {
	if(confirm("Poista asiakas, jonka s�hk�posti on " + sposti +"?")){
		$.ajax({url:"asiakkaat/"+sposti, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmoitus").html("Asiakkaan.");
	        }else if(result.response==1){
	        	$("#rivi_"+rekno).css("background-color", "red"); //V�rj�t��n poistetun asiakkaan rivi
	        	alert("Asiakkaan, jonka s�hk�posti on " + sposti +", poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}

</script>
</body>
</html>