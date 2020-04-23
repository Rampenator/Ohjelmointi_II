package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import beans.dao.Dao;
import beans.Asiakas;

@WebServlet("/asiakkaat/*") //voi sis�lt�� alikansioita 
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Asiakkaat() {
        super();
        System.out.println("Asiakkaat.Asiakkaat()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("Asiakkaat.doGet()"); //Testi toimiiko
		
		String pathInfo = request.getPathInfo(); //Haetaan polkutiedot, esim. /jarkko
		System.out.println("polku: "+pathInfo);	
		String hakusana="";
		if(pathInfo!=null) {		
			hakusana = pathInfo.replace("/", "");
		}		 
		Dao dao = new Dao(); //Data access object
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki(hakusana);

		String strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString(); //Muutetaan JSONiksi
		response.setContentType("application/json"); //M��ritet��n outputin tyypiksi JSON
		PrintWriter ulos = response.getWriter(); 
		ulos.println(strJSON); //Kirjoittaa ulos strJSONin eli asiakkaat listan
	}
	//Asiakkaan lis��minen
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
		System.out.println("Asiakkaat.doPost()"); //Testi toimiiko
		
		JSONObject jsonObj = new JsonStrToObj().convert(request); //Otetaan vastaan Json string ja muutetaan se Json objectiksi
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		
		response.setContentType("application/json"); //M��ritet��n outputin tyypiksi JSON
		PrintWriter ulos = response.getWriter();
		Dao dao = new Dao(); //Data access object 
		if(dao.lisaaAsiakas(asiakas)){ //metodi palauttaa true/false
			ulos.println("{\"response\":1}");  //Asiakkaan lis��minen onnistui {"response":1}
		}else{
			ulos.println("{\"response\":0}");  //Asiakaab lis��minen ep�onnistui {"response":0}
		}
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()"); //Testi toimiiko
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()"); //Testi toimiiko
		String pathInfo = request.getPathInfo(); //Haetaan polkutiedot, esim. /jarkko
		int asiakas_id = Integer.parseInt(pathInfo.replace("/", "")); //poistetaan polusta "/", j�ljelle j�� id, joka muutetaan int
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if(dao.poistaAsiakas(asiakas_id)){ //metodi palauttaa true/false
			out.println("{\"response\":1}"); //Asiakkaan poisto onnistui {"response":1}
		}else {
			out.println("{\"response\":0}"); //Asiakkaan poisto ep�onnistui {"response":0}
		}		
	}

}

