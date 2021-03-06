google.load("visualization", "1.1", {packages:["table"]});

function drawTable_Mid(){
  jsonData = $.ajax({
       url: "brawlers/table_brawlers.json",
       dataType:"json",
       async: false
       }).responseText;

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
		sortColumn: 5
                };

  var table = new google.visualization.Table(document.getElementById('brawlers_table'));

  table.draw(data, options);
}


