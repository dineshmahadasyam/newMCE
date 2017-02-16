<%@ page import="com.perotsystems.diamond.bom.Group"%>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'memberChangeEvent.label', default: 'Group')}" />
	
<g:set var="appContext" bean="grailsApplication"/>
	
<title>Search Member Change Events</title>
<style type='text/css' media='screen'>
#list-memberChangeEvent #group_member Label {
	width: 100px;
}

.enterField {
	width: 200px;
	text-align: left;
}

#list-memberChangeEvent #group_member Img {
	height: 20px;
	width: 20px;
	text-align: left;
}

.searchButton {
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

.searchButton:hover {
	background-color: #dfdfdf;
}

.searchButton:active {
	position: relative;
	top: 1px;
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
	filter: progid:DXImageTransform.Microsoft.gradient(        startColorstr='#0066cc',
		endColorstr='#7db9e8', GradientType=0); /* IE6-8 */
	border-radius: 15px;
}
</style>


<!-- Style Includes -->
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.window.css')}"
	type="text/css">

<!-- JavaScript Includes -->
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script>
var genericLookupWindow 
var genInnerWindowClosed = true;
function closeAllIFrames() {
	if(genericLookupWindow) {
		genericLookupWindow.close()
	}
}

function lookup(idName, cdoClassName, cdoClassAttributeName) {
	var htmlElementValue 
	var assocHTMLElementsValue
	if(idName.indexOf('|') == -1){			
		htmlElementValue = document.getElementById(idName).value
		assocHTMLElementsValue = htmlElementValue
	} else {
		var nameArray = idName.split("|")
		for (var i =0;i<nameArray.length;i++) {
			if(i == 0) {
				htmlElementValue = document.getElementById(nameArray[i]).value					
			}
			assocHTMLElementsValue += document.getElementById(nameArray[i]).value+"|"
		}
	}
	//alert("htmlElementValue = "+htmlElementValue )
	var appName = "${appContext.metadata['app.name']}";
	var urlValue = "/"+appName+"/lookUp/lookUp?htmlElementIdName=" + idName
			+ "&htmlElementValue=" + htmlElementValue + "&cdoClassName="
			+ cdoClassName + "&cdoClassAttributeName="+ cdoClassAttributeName +"&assocHTMLElementsValue="+ assocHTMLElementsValue + "&offset=0"
	//alert (urlValue )
	if (!genInnerWindowClosed) {
		genericLookupWindow.setUrl(urlValue)
	} else {
		genInnerWindowClosed = false;
		genericLookupWindow = $.window({
			showModal : true,
			title : "Lookup",
			bookmarkable : false,
			minimizable : false,
			maximizable : false,
			width : 900,
			height : 350,
			url : urlValue, 
		 onClose: function(wnd) { // a callback function while user click close button
			 genInnerWindowClosed = true;
		  }
		});
	}
}
</script>


<script language="javascript">

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
			    	var membr_maintaince_meaage_div = document.getElementById("grp_maintance_message_id")
		        	var membr_maintaince_meaage_div_value = document.getElementById("grp_maintance_message_id").innerHTML
		  	        if(membr_maintaince_meaage_div_value!=null)
		  	        {		  	        	
		  	         membr_maintaince_meaage_div.style.visibility="hidden"
		  	        }
			    	}  
 

			    	
				 }
			}
			/*if (elements[ii].type == "radio") {
				elements[ii].checked = false;
			}*/
		}
		var elements = document.getElementsByTagName("select");
		for ( var ii = 0; ii < elements.length; ii++) {
			elements[ii].selectedIndex = 0;
		}
	}

	function createGroup() {
		var createGroupID = "${params.groupId}"
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/groupMaintenance/create?groupId="
				+ createGroupID + "&groupEditType=MASTER")
	}
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
	
	function checkForSearchCritera(){
		var elements = document.getElementsByTagName("input");
		var searchCriteria = false;
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
		if(searchCriteria == false){
			alert ("Please enter search criteria to find Groups.");
		}
		return searchCriteria;
	}

	$(function($){
		   $("#IdGroupId").alphanum({
			    allow 		: '-_',
			    allowSpace  : false
			});

	})
</script>

</head>
<body >
	<div id="list-memberChangeEvent" class="content scaffold-list"
		role="main">
		<g:if test="${flash.message}">
			<div class="message" role="status" id="grp_maintance_message_id">
				${flash.message}
			</div>
		</g:if>
		<br> <br>
		<form name="searchForm" action="/${appContext.metadata['app.name']}/groupMaintenance/list">
			<input type="hidden" name="searchRef" value="searchForm">
			<table>
				<tr>
					<td>
						<table border="1" style="border-radius: 15px;">
							<tr>
								<td width="50%">
									<table border="0" id="group_member">
										<tr>
											<td class="innerbackground" colspan="4"
												style="color: #FFFFFF; text-align: center"><b>Group
												Maintenance</b></td>
										</tr>
										<tr>
											<td><Label><b>Group Id :</b> </Label></td>
											<td><input class="enterField" type="text" name="groupId"
												id="IdGroupId" value="${params.groupId}"
												maxlength="50" onclick='javascript: IdGroupId.value = ""' autofocus="autofocus"> 
											<td style="white-space: nowrap"><Label><b>
														Short Name : </b></Label></td>
											<td><input class="enterField" type="text"
												name="groupShortName" id="IdGroupShortName"
												value="${params.groupShortName}"
												maxlength="15"> &nbsp;</td>
										</tr>
										<tr>
											<td><Label><b>Name 1: </b></Label></td>
											<td><input class="enterField" type="text"
												name="groupName1" id="IdGroupName1"
												value="${params.groupName1}" maxlength="40">
												&nbsp;</td>
											<td><Label><b>Name 2: </b></Label></td>
											<td><input class="enterField" type="text"
												name="groupName2" id="IdGroupName2"
												value="${params.groupName2}" maxlength="40">
												&nbsp;</td>
										</tr>
										<% def style_plan = plan_lob.equals('checked') ?'style="display:block"':'style="display:none"'%>
										<tr id="search_button">
											<td colspan="2"><input class="searchButton" type="submit" value="Search" onClick="return checkForSearchCritera()">
											<g:if test="${params.groupId && create}">											
												<input class="searchButton" type="button" id="Create_id" 
												value="Create group - ${params.groupId }" onClick="createGroup()">
											</g:if>
											<td colspan="2" style="text-align: right">
												<div style="align: right">
													<input type="button" class="load" value="Reset"
														onClick="document.forms['searchForm'].reset();setFirstElementFocus()"> <input
														type="button" class="load" value="Clear"
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
		<g:if test="${groupMasterTotal>0}">
			<% Group event = groupMasterList.get(0)
