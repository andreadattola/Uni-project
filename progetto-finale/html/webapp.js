var iframe_presentazione = document.getElementById('presentazione');
//var files_html = ["7694_086.html","7694_088.html"];
var contenuti = new array();



function appendi_nodo_menu(file) {
  var a = document.createElement('option');
  a.innerHTML = file;
  a.value = file;
  document.getElementById('menu').appendChild(a);
}

function popola_menu() {
  var i;
  for (i=0;i<files_html.length;i++) {
    appendi_nodo_menu(files_html[i]);
  }
}

function cambia_contenuto() {
  var e = document.getElementById("menu");
  var link = e.options[e.selectedIndex].text;
  document.getElementById('presentazione').src = link;
  document.getElementById('titolo').innerHTML = "Visualizzazione file: ";
}
