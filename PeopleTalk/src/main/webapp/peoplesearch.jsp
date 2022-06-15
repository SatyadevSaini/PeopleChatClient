<!DOCTYPE html>
<%@page import="com.incapp.beans.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PeopleTalk</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/custom.css" rel="stylesheet">
	
	<script language="Javascript" src="js/jquery.js"></script>
	<script type="text/JavaScript" src='js/state.js'></script>
  </head>
  <body data-spy="scroll" data-target="#my-navbar">
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="profile">PeopleTalk</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><div class="navbar-text"><p>Welcome: <b> ${user.name } </b></p></div></li>
					<li><a href="profile">Home</a></li>
					<li><a href="mylogout">Logout</a><li>
				</ul>			
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="panel panel-default text center">
			<div class="panel-heading text-center">
				<c:if test="${area==''}">
					<h3>Search Results for: ${state}/${city}</h3>
				</c:if>
				<c:if test="${area!=''}">
					<h3>Search Results for: ${state}/${city}/${area}</h3>
				</c:if>
			</div>
		</div>
	</div>
	</br>
	</br>
		<div class="container">
			<c:forEach items="${users}" var="u">
	  		<div class="row">
				<div class="col-lg-3">
					<img src="getPhoto?email=${u.email }" height="100px" />
				</div>
				<div class="col-lg-7">
						<div class="form-group">
							<label for="email" class="control-label">Name: <font color="grey">${u.name}</font></label><br>
							<label for="name" class="control-label">Email:<font color="grey"> ${u.email}</font></label><br>
							<label for="gender" class="control-label">Gender: <font color="grey">${u.gender}</font></label><br>
							<label for="dob" class="control-label">Date of Birth: <font color="grey">${u.dob}</font></label><br>
							<label for="phone" class="control-label">Phone: <font color="grey">${u.phone}</font></label><br>										
						
						</div>
				</div>
				<form action="talk" class="form-horizontal" method="get">
					<div class="col-lg-2">
						<div class="form-group">
						</br>
						</br>
						<input type="hidden" name="talk_email" value="${u.email}" />
							<button class="btn btn-primary">Talk</button>
						</div>
					</div>
				</form>
			</div>
			<hr>
		  	</c:forEach>
			
		</div>
	</div>
	</br>
	<!--footer-->
	<div class="navbar navbar-inverse navbar-fixed-bottom">
		<div class="container">
			<div class="navbar-text pull-left">
				<p>Design and Develop by INCAPP</p>
			</div>
	
		</div>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>