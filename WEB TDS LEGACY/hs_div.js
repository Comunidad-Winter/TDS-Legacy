states=new Array()
states[0]="recupass_div"
states[1]="miniest_div"
function hideallExcept(elm){for(var i=0;i<states.length;i++){var layer=document.getElementById(states[i]);if(elm!=states[i]){layer.style.display="none";}
else if(layer.style.display=="block"){layer.style.display="none";}
else{layer.style.display="block";}}
return false;}