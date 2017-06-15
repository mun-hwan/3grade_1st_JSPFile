<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

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
	   
	   String Query1 = "SELECT UsrName,UsrMail,UsrSubject,UsrContent FROM board WHERE RcdNo=?";
	   pstmt = conn.prepareStatement(Query1);
	   pstmt.setInt(1,rno);
	   
	   rs = pstmt.executeQuery();
	   rs.next();
	   
	   String name = rs.getString(1);
	   String mail = rs.getString(2);
	   String subject = rs.getString(3);
	   String content = rs.getString(4);
%>

<HTML>
<HEAD>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
	<LINK REL="stylesheet" type="text/css" href="../include/style.css"/>
	<TITLE>게시글 수정</TITLE>
	
	<script type="text/javascript">
	function CheckForm(form){
		if(!form.subject.value){
			alert('게시판의 제목을 입력하세요.');
			form.subject.focus();
			return true;
		}
		form.submit();
	}

	</script>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
	<TR BGCOLOR=#A0A0A0>
		<TD ALIGN=CENTER><FONT SIZE=4><B>게시판 ( 게시글 수정 )</B></FONT></TD>
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
//------------------------------- JSP CODE END 	
%>

<FORM NAME="BoardModify" METHOD=POST ACTION="BoardModifyProc.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>">

<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>이름</B></TD>
		<TD WIDTH=500><%=name %></TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>전자우편</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=TEXT NAME="mail" SIZE=60 value='<%=mail %>' style="ime-mode:inactive">
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>제목</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=TEXT NAME="subject" SIZE=70 value='<%=subject%>'>
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>내용</B></TD>
		<TD WIDTH=500>
			<TEXTAREA NAME="content" COLS=70 ROWS=5><%=content%></TEXTAREA>
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>첨부 파일</B></TD>
		<TD WIDTH=500>
			첨부된 파일이 없습니다.	
		</TD>
	</TR>
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>새첨부파일</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=FILE NAME="filename" SIZE=50>&nbsp;			
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>패스워드</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
		</TD>
	</TR>
	
</TABLE>

</FORM>
<%
} catch(SQLException e){
	e.printStackTrace();
}finally{
	rs.close();
	pstmt.close();
	conn.close();
}


%>
<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

	<TR ALIGN=CENTER>
		<TD>
			<IMG SRC="../images/btn_mdfy.gif" onClick="javascript:CheckForm(BoardModify)" STYLE=CURSOR:HAND>&nbsp;&nbsp;
			<IMG SRC="../images/btn_cancel.gif" onClick="javascript:location.replace('BoardContent.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>')" STYLE=CURSOR:HAND>
		</TD>
	</TR>
	
</TABLE>

</BODY>
</HTML>