<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">

<title>Lisää asiakas</title>
</head>
<body>

<form id="info"> 
	<table class="tg">
		<thead>	
			<tr>
				<th colspan="5" class="tg-1lax"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr>
				<th class="tg-0lax">Etunimi</th>
				<th class="tg-0lax">Sukunimi</th>
				<th class="tg-0lax">Puhelin</th>
				<th class="tg-0lax">Sähköposti</th>
				<th class="tg-0lax"></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Lisää"></td>
			</tr>
		</tbody>
	</table>
</form>

<span id="Ilmoitus"></span>
</body>

<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	$("#info").validate({						
		rules: {
			etunimi:  {
				required: true,
				minlength: 3,
				maxlength: 50
			},	
			sukunimi:  {
				required: true,
				minlength: 3,
				maxlength: 50
			},
			puhelin:  {
				required: true,
				minlength: 10,
				maxlength: 50
			},	
			sposti:  {
				required: true,
				minlength: 10,
				maxlength: 100
			}	
		},
		messages: {
			etunimi: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			},
			puhelin: {
				required: "Puuttuu",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			},
			sposti: {
				required: "Puuttuu",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			}
		},			
		submitHandler: function(form) {	
			lisaaTiedot();
		}		
	}); 	
});

//Tehdään funktio asiakkaan lisäämistä varten. Funktio kutsuu backin POST-metodia ja välittää kutsun mukana
//uudet tiedot back endin puolelle json-stringina. url kutsuu asiakkaat servlettiä.

function lisaaTiedot(){	
	var formJsonStr = formDataJsonStr($("#info").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#Ilmoitus").html("Asiakkaan lisääminen epäonnistui.");
      }else if(result.response==1){			
      	$("#Ilmoitus").html("Asiakkaan lisääminen onnistui.");
      	$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
  }});	
}

</script>

</html>