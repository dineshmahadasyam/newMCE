<%@ page import="com.perotsystems.diamond.bom.fms.AgencyLicenseHdr" %>

<g:set var="appContext" bean="grailsApplication"/>
<g:set var="entityName" value="${message(code: 'AgencyLicenseHdr.label', default: 'AgencyLicenseHdr')}" />
<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

<style type='text/css' media='screen'>

 TD {
			padding: 0.5em 0.6em;
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
	border-radius: 15px;
}

</style>

<script>

$(function($){
	
	   $("#licenseNumber").alphanum({
			allow 		: '-_',
			allowSpace  : false
		});
})

function createLicense() {
	
	//var createLicenseNumber = "${params.licenseNumber}";
	var callingPage ="${params.callingPage}";
	
	if (callingPage == 'AGENCY') {	
		//window.location.assign('<g:createLinkTo dir="/agency/addLicense?licenseNumber="/>' 
		//		+ createLicenseNumber 
		//		+ '&seqAgencyId=' + ${agencyInstance?.seqAgencyId} 
		//		+ '&agencyId=' + ${agencyInstance?.agencyId} 
		//		+ '&agencyType=' + ${agencyInstance?.agencyType} 
		//		+ '&callingPage=' + callingPage);
		window.location.assign('<g:createLinkTo dir="/agency/addLicense"/>?seqAgencyId=${agencyInstance?.seqAgencyId}&agencyId=${agencyInstance?.agencyId }&agencyType=${agencyInstance?.agencyType}&callingPage=${params.callingPage}&createLicenseNumber=${params.licenseNumber}');
	}
	else if (callingPage == 'AGENT') {
		//window.location.assign('<g:createLinkTo dir="/agency/addLicense?licenseNumber="/>' 
		//		+ createLicenseNumber 
		//		+ '&seqAgentId=' + ${agentMasterInstance?.seqAgentId} 
		//		+ '&agentId=' + ${agentMasterInstance?.agentId} 
		//		+ '&agentType=' + ${agentMasterInstance?.agentType} 
		//		+ '&callingPage=' + callingPage);
		window.location.assign('<g:createLinkTo dir="/agency/addLicense"/>?seqAgentId=${agentMasterInstance?.seqAgentId}&agentId=${agentMasterInstance?.agentId}&agentType=${agentMasterInstance?.agentType}&callingPage=${params.callingPage}&createLicenseNumber=${params.licenseNumber}');
	}
	
}

function checkForSearchCriteria(){
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
		alert ("Please enter search criteria to find results.");
		setFirstElementFocus();
	  }
	  
	  return searchCriteria;
	
}

