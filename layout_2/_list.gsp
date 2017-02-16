
<%@ page import="com.dell.diamond.fms.AgentMasterCommand"%>
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
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

<script>
function createCompany() {
	var appName = "${appContext.metadata['app.name']}";
	var createCompanyCoded = "${params.agentId}";
		//window.location
			//	.assign('<g:createLinkTo dir="/agentMaster/create?agentId="/>'
				//		+ createCompanyCoded);
		window.location.assign("/"+appName+"/agentMaster/create?agentId="+createCompanyCoded+ "&editType=MASTER");
	}


	function checkForSearchCriteria() {
		var elements = document.getElementsByTagName("input");
		var searchCriteria = false;
		var strErrorMessage = '';
		
		for (var ii=0; ii < elements.length; ii++) {
		  if (elements[ii].type == "text") {
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
			alert ("Please enter search criteria to find Agent.");
			return false;
		  }
		  else {
			  	if ($('#creationDate').val().indexOf('_') != -1) {
					strErrorMessage = 'Please enter valid 2 digit month and 4 digit year.';
				}
		  		else {
		  			if (!validDate($('#creationDate').val())) {
						strErrorMessage = 'Please enter valid 2 digit month and 4 digit year.';
				  	}
			  	}
	
				if (strErrorMessage != '') {
					alert(strErrorMessage);
					return false;
				}
				else {
					return true;
				}	
		  }
		
	}

	function validDate(dateString) {

		if (dateString != '') {
			var comp = dateString.split('/');
			var m = parseInt(comp[0], 10);
			var d = 1;
			var y = parseInt(comp[1], 10);
			var date = new Date(y, m-1, d);
			if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
				//Valid Date
				return true;
			} else {
				//Invalid Date
			  	return false;
			}
		}
		else {
			return true;
		}


	}

	function clearSearchCriteria() {
		var elements = document.getElementsByTagName("input");
		var firstText = true;
		for ( var ii = 0; ii < elements.length; ii++) {
			if (elements[ii].type == "text") {
				elements[ii].value = "";
				if (firstText) {
					elements[ii].focus();
					firstText = false;
				}
			}
		}

		var elements = document.getElementsByTagName("select");
		for (var ii=0; ii < elements.length; ii++) {
		    elements[ii].selectedIndex = 0;
		}

		$("#creationDate").unmask();
		$("#creationDate").mask("?99/9999");
		
	}

	$(function($){
		   $("#creationDate").mask("?99/9999");
	});

	function createAgentOrBrokerId(){	
		var appName = "${appContext.metadata['app.name']}";
		var generateAutoAgentId = "${generateAutoSubId}";
			window.location.assign("/"+appName+"/agentMaster/create?agentId="+generateAutoAgentId + "&editType=MASTER");
		
	}

	
</script>

