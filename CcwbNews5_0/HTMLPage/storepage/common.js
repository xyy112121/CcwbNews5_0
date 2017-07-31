
function getiostoke1()
{
  //  window.webkit.messageHandlers.getiostoke1.postMessage();
//    alert(window.localStorage.getItem('authorization'));
}

function uploadiostoken(token)
{
//    alert(1);
    var tokennow=token;
    window.localStorage.setItem('authorization',tokennow);
}



window.onload=function (){
//    alert(window.localStorage.getItem('authorization'));
}
