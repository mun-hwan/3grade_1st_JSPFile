<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<%request.setCharacterEncoding("euc-kr");%>

<%
// -----------��ü ����
Connection conn =null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{

//------------ JDBC ����
String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb";
String jdbcId = "jspuser";
String jdbcPw ="jsppass";


Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);

//-----------------���۵� �������� ����
String name = request.getParameter("name");
String mail = request.getParameter("mail");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
String pass = request.getParameter("pass");

//-----------------���ο� ���ڵ��� RcdNo��GrpNo ����

String Query1 = "SELECT max(RcdNo),max(GrpNo) FROM board";
stmt = conn.createStatement();
rs = stmt.executeQuery(Query1);

rs.next();

int uid = (rs.getInt(1))+1;
int gid = (rs.getInt(2))+1;

//--------------------------��Ÿ �Է� ������ ����

String filename = null;
int filesize =0;
int refer =0 ;
int level=0;
int order =1;
long now = System.currentTimeMillis();

//--------------------�Է� ���� ����

String Query2 = "INSERT INTO board VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
pstmt = conn.prepareStatement(Query2);
pstmt.setInt(1,uid);
pstmt.setInt(2,gid);
pstmt.setString(3,name);
pstmt.setString(4,mail);
pstmt.setString(5,subject);
pstmt.setString(6,content);
pstmt.setString(7,pass);
pstmt.setString(8,filename);
pstmt.setInt(9,filesize);
pstmt.setLong(10,now);
pstmt.setInt(11,refer);
pstmt.setInt(12,level);
pstmt.setInt(13,order);

pstmt.executeUpdate();

}catch(SQLException e){

out.print(e);
}
finally{
	//---------------------���ּ��� ��ü�� ���ſ� ������ �̵�
	
	rs.close();
	pstmt.close();
	conn.close();
	
	response.sendRedirect("BoardList.jsp");
}
%>