session.setAttribute('groupDBID', event.groupDBId)
session.setAttribute('groupId', event.groupId)%>

			<table width="100%">
				<tr width="100%">
					<td width="100%" align="right">Number of Groups - ${groupMasterTotal}
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<table border="1">
							<tr>
								<td>
									<table border="0">
										<thead>
											<tr>
												<g:sortableColumn property="groupId" style="padding-left:5px;"
													title="${message(code: 'Group.memberChangeEventId.label', default: 'Group Id')}"
													params="${[groupId:params.groupId]}" />
												<g:sortableColumn property="shortName"
													title="${message(code: 'Group.groupId.label', default: 'Short Name')}"
													params="${[groupId:params.groupId]}" />
												<g:sortableColumn property="name1"
													title="${message(code: 'Group.changeEventType.label', default: 'Name 1')}"
													params="${[groupId:params.groupId]}" />
												<g:sortableColumn property="name2"
													title="${message(code: 'Group.retroEnabled.label', default: 'Name 2')}"
													params="${[groupId:params.groupId]}" />
												<g:sortableColumn property="levelCode"
													title="${message(code: 'Group.oldPeriodStartDate.label', default: 'Group Level')}"
													params="${[groupId:params.groupId]}" />
												<g:sortableColumn property="holdDate"
													title="${message(code: 'Group.oldPeriodEndDate.label', default: 'Hold Date')}"
													params="${[groupId:params.groupId]}" />
												<g:sortableColumn property="holdReason"
													title="${message(code: 'Group.newPeriodStartDate.label', default: 'Hold Reason')}"
													params="${[groupId:params.groupId]}" />
											</tr>
										</thead>
										<g:each in="${groupMasterList}" status="i" var="groupMaster">

											<tbody>
												<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
													<td style="padding-left:5px"><div style="height: 20px; overflow: hidden;">
															<g:link action="edit" id="${groupMaster.groupDBId}"
																params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'MASTER']}">
																${fieldValue(bean: groupMaster, field: "groupId")}

															</g:link>
														</div></td>

													<td><div style="height: 20px; overflow: hidden;">
															<g:link action="edit" id="${groupMaster.groupDBId}"
																params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'MASTER']}">
																${fieldValue(bean: groupMaster, field: "shortName")}
															</g:link>
														</div></td>

													<td><div style="height: 20px; overflow: hidden;">
															<g:link action="edit" id="${groupMaster.groupDBId}"
																params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'MASTER']}">
																${fieldValue(bean: groupMaster, field: "name1")}
															</g:link>
														</div></td>

													<td><div style="height: 20px; overflow: hidden;">
															<g:link action="edit" id="${groupMaster.groupDBId}"
																params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'MASTER']}">
																${fieldValue(bean: groupMaster, field: "name2")}
															</g:link>
														</div></td>

													<td><div style="height: 20px; overflow: hidden;">
															<g:link action="edit" id="${groupMaster.groupDBId}"
																params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'MASTER']}">
																<g:if test="${groupMaster?.levelCode?.toString().equals('1')}">
																Group
																</g:if>
																<g:elseif test="${groupMaster?.levelCode?.toString().equals('2')}">
																Super Group
																</g:elseif>
																<g:elseif test="${groupMaster?.levelCode?.toString().equals('3')}">
																Administrator Group
																</g:elseif>
															</g:link>
														</div></td>

													<td><div style="height: 20px; overflow: hidden;">
															<g:link action="edit" id="${groupMaster.groupDBId}"
																params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'MASTER']}">
																<g:formatDate format="yyyy-MM-dd"
																	date="${groupMaster.holdDate}" />
															</g:link>
														</div></td>

													<td><div style="height: 20px; overflow: hidden;">
															<g:link action="edit" id="${groupMaster.groupDBId}"
																params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'MASTER']}">
																${fieldValue(bean: groupMaster, field: "holdReason")}
															</g:link>
														</div></td>

												</tr>
											</tbody>

										</g:each>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<div class="pagination">
				<g:paginate total="${groupMasterTotal}"
					params="${[groupId:params.groupId, groupShortName:params.groupShortName, groupName1:params.groupName1, groupName2:params.groupName2]}" />
			</div>

		</g:if>


		<div style="display: none">
			<input type="button" onClick="closeAllIFrames()" id="closeIframes">
			<input type="button" onClick="iFrameSearchGroup()" id="ifSearchGroup">
		</div>
	</div>