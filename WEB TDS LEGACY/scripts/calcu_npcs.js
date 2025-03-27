var npcexp = [5000,10,1500,1200,1500,300,2500,6000,2500,180000,40,15000,400000,160,100,32,47,138,10000,20,95,400000,4000,300000,5,700,850,9000,3000,100,1000,2500,323,4500,15000,12,3000,395,1500,800,2000,4500,500,5000000,5,15,500,1000,500,800,2500,60];
var explvl = [0,300,450,675,1012,1518,2277,3416,5124,7886,11529,14988,19484,25329,32928,42806,55648,72342,94045,122259,158937,206618,268603,349184,453939,544727,667632,784406,941287,1129544,1355453,1626544,1951853,2342224,3372803,4047364,5828204,6993845,8392614,10071137,120853640,145024370,174029240,208835090,417670180,835340360,1670680720,1670680720];

function calcular() {


    var EXPMULT = 7;
    resultado = document.getElementById("resultados");
    resultado.style.display = "none";
    var nivel = parseInt(document.getElementById("lvl").value);
    var porc = parseInt(document.getElementById("pors").value);
    var npc = parseInt(document.getElementById("npc").value);

    if (isNaN(porc)) porc=0;    
    if (porc > 100 ) porc=100;
    if (porc < 0 ) porc=0;
    
    if (isNaN(nivel) || nivel <= 0 || nivel > 46) { alert('El nivel ingresado NO es correcto.'); return false; }
    if (isNaN(porc) || porc < 0 || porc > 100) { alert('El porcentaje ingresado NO es correcto.'); return false; }
    if (isNaN(npc) || npc < 0 || npc > 51) { alert('La criatura seleccionada NO es correcta.'); return false; }

    var elu=explvl[nivel];
    var expactual=(porc*elu) /100;
    var tot = 0;
    while (expactual < elu) {
        expactual+= (npcexp[npc]*EXPMULT);
        tot++;
    }
    const combox = document.getElementById('npc');
    var value = combox.value;
    var criat = combox.options[combox.selectedIndex].text;
	
    document.getElementById("resultados").innerHTML = "Necesitas matar " + tot + " " + criat;

    if (nivel >= 40 && (npcexp[npc]*EXPMULT) < (15000*EXPMULT) ){
 	document.getElementById("alert").innerHTML = "¡Atención, siendo nivel " + nivel + " conviene ir a lugares peligrosos como Dungeon Magma!<br><br>";
    }else if (tot > 1000) {
        document.getElementById("alert").innerHTML ="Consejo: Ésta criatura da muy poca experiencia para tu nivel, prueba matando otro monstruo que de más experiencia.<br><br>";
    }else{ document.getElementById("alert").innerHTML ="";
    }
    resultado.style.display = ``;
    return true;
}