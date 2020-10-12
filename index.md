
<head>
  <link rel="stylesheet" href="stylesheet.css">
</head>

<body>

<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
  document.getElementById("main").style.marginLeft = "250px";
  document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
  document.getElementById("main").style.marginLeft= "0";
  document.body.style.backgroundColor = "white";
}
</script>


<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <img class = "Container" src="https://github.com/Telucero/Taylor_Portfolio/blob/Web/Backups/images/00100dPORTRAIT_00100_BURST20181116154658328_COVER.jpg?raw=true" alt="Portrait" style="width:100%">

  <a href="#">Home</a>
  <a href="About_page.html">About</a>
  <a href="#">Resume</a>
  <a href="#">Projects</a>
  <a href="#">Contact</a>
</div>

<div id="main" onclick="closeNav()">

  <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; open</span>




</div>
</body>

>>>>>>> 18acf08919cc2d12ff0e960b54a3fa98edf52cfd
