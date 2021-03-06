google.load("visualization", "1.1", {packages:["table"]});

var columna = 2;

var jsonData = $.ajax({
     url: "table/table_mid.json",
     dataType:"json",
     async: false
     }).responseText;

function drawTable_Top(){
  jsonData = $.ajax({
       url: "table/table_top.json",
       dataType:"json",
       async: false
       }).responseText;

  columna = 2;

  drawTable();
}

function drawTable_Jungle(){
  jsonData = $.ajax({
       url: "table/table_jungle.json",
       dataType:"json",
       async: false
       }).responseText;

  columna = 2;

  drawTable();
}

function drawTable_Mid(){
  jsonData = $.ajax({
       url: "table/table_mid.json",
       dataType:"json",
       async: false
       }).responseText;

  columna = 2;

  drawTable();
}

function drawTable_Bot(){
  jsonData = $.ajax({
       url: "table/table_bote.json",
       dataType:"json",
       async: false
       }).responseText;

  columna = 3;

  drawTable();
}


function drawTable() {
  var data = new google.visualization.DataTable(jsonData);

  var options = {'allowHtml': true,
                 'width': '100%',
                 'height': '100%',
                 cssClassNames : {
                   headerRow: 'tabla-header',
                   tableRow: 'tabla-row',
                   oddTableRow: 'tabla-row-odd',
                   headerCell: 'header-cell',
                   hoverTableRow: 'hover-row',
                   selectedTableRow: 'selected-row', 
                   tableCell: 'table-cell'
                   },
		  sortAscending: false,
		  sortColumn: columna
                };

  var table = new google.visualization.Table(document.getElementById('champ_table'));

  table.draw(data, options);
}


