<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html ng-app="myApp">
<head>
<meta charset="UTF-8">
<title>Instagram_Acorn</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/nav-modal.css" />
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/angular.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/upload-image.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/imgLiquid.js"></script>
<script>
	var myApp=angular.module("myApp",[]);
	myApp.controller("myCtrl",function($scope,$http){
		//
		$scope.isNull=false;
		$scope.dto={};
		$scope.dtoList=[];
		$scope.getData=function(){
			$http({
				url:"userpageData.do",
				method:"get",
				params:{"id":"${param.id}"}
			}).success(function(data){
				console.log(data);
				$scope.dto=data;
			});	
		};
		$scope.getBoardList=function(){
			$http({
				url:"userboardlist.do",
				method:"get",
				params:{"id":"${param.id}"}
				
			}).success(function(data){
				console.log(data);
				$scope.dtoList=data;
				
				if(data == 0){
					$scope.isNull=true;
				}
		
				$(".imgLiquidFill").imgLiquid();
			});
		};
		$scope.getData();
		$scope.getBoardList();
		
		$scope.backImage=function(index){
			$(".imgLiquidFill").imgLiquid();
			
			$scope.boardNum=$scope.dtoList[index].num_board;
			return{
				'background-image':'url(${pageContext.request.contextPath}/upload/'+$scope.dtoList[index].p_orgfilename+')'
			}
		};
		$(".imgLiquidFill").imgLiquid();
		
		$scope.searchList=[];
		$scope.searchValue="";
		$scope.searchValue2="";
		$scope.selectValue="pop";
		
		$scope.onClick=function(a){
			console.log(a);
		}; 
		console.log($scope.selectValue);
		console.log($scope.searchValue);
		$scope.getData2=function(msg){
			$scope.searchValue=msg;
			$scope.searchValue2=msg;
			//console.log($scope.searchValue);
			
			$http({
				url:"${pageContext.request.contextPath}/search/Search_like.do",
				method:"get",
				params:{"keyword":$scope.searchValue,"keyword2":$scope.selectValue}
	
			}).success(function(data){
				console.log($scope.selectValue);
				console.log(data);
				$scope.searchList=data;
			});
		};
		$scope.getChange=function(){
			$scope.searchList=[];
			$scope.getData2();
		};
		$scope.test=function(test){
			console.log("test : "+test);
		};
		//$scope.getData();
		// 팔로우 된 사람인지, 본인인지 체크해서 저장할 변수
		// 3=본인, 0=not followed, 1=followed
		$scope.isFollowed=0;
		$scope.getFollowCheck=function(){
			console.log("hi");
			$http({
				url:"${pageContext.request.contextPath}/search/search_followed.do",
				method:"get",
				params:{
					"id_follow":"${param.id}"
				}
			}).success(function(data){
				console.log(data);
				$scope.isFollowed=data.isFollowed;
				console.log("isFollowed : "+$scope.isFollowed);
			});
		};
		$scope.getFollowCheck();
		$scope.doFollow=function(){
			console.log("doFollow");
			$http({
				url:"${pageContext.request.contextPath}/search/do_follow.do",
				method:"get",
				params:{
					"id_follow":"${param.id}"
				}
			}).success(function(data){
				console.log(data);
				$scope.isFollowed=1;
				console.log("isFollowed : "+$scope.isFollowed);
			});
		};
		$scope.removeFollow=function(){
			console.log("removeFollow");
			$http({
				url:"${pageContext.request.contextPath}/search/remove_follow.do",
				method:"get",
				params:{
					"id_follow":"${param.id}"
				}
			}).success(function(data){
				console.log(data);
				$scope.isFollowed=0;
				console.log("isFollowed : "+$scope.isFollowed);
			});
		};
		
	});
</script>
<style>
#three{
   display: inline;
   margin-left: 20px;
   /* font-size: 17px; */
}
.testImage{
/* 	width: 350px;
	hegith: 350px; */
	background-size: cover;
	background-position: center center;
	background-repeat: no-repeat;
}

.container {
   	 width:970px;
}

.row{
	position: relative;
	left: 5px;
	top: 6px;
}

.imgLiquidFill{
	margin-right:20px;
	margin-bottom:15px;
}

.insList:hover .box{display: block}
   
.insList{
   position: relative;

}
.box{
   position: absolute;
   top:0;
   bottom: 0;
   right: 10px;
   left: 15px;
   display: none;
   background: rgba(0,0,0,0.5);
   margin-right:0;
   margin-bottom:15px;
}

.likeBox{

   font-size:20px;
   color:#fff;
   position: relative;
   top: 45%;
   text-align: center;
     
}
.glyphicon.glyphicon-cog:hover{
	cursor:pointer;
}

