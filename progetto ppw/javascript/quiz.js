function gestoreClickResetta() { //resetto il quiz
  try {
    nuovoQuiz();
  } catch (e) {
    alert("gestoreClickResetta " + e);
  }
}

function gestoreClickAvanti() { // vado avanti nella domanda e salvo la rispota
  try {
    if (numeroDomandaCorrente == numeroDomande) {

      return;
    }
    if (nodoRisposta0.checked) {

      risposteDate[numeroDomandaCorrente] = 0;
    } else if (nodoRisposta1.checked) {

      risposteDate[numeroDomandaCorrente] = 1;
    } else if (nodoRisposta2.checked) {

      risposteDate[numeroDomandaCorrente] = 2;
    } else {

      return;
    }

    if (risposteDate[numeroDomandaCorrente] == quiz[numeroDomandaCorrente].rispostaEsatta) {

      move();
    }

    numeroDomandaCorrente++;

    if (numeroDomandaCorrente == numeroDomande) {
      var esito = calcolaEsito();
      var s;
      if (esito == 1) {
        s = "1 risposta esatta su " + numeroDomande;
      } else {
        s = esito + " risposte esatte su " + numeroDomande;
      }
      scriviMessaggio(nodoRisultato, s);
    } else {
      aggiornaDomanda(numeroDomandaCorrente);
    }

  } catch (e) {
    alert("gestoreClickAvanti " + e);
  }
}

var width = 0;

function move() { //gestisco la progressione della barra
  var elem = document.getElementById("myBar");

  var id = setInterval(frame, 10);

  width += 25;

  function frame() {

    if (width > 100) {
      clearInterval(id);
    } else {

      elem.style.width = width + '%';
    }
  }
}

function calcolaEsito() { //calcolo le risposte giuste

  var numeroRisposteEsatte = 0;
  for (var i = 0; i < quiz.length; i++) {

    var parte = quiz[i];
    if (parte.rispostaEsatta == risposteDate[i]) {

      numeroRisposteEsatte++;
    }
  }
  return numeroRisposteEsatte;
}

function nuovoQuiz() {

  width = 0;
  numeroDomandaCorrente = 0;
  aggiornaDomanda(numeroDomandaCorrente);
  scriviMessaggio(nodoRisultato, "");
  risposteDate = [];
}

function aggiornaDomanda(i) {

  scriviMessaggio(
    nodoNumeroDomanda,
    "Domanda " + (i + 1) + " di " + numeroDomande
  );

  var parte = quiz[i];

  scriviMessaggio(nodoTestoDomanda, parte.domanda)
  scriviMessaggio(nodoTestoRisposta0, parte.risposte[0]);
  scriviMessaggio(nodoTestoRisposta1, parte.risposte[1]);
  scriviMessaggio(nodoTestoRisposta2, parte.risposte[2]);

  nodoRisposta0.checked = false;
  nodoRisposta1.checked = false;
  nodoRisposta2.checked = false;
}

function scriviMessaggio(nodo, messaggio) {

  var nodoTesto = document.createTextNode(messaggio);

  if (nodo.childNodes.length == 0) {

    nodo.appendChild(nodoTesto);
  } else {

    nodo.replaceChild(nodoTesto, nodo.firstChild);
  }
}

var nodoNumeroDomanda;
var nodoTestoDomanda;
var nodoRisposta0;
var nodoTestoRisposta0;
var nodoRisposta1;
var nodoTestoRisposta1;
var nodoRisposta2;
var nodoTestoRisposta2;
var nodoAvanti;
var nodoRisultato;
var nodoResetta;
var numeroDomande;
var numeroDomandaCorrente;
var risposteDate;

function gestoreLoad() {

  try {

    nodoNumeroDomanda = document.getElementById("numeroDomanda");
    nodoTestoDomanda = document.getElementById("testoDomanda");
    nodoRisposta0 = document.getElementById("risposta0");
    nodoTestoRisposta0 = document.getElementById("testoRisposta0");
    nodoRisposta1 = document.getElementById("risposta1");
    nodoTestoRisposta1 = document.getElementById("testoRisposta1");
    nodoRisposta2 = document.getElementById("risposta2");
    nodoTestoRisposta2 = document.getElementById("testoRisposta2");
    nodoAvanti = document.getElementById("avanti");
    nodoRisultato = document.getElementById("risultato");
    nodoResetta = document.getElementById("inizia");

    nodoAvanti.onclick = gestoreClickAvanti;
    nodoResetta.onclick = gestoreClickResetta;
    numeroDomande = quiz.length;
    nuovoQuiz();

  } catch (e) {

    alert("gestoreLoad" + e);
  }
}

window.onload = gestoreLoad;

var quiz = [{
    domanda: "A QUALE RITMO OCCORRE ALLENARSI PER OTTENERE RISULTATI?",
    risposte: [
      "È la pratica regolare che darà piacere e risultati",
      "il meno possibile",
      "più volte al giorno senza stop"
    ],
    rispostaEsatta: 0
  },
  {
    domanda: "QUAL È L’ERRORE PIÙ FREQUENTE DA NON COMMETTERE IN PALESTRA?",
    risposte: [
      "eseguire esercizi inadeguati che possono essere causa di infortuni",
      "allenarsi seriamente",
      "essere disposti a concentrarsi sull'allenamento in modo serio"
    ],
    rispostaEsatta: 0
  },
  { // domanda 2
    domanda: "QUALE ESERCIZIO DEVO FARE PER AVERE UNA PANCIA PIATTA?",
    risposte: [
      "fare centinaia di addominali",
      "correre ore",
      "l'esercizio perfetto è allenarsi e stabilire una buona dieta"
    ],
    rispostaEsatta: 2
  },
  { // domanda 3
    domanda: "IL GRASSO SI TRASFORMA IN MUSCOLO?",
    risposte: [
      "Certamente infatti meglio essere grassi per avere risultati",
      "No! I muscoli consumano i grassi",
      "No il grasso è il muscolo"
    ],
    rispostaEsatta: 1
  }
];
