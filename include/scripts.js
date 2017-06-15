//-------------------------------------------전자우편주소 형식 검사(예쓸이거)
function isCorrectEmail(fname, ename) 
{

   var i;
   var position_at = 0;
   var dot = 0;
   var id = "";
   var server = "";

   var email = eval("document." + fname + "." + ename);

   for (i = 0; i < email.value.length; i++) 
   {
      if(email.value.charAt(i) == '@') 
      {
         position_at = position_at + 1;
      }
      else if (position_at == 0) 
      {
         id = id + email.value.charAt(i);
      } 
      else 
      {
         server = server + email.value.charAt(i);
      }
   }

   
   if (position_at >= 2 || position_at == 0) 
   {
      return false;
   }
   
   
   for (i = 0; i < id.length; i++) 
   {
      if (!((id.charAt(i) >= 'A' && id.charAt(i) <= 'z')
            || (id.charAt(i) >= '0' && id.charAt(i) <= '9')
            || (id.charAt(i) == '_') || (id.charAt(i) == '-'))) 
      {
         return false;
      }
   }

   for (i = 0; i < server.length; i++) 
   {
      if (server.charAt(i) == '.') 
      {
         dot = dot + 1;
      }
   }

   if (dot < 1) 
   {
      return false;
   }

   if (server.charAt(server.length - 1) == '.') 
   {
      return false;
   }

   for (i = 0; i < server.length; i++) 
   {
      if (!((server.charAt(i) >= 'A' && server.charAt(i) <= 'z')
            || (server.charAt(i) >= '0' && server.charAt(i) <= '9')
            || (server.charAt(i) == '.') || (server.charAt(i) == '-'))) 
      {
         return false;
      }
   }

   return true;
}

//------------한글만 입력되는 함수

function Korean(){
	
	
	if(event.ctrlKey||event.shiftKey||event.shiftLift||event.altKey){
		event.returnValue = false;
		return false;
	}
	
	if((event.keyCode == 8
			||event.keyCode == 9
			||event.keyCode == 35
			||event.keyCode == 36
			||event.keyCode == 37
			||event.keyCode == 39
			||event.keyCode == 46));
	{
		event.returnValue = true;
		return;
	}
	
	if((event.keyCode <12592 || event.keyCode > 12687))
		{
		event.returnValue =false;
		return false;
		}
}