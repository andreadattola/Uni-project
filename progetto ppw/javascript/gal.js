function cambiaFoto(x){ // funzione che cambia l'immagine nella galleria
	indice += x;
	if (indice == numeroFoto){
			indice = 0;
		}
	if (indice < 0){
			indice = numeroFoto-1;
		}
	var elemento = galleria[indice];
	nodoFoto.setAttribute("src", elemento.immagine);
}

//gestori
function gestoreClickIndietro(){
	try{
		cambiaFoto(-1);
	}
	catch(e){
		alert("gestoreClickIndietro " +e);
	}
}

function gestoreClickAvanti(){
	try{
		cambiaFoto(1);
	}
	catch(e){
		alert("gestoreClickAvanti " +e);
	}
}

//variabili globali
const numeroFoto = 8;
var nodoIndietro;
var nodoAvanti;
var nodoFoto;
var indice=0;


//function gestoreLoad
function gestoreLoad(){
	try{
		nodoIndietro = document.getElementById("indietro");
		nodoAvanti = document.getElementById("avanti");
		nodoFoto = document.getElementById("fotoGalleria");
		nodoIndietro.onclick = gestoreClickIndietro;
		nodoAvanti.onclick = gestoreClickAvanti;
		cambiaFoto(0);
	}
	catch(e){
		alert("gestoreLoad " +e);
	}
}

window.onload = gestoreLoad;

//contenuti
var galleria = [
	{
		immagine: "images/1.jpg",

	},
	{
		immagine: "images/2.jpg",

	},
	{
		immagine: "images/3.jpg",

	},
	{
		immagine: "images/4.jpg",

	},
	{
		immagine: "images/5.jpg",
	},
	{
		immagine: "images/6.jpg",
	},
	{
	    immagine: "images/7.jpg",
	},
	{
		immagine: "images/8.jpg",
	}
];
