<%@ page import="com.perotsystems.diamond.bom.AgencyRateScheduleHdr"%>
<!DOCTYPE html>
<html>
<head>
<style type='text/css' media='screen'>
#list-agentMaster #criteria_member {
	padding-left: 200px;
}

#list-agentMaster #criteria_member Input {
	width: 180px;
	height: 20px;
	text-align: left;
}

#list-agentMaster #criteria_member Img {
	height: 40px;
	width: 40px;
	text-align: left;
}

.load {
	-moz-box-shadow: inset -1px 1px 7px 0px #ffffff;
	-webkit-box-shadow: inset -1px 1px 7px 0px #ffffff;
	box-shadow: inset -1px 1px 7px 0px #ffffff;
	background-color: #ededed;
	-moz-border-radius: 15px;
	-webkit-border-radius: 15px;
	border-radius: 10px;
	border: 1px solid #999999;
	display: inline-block;
	color: #404040;
	font-family: arial;
	font-size: 16px;
	font-weight: normal;
	padding: 5px 24px;
	text-decoration: none;
	text-shadow: 1px 0px 13px #ffffff;
}

.load:hover {
	background-color: #dfdfdf;
}

.load:active {
	position: relative;
	top: 1px;
}

.magnifying {
	-moz-box-shadow: inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow: inset 0px 1px 0px 0px #ffffff;
	box-shadow: inset 0px 1px 0px 0px #ffffff;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ededed
		), color-stop(1, #dfdfdf));
	background: -moz-linear-gradient(center top, #ededed 5%, #dfdfdf 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed',
		endColorstr='#dfdfdf');
	background-color: #ededed;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	border-radius: 6px;
	border: 1px solid #b8b2b8;
	display: inline-block;
	color: #777777;
	font-family: arial;
	font-size: 15px;
	font-weight: bold;
	padding: 0px 0px;
	text-decoration: none;
	text-shadow: 1px 1px 0px #ffffff;
	margin-top: 10px;
}

.magnifying:hover {
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #dfdfdf
		), color-stop(1, #ededed));
	background: -moz-linear-gradient(center top, #dfdfdf 5%, #ededed 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf',
		endColorstr='#ededed');
	background-color: #dfdfdf;
}

.magnifying:active {
	position: relative;
	top: 1px;
}

.innerbackground {
	background: rgb(0, 102, 204); /* Old browsers */
	/* IE9 SVG, needs conditional override of 'filter' to 'none' */
	background:
		url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iIzAwNjZjYyIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjI3JSIgc3RvcC1jb2xvcj0iIzI5ODlkOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjUyJSIgc3RvcC1jb2xvcj0iIzIwN2NjYSIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9Ijc4JSIgc3RvcC1jb2xvcj0iIzI5ODlkOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiM3ZGI5ZTgiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
	background: -moz-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, rgba(0,
		102, 204, 1)), color-stop(27%, rgba(41, 137, 216, 1)),
		color-stop(52%, rgba(32, 124, 202, 1)),
		color-stop(78%, rgba(41, 137, 216, 1)),
		color-stop(100%, rgba(125, 185, 232, 1))); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%);
	/* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%);
	/* Opera 11.10+ */
	background: -ms-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%); /* IE10+ */
	background: linear-gradient(to bottom, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient(         startColorstr='#0066cc',
		endColorstr='#7db9e8', GradientType=0); /* IE6-8 */
	border-radius: 7px;
}
</style>
<meta name="layout" content="main_2">
<g:set var="appContext" bean="grailsApplication"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>


<script type="text/javascript">

function createRateSchedule() {
	var rateId = "${params.rateId}";
		window.location
				.assign('<g:createLinkTo dir="/rateSchedule/create?rateId="/>'
						+ rateId);
	}