<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'agentMaster.label', default: 'AgentMaster')}" />
	<g:set var="appContext" bean="grailsApplication"/>
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div id="list-agentMaster" class="content scaffold-list" role="main"
		style="width: 100%; overflow: scroll;">
		<g:if test="${flash.message}">
			<div class="message" role="status"
				style="display:${flash.message?'show':'hidden'};">
				${flash.message}
			</div>
		</g:if>
		<form name="searchForm" method="POST"
			action='<g:createLinkTo dir="/agentMaster/list"/>'>
			<input type="hidden" name="submitted" value="true">
			<table>
				<tr>
					<td>
						<table border="1">
							<tr>
								<td>
									<table>
										<tr>
											<td class="innerbackground" colspan="6"
												style="color: #FFFFFF; text-align: center"><b>Search
													Agents </b></td>
										</tr>
										<tr>
											<td><b>First Name : </b></td>
											<td><input autofocus="autofocus" type="text"
												title ="The First Name of the Agent/Broker"
												name="firstName" id="firstName" value="${params.firstName}"
												maxlength="35" onclick='javascript: firstName.value = ""'>
												&nbsp;</td>

											<td><b>Last Name : </b></td>
											<td><input type="text" name="lastName" id="lastName"
												title ="The Last Name of the Agent/Broker"
												value="${params.lastName}" maxlength="60"
												onclick='javascript: lastName.value = ""'> &nbsp;</td>
											<td><b>Agent/Broker ID : </b></td>
											<td><input type="text" name="agentId" id="agentId"
												title ="The Id Number for the Agent/Broker"
												value="${params.agentId}" maxlength="15"
												onclick='javascript: agentId.value = ""'> &nbsp;</td>
										</tr>
										<tr>
										<!-- 
											<td><b>License No: </b></td>
											<td><input autofocus="autofocus" type="text"
												title ="The License Number of the Agent/Broker"
												name="licenseNo" id="licenseNo" value="${params.licenseNo}"
												maxlength="22" onclick='javascript: licenseNo.value = ""'>
												&nbsp;</td>
                                     -->         
											<td><b>Agent/Broker Type : </b></td>
											<td>
												<select name="agentType" id="agentType" title ="The Agent Type" onchange="checkAgentType()">										
														<option value="">-- Select an Agent Type --</option>
													 	<option value="C" ${"C".equals(request.getParameter("agentType"))? 'selected' :'' }>C – Company</option>
													 	<option value="I" ${"I".equals(request.getParameter("agentType"))? 'selected' :'' }>I – Independent</option>
												</select>
												
											</td>
											<td><b>Status: </b></td>
											<td>
												<select name="status" id="status" title ="The Agent Status">
														<option value="">-- Select an Agent Status --</option>
													 	<option value="A" ${"A".equals(request.getParameter("status"))? 'selected' :'' }>A – Active</option>
													 	<option value="T" ${"T".equals(request.getParameter("status"))? 'selected' :'' }>T – Terminated</option>
												</select>
										</tr>
										<tr>
											<td><b>Financial Period : </b></td>
											<td>
												<input type="text" name="creationDate" id="creationDate" 
												title ="Enter 2 digit Month and 4 digit Year for the financial period. Example 052015"
												value="${params.creationDate}"> &nbsp;
											</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>

										<tr id="search_button">
											<td colspan="2"><input type="submit" value="Search"
												class="load" onClick="return checkForSearchCriteria();"> 
												<g:if test="${params.agentId && create}">
													<div id="createCompanyDiv" style="visibility:${iscreateAgentFlag? 'show':'hidden'};display:inline">
														<g:checkURIAuthorization uri="/agentMaster/create">
															<input type="button" class="load" value="Create an Agent - ${params.agentId}" onClick="createCompany()" />
														</g:checkURIAuthorization>
													</div>
												</g:if>
											    <g:else>
											    <div id="createCompanyDiv" style="visibility:${iscreateAgentFlag? 'show':'hidden'};display:inline">
														<g:checkURIAuthorization uri="/agentMaster/create">
											               <input type="button" class="load" id="Create_id"
														value="Auto Assign Agent/Broker ID" onClick="createAgentOrBrokerId()" />
														</g:checkURIAuthorization>
													</div>
											    </g:else>
											</td>
											<td></td>
											<td></td>
											<td></td>
											<td colspan="2" style="text-align: right">
												<div style="align: right">
												<input type="button" class="load" value="Reset"
														onClick="document.forms['searchForm'].reset();"> 
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
		<g:if test="${ agentMasterInstanceTotal >0}">
			<div id="list-agentMaster" class="content scaffold-list" role="main"
				style="width: 100%; overflow-x: scroll; display: inline">
				&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;Number of Agents -
				${agentMasterInstanceTotal}
				<table>
					<tr>
						<td>
							<table border="1">
								<tr>
									<td>
										<table>
											<thead>
												<tr>

													<g:sortableColumn property="agentId"  style="padding-left:20px;"
														title="${message(code: 'agentMaster.agentId.label', default: 'Agent/Broker ID')}"
														params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />

													<g:sortableColumn property="agentType"
														title="${message(code: 'agentMaster.agentType.label', default: 'Agent Type')}"
														params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />

													<g:sortableColumn property="firstName"
														title="${message(code: 'agentMaster.firstName.label', default: 'First Name')}"
														params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />

													<g:sortableColumn property="lastName"
														title="${message(code: 'agentMaster.lastName.label', default: 'Last Name')}"
														params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />

													<g:sortableColumn property="payType"
														title="${message(code: 'agentMaster.payType.label', default: 'Pay Type')}"
														params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />

													<g:sortableColumn property="status"
														title="${message(code: 'agentMaster.status.label', default: 'Status')}"
														params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />
												</tr>
											</thead>
											<tbody>
												<g:each in="${agentMasterInstanceList}" status="i"
													var="agentMasterInstance">
													<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

														<td><g:link action="edit" id="${agentId}"
																params="${[editType:'MASTER', seqAgentId: agentMasterInstance.seqAgentId, agentId: agentMasterInstance.agentId, agentType: agentMasterInstance.agentType, creationDate:params.creationDate]}">
																${fieldValue(bean: agentMasterInstance, field: "agentId")}
															</g:link></td>
														<td><g:link action="edit" id="${agentId}"
																params="${[editType:'MASTER', seqAgentId: agentMasterInstance.seqAgentId, agentId: agentMasterInstance.agentId, agentType: agentMasterInstance.agentType, creationDate:params.creationDate]}">
																${fieldValue(bean: agentMasterInstance, field: "agentType")}
															</g:link></td>
														<td><g:link action="edit" id="${agentId}"
																params="${[editType:'MASTER', seqAgentId: agentMasterInstance.seqAgentId, agentId: agentMasterInstance.agentId, agentType: agentMasterInstance.agentType, creationDate:params.creationDate]}">
																${fieldValue(bean: agentMasterInstance, field: "firstName")}
															</g:link></td>

														<td><g:link action="edit" id="${agentId}"
																params="${[editType:'MASTER', seqAgentId: agentMasterInstance.seqAgentId, agentId: agentMasterInstance.agentId, agentType: agentMasterInstance.agentType, creationDate:params.creationDate]}">
																${fieldValue(bean: agentMasterInstance, field: "lastName")}
															</g:link></td>
														
														<td><g:link action="edit" id="${agentId}"
																params="${[editType:'MASTER', seqAgentId: agentMasterInstance.seqAgentId, agentId: agentMasterInstance.agentId, agentType: agentMasterInstance.agentType, creationDate:params.creationDate]}">
																${fieldValue(bean: agentMasterInstance, field: "payType")}
															</g:link></td>

														<td><g:link action="edit" id="${agentId}"
																params="${[editType:'MASTER', seqAgentId: agentMasterInstance.seqAgentId, agentId: agentMasterInstance.agentId, agentType: agentMasterInstance.agentType, creationDate:params.creationDate]}">
																${fieldValue(bean: agentMasterInstance, field: "status")}
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
				<g:paginate total="${agentMasterInstanceTotal}"
					params="${[submitted: true,firstName:params.firstName, lastName :params.lastName, agentId: params.agentId, agentType: params.agentType, status: params.status, max: params.max, offset:params.offset]}" />
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