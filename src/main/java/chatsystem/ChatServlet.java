package chatsystem;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/chatlog")
public class ChatServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private static final ConcurrentHashMap<String, ArrayList<String>> chatLog = new ConcurrentHashMap<String, ArrayList<String>>(); 

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String type = request.getParameter("type");
		PrintWriter pw = response.getWriter();
		if (type.equals("send")) {
			String sender = request.getParameter("sender");
			String receiver = request.getParameter("receiver");
			String message = request.getParameter("message");
			
			if (!chatLog.containsKey(receiver)) {
				chatLog.put(receiver, new ArrayList<String>());
			}
			
			chatLog.get(receiver).add(sender+": "+message.trim());
			System.out.println("send to " + receiver +" successfully "+message);
			pw.print("send to " + receiver +" successfully");
		} else {
			String username = request.getParameter("username");
			if (chatLog.containsKey(username)) {
				
				ArrayList<String> msgs = chatLog.get(username);
				String result = "";
				synchronized(msgs) {
					for (String str : msgs) {
						result += str+"\n";
					}
					msgs.clear();
				}
				System.out.println(result);
				pw.print(result);
			}
		}
		
	}
	
}
