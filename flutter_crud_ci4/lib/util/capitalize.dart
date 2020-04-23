String capitalize(String str){

  if(str == null) return '';

  return "${str[0].toUpperCase() + str.substring(1)}";
  
}