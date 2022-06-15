<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 

<!DOCTYPE html>
<%@page import="com.incapp.beans.User"%>
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
	</br>
	</br>
		<div class="container">
			<section>
			<div class="row">
				<div class="col-lg-6">
					<div class="col-lg-4">
						<img src="getPhoto?email=${user.email }" height="100px" />
					</div>
					<div class="col-lg-6">
						<div class="form-group">
							<label for="email" class="control-label">Name: <font color="grey">${user.name }</font></label>
						</div><!--end form group-->
						<div class="form-group">
							<label for="name" class="control-label">Email:<font color="grey"> ${user.email }</font></label>
						</div><!--end form group-->
						<div class="form-group">
							<label for="gender" class="control-label">Gender: <font color="grey">${user.gender }</font></label>
						</div><!--end form group-->
						<div class="form-group">
							<label for="dob" class="control-label">Date of Birth: <font color="grey">${user.dob }</font></label>
						</div>
						</div><!--end form group-->
						<div class="col-lg-10 form-group">
							<label for="state" class="control-label">Address: <font color="grey">${user.area }, ${user.city }, ${user.state }</font></label>
						</div><!--end form group-->
						<div class="form-group">
							<div class="col-lg-10 form-group">
								<a href="editprofile.html" class="btn btn-primary">Edit Profile</a>
                                <a href="changepassword.html" class="btn btn-primary">Change Password</a>
															
							</div>		
						</div>
					</div>
				<div class="col-lg-6">
					<div class="panel panel-default">
						<div class="panel-heading text-center">
							<h3>Search People</h3>
						</div>
						<div class="panel-body">
							<form action="peoplesearch" method="post" class="form-horizontal">
								<div class="form-group">
									<label for="state" class="col-lg-3 control-label">State:</label>
									<div class="col-lg-9">
										<select name="state" class="form-control" id="listBox" onchange='selct_district(this.value)'>
											
										</select>
									</div>
								</div><!--end form group-->
								<div class="form-group">
									<label for="city" class="col-lg-3 control-label">City:</label>
										<div class="col-lg-9">
											<select name="city" class="form-control" id='secondlist'>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="area" class="col-lg-3 control-label">Area:</label>
									<div class="col-lg-9">
										
										<input type="text" name="area" class="form-control" id="area" placeholder="Enter your Area" />
									</div>
								</div>
								<!-- For CSRF Token -->
								<sec:csrfInput /> 
								<div class="form-group">
									<div class="col-lg-10 col-lg-offset-3">
										<button type="search" class="btn btn-primary" >Search</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
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