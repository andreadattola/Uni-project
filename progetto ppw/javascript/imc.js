function gestoreBMI() { //controllo che i valori del nodo altezza e peso siano concordi e dopo di che con la formula apposta calcolo ibm
  try {
    var altezza = nodoAltezza.value
    var peso = nodoPeso.value;

    var t = document.createTextNode("I VALORI DI ALTEZZA E DI PESO DEVONO ESSERE: ES 1.80, 75");

    if((isNaN(nodoAltezza.value)) || (isNaN(nodoPeso.value))){

      nodoSpan.appendChild(t);
      wasNaN = 1;
    } else {

      var x = Number(peso) / (Number(altezza) * Number(altezza));

      var i = 0;

      while(i < situation.length && x >= situation[i].min && x <= situation[i].max){

        i++;
      }

      nodoResult.value = Math.round(x * 100) / 100;
      nodoCateg.value = situation[i].sit;
      for (var i = 0; i < situation.length; i++) {

        if (x >= situation[i].min && x <= situation[i].max) {

          nodoResult.value = Math.round(x * 100) / 100;
          nodoCateg.value = situation[i].sit;
        }
      }

      if(nodoSpan.firstChild){
        nodoSpan.removeChild(nodoSpan.firstChild);
        wasNaN = 0;
      }
    }
  } catch (e) {
    alert(e);
  }
}

function gestoreCompare() { //trovo il risultato dell ibm e scandisco l'array comparando il valore con il range min max della tabella ibm
  try {
    var x = nodoResult.value;

    for (var i = 0; i < situation.length; i++) {

      if (x >= situation[i].min && x <= situation[i].max) {

        alert(situation[i].sit);
      }
    }

  } catch (e) {
    alert(gestoreCompare);
  }
}

var nodoPeso;
var nodoCateg;
var nodoResult;
var nodoAltezza;
var nodoImposta;
var nodoSpan;
var wasNaN = 0;

function gestoreLoad() { //carico il documento e le variabili che mi servono
  try {
    nodoPeso = document.getElementById("peso");
    nodoAltezza = document.getElementById("altezza");
    nodoResult = document.getElementById("result");
    nodoCateg = document.getElementById("categ")
    nodoImposta = document.getElementById("imposta")
    nodoSpan = document.getElementById("nspan")
    nodoImposta.onclick = gestoreBMI;
  } catch (e) {
    alert("gestoreLoad " + e);
  }
}

window.onload = gestoreLoad;

var situation = [{
    sit: "Grave Magrezza",
    min: -100.00,
    max: 16.00
  },
  {
    sit: "sottopeso",
    min: 16.01,
    max: 17.50
  },
  {
    sit: "leggermente sottopeso",
    min: 17.51,
    max: 18.50
  },
  {
    sit: "Normo peso",
    min: 18.51,
    max: 25.00
  },
  {
    sit: "Sovrappeso",
    min: 25.01,
    max: 30.00
  },
  {
    sit: "Obesità di I classe",
    min: 30.01,
    max: 35.00
  },
  {
    sit: "Obesità di II classe",
    min: 35.01,
    max: 40.00
  },
  {
    sit: "Obesità di III classe",
    min: 40.01,
    max: 100.00
  }
];
