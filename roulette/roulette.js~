var margin = {top: -90, right: 0, bottom: 0, left: -120};

var width = 820 - margin.left - margin.right,
    height = 750 - margin.top - margin.bottom;

var bottom = 0;
var ruleta = "roulette/personajes_mid.json";
var icono_width = 32;
var icono_height = 32;

function mid_roulette()
{
  d3.select("svg").remove();
  bottom = 0;
  ruleta = "roulette/personajes_mid.json";
  roulette(ruleta)
}

function jungle_roulette()
{
  d3.select("svg").remove();
  bottom = 0;
  ruleta = "roulette/personajes_jungle.json";
  roulette(ruleta)
}

function top_roulette()
{
  d3.select("svg").remove();
  bottom = 0;
  ruleta = "roulette/personajes_topo.json";
  roulette(ruleta)
}

function bot_roulette()
{
  d3.select("svg").remove();
  bottom = 1;
  ruleta = "roulette/personajes_boti.json";
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
    "1": "roulette/personajes/1.png",
    "2": "roulette/personajes/2.png",
    "3": "roulette/personajes/3.png",
    "4": "roulette/personajes/4.png",
    "5": "roulette/personajes/5.png",
    "6": "roulette/personajes/6.png",
    "7": "roulette/personajes/7.png",
    "8": "roulette/personajes/8.png",
    "9": "roulette/personajes/9.png",
    "10": "roulette/personajes/10.png",
    "11": "roulette/personajes/11.png",
    "12": "roulette/personajes/12.png",
    "13": "roulette/personajes/13.png",
    "14": "roulette/personajes/14.png",
    "15": "roulette/personajes/15.png",
    "16": "roulette/personajes/16.png",
    "17": "roulette/personajes/17.png",
    "18": "roulette/personajes/18.png",
    "19": "roulette/personajes/19.png",
    "20": "roulette/personajes/20.png",
    "21": "roulette/personajes/21.png",
    "22": "roulette/personajes/22.png",
    "23": "roulette/personajes/23.png",
    "24": "roulette/personajes/24.png",
    "25": "roulette/personajes/25.png",
    "26": "roulette/personajes/26.png",
    "27": "roulette/personajes/27.png",
    "28": "roulette/personajes/28.png",
    "29": "roulette/personajes/29.png",
    "30": "roulette/personajes/30.png",
    "31": "roulette/personajes/31.png",
    "32": "roulette/personajes/32.png",
    "33": "roulette/personajes/33.png",
    "34": "roulette/personajes/34.png",
    "35": "roulette/personajes/35.png",
    "36": "roulette/personajes/36.png",
    "37": "roulette/personajes/37.png",
    "38": "roulette/personajes/38.png",
    "39": "roulette/personajes/39.png",
    "40": "roulette/personajes/40.png",
    "41": "roulette/personajes/41.png",
    "42": "roulette/personajes/42.png",
    "43": "roulette/personajes/43.png",
    "44": "roulette/personajes/44.png",
    "45": "roulette/personajes/45.png",
    "48": "roulette/personajes/48.png",
    "50": "roulette/personajes/50.png",
    "51": "roulette/personajes/51.png",
    "53": "roulette/personajes/53.png",
    "54": "roulette/personajes/54.png",
    "55": "roulette/personajes/55.png",
    "56": "roulette/personajes/56.png",
    "57": "roulette/personajes/57.png",
    "58": "roulette/personajes/58.png",
    "59": "roulette/personajes/59.png",
    "60": "roulette/personajes/60.png",
    "61": "roulette/personajes/61.png",
    "62": "roulette/personajes/62.png",
    "63": "roulette/personajes/63.png",
    "64": "roulette/personajes/64.png",
    "67": "roulette/personajes/67.png",
    "68": "roulette/personajes/68.png",
    "69": "roulette/personajes/69.png",
    "72": "roulette/personajes/72.png",
    "74": "roulette/personajes/74.png",
    "75": "roulette/personajes/75.png",
    "76": "roulette/personajes/76.png",
    "77": "roulette/personajes/77.png",
    "78": "roulette/personajes/78.png",
    "79": "roulette/personajes/79.png",
    "80": "roulette/personajes/80.png",
    "81": "roulette/personajes/81.png",
    "82": "roulette/personajes/82.png",
    "83": "roulette/personajes/83.png",
    "84": "roulette/personajes/84.png",
    "85": "roulette/personajes/85.png",
    "86": "roulette/personajes/86.png",
    "89": "roulette/personajes/89.png",
    "90": "roulette/personajes/90.png",
    "91": "roulette/personajes/91.png",
    "92": "roulette/personajes/92.png",
    "96": "roulette/personajes/96.png",
    "98": "roulette/personajes/98.png",
    "99": "roulette/personajes/99.png",
    "101": "roulette/personajes/101.png",
    "102": "roulette/personajes/102.png",
    "103": "roulette/personajes/103.png",
    "104": "roulette/personajes/104.png",
    "105": "roulette/personajes/105.png",
    "106": "roulette/personajes/106.png",
    "107": "roulette/personajes/107.png",
    "110": "roulette/personajes/110.png",
    "111": "roulette/personajes/111.png",
    "112": "roulette/personajes/112.png",
    "113": "roulette/personajes/113.png",
    "114": "roulette/personajes/114.png",
    "115": "roulette/personajes/115.png",
    "117": "roulette/personajes/117.png",
    "119": "roulette/personajes/119.png",
    "120": "roulette/personajes/120.png",
    "121": "roulette/personajes/121.png",
    "122": "roulette/personajes/122.png",
    "126": "roulette/personajes/126.png",
    "127": "roulette/personajes/127.png",
    "131": "roulette/personajes/131.png",
    "133": "roulette/personajes/133.png",
    "134": "roulette/personajes/134.png",
    "143": "roulette/personajes/143.png",
    "150": "roulette/personajes/150.png",
    "154": "roulette/personajes/154.png",
    "157": "roulette/personajes/157.png",
    "161": "roulette/personajes/161.png",
    "201": "roulette/personajes/201.png",
    "222": "roulette/personajes/222.png",
    "223": "roulette/personajes/223.png",
    "236": "roulette/personajes/236.png",
    "238": "roulette/personajes/238.png",
    "245": "roulette/personajes/245.png",
    "254": "roulette/personajes/254.png",
    "266": "roulette/personajes/266.png",
    "267": "roulette/personajes/267.png",
    "268": "roulette/personajes/268.png",
    "412": "roulette/personajes/412.png",
    "421": "roulette/personajes/421.png",
    "429": "roulette/personajes/429.png",
    "432": "roulette/personajes/432.png"
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
    "1": "roulette/adc_sup/pareja_1.png",
    "2": "roulette/adc_sup/pareja_2.png",
    "3": "roulette/adc_sup/pareja_3.png",
    "4": "roulette/adc_sup/pareja_4.png",
    "5": "roulette/adc_sup/pareja_5.png",
    "6": "roulette/adc_sup/pareja_6.png",
    "7": "roulette/adc_sup/pareja_7.png",
    "8": "roulette/adc_sup/pareja_8.png",
    "9": "roulette/adc_sup/pareja_9.png",
    "10": "roulette/adc_sup/pareja_10.png",
    "11": "roulette/adc_sup/pareja_11.png",
    "12": "roulette/adc_sup/pareja_12.png",
    "13": "roulette/adc_sup/pareja_13.png",
    "14": "roulette/adc_sup/pareja_14.png",
    "15": "roulette/adc_sup/pareja_15.png",
    "16": "roulette/adc_sup/pareja_16.png",
    "17": "roulette/adc_sup/pareja_17.png",
    "18": "roulette/adc_sup/pareja_18.png",
    "19": "roulette/adc_sup/pareja_19.png",
    "20": "roulette/adc_sup/pareja_20.png",
    "21": "roulette/adc_sup/pareja_21.png",
    "22": "roulette/adc_sup/pareja_22.png",
    "23": "roulette/adc_sup/pareja_23.png",
    "24": "roulette/adc_sup/pareja_24.png",
    "25": "roulette/adc_sup/pareja_25.png",
    "26": "roulette/adc_sup/pareja_26.png",
    "27": "roulette/adc_sup/pareja_27.png",
    "28": "roulette/adc_sup/pareja_28.png",
    "29": "roulette/adc_sup/pareja_29.png",
    "30": "roulette/adc_sup/pareja_30.png",
    "31": "roulette/adc_sup/pareja_31.png",
    "32": "roulette/adc_sup/pareja_32.png",
    "33": "roulette/adc_sup/pareja_33.png",
    "34": "roulette/adc_sup/pareja_34.png",
    "35": "roulette/adc_sup/pareja_35.png",
    "36": "roulette/adc_sup/pareja_36.png",
    "37": "roulette/adc_sup/pareja_37.png",
    "38": "roulette/adc_sup/pareja_38.png",
    "39": "roulette/adc_sup/pareja_39.png",
    "40": "roulette/adc_sup/pareja_40.png",
    "41": "roulette/adc_sup/pareja_41.png",
    "42": "roulette/adc_sup/pareja_42.png",
    "43": "roulette/adc_sup/pareja_43.png",
    "44": "roulette/adc_sup/pareja_44.png",
    "45": "roulette/adc_sup/pareja_45.png",
    "46": "roulette/adc_sup/pareja_46.png",
    "47": "roulette/adc_sup/pareja_47.png",
    "48": "roulette/adc_sup/pareja_48.png",
    "49": "roulette/adc_sup/pareja_49.png",
    "50": "roulette/adc_sup/pareja_50.png"
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
