<%@page import="bean.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>个人中心</title>
	<link rel="icon" href="images/icon.jpg">
	<link rel="stylesheet" href="css/bootstrap.min.css">  
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/info.js" charset="UTF-8"></script>
</head>
<body>
	<!-- 导航栏 -->
        <nav class = "nav navbar-default navbar-static-top" role = "navigation">
        	<div class="container-fluid">
	        	<div class="navbar-header">
	        		<ol class="breadcrumb">
	        			<li><a href="./index">Home</a></li>
	        			<li class="active">个人中心</li>
	        		</ol>
	        	</div>
	        	<div>
	        		<ul class="nav navbar-nav navbar-right">
	        			<c:set var="name" value="${name}"/>
	        			<c:choose>
	        				<c:when test="${name != null}">
	        					<li>
	        						<a href="#" id = "welcome">
	        							Welcome ${name}
	        						</a>
	        					</li>
	        				</c:when>
	        				<c:otherwise>
			        			<li><a href="./login"><span class="glyphicon glyphicon-log-in"></span> 登录</a></li>
			        			<li><a href="./regist"><span class="glyphicon glyphicon-user"></span> 注册</a></li>
	        				</c:otherwise>
	        			</c:choose>
	        		</ul>
	        	</div>
	        </div>
        </nav>

		<div class="container">
		<!-- 第二行 -->
			<div class="well row">
        		<div class="col-md-2 column">
        			<span class="glyphicon glyphicon-user"></span>
        			<input type="text" disabled="disabled" value="${name}" class="form-control" id ="name">
        		</div>
        		<button class="btn btn-sm" id="update_name" data-toggle="tooltip" data-placement="right" title="更改成功">编辑</button>
			</div>
			<!-- 第三行 -->
			<div class="row clearfix">
				<div class="col-md-2 column"></div>
				<div class="col-md-6 column"></div>
				<div class="col-md-4 column">
					<div class="row clearfix">
						<div class="col-md-4 column">
							<select class="form-control">
								<option>2017</option>
								<option>2016</option>
								<option>2015</option>
								<option>2014</option>
							</select>
						</div>
						<div class="col-md-4 column">
							<select class="form-control">
								<option>12</option>
								<option>11</option>
								<option>10</option>
								<option>9</option>
								<option>8</option>
								<option>7</option>
								<option>6</option>
								<option>5</option>
								<option>4</option>
								<option>3</option>
								<option>2</option>
								<option>1</option>
							</select>
						</div>
						<div class="col-md-4 column">
							<button class="btn btn-primary">查询</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 订单 -->
			
			<div class="row clearfix">
				<div class="col-md-2 column well">
					我的订单<span class="glyphicon glyphicon-hand-right"></span>
				</div>
				<div class="col-md-10 column">
					<table class="table table-hover table-striped">
		        			<thead>
		        				<tr>
		        					<th>订单信息</th>
		        					<th>数量</th>
		        					<th>总价</th>
		        					<th>订单状态</th>
		        					<th>详情</th>
		        				</tr>
		        			</thead>
		        			<sql:setDataSource var="database" driver="com.mysql.jdbc.Driver"
								url="jdbc:mysql://localhost:3306/tickets"
								user="root" password="root"/>
							<tbody>
								<sql:query var="orders" dataSource="${database}">
									SELECT * from orderInfo where uId = ${sessionScope.userId};
								</sql:query>
								<c:forEach var="order" items="${orders.rows}">
									<tr>
			        					<td>
											<sql:query var="schedules" dataSource="${database}">
												SELECT * from scheduleInfo where sId = ${order.sId};
											</sql:query>
											<c:forEach var="schedule" items="${schedules.rows}">
												<sql:query var="movies" dataSource="${database}">
													SELECT * from movieInfo where mId = ${schedule.mId};
												</sql:query>
												<c:forEach var="movie" items="${movies.rows}">
													<c:out value="${movie.movieName} "></c:out>
												</c:forEach><!-- 实际上只有一个 -->
												
												<sql:query var="cinemas" dataSource="${database}">
													SELECT * from cinemaInfo where cId = ${schedule.cId};
												</sql:query>
												<c:forEach var="cinema" items="${cinemas.rows}">
													<c:out value="影院名:${cinema.cinemaName}"></c:out>
												</c:forEach><!-- 实际上只有一个 -->
												<c:out value="放映厅:${schedule.hallName}"></c:out>
												
												<c:out value="观影时间:${schedule.startDate}  ${schedule.startTime}"></c:out>
											</c:forEach><!-- 实际上只有一个 -->
			        					</td>
			        					<td>1</td>
			        					<td>${order.orderPrice}</td>
			        					<td>${order.status}</td>
			        					<td>
			        						<a href="./order/${order.orderId}"><button>订单详情</button></a>
			        						<!-- 这里使用的数据库里面的属性名orderId而不是oId -->
			        					</td>
			        				</tr>
								</c:forEach>
							</tbody>
		        		</table>
				</div>
			</div>
		</div>
</body>
</html>