function clearSearchCriteria() {
	var elements = document.getElementsByTagName("input");
	var firstText = true;
	for (var ii=0; ii < elements.length; ii++) {
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
}

function setFirstElementFocus() {
	var firstText = true;
	var elements = document.getElementsByTagName("input");
	for (var ii=0; ii < elements.length; ii++) {
		  if (elements[ii].type == "text") {
			if (firstText) {
				firstText = false;
				elements[ii].focus();
			 }
		  }
	}
}
</script>

<div id="list-license" class="content scaffold-list" role="main" style="width: 100%; overflow: auto;">
		<g:if test="${flash.message}">
			<div class="message" role="status" style="display:${flash.message?'show':'hidden'};" >
				${flash.message}
			</div>
		</g:if>
		<form name="searchForm" action="/${appContext.metadata['app.name']}/agency/searchLicense" >
			<input type="hidden" name="searchRef" value="searchForm">
			<input type="hidden" name="editType" value="LICENSE" />
			<g:if test="${params.callingPage == 'AGENCY'}">
				<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId}" />
				<input type="hidden" name="callingPage" value="AGENCY" />
			</g:if>
			<g:elseif test="${params.callingPage == 'AGENT'}">
				<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId}" />
				<input type="hidden" name="callingPage" value="AGENT" />
			</g:elseif>
			
			<table>
				<tr>
					<td>
						<table border="1">
							<tr>
								<td>
									<table>
										<tr>
											<td class="innerbackground" colspan="4" style="color: #FFFFFF; text-align: center"><b>Search License Records
											</b></td>
										</tr>
										<tr>
											<td><b>License No : </b></td>
											<td><input autofocus="autofocus" type="text"
												name="licenseNumber" id="licenseNumber" title ="The License No."
												value="${params.licenseNumber}" maxlength="11"> &nbsp;</td>

											<td><b>License LOA : </b></td>
											<td>
												<g:getSystemCodes
													systemCodeType="COMMIS_LOA" 
													systemCodeActive = "Y"
													htmlElelmentId="licenseLoa"
													blankValue="Line Of Authority"
													defaultValue="${params.licenseLoa}" 
													width="200px"/>
											</td>
										</tr>

										<tr id="search_button">
											<td colspan="2"><input type="submit" value="Search"
												class="load" onClick="return checkForSearchCriteria()"> 
												<g:if test="${params.licenseNumber}">
													<div id="createLicenseDiv" style="visibility:${createLicenseFlag? 'show':'hidden'};display:inline" >
															<input type="button" class="load"
																value="Create a License  - ${params.licenseNumber}"
																onClick="createLicense()" />															
													</div>
												</g:if></td>
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
		<g:if test="${ licenseCount >0}">
			<div id="list-license" class="content scaffold-list" role="main" style="width: 100%; overflow-x: scroll; display:inline">
				&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;Number of License Records -
				${licenseCount}
				<table>
					<tr>
						<td>
							<table border="1">
								<tr>
									<td>
										<table>
											<thead>
												<tr>
													<th class="sortable">&nbsp;&nbsp;&nbsp;&nbsp;License No</th>
													<th class="sortable">License LOA</th>
													<th class="sortable">State</th>
													<th class="sortable">Status</th>	
													<th class="sortable">Status Date</th>
													<th class="sortable">Expiration Date</th>		
													
												</tr>
											</thead>
											<tbody>
												<g:each in="${licenseCollection}" status="i" var="licenseInstance">
													<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

														<td style="height: 20px; overflow: hidden;">
															<div>
																<g:if test="${params.callingPage == 'AGENCY'}">
																	<g:link action="edit"
																		params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENCY', seqAgencyId: agencyInstance?.seqAgencyId,
																		licenseNumber: licenseInstance.licenseNumber]}">
																		${fieldValue(bean: licenseInstance, field: "licenseNumber")}
																	</g:link>
																</g:if>
																<g:elseif test="${params.callingPage == 'AGENT'}">
																	<g:link action="edit"
																		params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENT', seqAgentId: agentMasterInstance?.seqAgentId,
																		licenseNumber: licenseInstance.licenseNumber]}">
																		${fieldValue(bean: licenseInstance, field: "licenseNumber")}
																	</g:link>
																</g:elseif>
															</div>
														</td>
														<td style="height: 20px; overflow: hidden;">
															<div>
																	<g:if test="${params.callingPage == 'AGENCY'}">
																		<g:link action="edit"
																			params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENCY', seqAgencyId: agencyInstance?.seqAgencyId,
																			licenseNumber: licenseInstance.licenseNumber]}">
																			${fieldValue(bean: licenseInstance, field: "licenseLoa")}
																		</g:link>
																	</g:if>
																	<g:elseif test="${params.callingPage == 'AGENT'}">
																		<g:link action="edit"
																			params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENT', seqAgentId: agentMasterInstance?.seqAgentId,
																			licenseNumber: licenseInstance.licenseNumber]}">
																			${fieldValue(bean: licenseInstance, field: "licenseLoa")}
																		</g:link>
																	</g:elseif>
																	
															</div>
														</td>
														<td style="height: 20px; overflow: hidden;">
																<div>
																	<g:if test="${params.callingPage == 'AGENCY'}">
																		<g:link action="edit"
																			params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENCY', seqAgencyId: agencyInstance?.seqAgencyId,
																			licenseNumber: licenseInstance.licenseNumber]}">
																			${fieldValue(bean: licenseInstance, field: "state")}
																		</g:link>
																	</g:if>
																	<g:elseif test="${params.callingPage == 'AGENT'}">
																		<g:link action="edit"
																			params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENT', seqAgentId: agentMasterInstance?.seqAgentId,
																			licenseNumber: licenseInstance.licenseNumber]}">
																			${fieldValue(bean: licenseInstance, field: "state")}
																		</g:link>
																	</g:elseif>
																	
																</div>
															
														</td>
														<td style="height: 20px; overflow: hidden;">
															<g:if test="${licenseInstance?.agencyLicenceDtls?.status}">
																<div>
																	<g:if test="${params.callingPage == 'AGENCY'}">
																		<g:link action="edit"
																			params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENCY', seqAgencyId: agencyInstance?.seqAgencyId,
																			licenseNumber: licenseInstance.licenseNumber]}">
																			${licenseInstance?.agencyLicenceDtls?.status[0]}
																		</g:link>
																	</g:if>
																	<g:elseif test="${params.callingPage == 'AGENT'}">
																		<g:link action="edit"
																			params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENT', seqAgentId: agentMasterInstance?.seqAgentId,
																			licenseNumber: licenseInstance.licenseNumber]}">
																			${licenseInstance?.agencyLicenceDtls?.status[0]}
																		</g:link>
																	</g:elseif>
																	
																</div>
															</g:if>
															<g:else></g:else>
														</td>
														<td style="height: 20px; overflow: hidden;">
															<g:if test="${licenseInstance?.agencyLicenceDtls?.currentStatusDate}">
																<div>
																	<g:if test="${params.callingPage == 'AGENCY'}">
																		<g:link action="edit"
																			params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENCY', seqAgencyId: agencyInstance?.seqAgencyId,
																			licenseNumber: licenseInstance.licenseNumber]}">
																			<g:formatDate format="MM/dd/yyyy" date="${licenseInstance.agencyLicenceDtls.currentStatusDate[0]}" />
																		</g:link>
																	</g:if>
																	<g:if test="${params.callingPage == 'AGENT'}">
																		<g:link action="edit"
																			params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENT', seqAgentId: agentMasterInstance?.seqAgentId,
																			licenseNumber: licenseInstance.licenseNumber]}">
																			<g:formatDate format="MM/dd/yyyy" date="${licenseInstance.agencyLicenceDtls.currentStatusDate[0]}" />
																		</g:link>
																	</g:if>
																</div>
															</g:if>
															<g:else></g:else>
														</td>
														<td style="height: 20px; overflow: hidden;">
															<g:if test="${licenseInstance?.agencyLicenceDtls?.expirationDate}">
																<div>
																	<g:if test="${params.callingPage == 'AGENCY'}">
																		<g:link action="edit"
																			params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENCY', seqAgencyId: agencyInstance?.seqAgencyId,
																			licenseNumber: licenseInstance.licenseNumber]}">
																			<g:formatDate format="MM/dd/yyyy" date="${licenseInstance.agencyLicenceDtls.expirationDate[0]}" />
																		</g:link>
																	</g:if>
																	<g:elseif test="${params.callingPage == 'AGENT'}">
																		<g:link action="edit"
																			params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENT', seqAgentId: agentMasterInstance?.seqAgentId,
																			licenseNumber: licenseInstance.licenseNumber]}">
																			<g:formatDate format="MM/dd/yyyy" date="${licenseInstance.agencyLicenceDtls.expirationDate[0]}" />
																		</g:link>
																	</g:elseif>
																	
																</div>
															</g:if>
															<g:else></g:else>
														</td>
													</tr>
												</g:each>
											</tbody>

										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<%--  
			<g:if test="${params.callingPage == 'AGENCY'}">
				<div class="pagination">
					<g:paginate total="${licenseCount}" action="searchLicense"
						params="${[editType:'LICENSE', callingPage:'AGENCY', seqAgencyId: params.seqAgencyId, licenseNumber:params.licenseNumber, licenseLoa :params.licenseLoa , offset:request.getParameter('offset')]}" />
				</div>
			</g:if>
			<g:elseif test="${params.callingPage == 'AGENT'}">
				<div class="pagination">
					<g:paginate total="${licenseCount}" action="searchLicense"
						params="${[editType:'LICENSE', callingPage:'AGENT', seqAgentId: params.seqAgentId, licenseNumber:params.licenseNumber, licenseLoa :params.licenseLoa , offset:request.getParameter('offset')]}" />
				</div>
			</g:elseif>
			--%>
		</g:if>
		<div style="display: none">
			<input type="button" onClick="closeAllIFrames()" id="closeIframes">
		</div>
	</div>
