var margin = {top: -90, right: 0, bottom: 0, left: -120};

var width = 1000 - margin.left - margin.right,
    height = 950 - margin.top - margin.bottom;

function bichos_roulette()
{
  d3.select("svg").remove();
  ruleta = "bichos/bichos.json";
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
  
    g.select("image")
     .attr("width",icono_width)
    .attr("height",icono_height);

    link.style('stroke-width', 0.5);
    link.style('stroke', "#ccc");
  }



  var imageByGroup = {
   "1": "bichos/bichos/1.png",
   "2": "bichos/bichos/2.png",
   "3": "bichos/bichos/3.png",
   "4": "bichos/bichos/4.png",
   "5": "bichos/bichos/5.png",
   "6": "bichos/bichos/6.png",
   "7": "bichos/bichos/7.png",
   "8": "bichos/bichos/8.png",
   "9": "bichos/bichos/9.png",
   "10": "bichos/bichos/10.png",
   "11": "bichos/bichos/11.png",
   "12": "bichos/bichos/12.png",
   "13": "bichos/bichos/13.png",
   "14": "bichos/bichos/14.png",
   "15": "bichos/bichos/15.png",
   "16": "bichos/bichos/16.png",
   "17": "bichos/bichos/17.png",
   "18": "bichos/bichos/18.png",
   "19": "bichos/bichos/19.png",
   "20": "bichos/bichos/20.png",
   "21": "bichos/bichos/21.png",
   "22": "bichos/bichos/22.png",
   "23": "bichos/bichos/23.png",
   "24": "bichos/bichos/24.png",
   "25": "bichos/bichos/25.png",
   "26": "bichos/bichos/26.png",
   "27": "bichos/bichos/27.png",
   "28": "bichos/bichos/28.png",
   "29": "bichos/bichos/29.png",
   "30": "bichos/bichos/30.png",
   "31": "bichos/bichos/31.png",
   "32": "bichos/bichos/32.png",
   "33": "bichos/bichos/33.png",
   "34": "bichos/bichos/34.png",
   "35": "bichos/bichos/35.png",
   "36": "bichos/bichos/36.png",
   "37": "bichos/bichos/37.png",
   "38": "bichos/bichos/38.png",
   "39": "bichos/bichos/39.png",
   "40": "bichos/bichos/40.png",
   "41": "bichos/bichos/41.png",
   "42": "bichos/bichos/42.png",
   "43": "bichos/bichos/43.png",
   "44": "bichos/bichos/44.png",
   "45": "bichos/bichos/45.png",
   "46": "bichos/bichos/46.png",
   "47": "bichos/bichos/47.png",
   "48": "bichos/bichos/48.png",
   "49": "bichos/bichos/49.png",
   "50": "bichos/bichos/51.png"
  };

  icono_width = 156;
  icono_height = 32;

   node.append("image")
      .attr("xlink:href", function(d) {return imageByGroup[d.group];})
      /*.attr("x", positionx_icono)
      .attr("y", positiony_icono)*/
      .attr("width", icono_width)
      .attr("height", icono_height)
      /*.attr("transform","rotate(30)");*/
      .attr("transform", function(d){
         var angle = Math.atan2(d.y-550.01,d.x-600.01)*180/Math.PI
         if(angle>90&&angle<180){return "rotate("+(angle+180)+")";}
         else if(angle<-90){return "rotate("+(angle+180)+")";}
         else{return "rotate("+(angle)+")";}
       })
      .attr("x", function(d){if(d.x<601){return -150;}})
      .attr("y", function(d){if(d.x<601&&d.y>500){return -20;}else if(d.x<501){return -30;}else{return -16;}});




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
