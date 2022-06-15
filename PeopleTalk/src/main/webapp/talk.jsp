<%@page import="com.incapp.beans.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 

<!DOCTYPE html>
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
			<div class="row">
				<div class="col-lg-4">
					<img src="getPhoto?email=${talk_user.email }" height="100px" />
				</div>
				<div class="col-lg-4">
					<div class="form-group">
					</br>
						<label for="email" class="control-label">Name: <font color="grey">${talk_user.name }</font></label><br>
						<label for="gender" class="control-label">Gender: <font color="grey">${talk_user.gender }</font></label><br>
						<label for="phone" class="control-label">Phone: <font color="grey">${talk_user.phone }</font></label><br>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="form-group">
					</br>
						<label for="name" class="control-label">Email:<font color="grey"> ${talk_user.email }</font></label><br>
						<label for="dob" class="control-label">Date of Birth: <font color="grey">${talk_user.dob }</font></label><br>
						<label for="address" class="control-label">Address: <font color="grey">${talk_user.state }/${talk_user.city }/${talk_user.area }</font></label><br>
					</div>
				</div>
			</div>
		</div>
		</br>
		<div class="container text-center">
			<div class="panel panel-default">
				<p>${msgResult}</p>
				<div class="panel-body text-center">
					<form action="sendMessage" data-toggle="validator" method='post' enctype='multipart/form-data' class="form-horizontal">
						<div class="form-group">
							<label for="message" class="col-lg-2 control-label">Message:</label>
								<div class="col-lg-4">
									<textarea id="message" name="message" class="form-control" rows="5" cols="50" required></textarea>
								</div>
						</div><!--end form group-->
							<div class="form-group">
							<label for="filetosend" class="col-lg-2 control-label">File to Send:</label>
								<div class="col-lg-4">
									<input type="file" name="ufile" class="form-control" id="filetosend"/>
								</div>
								
								<!-- For CSRF Token -->
								<sec:csrfInput /> 
								
								<div class="col-lg-2">
									<button type="submit" class="btn btn-primary">Send</button>
								</div>
						</div><!--end form group-->
					</form>
				</div>
			</div>
		</div>
		<div class="container text-center">
			<div class="panel panel-default">
				<div class="panel-body text-center">
					<div class="row">
						<div class="col-md-6">
							<div class="panel panel-default">
								<div class="panel-heading text-center">
									<h5><b> ${user.name } </b>'s Messages</h5>
								</div>
								<div class="panel-body text-left">
									<c:forEach items="${sMessages}" var="m">
									<p> <b>${m.message }</b></p>
									<c:if test='${m.fileName!=null}'>
										<p> 
											File: <a href='downloadFile?id=${m.id}&fileName=${m.fileName}'>${m.fileName }</a>
										</p>
									</c:if>
									<p> Date Time: ${m.udate } ${m.utime } </p>
									<hr>
									</c:forEach>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="panel panel-default">
								<div class="panel-heading text-center">
									<h5><b> ${talk_user.name } </b>'s Messages</h5>
								</div>
								<div class="panel-body text-left">
									<c:forEach items="${rMessages}" var="m">
									<p> <b>${m.message }</b></p>
									<c:if test='${m.fileName!=null}'>
										<p> 
											File: <a  href='downloadFile?id=${m.id}&fileName=${m.fileName}'>${m.fileName }</a> 
										</p>
									</c:if>
									<p> Date Time: ${m.udate } ${m.utime } </p>
									<hr>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<hr>
	
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
	<script type="text/javascript" src="js/jquery-2.2.2.min.js"></script>
    <script src="js/validator.js"></script>
  </body>
</html>