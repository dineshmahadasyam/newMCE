<%@ page import="com.perotsystems.diamond.bom.fms.AgencyLicenseHdr" %>


<!DOCTYPE html>
<html>
<head>
<g:set var="appContext" bean="grailsApplication" />
<meta name="layout" content="main">
<g:set var="entityName" value="${message(code: 'AgencyLicenseHdr.label', default: 'AgencyLicenseHdr')}" />

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>

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

function checkForSearchCritera(){
	var elements = document.getElementsByTagName("input");
	var searchCriteria = false;

	for (var ii=0; ii < elements.length; ii++) {
		  if (elements[ii].type == "text") {
			  
			    if(elements[ii].value != ""){
				    searchCriteria = true;
				    break;
				}
		  }
	}

	if (searchCriteria == false) {
		var selects = document.getElementsByTagName("select");
		var appName = "${appContext.metadata['app.name']}";
		for (var ii=1; ii < selects.length; ii++) {		
			var val = document.getElementById(selects[ii].id).value;
		    if(  (val != "") && (val.indexOf(appName) == -1)  ){				    	
			    searchCriteria = true;	
			    break;			    	
			}				  
		}
	}
	
	if(searchCriteria == false){
	//	alert ("Please enter search criteria to find results.");
		document.getElementById('BtnInfoAlertId').click();
	}
	return searchCriteria;
	
}
function clearSearchCriteria() {


	// Below line is added as on click of clear button we have to clear records as well.				
	$('#SearchResults').hide();  
	$('.message').hide();
	$('.errors').hide();
	$('#SearchNoResults').hide();
	
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
</head>
<!-- START - FMS Content Body -->
<div id="fms_content_body">

	<%-- Error messages start--%>
	<g:if test="${flash.message}">
		<div class="message" role="status">
			${flash.message}
		</div>
	</g:if>
	<g:if test="${fieldErrors}">
		<ul class="errors" role="alert">
			<g:each in="${fieldErrors}" var="error">
				<li>
					${error}
				</li>
			</g:each>
		</ul>
	</g:if>
	<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
	<%-- Error messages end--%>


	<div id="DataTableSection">
		<form name="searchForm" action="/${appContext.metadata['app.name']}/agency/searchLicense">
			<input type="hidden" name="searchRef" value="searchForm">
			<input type="hidden" name="editType" value="LICENSE" /> 
			<input type="hidden" name="submitted" value="true">

			<g:if test="${params.callingPage == 'AGENCY'}">
				<input type="hidden" name="seqAgencyId"
					value="${agencyInstance?.seqAgencyId}" />
				<input type="hidden" name="callingPage" value="AGENCY" />
			</g:if>
			<g:elseif test="${params.callingPage == 'AGENT'}">
				<input type="hidden" name="seqAgentId"
					value="${agentMasterInstance?.seqAgentId}" />
				<input type="hidden" name="callingPage" value="AGENT" />
			</g:elseif>

			<input type="hidden" name="searchRef" value="searchForm">

			<div class="fms_widget fms_form_container">

				<div class="fms_form_header">
					<h2>Search License Records</h2>
					<a href="#" class="fms_form_header_close" title="Hide Form"><i
						class="fa fa-minus-square"></i></a>
				</div>

				<div class="fms_form">
					<div class="fms_form_body">

						<div class="fms_form_layout_2column">
							<div class="fms_form_column fms_long_labels">

								<label class="control-label" for="licenseNumber"
									id="licenseNumber_label">License No :</label>
								<div class="fms_form_input">
									<input autofocus="autofocus" type="text" class="form-control"
										name="licenseNumber" id="licenseNumber"
										title="The License No." value="${params.licenseNumber}"
										maxlength="11">
									<div class="fms_form_error" id="licenseNumber_error"></div>
								</div>

							</div>
							<div class="fms_form_column fms_long_labels">

								<label class="control-label" for="licenseLoa"
									id="licenseLoa_label">License LOA : </label>
								<div class="fms_form_input">
									<g:getSystemCodes cssClass="form-control"
										systemCodeType="COMMIS_LOA" systemCodeActive="Y"
										htmlElelmentId="licenseLoa" blankValue="Line Of Authority"
										defaultValue="${params.licenseLoa}"/>
									<div class="fms_form_error" id="licenseLoa_error"></div>
								</div>
							</div>
						</div>

					</div>

					<div class="fms_form_button">
						<input type="submit" value="Search" class="btn btn-primary" onClick="return checkForSearchCritera()"> 
						<input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
						<button  type="button" id="BtnClear" class="btn btn-default" onClick="clearSearchCriteria()">Clear</button>
						<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset search." data-target="#BlankAlertModal"><span class="glyphicon glyphicon-repeat"></span></button>
					</div>

				</div>

			</div>
		</form>

		<!-- END  - Search Form -->

		<g:if test="${createLicenseFlag && params.licenseNumber}">
			<g:checkURIAuthorization uri="/agency/addLicense">
				<div id="SearchNoResults"
					class="fms_widget fms_widget_border fms_widget_bgnd-color">
					<button class="btn btn-primary btn-sm" id="Create_id"
						title="Click to create License" onClick="createLicense()">
						<i class="fa fa-plus"></i> Create a License -
						${params.licenseNumber}
					</button>
				</div>
			</g:checkURIAuthorization>
		</g:if>

		<g:if test="${ licenseCount >0}">
			<div id="SearchResults" class="fms_widget">
				<div class="fms_widget">
					<h2>License and Certifications Search Results</h2>

					<div class="row">
						<div id="SearchResultsFound" class="col-xs-6 fms-results-found">
							${licenseCount}
							Results Found
						</div>
						<div class="col-xs-6 fms-column-selector">
							<div class="columnSelectorWrapper">
								<input id="colSelect1" type="checkbox"
									class="hidden columnSelectorcolSelect1"> <label
									class="columnSelectorButton" for="colSelect1"
									title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i
									class="fa fa-caret-down"></i></label>
								<div id="columnSelector" class="columnSelector">
									<!-- this div is where the column selector is added -->
								</div>
							</div>
						</div>
					</div>

					<div class="fms_table_wrapper">
						<table id="SearchResults1"
							class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector"
							role="grid" aria-describedby="SearchResults_pager_info">
							<thead>
								<tr>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="0" aria-disabled="true">License No</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" aria-disabled="true">License LOA</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" aria-disabled="true">State</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="3" aria-disabled="true">Status</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" aria-disabled="true">Status Date</th>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="5" aria-disabled="true">Expiration Date</th>

									<th class="{sorter: false} tablesorter-header sorter-false"
										data-column="6" data-columnselector="disable"
										aria-disabled="true">Actions</th>
								</tr>
							</thead>
							<tfoot>
							
							<g:if test="${licenseCount > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
					                <th colspan="12" data-column="0" class="tablesorter-headerAsc">
					                        <div id="SearchResultsPager" class="pager tablesorter-pager">
					                          <span class="right">
						                          <div class="pagination">
						                            <g:paginate total="${licenseCount}"
														params="${[editType:'LICENSE', callingPage:'AGENCY', seqAgencyId: params.seqAgencyId, licenseNumber:params.licenseNumber, licenseLoa :params.licenseLoa , offset:request.getParameter('offset')]}" />
						                          </div>
					                          </span>
					                        </div>               
					                </th>  
					              </g:if> 
							
							</tfoot>

							<tbody>
								<g:each in="${licenseCollection}" status="i"
									var="licenseInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

											<td>
												${fieldValue(bean: licenseInstance, field: "licenseNumber")}
											</td>
											

											<td>
												${fieldValue(bean: licenseInstance, field: "licenseLoa")}
											</td>
											

											<td>
												${fieldValue(bean: licenseInstance, field: "state")}
											</td>
											<td>
												${licenseInstance?.agencyLicenceDtls?.status[0]}
											</td>

											<td><g:formatDate format="MM/dd/yyyy"
													date="${licenseInstance.agencyLicenceDtls.currentStatusDate[0]}" /></td>

											<td><g:formatDate format="MM/dd/yyyy"
													date="${licenseInstance.agencyLicenceDtls.expirationDate[0]}" /></td>

										<g:if test="${params.callingPage == 'AGENT'}">
										<td><g:link class="btn fms_btn_icon btn-sm BtnEditRow"
												title="Click to edit detail." action="edit"
												params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENT', seqAgentId: agentMasterInstance?.seqAgentId,
																	licenseNumber: licenseInstance.licenseNumber]}">
												<span class="glyphicon glyphicon-pencil"></span>
											</g:link></td>
										</g:if>
										<g:elseif test="${params.callingPage == 'AGENCY'}">
										<td><g:link class="btn fms_btn_icon btn-sm BtnEditRow"
												title="Click to edit detail." action="edit"
												params="${[editType:'LICENSE', editSubType:'UPDATE', callingPage: 'AGENCY', seqAgencyId: agencyInstance?.seqAgencyId,
																		licenseNumber: licenseInstance.licenseNumber]}">
												<span class="glyphicon glyphicon-pencil"></span>
											</g:link></td>
										</g:elseif>
									</tr>
								</g:each>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</g:if>
	</div>