function checkForSearchCriteria() {
	var elements = document.getElementsByTagName("input");
	var searchCriteria = false;
	var strErrorMessage = '';
	
	for (var ii=0; ii < elements.length; ii++) {
	  if (elements[ii].type == "text" ) {
	    if(elements[ii].value){
		    searchCriteria = true;
		    }
	  }
	}

	var selects = document.getElementsByTagName("select");
	for (var ii=0; ii < selects.length; ii++) {
	  if (selects[ii]) {
	    if(selects[ii].value != ""){
		    searchCriteria = true;
		}
	  }
	}
		
	  if(searchCriteria == false) {
		alert ("Please enter search criteria to find results");
		return false;
	  }
}



$(function($){
	   
	   $("#idrateId").alphanum({
			allow 		: '-_',
			allowSpace  : false
		});

	   $("#idDescription").alphanum({
			allow 		: '-.',
			allowSpace  : true
		});
	})
	
	
	function setFirstElementFocus() {		
		var firstText = true;
		var elements = document.getElementsByTagName("input");
		for (var ii=0; ii < elements.length; ii++) {
			  if (elements[ii].type == "text") {
			    if (firstText) {
				    firstText = false;
			    	elements[ii].focus();
			    	//break;
				 }
			  }
		}
	}
	
	function clearSearchCriteria() {
		var elements = document.getElementsByTagName("input");
		var firstText = true;
		for ( var ii = 0; ii < elements.length; ii++) {
			if (elements[ii].type == "text") {
				elements[ii].value = "";
				if (firstText) {
				    firstText = false;
			    	elements[ii].focus();
			    	var clear_btn = document.getElementById('Create_id') 		    	
                    if(clear_btn!= null)
			    	{                    	
			    	clear_btn.style.visibility="hidden"
			    	var membr_maintaince_meaage_div = document.getElementById("rate_schedue_message_id")
		        	var membr_maintaince_meaage_div_value = document.getElementById("rate_schedue_message_id").innerHTML
		  	        if(membr_maintaince_meaage_div_value!=null)
		  	        {		  	        	
		  	         membr_maintaince_meaage_div.style.visibility="hidden"
		  	        }
			    	}  
				 }
			}
		}
		var elements = document.getElementsByTagName("select");
		for ( var ii = 0; ii < elements.length; ii++) {
			elements[ii].selectedIndex = 0;
		}
	}
	
	
</script>


