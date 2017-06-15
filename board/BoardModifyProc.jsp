<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("euc-kr"); %>

<%

int rno = Integer.parseInt(request.getParameter("rno"));

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String encoded_key ="";

String column = request.getParameter("column");
if(column == null) 
	{column="";}

String key = request.getParameter("key");
if(key!=null){
	encoded_key = URLEncoder.encode(key,"euc-kr");
}else{
	key="";
}

try {
	   //------------------------------- JDBC 설정
	   
	   String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb";
	   String jdbcId = "jspuser";
	   String jdbcPw = "jsppass";

	   Class.forName("com.mysql.jdbc.Driver");
	   conn = DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);
	   
	   //-------------------------------전달된 데이터의 추출
	   String mail = request.getParameter("mail");
	   String subject = request.getParameter("subject");
	   String content = request.getParameter("content");
	   String passwd = request.getParameter("pass");
	   
	   //-------------------------------------레코드 패스워드 추출
	   String Query1 = "SELECT UsrPass FROM board WHERE RcdNo=?";
	   pstmt = conn.prepareStatement(Query1);
	   pstmt.setInt(1,rno);
	   rs = pstmt.executeQuery();
	   rs.next();
	   String dbPass = rs.getString(1);
	   
	   //------------------------------------ 패스워드의 비교와 레코드의 삭제
	   
	   if(passwd.equals(dbPass)){
		   
		   String Query2 = "UPDATE board SET UsrMail=?, UsrSubject=?, UsrContent=? WHERE RcdNo=?";
		   pstmt = conn.prepareStatement(Query2);
		   pstmt.setString(1,mail);
		   pstmt.setString(2,subject);
		   pstmt.setString(3,content);
		   pstmt.setInt(4,rno);
		   
		   pstmt.executeUpdate();
		   
		   	rs.close();
			pstmt.close();
			conn.close();
			
			String retUrl = "BoardContent.jsp?rno="+rno+"&column="+column+"&key="+encoded_key;
			response.sendRedirect(retUrl);
	   }else {
		   rs.close();
			pstmt.close();
			conn.close();
			out.println("<script language=\"javascript\">");
			out.println("alert('패스워드가 틀렸습니다.')");
			out.println("history.back()");
			out.println("</script>");
			out.flush();
	   }
	   
}catch(SQLException e){
	out.print(e);
}
	   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>