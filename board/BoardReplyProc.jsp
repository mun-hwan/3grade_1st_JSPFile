<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.net.URLEncoder" %>
    
    <%request.setCharacterEncoding("euc-kr"); %>
    
    <%
    
   
	int rno = Integer.parseInt(request.getParameter("rno"));

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	
	
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
		   
		   //--------최대 RcdNo값 추출과 답변 레코드의 값 결정
		   String Query1 = "SELECT max(RcdNo) FROM board";
		   pstmt = conn.prepareStatement(Query1);
		   rs1 = pstmt.executeQuery();
		   rs1.next();
		   
		   int new_rno = rs1.getInt(1)+1;
		   
		   //-----------------------부모 레코드의 필드 값 추출
		   String Query2 = "SELECT GrpNo,RcdLevel,RcdOrder FROM board WHERE RcdNo=?";
		   pstmt = conn.prepareStatement(Query2);
		   pstmt.setInt(1,rno);
		   rs2 = pstmt.executeQuery();
		   rs2.next();
		   
		   int gno = rs2.getInt(1);
		   int level = rs2.getInt(2);
		   int order = rs2.getInt(3);
		   int new_level = level+1;
		   int new_order = order+1;
				   
		   //--------------------기존 레코드의 RcdOrder 필드 값 재설정
		   
		   String Query3 = "UPDATE board SET RcdOrder=RcdOrder+1 WHERE GrpNo=? AND RcdOrder>?";
		   pstmt = conn.prepareStatement(Query3);
		   pstmt.setInt(1,gno);
		   pstmt.setInt(2,order);
		   pstmt.executeUpdate();
		   
		   //---------------<FORM>구성 요소 추ㅜㄹ과 입력 필드 값 생성
		   String name = request.getParameter("name");
		   String mail = request.getParameter("mail");
		   String subject = request.getParameter("subject");
		   String content = request.getParameter("content");
		   String pass = request.getParameter("pass");
		   String filename = null;
		   int filesize = 0;
		   int refer =0;
		   long now = System.currentTimeMillis();
		   
		   //-----------------------답변 레콛 저장
		   String Query4 = "INSERT INTO board VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		   pstmt = conn.prepareStatement(Query4);
		   pstmt.setInt(1,new_rno);
		   pstmt.setInt(2,gno);
		   pstmt.setString(3,name);
		   pstmt.setString(4,mail);
		   pstmt.setString(5,subject);
		   pstmt.setString(6,content);
		   pstmt.setString(7,pass);
		   pstmt.setString(8,filename);
		   pstmt.setInt(9,filesize);
		   pstmt.setLong(10,now);
		   pstmt.setInt(11,refer);
		   pstmt.setInt(12,new_level);
		   pstmt.setInt(13,new_order);
		   
		   pstmt.executeUpdate();
		   
	}catch(SQLException e){
		out.print(e);
	}finally{
		
		
		rs2.close();
		rs1.close();
		pstmt.close();
		conn.close();
		String retUrl = "BoardList.jsp?column="+ column+ "&key=" + encoded_key;
		response.sendRedirect(retUrl);
		
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