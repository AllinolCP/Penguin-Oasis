var hasOpenedPrivateMessenger=false;function setMyKey(e,t){privateMessenger.myID=t;privateMessenger.myPMKey=e;}
function showOutsideContent(e,t){var n=document.getElementById(e);if(n==undefined)
return"unknown";if(e=="transformManager"){if(hasOpenedTrans==false)
createTransformations()}
if(e=="userRate"){if(t!=undefined&&!isNaN(t)){document.getElementById("userRate").style.display="block"}}
if(e=='privateMessenger'){if(hasOpenedPrivateMessenger==false){hasOpenedPrivateMessenger=true;privateMessenger.loadMessages();privateMessenger.openMessenger();return true;}
document.getElementById('privateMessenger').style.display='block';}
n.style.display="block"}
function closeOutsideContent(e){var t=document.getElementById(e);if(t==undefined)
return"unknown";t.style.display="none";thisMovie("oasis_load").hideOutsideContent()}
function thisMovie(e){if(navigator.appName.indexOf("Microsoft")!=-1){return window[e]}else{return document[e]}}