<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'AgencyRateSchedule.label', default: 'AgencyRateSchedule')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<div id="list-AgencyRateSchedule" class="content scaffold-list" role="main"
		style="width: 100%; overflow: scroll;">
		<g:if test="${flash.message}">
			<div class="message" role="status" id="rate_schedue_message_id"
				style="display:${flash.message?'show':'hidden'};">
				${flash.message}
			</div>
		</g:if>
		<form name="searchForm" method="POST"
			action='<g:createLinkTo dir="/rateSchedule/list"/>'>
			<input type="hidden" name="submitted" value="true">
			<table>
				<tr>
					<td>
						<table border="1" id="criteria_member">
							<tr>
								<td>
									<table>
										<tr>
											<td class="innerbackground" colspan="6"
												style="color: #FFFFFF; text-align: center"><b>Commissions – Incentive Rate Schedule Search</b></td>
										</tr>
										<tr>
											<td>
												<b>Rate ID : </b>
											</td>
											<td>
												<input type="text" name="rateId" id="idrateId" maxlength="15" autofocus="autofocus" value="${params.rateId}"
												title= "The unique Rate ID for the Rate schedule"> &nbsp;
											</td>
											<td>
												<b>Description : </b>
											</td>
											<td>
												<input type="text" name="description" id="idDescription" maxlength="60" value="${params.description}"
												title="The Description of the Rate schedule"> &nbsp;
											</td>
											<td>
												<b>Calc Type : </b>
											</td>
											<td>
												<g:select name="calcType" style="width: 150px" 
													tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="calcType" value="${params.calcType}" 
													from="${['' : '', 'I': 'I - Incentive' , 'C': 'C - Commission']}" optionValue="value" optionKey="key"></g:select>
											</td>
										</tr>
										
										<tr id="search_button">
											<td colspan="2"><input type="submit" value="Search"
												class="load" onClick="return checkForSearchCriteria();"> 
												<g:if test="${create && params.rateId}">
														<input type="button" class="load" id="Create_id" value="Create a Rate Schedule - ${params.rateId}" onClick="createRateSchedule()" />
												</g:if>
											</td>
											<td></td>
											<td></td>
											<td></td>
											<td colspan="2" style="text-align: right">
												<div style="align: right">
													<input type="button" class="load" value="Reset"
														onClick="document.forms['searchForm'].reset();setFirstElementFocus()"> 
													<input type="button" class="load" value="Clear"
														onClick="clearSearchCriteria()">
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<g:if test="${ rateSchInstanceTotal >0}">
			<div id="list-agencyMaster" class="content scaffold-list" role="main"
				style="width: 100%; overflow-x: scroll; display: inline">
				&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;Number of Rate Schedules -
				${rateSchInstanceTotal}
				<table>
					<tr>
						<td>
							<table border="1">
								<tr>
									<td>
										<table>
											<thead>
												<tr>
													<g:sortableColumn property="rateId"
														title="${message(code: 'AgencyRateScheduler.rateId.label', default: 'Rate ID')}" 
														params="${[rateId:params.rateId, description:params.description, calcType:params.calcType]}" />

													<g:sortableColumn property="description"
														title="${message(code: 'AgencyRateSchedule.description.label', default: 'Description')}" 
														params="${[rateId:params.rateId, description:params.description, calcType:params.calcType]}"/>
														
													<g:sortableColumn property="calcType"
														title="${message(code: 'AgencyRateSchedule.calcType.label', default: 'Calc Type')}" 
														params="${[rateId:params.rateId, description:params.description, calcType:params.calcType]}"/>
													
												</tr>
											</thead>
											<tbody>
												<g:each in="${rateSchInstanceList}" status="i"
													var="rateSchInstance">
													<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

														<td><g:link action="edit" id="${rateSchInstance.rateId}"
																params="${[seqRateId: rateSchInstance.seqRateId, rateId: rateSchInstance.rateId, description: rateSchInstance.description,editType:'MASTER']}">
																${fieldValue(bean: rateSchInstance, field: "rateId")}
															</g:link></td>
														<td><g:link action="edit" id="${rateSchInstance.rateId}"
																params="${[editType:'MASTER', seqRateId: rateSchInstance.seqRateId, rateId: rateSchInstance.rateId, description: rateSchInstance.description]}">
																${fieldValue(bean: rateSchInstance, field: "description")}																
															</g:link></td>
														<td><g:link action="edit" id="${rateSchInstance.rateId}"
																params="${[editType:'MASTER', seqRateId: rateSchInstance.seqRateId, rateId: rateSchInstance.rateId, description: rateSchInstance.description]}">
																<g:if test="${fieldValue(bean: rateSchInstance, field: "calcType").equals('C') }">Commission</g:if>
																<g:elseif test="${fieldValue(bean: rateSchInstance, field: "calcType").equals('I') }">Incentive</g:elseif>
																<g:else>${fieldValue(bean: rateSchInstance, field: "calcType")}</g:else>														
															</g:link></td>
													</tr>
												</g:each>
											</tbody>
										</table>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<div class="pagination">
				<g:paginate total="${rateSchInstanceTotal}"
					params="${[submitted: true, rateId: params.rateId, description: params.description, calcType:params.calcType, max: params.max, offset:params.offset]}" />
			</div>
		</g:if>
		<div style="display: none">
			<input type="button" onClick="closeAllIFrames()" id="closeIframes">
			<input type="button" onClick="iFrameSearchTradp()" id="ifSearchTradp">
			<input type="button" onClick="iFrameSearchBatch()" id="ifSearchBatch">
		</div>
	</div>
	</body>
</html>
									