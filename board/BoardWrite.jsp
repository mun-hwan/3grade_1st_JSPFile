<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.net.URLEncoder" %>

<%
String encoded_key = "";

String column = request.getParameter("column");
if(column == null) 
	{column="";}

String key = request.getParameter("key");
if(key!=null){
	encoded_key = URLEncoder.encode(key,"euc-kr");
}else{
	key="";
}

%>

<HTML>
<HEAD>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
	<LINK REL="stylesheet" type="text/css" href="../include/style.css"/>	
	<script language="javascript" src="../include/scripts.js"></script>	
	<TITLE>�Խñ� �Է�</TITLE>
	
	<script type="text/javascript">
	function CheckForm(form)
	{
		if(!form.name.value){
			alert('������ �Է��ϼ���.');
			form.name.focus();
			return true;
		}
		
		/*if(form.mail.value){
			
			if(!isCorrectEmail(BoardWrite,mail)){
			alert('���ڿ��������� �ùٸ��� �ʽ��ϴ�.');
			form.mail.focus();
			form.mail.select();
			return;
			}
			
		}else
			{
			alert('���ڿ��������� �Է��ϼ���.');
			form.mail.focus();
			form.mail.select();
			return true;
			}*/
		
		if(!form.subject.value){
			alert('�Խ����� ������ �Է��ϼ���.');
			form.subject.focus();
			return true;
		}
		if(!form.pass.value){
			alert('�н������� �Է��ϼ���.');
			form.pass.focus();
			return true;
		}
		
		
		form.submit();
	}
	</script>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
	<TR BGCOLOR=#A0A0A0>
		<TD ALIGN=CENTER><FONT SIZE=4><B>�Խ��� ( �Խñ� �Է� )</B></FONT></TD>
	</TR>
</TABLE>

<%
//------------------------------- JSP CODE START ( ���� ������ ���� ���� ���� )
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
//----onKeyDown="javascript:Korean()"
%>

<FORM NAME="BoardWrite" METHOD=POST ACTION="BoardWriteProc.jsp">

<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=2 ALIGN=CENTER>

	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>�̸�</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=TEXT NAME="name" SIZE=20 style="ime-mode:active"
			/>
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>���ڿ���</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=TEXT NAME="mail" SIZE=60 style="ime-mode:inactive">
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=TEXT NAME="subject" SIZE=70>
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����</B></TD>
		<TD WIDTH=500>
			<TEXTAREA NAME="content" COLS=70 ROWS=8></TEXTAREA>
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����÷��</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=FILE NAME="filename" SIZE=60>
		</TD>
	</TR> 
	 
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>�н�����</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
		</TD>
	</TR>
	
</TABLE>

</FORM>

<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

	<TR ALIGN=CENTER>
		<TD WIDTH=110 ALIGN=LEFT>
			<IMG SRC="../images/btn_list.gif" onClick="javascript:location.replace('BoardList.jsp?column=<%=column%>&key=<%=encoded_key%>')" STYLE=CURSOR:HAND>
		</TD>
		<TD WIDTH=400 ALIGN=CENTER>		
			<IMG SRC="../images/btn_save.gif" STYLE=CURSOR:HAND onClick="javascript:CheckForm(BoardWrite)">&nbsp;&nbsp;
			<IMG SRC="../images/btn_cancel.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardList.jsp?column=<%=column%>&key=<%=encoded_key%>')">
		</TD>
		<TD WIDTH=110 ALIGN=LEFT>&nbsp;</TD>   
	</TR>
	
</TABLE>

</BODY>
</HTML>