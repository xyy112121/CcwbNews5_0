
function getiostoke1()
{
  //  window.webkit.messageHandlers.getiostoke1.postMessage();
//    alert(window.localStorage.getItem('authorization'));
}

function uploadiostoken(token)
{
    
    var tokennow=token;
    window.localStorage.setItem('authorization',tokennow);
//    alert(token);
}



window.onload=function (){
    
}
