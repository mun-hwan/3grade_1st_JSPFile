<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.SimpleDateFormat" %> 
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder" %>

<%request.setCharacterEncoding("euc-kr"); %>

<%
//---------------------------------- 변수 및 객체 선언

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs1 = null;
ResultSet rs2 = null;

int TotalRecords = 0;

String Query1=" ";
String Query2=" ";
String encoded_key=" ";


//-------------------키워드 데이터 추출

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
   
   //------------------------------- 질의의 생성과 객체의 생성
   if(column.equals("")||key.equals(""))
   {
	   Query1 = "SELECT count(RcdNo) FROM board";
	   Query2 = "SELECT RcdNo, UsrSubject, UsrName, UsrDate, UsrRefer, RcdLevel FROM board ORDER BY GrpNo DESC, RcdOrder ASC";
   }else{
	   Query1 = "SELECT count(RcdNo) FROM board WHERE " + column + " LIKE '%" +key + "%'";
	   Query2 = "SELECT RcdNo, UsrSubject, UsrName, UsrDate, UsrRefer, RcdLevel FROM board WHERE "+
	   			 column+" LIKE '%"+key+"%'" +" ORDER BY GrpNo DESC, RcdOrder ASC";
   }
   pstmt = conn.prepareStatement(Query1);
   rs1 = pstmt.executeQuery();
   pstmt = conn.prepareStatement(Query2);
   rs2 = pstmt.executeQuery();   
   
   //------------------------------- 전체 레코드 수 추출
   rs1.next();
   TotalRecords = rs1.getInt(1);
   
%>   

<HTML>
<HEAD>
   <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
   <LINK REL="stylesheet" type="text/css" href="../include/style.css"/>   
   <TITLE>게시글 리스트</TITLE>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
   <TR BGCOLOR=#A0A0A0>
      <TD ALIGN=CENTER><FONT SIZE=4><B>게시판 ( 리스트 )</B></FONT></TD>
   </TR>
</TABLE>

<%
//------------------------------- JSP CODE START ( 세션 변수에 따른 문서 선택 )
   String member_id = (String)session.getAttribute("member_id");
   if(member_id == null) {
%>
      <jsp:include page="../member/LoginForm.jsp"/>
<% 
   } else { 
%>      
      <jsp:include page="../member/LoginState.jsp"/>   
<% 
   }
%>
 
<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

   <TR ALIGN=CENTER>
      <TD WIDTH=45><B>번호</B></TD>
      <TD WIDTH=395><B>제목</B></TD>
      <TD WIDTH=65><B>작성자</B></TD>
      <TD WIDTH=70><B>작성일</B></TD>
      <TD WIDTH=45><B>참조</B></TD>
   </TR>
   
<%
   //------------------------------- 순환문을 이용한 레코드 출력 시작
   while(rs2.next()) {
      
      //--------------------------- 필드 데이터 추출과 출력
      int rno = rs2.getInt("RcdNo");
      
      String subject = rs2.getString("UsrSubject");
   
      String name = rs2.getString("UsrName");
      
      long date = rs2.getLong("UsrDate");   
      SimpleDateFormat Current = new SimpleDateFormat("yyyy/MM/dd"); 
      String today = Current.format(date); 
   
      int refer = rs2.getInt("UsrRefer");
      int level = rs2.getInt("RcdLevel");
%>    

   <TR>   
      <TD WIDTH=45 ALIGN=CENTER><%=TotalRecords%></TD>
      <TD WIDTH=395 ALIGN=LEFT>
      
      <%
      //----------------
      for(int i =0;i<level;i++) out.println("&nbsp;&nbsp;");
      if(level>0)
      {
    	  String IMGURL="../images/re.gif";
    	  out.println("<IMG ALIGN=ABSMIDDLE SRC=" + IMGURL+">");
      }
      
      //------------------긴 문자열 처리
      int max_length=28;
      int cut_length = max_length-(level);
      
      if(subject.length() > cut_length)
      {
    	  subject = subject.substring(0,cut_length);
    	  subject = subject + "...";
      }
      //------------------------
      
      %>
      <A HREF="BoardContent.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>"><%=subject%></A>
      <%
      //-----------------
      long now = System.currentTimeMillis();
      long dist = (now-date)/1000;
      long during = 60*60*24;
      
      if(dist<during) {
    	  String IMGURL="../images/new.gif";
    	  out.println("<IMG ALIGN=ABSMIDDLE width=15 HEIGHT=12 SRC=" + IMGURL+">");
      }
      //---------------
      %>
      </TD>
      <TD WIDTH=65 ALIGN=CENTER><%=name%></TD>
      <TD ALIGN=CENTER><%=today%></TD>
      <TD ALIGN=CENTER><%=refer%></TD>
   </TR>
      
<%
   //------------------------------- 순환문을 이용한 레코드 출력  종료
   TotalRecords--;
}
%> 

</TABLE>

<FORM NAME="BoardSearch" METHOD=POST action="BoardList.jsp">

<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

   <TR>
      <TD ALIGN=LEFT WIDTH=100>
         <IMG SRC="../images/btn_new.gif" onClick="javascript:location.replace('BoardWrite.jsp?column=<%=column%>&key=<%=encoded_key%>')" STYLE=CURSOR:HAND>
      </TD>
      <TD WIDTH=320 ALIGN=CENTER>
         <IMG SRC="../images/btn_bf_block.gif">&nbsp;
         <IMG SRC="../images/btn_bf_page.gif">&nbsp;       
         1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6&nbsp;&nbsp;7&nbsp;&nbsp;8&nbsp;&nbsp;9&nbsp;&nbsp;10&nbsp;
         <IMG SRC="../images/btn_nxt_page.gif">&nbsp; 
         <IMG SRC="../images/btn_nxt_block.gif">                      
      </TD>
      <TD WIDTH=200 ALIGN=RIGHT>
         <SELECT NAME="column" SIZE=1>
            <OPTION VALUE="" SELECTED>선택</OPTION>
            <OPTION VALUE="UsrSubject">제목</OPTION>
            <OPTION VALUE="UsrContent">내용</OPTION>
         </SELECT> 
         <INPUT TYPE=TEXT NAME="key" SIZE=10 MAXLENGTH=20> 
         <IMG SRC="../images/btn_search.gif" ALIGN=absmiddle STYLE=CURSOR:HAND onClick="javascript:submit()">
      </TD>    
   </TR>
   
</TABLE>

</FORM>

<%
}
catch (SQLException e) {
   
   e.printStackTrace();
   
} finally {
   //------------------------------- 생성된 객체 제거
    rs2.close();
    rs1.close();
    pstmt.close();
    conn.close();   
}
%>
</BODY>
</HTML>
