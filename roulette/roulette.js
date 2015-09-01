var margin = {top: -90, right: 0, bottom: 0, left: -120};

var width = 820 - margin.left - margin.right,
    height = 750 - margin.top - margin.bottom;

var bottom = 0;
var ruleta = "roulette/champions_mid.json";
var icono_width = 32;
var icono_height = 32;

function mid_roulette()
{
  d3.select("svg").remove();
  bottom = 0;
  ruleta = "roulette/champions_mid.json";
  roulette(ruleta)
}

function jungle_roulette()
{
  d3.select("svg").remove();
  bottom = 0;
  ruleta = "roulette/champions_jungle.json";
  roulette(ruleta)
}

function top_roulette()
{
  d3.select("svg").remove();
  bottom = 0;
  ruleta = "roulette/champions_top.json";
  roulette(ruleta)
}

function bot_roulette()
{
  d3.select("svg").remove();
  bottom = 1;
  ruleta = "roulette/champions_boti.json";
  roulette(ruleta)
}

function roulette(ruleta){
var svg = d3.select("#mid").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    /*.attr("style", "outline: thin solid red;") */
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");



var force = d3.layout.force()
    .gravity(0)
    .distance(100)
    .charge(-100)
    .size([width, height]);

d3.json(ruleta, function(error, json) {
  if (error) throw error;

  force
      .nodes(json.nodes)
      .links(json.links)
      .start();


  var link = svg.selectAll(".link")
      .data(json.links)
      .enter().append("path")
      .attr("class", "link");

  var node = svg.selectAll(".node")
      .data(json.nodes)
      .enter().append("g")
      .attr("class", "node")
      .attr("x", function(d) { return d.x;})
      .attr("y", function(d) { return d.y;})
      .on("mouseover",mouseovered)
      .on("mouseout",mouseouted);

  function mouseovered(d) 
  {
    var g = d3.select(this);
    var info = g.append('text')
        .classed('name',true)
        .attr('x', positionx)
        .attr('y', positiony)
        .style("fill","white")
        .style("font-size","18px")
        .text(function(d) { return d.name; });

    g.select("image")
     .attr("width",icono_width*1.5)
     .attr("height",icono_height*1.5);
  
   link.style('stroke-width', function(l) {
      if (d === l.source )
        return Math.abs(l.value);
      else
        return 0;
      });

   link.style('stroke', function(l) {
      if (d === l.source )
      {
        if(l.value < 0)
        {
          return "red";
        } else if (l.value > 0) {
          return "green";
        }
      }
     });
  }

  function mouseouted(d)
  {
    var g = d3.select(this);

    g.select('text.name').remove();
  
    g.select("image")
     .attr("width",icono_width)
    .attr("height",icono_height);

    link.style('stroke-width', 0.5);
    link.style('stroke', "#ccc");
  }


  function positionx(d)
  {
    var alpha = Math.atan((d.y-350.01)/(d.x-500.01))
    if(bottom===0)
    {
       if(d.x > 501) { return Math.abs(50*Math.cos(alpha))}
       else if (d.x < 499) { return -Math.abs(80*Math.cos(alpha))}
       else { return 0};
    } else {
       if(d.x > 501) { return -Math.abs(100*Math.cos(alpha))}
       else if (d.x < 499) { return Math.abs(60*Math.cos(alpha))}
       else { return 0};
    }
  }

  function positiony(d)
  {
    var alpha = Math.atan((d.y-350.01)/(d.x-500.01))
    if(bottom===0)
    {
      if(d.y > 351) { return Math.abs(70*Math.sin(alpha))}
      else if (d.y < 349) { return -Math.abs(40*Math.sin(alpha))}
      else { return 0};
    } else {
      if(d.y > 351) { return -Math.abs(70*Math.sin(alpha))}
      else if (d.y < 349) { return Math.abs(40*Math.sin(alpha))}
      else { return 0};
    } 
  }

  if(bottom===0)
  {
    var imageByGroup = {
    "1": "roulette/champions/1.png",
    "2": "roulette/champions/2.png",
    "3": "roulette/champions/3.png",
    "4": "roulette/champions/4.png",
    "5": "roulette/champions/5.png",
    "6": "roulette/champions/6.png",
    "7": "roulette/champions/7.png",
    "8": "roulette/champions/8.png",
    "9": "roulette/champions/9.png",
    "10": "roulette/champions/10.png",
    "11": "roulette/champions/11.png",
    "12": "roulette/champions/12.png",
    "13": "roulette/champions/13.png",
    "14": "roulette/champions/14.png",
    "15": "roulette/champions/15.png",
    "16": "roulette/champions/16.png",
    "17": "roulette/champions/17.png",
    "18": "roulette/champions/18.png",
    "19": "roulette/champions/19.png",
    "20": "roulette/champions/20.png",
    "21": "roulette/champions/21.png",
    "22": "roulette/champions/22.png",
    "23": "roulette/champions/23.png",
    "24": "roulette/champions/24.png",
    "25": "roulette/champions/25.png",
    "26": "roulette/champions/26.png",
    "27": "roulette/champions/27.png",
    "28": "roulette/champions/28.png",
    "29": "roulette/champions/29.png",
    "30": "roulette/champions/30.png",
    "31": "roulette/champions/31.png",
    "32": "roulette/champions/32.png",
    "33": "roulette/champions/33.png",
    "34": "roulette/champions/34.png",
    "35": "roulette/champions/35.png",
    "36": "roulette/champions/36.png",
    "37": "roulette/champions/37.png",
    "38": "roulette/champions/38.png",
    "39": "roulette/champions/39.png",
    "40": "roulette/champions/40.png",
    "41": "roulette/champions/41.png",
    "42": "roulette/champions/42.png",
    "43": "roulette/champions/43.png",
    "44": "roulette/champions/44.png",
    "45": "roulette/champions/45.png",
    "48": "roulette/champions/48.png",
    "50": "roulette/champions/50.png",
    "51": "roulette/champions/51.png",
    "53": "roulette/champions/53.png",
    "54": "roulette/champions/54.png",
    "55": "roulette/champions/55.png",
    "56": "roulette/champions/56.png",
    "57": "roulette/champions/57.png",
    "58": "roulette/champions/58.png",
    "59": "roulette/champions/59.png",
    "60": "roulette/champions/60.png",
    "61": "roulette/champions/61.png",
    "62": "roulette/champions/62.png",
    "63": "roulette/champions/63.png",
    "64": "roulette/champions/64.png",
    "67": "roulette/champions/67.png",
    "68": "roulette/champions/68.png",
    "69": "roulette/champions/69.png",
    "72": "roulette/champions/72.png",
    "74": "roulette/champions/74.png",
    "75": "roulette/champions/75.png",
    "76": "roulette/champions/76.png",
    "77": "roulette/champions/77.png",
    "78": "roulette/champions/78.png",
    "79": "roulette/champions/79.png",
    "80": "roulette/champions/80.png",
    "81": "roulette/champions/81.png",
    "82": "roulette/champions/82.png",
    "83": "roulette/champions/83.png",
    "84": "roulette/champions/84.png",
    "85": "roulette/champions/85.png",
    "86": "roulette/champions/86.png",
    "89": "roulette/champions/89.png",
    "90": "roulette/champions/90.png",
    "91": "roulette/champions/91.png",
    "92": "roulette/champions/92.png",
    "96": "roulette/champions/96.png",
    "98": "roulette/champions/98.png",
    "99": "roulette/champions/99.png",
    "101": "roulette/champions/101.png",
    "102": "roulette/champions/102.png",
    "103": "roulette/champions/103.png",
    "104": "roulette/champions/104.png",
    "105": "roulette/champions/105.png",
    "106": "roulette/champions/106.png",
    "107": "roulette/champions/107.png",
    "110": "roulette/champions/110.png",
    "111": "roulette/champions/111.png",
    "112": "roulette/champions/112.png",
    "113": "roulette/champions/113.png",
    "114": "roulette/champions/114.png",
    "115": "roulette/champions/115.png",
    "117": "roulette/champions/117.png",
    "119": "roulette/champions/119.png",
    "120": "roulette/champions/120.png",
    "121": "roulette/champions/121.png",
    "122": "roulette/champions/122.png",
    "126": "roulette/champions/126.png",
    "127": "roulette/champions/127.png",
    "131": "roulette/champions/131.png",
    "133": "roulette/champions/133.png",
    "134": "roulette/champions/134.png",
    "143": "roulette/champions/143.png",
    "150": "roulette/champions/150.png",
    "154": "roulette/champions/154.png",
    "157": "roulette/champions/157.png",
    "161": "roulette/champions/161.png",
    "201": "roulette/champions/201.png",
    "222": "roulette/champions/222.png",
    "223": "roulette/champions/223.png",
    "236": "roulette/champions/236.png",
    "238": "roulette/champions/238.png",
    "245": "roulette/champions/245.png",
    "254": "roulette/champions/254.png",
    "266": "roulette/champions/266.png",
    "267": "roulette/champions/267.png",
    "268": "roulette/champions/268.png",
    "412": "roulette/champions/412.png",
    "421": "roulette/champions/421.png",
    "429": "roulette/champions/429.png",
    "432": "roulette/champions/432.png"
    };

    icono_width = 32;
    icono_height = 32;

    node.append("image")
        .attr("xlink:href", function(d) {return imageByGroup[d.group];})
        .attr("x", -8)
        .attr("y", -8)
        .attr("width", icono_width)
        .attr("height", icono_height);

  } else {
    var imageByGroup = {
    "1": "roulette/adc_sup/duo_1.png",
    "2": "roulette/adc_sup/duo_2.png",
    "3": "roulette/adc_sup/duo_3.png",
    "4": "roulette/adc_sup/duo_4.png",
    "5": "roulette/adc_sup/duo_5.png",
    "6": "roulette/adc_sup/duo_6.png",
    "7": "roulette/adc_sup/duo_7.png",
    "8": "roulette/adc_sup/duo_8.png",
    "9": "roulette/adc_sup/duo_9.png",
    "10": "roulette/adc_sup/duo_10.png",
    "11": "roulette/adc_sup/duo_11.png",
    "12": "roulette/adc_sup/duo_12.png",
    "13": "roulette/adc_sup/duo_13.png",
    "14": "roulette/adc_sup/duo_14.png",
    "15": "roulette/adc_sup/duo_15.png",
    "16": "roulette/adc_sup/duo_16.png",
    "17": "roulette/adc_sup/duo_17.png",
    "18": "roulette/adc_sup/duo_18.png",
    "19": "roulette/adc_sup/duo_19.png",
    "20": "roulette/adc_sup/duo_20.png",
    "21": "roulette/adc_sup/duo_21.png",
    "22": "roulette/adc_sup/duo_22.png",
    "23": "roulette/adc_sup/duo_23.png",
    "24": "roulette/adc_sup/duo_24.png",
    "25": "roulette/adc_sup/duo_25.png",
    "26": "roulette/adc_sup/duo_26.png",
    "27": "roulette/adc_sup/duo_27.png",
    "28": "roulette/adc_sup/duo_28.png",
    "29": "roulette/adc_sup/duo_29.png",
    "30": "roulette/adc_sup/duo_30.png",
    "31": "roulette/adc_sup/duo_31.png",
    "32": "roulette/adc_sup/duo_32.png",
    "33": "roulette/adc_sup/duo_33.png",
    "34": "roulette/adc_sup/duo_34.png",
    "35": "roulette/adc_sup/duo_35.png",
    "36": "roulette/adc_sup/duo_36.png",
    "37": "roulette/adc_sup/duo_37.png",
    "38": "roulette/adc_sup/duo_38.png",
    "39": "roulette/adc_sup/duo_39.png",
    "40": "roulette/adc_sup/duo_40.png",
    "41": "roulette/adc_sup/duo_41.png",
    "42": "roulette/adc_sup/duo_42.png",
    "43": "roulette/adc_sup/duo_43.png",
    "44": "roulette/adc_sup/duo_44.png",
    "45": "roulette/adc_sup/duo_45.png",
    "46": "roulette/adc_sup/duo_46.png",
    "47": "roulette/adc_sup/duo_47.png",
    "48": "roulette/adc_sup/duo_48.png",
    "49": "roulette/adc_sup/duo_49.png",
    "50": "roulette/adc_sup/duo_50.png"
    };

    icono_width = 60;
    icono_height = 32;

    node.append("image")
        .attr("xlink:href", function(d) {return imageByGroup[d.group];})
        /*.attr("x", positionx_icono)
        .attr("y", positiony_icono)*/
        .attr("width", icono_width)
        .attr("height", icono_height)
        /*.attr("transform","rotate(30)");*/
        .attr("transform", function(d){
           var angle = Math.atan2(d.y-350.01,d.x-500.01)*180/Math.PI
           if(angle>90&&angle<180){return "rotate("+(angle+180)+")";}
           else if(angle<-90){return "rotate("+(angle+180)+")";}
           else{return "rotate("+angle+")";}
         })
        .attr("x", function(d){if(d.x<501){return -60;}})
        .attr("y", function(d){if(d.x<501){return -25;}});
  }



    var diagonal = d3.svg.diagonal()
        .source(function(d) { return {"x":d.source.y, "y":d.source.x}; })            
        .target(function(d) { return {"x":d.target.y, "y":d.target.x}; })
        .projection(function(d) { return [d.y, d.x]; });

  force.on("tick", function() {
    link.attr("d",diagonal)

    node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
  });
});
}
