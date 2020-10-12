
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
  <a href="#">About</a>
  <a href="#">Services</a>
  <a href="#">Clients</a>
  <a href="#">Contact</a>
</div>

<!-- Use any element to open the sidenav -->
<span onclick="openNav()">open</span>

<!-- Add all page content inside this div if you want the side nav to push page content to the right (not used if you only want the sidenav to sit on top of the page -->
<div id="main">



    <h1> Hello World </h1>


      <p> I'm hosted with Github pages. </p>

      <h3 id = "Cocktail_Informant"> Cocktail Informant </h3>
      <p> (https://github.com/Telucero/Taylor_Portfolio/blob/master/Python%20Work%20Samples/Cocktail_Info.py)
        In this program, I utilized an API that provided information on 500+ drinks, from there I developed code to pull-out drinks from the cocktail Dictionary by using Keys to get their respective values. This program provides the inputted drink's ingredients and recipe with the appropriate measurements and instruction. </p>

      <h3 id = "Artist_Recommender"> Artist Recommender </h3>
      <p> (https://github.com/Telucero/Taylor_Portfolio/blob/master/Python%20Work%20Samples/Artist%20Recommender.py)
        In this project, I used the musicgraph API to pull information on popular artists based on total followers, popularity, and genre to provide possible recommendations the user might like. This then outputs a visual providing information on why this artist was chosen.
      </p>

      <h3 id = "Database_Management"> Database Management </h3>

      <p> (https://github.com/Telucero/Taylor_Portfolio/blob/master/SQL%20Work%20Sample.sql)
        In this project I managed a database for a client with a diverse array of sci-fi products. I first created tables and then based on a conceptual model built the relationship between them, these tables are Project Transaction Part, Project part, Project Transaction, and Project Transaction Type. Next, I input the necessary values into each table, identifying Foreign Keys and references along the way. At the end of this, I wrote queries to pull information based on conditionals, Joins,and Aggregate functions.
      </p>

      <h3 id = "Customer_Flight_Satisfaction"> Customer Flight Analysis </h3>

      <p> (https://github.com/Telucero/Taylor_Portfolio/blob/master/R%20Work%20Samples/Airline%20Satisfaction.R)
        This was my favorite project. I analyzed customer data focusing on Descriptive, Diagnostic, and Prescriptive analytics to provide recommendations and reasoning towards low flight satisfaction for customers. While working on this project, I played around a lot when analyzing the statistics to identify important attributes to focus in on. There were a few steps in the process to recieve these recommendations; they were Data Cleansing, Data Munging, Data Manipulation, and Data Visualization. In the Data Visualization part, I used ggplot2 to make a world map showing flight paths based on identified low customer satisfaction levels.
      </p>


    <img src= "https://github.com/Telucero/Taylor_Portfolio/blob/master/images/Flight%20Paths:%20Satisfaction%20Levels%201%20&%202.png?raw=true" alt="LowSatisfaction" content="img/html; charset=UTF-8; X-Content-Type-Options = nosniff" response header/>

    <img src= "https://github.com/Telucero/Taylor_Portfolio/blob/master/images/Low%20Satisfaction%20Flight%20Paths.png?raw=true" alt="LowSatisfaction"/>

      <h3 id = "Supervised_Ml"> Predicting Customer Churn </h3>

      <p> (https://github.com/Telucero/Taylor_Portfolio/tree/master/R%20Work%20Samples/Telco%20Churn)
        This project was completed to further my understanding and practice with Data & Data Science. This project focused on Supervised Machine Learning with  Decision Tree Classification, to predict customer churn. After a thorough analysis, a Predictive Model was developed, trained, and pruned to refine the model to best fit the entire customer population, instead of overfitting the model to the Training and Test data. This project includes Documented Information on understanding the analysis and the R code developed for the project.
      </p>

      <h3 id = "Various_Haskell_Files"> Haskell Files </h3>

      <p> Haskell Files
        Understanding Haskell after I learned Python was difficult but some of the skills and general concepts are transferable from python. It would take a bit more code to get across since Haskell is a compiled language. These files include my work with Algebraic Data types, Anonymous Functions, Trees, IO, and Turing Machines. There are a few skills that are sprinkled throughout these works like List Comprehension, Nested Functions, and Loops. Each folder contains the necessary files to run the full programs, for example the defined data types constructed for the game.
      </p>


</div>
</body>

>>>>>>> 18acf08919cc2d12ff0e960b54a3fa98edf52cfd