</style>
</head>
<body ng-controller="myCtrl">
<jsp:include page="../navbar/navbar.jsp"/>
<div class="container" style="margin-top:150px;">
	<div class="row">
		<div class="col-xs-3 col-xs-offset-1">
	        <div id="profileImgs" class="text-center">
	            <img id="one" ng-src="${pageContext.request.contextPath}/upload/{{dto.orgFileName}}" width="100" style="border-radius: 100%;" class="rounded" alt="...">
	            <!-- <img id="one_2" src="../images/멍멍이.jpg" class="rounded" alt="..." style="display: none;"> -->
        	</div>
		</div><!--col-xs-3-->
	    <div class="col-xs-7 text-center">
			<h1 style="font-weight:lighter; display: inline-block;">{{dto.nick}}</h1>
			<button ng-if="isFollowed==3" onclick="location.href='${pageContext.request.contextPath}/profile/myprofile.do'" class="btn btn-default btn-xs" style="display: inline-block; margin-left: 20px; font-weight: bold; padding-left: 30px; padding-right: 30px; font-size: 15px; margin-top: -12px; " >프로필편집</button>
			<button ng-if="isFollowed==0" ng-click="doFollow()" class="btn btn-default btn-xs" style="display: inline-block; margin-left: 20px; font-weight: bold; padding-left: 30px; padding-right: 30px; font-size: 15px; margin-top: -12px; " >팔로우 하기</button>
			<button ng-if="isFollowed==1" ng-click="removeFollow()" class="btn btn-default btn-xs" style="display: inline-block; margin-left: 20px; font-weight: bold; padding-left: 30px; padding-right: 30px; font-size: 15px; margin-top: -12px; " >팔로우 해제</button>
			<span onclick="javascript:location.href='${pageContext.request.contextPath}/profile/myprofile.do'" class="glyphicon glyphicon-cog" style="font-size: 23px; margin-left: 5px;"  ></span>
			<br/>
			<div id="profileInfo"> 
			    <div style="font-size: 17px; display: inline-block; margin-top: 15px">게시글 <span ng-if="dto.lcount!=null">{{dto.lcount}}</span>
			    	<span ng-if="dto.lcount==null">0</span>
			    </div>
			    <div id="three">팔로우 <span ng-if="dto.countFollower!=null">{{dto.countFollower}}</span>
			    	<span ng-if="dto.countFollower==null">0</span>
			    </div>
			    <div id="three">팔로워 <span ng-if="dto.countFollow!=null">{{dto.countFollow}}</span> 
			    	<span ng-if="dto.countFollow==null">0</span> 
			    </div>
			</div>
			<br/>
			<div style="font-size: 20px; font-weight: bold; margin-top: 15px;"></div>
	    </div><!--col-xs-7-->
	</div>
	<div class="postContent">
		<div ng-show="isNull" style="align:center;"><p style="text-align:center;font-size:15px;">
			<br /><strong>아직 등록된 사진이 없습니다 <br />사진을 친구들과 함께 공유해보세요</strong></p></div>
 		<div class="row" ng-repeat="tmp in dtoList" ng-switch on="$index%3">
			<div class="insList col-xs-4" ng-switch-when="0">
				<div class="imgLiquidFill imgLiquid" style="width:300px; height:350px" ng-style="backImage({{$index}})" >
				<div class="box"><div class="likeBox"><span class="glyphicon glyphicon-heart"></span><span id="pfont">{{boardNum}}</span></div></div>
					<img class="img-responsive" src=""/>
					<div ng-init="onLoad()"></div>
				</div>
			</div>
			<div class="insList col-xs-4" ng-switch-when="0" ng-if="($index+1)<dtoList.length">
				<div class="imgLiquidFill imgLiquid" style="width:300px; height:350px" ng-style="backImage({{$index+1}})" >
				<div class="box"><div class="likeBox"><span class="glyphicon glyphicon-heart"></span><span id="pfont">{{boardNum}}</span></div></div>
					<img class="img-responsive" src=""/>
					<div ng-init="onLoad()"></div>
				</div>
			</div>
			<div class="insList col-xs-4" ng-switch-when="0" ng-if="($index+2)<dtoList.length">
				<div class="imgLiquidFill imgLiquid" style="width:300px; height:350px" ng-style="backImage({{$index+2}})" >
				<div class="box"><div class="likeBox"><span class="glyphicon glyphicon-heart"></span><span id="pfont">{{boardNum}}</span></div></div>
					<img class="img-responsive" src=""/>
					<div ng-init="onLoad()"></div>
				</div>
			</div>
		</div>

	</div><!-- postContent -->
</div>
<script>
$(".s_menu").click(function(){
	
	$(".nav-justified > li").removeClass("s_click");

	$(this)
	.parent()
	.addClass("s_click");

});

</script>
</body>
</html>