//log(type, string, callstack)
#macro TEXT 0
#macro ERROR 1
#macro WARNING 2
#macro SEPARATOR 3
#macro TITLE 4

switch(argument0)
{
  case TEXT:
    file_text_write_string(Game.Log, argument1); file_text_writeln(Game.Log); break;
    
  case ERROR:
    file_text_write_string(Game.Log, "ERROR: " + argument1); file_text_writeln(Game.Log); break;
    
  case WARNING:
    file_text_write_string(Game.Log, "///!\\\ " + argument1); file_text_writeln(Game.Log); break;
    
  case SEPARATOR:
    file_text_write_string(Game.Log, "--------------------------------------------"); file_text_writeln(Game.Log); break;
    
  case TITLE:
    file_text_write_string(Game.Log, "{---------------- " + argument1 + " ----------------}"); file_text_writeln(Game.Log); break;
}

if(argument2 != 0)
{
  file_text_write_string(Game.Log, ">>>>>>>>>>>>>Call Stack<<<<<<<<<<<<<"); file_text_writeln(Game.Log);
  
  var stack_depth = array_length_1d(argument2);
  for(var i = stack_depth - 1; i >= 0; i--)
  {
    file_text_write_string(Game.Log, argument2[i]); file_text_writeln(Game.Log);
  }
  
  file_text_write_string(Game.Log, ">>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<"); file_text_writeln(Game.Log);
}