</div>
</div>
</html>

<script type="text/javascript">

		$(document).ready(function () {

		    $(".tablesorter").tablesorter({
		        theme: 'blue',
		        initialized: function (table) {
		            $(".tablesorter").find(".show-disable-icon").removeClass("sorter-false");
		            
		            var sortvar = getQueryVariable('sort');
		            var order = getQueryVariable('order');
		            var expr = 'tr[class="tablesorter-headerRow"] th[id^="' + sortvar + '"]'
		            var sortID = $(expr).attr('id');
		            
		            if(sortvar!== -1) {
		                $("#" + sortID).removeClass("tablesorter-headerDesc");
		                $("#" + sortID).removeClass("tablesorter-headerAsc");
		                if (order === 'desc') {
		                    $("#" + sortID).addClass("tablesorter-headerDesc");
		                } else {
		                    $("#" + sortID).addClass("tablesorter-headerAsc");
		                }
		            }            
		        },

		        widgets: ['zebra', 'columnSelector'],
		        widgetOptions : {
		          columnSelector_container : $('#columnSelector'),
		          columnSelector_saveColumns: true,
		          columnSelector_mediaquery: false,      
		          columnSelector_layout : '<label><input type="checkbox">{name}</label>',
		          columnSelector_cssChecked : 'checked',

		          // Hide/Show columns based on viewport width 
		          columnSelector_mediaquery: true,
		          columnSelector_mediaqueryState: false,
		          columnSelector_mediaqueryName: 'Auto display columns: ',
		          columnSelector_priority : 'data-priority'      
		        }
		    });
		    
		    $(".show-disable-icon").click(function (evt) {
		        var columnRef = evt.currentTarget.id;
		        var url = $("#" + columnRef).attr("data-sorturl");
		        //var ad = Math.floor(Math.random() * 2);
		        
		        var newURL = url;// + "&sort=" + columnRef+"&order="+ad;
		        window.location = newURL;
		        
		    });

		    function getQueryVariable(variable) {
		        var query = window.location.search.substring(1);
		        var vars = query.split("&");
		        for (var i = 0; i < vars.length; i++) {
		            var pair = vars[i].split("=");
		            if (pair[0] == variable) {
		                return pair[1];
		            }
		        }
		        return -1;
		    }
		    
		});

</script>

<script type="text/javascript">
	$(document).ready(function() {

		$('.btnInfoAlert').hide();
		$('.btnInfoAlert').click(function(e) {
			$('#BlankAlertModal').modal('show');
		});
		$('#BlankAlertModal').modal({
			backdrop : 'static',
			show : false
		});
	});
</script>

<!-- START - blank search Notice Modal -->
<div class="modal fade" id="BlankAlertModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->
	<div class="modal-dialog">
		<div class="modal-content fms_modal_error-sm">
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h5>Please enter search criteria to find results.</h5>
			</div>

			<div class="modal-footer text-center">
				<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
			</div>
		</div>
	</div>
</div>
<!-- END - blank search Notice Modal -->