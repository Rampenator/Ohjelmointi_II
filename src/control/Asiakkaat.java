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

@WebServlet("/asiakkaat/*") //voi sis‰lt‰‰ alikansioita 
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
		String hakusana = pathInfo.replace("/", "");
		Dao dao = new Dao(); //Data access object
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki(hakusana);

		String strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString(); //Muutetaan JSONiksi
		response.setContentType("application/json"); //M‰‰ritet‰‰n outputin tyypiksi JSON
		PrintWriter ulos = response.getWriter(); 
		ulos.println(strJSON); //Kirjoittaa ulos strJSONin eli asiakkaat listan
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		System.out.println("Asiakkaat.doPost()"); //Testi toimiiko
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()"); //Testi toimiiko
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()"); //Testi toimiiko
	}
	
}
