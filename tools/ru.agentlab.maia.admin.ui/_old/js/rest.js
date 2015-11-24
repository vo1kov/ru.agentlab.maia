function getHttpRequest(){
  var request;
  try {
	request = new ActiveXObject("Msxml2.XMLHTTP");
  } catch (e) {
	try {
	  request = new ActiveXObject("Microsoft.XMLHTTP");
	} catch (E) {
	  request = false;
	}
  }
  if (!request && typeof XMLHttpRequest!='undefined') {
	request = new XMLHttpRequest();
  }
  return request;
}