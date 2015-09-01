var margin = {top: -90, right: 0, bottom: 0, left: -120};

var width = 1000 - margin.left - margin.right,
    height = 950 - margin.top - margin.bottom;

function brawlers_roulette()
{
  d3.select("svg").remove();
  ruleta = "brawlers/brawlers.json";
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
   "1": "brawlers/brawlers_line/1.png",
   "2": "brawlers/brawlers_line/2.png",
   "3": "brawlers/brawlers_line/3.png",
   "4": "brawlers/brawlers_line/4.png",
   "5": "brawlers/brawlers_line/5.png",
   "6": "brawlers/brawlers_line/6.png",
   "7": "brawlers/brawlers_line/7.png",
   "8": "brawlers/brawlers_line/8.png",
   "9": "brawlers/brawlers_line/9.png",
   "10": "brawlers/brawlers_line/10.png",
   "11": "brawlers/brawlers_line/11.png",
   "12": "brawlers/brawlers_line/12.png",
   "13": "brawlers/brawlers_line/13.png",
   "14": "brawlers/brawlers_line/14.png",
   "15": "brawlers/brawlers_line/15.png",
   "16": "brawlers/brawlers_line/16.png",
   "17": "brawlers/brawlers_line/17.png",
   "18": "brawlers/brawlers_line/18.png",
   "19": "brawlers/brawlers_line/19.png",
   "20": "brawlers/brawlers_line/20.png",
   "21": "brawlers/brawlers_line/21.png",
   "22": "brawlers/brawlers_line/22.png",
   "23": "brawlers/brawlers_line/23.png",
   "24": "brawlers/brawlers_line/24.png",
   "25": "brawlers/brawlers_line/25.png",
   "26": "brawlers/brawlers_line/26.png",
   "27": "brawlers/brawlers_line/27.png",
   "28": "brawlers/brawlers_line/28.png",
   "29": "brawlers/brawlers_line/29.png",
   "30": "brawlers/brawlers_line/30.png",
   "31": "brawlers/brawlers_line/31.png",
   "32": "brawlers/brawlers_line/32.png",
   "33": "brawlers/brawlers_line/33.png",
   "34": "brawlers/brawlers_line/34.png",
   "35": "brawlers/brawlers_line/35.png",
   "36": "brawlers/brawlers_line/36.png",
   "37": "brawlers/brawlers_line/37.png",
   "38": "brawlers/brawlers_line/38.png",
   "39": "brawlers/brawlers_line/39.png",
   "40": "brawlers/brawlers_line/40.png",
   "41": "brawlers/brawlers_line/41.png",
   "42": "brawlers/brawlers_line/42.png",
   "43": "brawlers/brawlers_line/43.png",
   "44": "brawlers/brawlers_line/44.png",
   "45": "brawlers/brawlers_line/45.png",
   "46": "brawlers/brawlers_line/46.png",
   "47": "brawlers/brawlers_line/47.png",
   "48": "brawlers/brawlers_line/48.png",
   "49": "brawlers/brawlers_line/49.png",
   "50": "brawlers/brawlers_line/51.png"
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
