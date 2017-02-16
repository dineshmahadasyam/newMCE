
<%@ page import="com.dell.diamond.fms.AgentMasterCommand"%>
<!DOCTYPE html>
<html>
<head>

	<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="agentMaster"/>
		
		<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'agentMaster.label', default: 'AgentMaster')}" />
	<g:set var="appContext" bean="grailsApplication"/>
	<title><g:message code="default.list.label" args="[entityName]" /></title>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

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
		document.getElementById('BtnInfoAlertId').click();
		//alert ("Please enter search criteria to find Agent.");
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

		// Below line is added as on click of clear button we have to clear records as well.				
		$('#SearchResults').hide();  
		$('.message').hide();
		$('.errors').hide();
		$('#SearchNoResults').hide();
		
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

	$(function($){
		 $("#agentId").alphanum({
			 	allow 		: '-_',
				allowSpace  : false
			});
	});
	function createAgentOrBrokerId(){	
		var appName = "${appContext.metadata['app.name']}";
		//var generateAutoAgentId = "${generateAutoSubId}";
		//alert('generateAutoAgentId: '+generateAutoAgentId);
			window.location.assign("/"+appName+"/agentMaster/create?&editType=MASTER");
		
	}

	
</script>
</head>

 <div id="fms_content">
      <div id="fms_content_header">
        <div class="fms_content_header_note">
        </div>
       
        <div class="fms_content_title">
        <h1>Agent Maintenance</h1>
         <!--  <h1>Add MEMMC LIS to Member : MEM461 Person Number : 01</h1> -->       
			
        </div>
      </div> 

      <div id="fms_content_body">
      
       <div id="error_Messages">
      
       <%-- Error messages start--%>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<g:if test="${fieldErrors}">
			<ul class="errors" role="alert">
				<g:each in="${fieldErrors}" var="error">
					<li>${error}</li>
				</g:each>
			</ul>
		</g:if>
		<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
		<%-- Error messages end--%>
       </div>

	
		<form name="searchForm" action="/${appContext.metadata['app.name']}/agentMaster/list">
			<input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):'agentId'}" />
      		<input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
      		
      		<input type="hidden" name="submitted" value="true">
      		
      		<!-- START - Group Search Form -->      
          <div class="fms_widget fms_form_container">
            <div class="fms_form_header">            
              <h2>Agent Search</h2>
              <a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
            </div>

          <div class="fms_form">
          	<div class="fms_form_body">

               <div class="fms_form_layout_2column">                  
                  <div class="fms_form_column fms_very_long_labels">
                  
                  
                  	<label class="control-label" id="agentId_label" for="agentId">Agent/Broker ID :</label>
                    <div class="fms_form_input">
                      <input type="text" name="agentId" id="agentId" class="form-control"
							 title ="The Id Number for the Agent/Broker"
							 value="${params.agentId}" maxlength="15"
							 onclick='javascript: agentId.value = ""'>
                      <div class="fms_form_error" id="agentId_error"></div>
                    </div>
      		
      				<label class="control-label" id="firstName_label" for="firstName">First Name :</label>
                    <div class="fms_form_input">
                      <input autofocus="autofocus" type="text" class="form-control"
							 title ="The First Name of the Agent/Broker"
							 name="firstName" id="firstName" value="${params.firstName}"
							 maxlength="35" onclick='javascript: firstName.value = ""'>
                      <div class="fms_form_error" id="firstName_error"></div>
                    </div>
                    
                    <label class="control-label" id="lastName_label" for="lastName">Last Name :</label>
                    <div class="fms_form_input">
                      <input type="text" name="lastName" id="lastName" class="form-control"
							 title ="The Last Name of the Agent/Broker"
							 value="${params.lastName}" maxlength="60"
							 onclick='javascript: lastName.value = ""'>
                      <div class="fms_form_error" id="lastName_error"></div>
                    </div>
      		
					<!-- 
						<td><b>License No: </b></td>
						<td><input autofocus="autofocus" type="text"
							title ="The License Number of the Agent/Broker"
							name="licenseNo" id="licenseNo" value="${params.licenseNo}"
							maxlength="22" onclick='javascript: licenseNo.value = ""'>
							&nbsp;</td>
                    -->      
                    
                    </div>
                    
                <div class="fms_form_column fms_very_long_labels">

					<label class="control-label" id="agentType_label" for="agentType">Agent/Broker Type :</label>
                    	<div class="fms_form_input">
		                      <select class="form-control" name="agentType" id="agentType" title ="The Agent Type" onchange="checkAgentType()">										
									  <option value="">-- Select the Agent Type --</option>
								 	  <option value="C" ${"C".equals(request.getParameter("agentType"))? 'selected' :'' }>C – Company</option>
								 	  <option value="I" ${"I".equals(request.getParameter("agentType"))? 'selected' :'' }>I – Independent</option>
							  </select>
                      		  <div class="fms_form_error" id="agentType_error"></div>
                    	</div> 
											
					 <label class="control-label" id="status_label" for="status">Status:</label>
	                    <div class="fms_form_input">
		                      <select class="form-control" name="status" id="status" title ="The Agent Status">
									  <option value="">-- Select the Agent Status --</option>
								 	  <option value="A" ${"A".equals(request.getParameter("status"))? 'selected' :'' }>A – Active</option>
								 	  <option value="T" ${"T".equals(request.getParameter("status"))? 'selected' :'' }>T – Terminated</option>
							  </select>
		                      <div class="fms_form_error" id="status_error"></div>
	                    </div>				   
											
					 <label class="control-label" id="creationDate_label" for="creationDate">Financial Period :</label>
	                    <div class="fms_form_input">
	                      <input type="text" name="creationDate" id="creationDate" class="form-control"
								 title ="Enter 2 digit Month and 4 digit Year for the financial period. Example 052015"
								 value="${params.creationDate}">
	                      <div class="fms_form_error" id="creationDate_error"></div>
	                    </div>					
					</div>
                </div>
              </div>
              
              <div class="fms_form_button">
              	<input type="submit" value="Search" class="btn btn-primary" onClick="return checkForSearchCriteria();"> 
                <input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
                <button  type="button" id="BtnClear" class="btn btn-default" onClick="clearSearchCriteria()">Clear</button>
                <button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset Agent form." data-target="#BlankAlertModal"></span></button> 
              </div>
             </div>
           </div>
      	</form>
			
		<g:if test="${create && params.agentId}">
			<g:checkURIAuthorization uri="/agentMaster/create">
				<div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
					<button class="btn btn-primary btn-sm" id="Create_id"
						title="Click to add new company." onClick="createCompany()">
							<i class="fa fa-plus"></i> Create an Agent ${params.agentId}
					</button>
				</div>
			</g:checkURIAuthorization>
		</g:if>
		
		<g:if test="${iscreateAgentFlag2 == true}">
			<div id="createCompanyDiv">
				<div id="SearchNoResults1" class="fms_widget fms_widget_border fms_widget_bgnd-color"
					style="display: ${iscreateAgentFlag?'block':'none' }">
					<g:checkURIAuthorization uri="/agentMaster/create">
						<input type="button" class="btn btn-primary" id="Create_id" 
							value="Auto Assign Agent/Broker ID" onClick="createAgentOrBrokerId()" />
					</g:checkURIAuthorization>
				</div>
			</div>
		</g:if>

		<g:if test="${ agentMasterInstanceTotal >0}">
		
			<div id="SearchResults" class="fms_widget">
        	<div class="fms_widget">
        	
          <h2>Agent Search Results</h2>


          <div class="row">
            <div id="SearchResultsFound" class="col-xs-6 fms-results-found">${agentMasterInstanceTotal} Results Found</div>
            <div class="col-xs-6 fms-column-selector">
              <div class="columnSelectorWrapper">
                <input id="colSelect1" type="checkbox" class="hidden columnSelectorcolSelect1" />
                <label class="columnSelectorButton" for="colSelect1" title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></label>
                <div id="columnSelector" class="columnSelector">                	
					<!-- this div is where the column selector is added -->
				    
				</div> 
              </div>
            </div>
          </div>
		</div>
          <div class="fms_table_wrapper">
            <table id="SearchResults1" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="SearchResults_pager_info">
              <thead>
                <tr role="row" class="tablesorter-headerRow" >
                
                	<fmsui:sortableColumn property="agentId" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="1" data-column="0" aria-disabled="false"
						title="${message(code: 'agentMaster.agentId.label', default: 'Agent/Broker ID')}"
						params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />
                	
                	<fmsui:sortableColumn property="agentType" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="2" data-column="1" aria-disabled="false"
						title="${message(code: 'agentMaster.agentType.label', default: 'Agent Type')}"
						params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />

					<fmsui:sortableColumn property="firstName" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="3" data-column="2" aria-disabled="false"
						title="${message(code: 'agentMaster.firstName.label', default: 'First Name')}"
						params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />
						
					<fmsui:sortableColumn property="lastName" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="4" data-column="3" aria-disabled="false"
						title="${message(code: 'agentMaster.lastName.label', default: 'Last Name')}"
						params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />
						
					<fmsui:sortableColumn property="payType" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="5" data-column="4" aria-disabled="false"
						title="${message(code: 'agentMaster.payType.label', default: 'Pay Type')}"
						params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />
						
					<fmsui:sortableColumn property="status" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="6" data-column="5" aria-disabled="false"
						title="${message(code: 'agentMaster.status.label', default: 'Status')}"
						params="${[submitted:true, firstName:params.firstName, lastName:params.lastName, agentId:params.agentId,  agentType:params.agentType, licenseNo:params.licenseNo, creationDate:params.creationDate, status:params.status]}" />						
                	
                	<th class="{sorter: false} tablesorter-header sorter-false" data-column="11" data-columnselector="disable" aria-disabled="true">Actions</th>
          			
				</tr>
              </thead>
              <tfoot>
           		 <g:if test="${agentMasterInstanceTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
               		<th colspan="12" data-column="0" class="tablesorter-headerAsc">
                      <div id="SearchResultsPager" class="pager tablesorter-pager">
                        <span class="right">
                         <div class="pagination">
                           <g:paginate total="${agentMasterInstanceTotal}" params="${[submitted: true,firstName:params.firstName, lastName :params.lastName, agentId: params.agentId, agentType: params.agentType, status: params.status, max: params.max, offset:params.offset]}" />
                         </div>
                        </span>
                      </div>               
                     </th>  
                  </g:if>  
              </tfoot>
              <tbody>	
					
					<g:each in="${agentMasterInstanceList}" status="i" var="agentMasterInstance">
						 <tr role="row">
							
							<td>${fieldValue(bean: agentMasterInstance, field: "agentId")}</td>
							<td>${fieldValue(bean: agentMasterInstance, field: "agentType")}</td>
							<td>${fieldValue(bean: agentMasterInstance, field: "firstName")}</td>
							<td>${fieldValue(bean: agentMasterInstance, field: "lastName")}</td>
							<td>${fieldValue(bean: agentMasterInstance, field: "payType")}</td>
							<td>${fieldValue(bean: agentMasterInstance, field: "status")}</td>
							
							<td>

                    <ul class="fms_table_action">
                      <li><g:link class="btn fms_btn_icon btn-sm" title="Click to view Master Record" action="edit" id="${agentId}" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'MASTER', creationDate:params.creationDate]}"><i class="fa fa-folder-open"></i></g:link></li>
                      <li class="fms_table_action_sub">
                       <button class="btn fms_btn_icon btn-sm" title="Click to view more options."><i class="glyphicon glyphicon-option-horizontal"></i></button>
                        <ul>
							<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'ADDRESS', creationDate:params.creationDate]}">Addresses</g:link></li>
							<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'CONTACT', creationDate:params.creationDate]}">Contacts</g:link></li>
							<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'TXN', creationDate:params.creationDate]}">Transactions</g:link></li>
							<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'COMMISSION', creationDate:params.creationDate]}">Broker Commissions</g:link></li>
							<li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'CONTRACTS', creationDate:params.creationDate]}">Contracts</g:link></li>
						    <li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'BANKING', creationDate:params.creationDate]}">Banking</g:link></li>
						    <li><g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'LICENSE', callingPage: 'AGENT']}">License and Certification</g:link></li>   
                         </ul>
                      </li>
                    </ul>
                    </td>
				</tr>
			</g:each>
		</tbody>
		</table>
		</div>
		</div>
		</g:if>
		</div>
		</div>

<script type="text/javascript">

		$(document).ready(function() { 
			var SearchNoResults1 = document.getElementById("SearchNoResults1")
		    $('#BtnClear').click(function(e){
		      $('#SearchNoResults, #SearchResults').addClass('hidden');
		      SearchNoResults1.style.display = "block"
		    });
		});


		$(document).ready(function() { 
		
			$('.btnInfoAlert').hide();  
			$('.btnInfoAlert').click(function(e){ 
		    	$('#BlankAlertModal').modal('show');
		    });
		 	$('#BlankAlertModal').modal({
		    	backdrop: 'static',
		       show: false
		   	});
		});


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

<!-- START - blank search Notice Modal -->
<div class="modal fade" id="BlankAlertModal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel">
	<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->
	<div class="modal-dialog">
		<div class="modal-content fms_modal_error-sm">
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h5>Please enter search criteria to find Agent.</h5>
			</div>

			<div class="modal-footer text-center">
				<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
			</div>
		</div>
	</div>
</div>
<!-- END - blank search Notice Modal -->


</html>