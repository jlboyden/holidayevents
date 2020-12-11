<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Web Project</title>

  <!-- jQuery -->
  <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <script type="text/javascript" src="js/Main.js"></script>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <!-- Custom styles -->
  <link rel="stylesheet" href="css/style.css">

    <!-- GoogleMaps API -->
    <script src="//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&key=AIzaSyAiQE6R7JRtu-V1R_Tao9SZtuprlemAT6c&libraries=
    places,visualization"></script>

    <!-- jQuery -->
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>


</head>

<body>
<div id="splash" class="splash">
  <button id="splash-close-btn" class ="splash-close-btn">Close</button>
  <div class="splash-heading">
    <h3>Happy Holidays!</h3>
    <br>
  </div>
  <h5>Thank you for checking out the Holiday Event Viewer.</h5>
  <h5>This tool is designed to help you learn about fun events and sightseeing to safely participate in here in Austin.<br><br>
    You can use this handy web form to enter your home or business as a fun place for families to drive by and see your decorations.
    <br><br>Or if you are hosting a charity event in the spirit of the holidays, those details can be entered into the form.
    <br><br>In the Find Events tab, it is a few button clicks to find which destination is right for you when finding holiday events for the whole family.<br><br><br>
    </h5>
  <div>
    <img src="img/christmas-lights.png" align = middle/><img src="img/pumpkin.png"/><img src="img/turkey.png"/><img src="img/christmas-tree.png"/><img src="img/menorah.png"/><img src="img/fireworks.png"/><img src="img/easter-day.png" align = middle/>
  </div>
</div>

<div class="data-page-splash" hidden>
  <button id="data-close-btn" class ="splash-close-btn">Close</button>
  <div class="splash-heading">
    <h2>Data Sources</h2>
  </div>

</div>

<div class="navbar navbar-fixed-top">
  <header class="header">
    <h1 style="font-family:Imprint MT Shadow; font-size:160%;"><i>Holiday Events Viewer</i></h1>
    <img src="img/header-lights.png" alt="Holiday Lights" align="middle" >
    <button id="header-button" class="header-button">     </button>
  </header>
</div>

<%--<div id="header-dropdown-menu" class="header-dropdown-menu">
  <ul>
    <li id="about-menu-item">
      <a href="#">About</a>
    </li>
    <li>
      <a target="_blank" href="https://github.com/KJGEOG575/GEOG_575_Final_Project">Project Source Code</a>
    </li>
  </ul>
</div>--%>

<div class="container-fluid">
  <div class="row">
    <div class="sidebar col-xs-3">

      <!-- Tab Navis-->
      <ul class="nav nav-tabs">
        <li class="active"><a href="#create_report" data-toggle="tab">Create Event</a></li>
        <li><a href="#query_report" data-toggle="tab">Find Events</a></li>
      </ul>

      <!-- Tab panes -->
      <div class="tab-content ">
        <!-- Create Report Tab Panel -->
        <div class="tab-pane active" id="create_report">
          <form id = "create_report_form">
            <div><label>First Name:&nbsp</label><br><input placeholder="Your first name (required)" name="fN"></div>
            <div><label>Last Name:&nbsp</label><br><input placeholder="Your last name (required)" name="lN"></div>
            <div><label>Telephone:&nbsp</label><br><input placeholder="Your telephone number" name="tel"></div>
            <div><label>Email:&nbsp</label><br><input placeholder="Your email address" name="email"></div>
            <div><label>Street Address Display:&nbsp</label><br><input placeholder="Street address (required)" name="st_address"></div>
              <div><label>Neighborhood:&nbsp</label><br><input placeholder="Neighborhood" name="neighborhood"></div>

            <div><label>Event Type:</label><br>
              <select onchange="onSelectReportType(this)" name="eventtype">
                <option value="">Choose the event type</option>
                <option value="residential">residential</option>
                <option value="commercial">commercial</option>
                <option value="charity">charity</option>
              </select>
            </div>
              <div><label>Holiday Selection:  </label><br>
                  <select name="holidaytype">
                      <option value="">Choose the holiday</option>
                      <option value="Christmas">Christmas</option>
                      <option value="Hanukkah">Hanukkah</option>
                      <option value="Thanksgiving">Thanksgiving</option>
                      <option value="Halloween">Halloween</option>
                      <option value="Independence_Day">Independence_Day</option>
                      <option value="Easter">Easter</option>
                  </select>
              </div>
            <div class="additional_msg_div" style="visibility: hidden"><label class="additional_msg"></label>
              <br><select class="additional_msg_select" name="decorationtype"></select>
            </div>

            <div><label>Address:</label>
              <br><input id="autocomplete" placeholder="Address (required)" >
            </div>
            <div><label>Comment:&nbsp</label><br><input placeholder="Message" name="message"></div>
            <br><br><button type="submit" class="btn btn-default" id="report_submit_btn">
              <span class="glyphicon glyphicon-star"></span> Submit
            </button>
          </form>
        </div>

        <!-- Query Report Tab Panel -->
        <div class="tab-pane" id="query_report">
          <form id = "query_report_form">
            <div><label>Event Type:</label>
              <br><select onchange="onSelectReportType(this)" name="eventtype">
                <option value="">Choose the event type</option>
                <option value="residential">Residential</option>
                <option value="commercial">Commercial</option>
                <option value="charity">Charity</option>
              </select>
            </div>
            <div class="additional_msg_div" style="visibility: hidden"><label class="additional_msg"></label>
              <br><select class="additional_msg_select" name="decoration or donation"></select>
            </div>
            <div><label>Holiday Selection:</label>
              <br><select name="holidaytype">
                  <option value="">Choose the holiday</option>
                  <option value="Christmas">Christmas</option>
                  <option value="Hanukkah">Hanukkah</option>
                  <option value="Thanksgiving">Thanksgiving</option>
                  <option value="Halloween">Halloween</option>
                  <option value="Independence_Day">Independence_Day</option>
                  <option value="Easter">Easter</option>
              </select>
            </div>
            <br><br><button type="submit" class="btn btn-default">
              <span class="glyphicon glyphicon-star"></span> Submit the query
            </button>
          </form>
        </div>
      </div>
    </div>

    <div id="map-canvas" class="col-xs-9"></div>

  </div>
</div>

<script src="js/loadformv2.js"></script>
<script src="js/loadmapv2.js"></script>

</body>
</html>
