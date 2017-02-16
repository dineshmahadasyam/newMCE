<%@ page import="com.perotsystems.diamond.bom.fms.Agency"%>
<!DOCTYPE html>
<html>
<head>

<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="agency"/>

<meta name="layout" content="main">
<g:set var="appContext" bean="grailsApplication"/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>


<script type="text/javascript">

function createAgecny() {
	var agencyId = "${params.agencyId}";
		window.location
				.assign('<g:createLinkTo dir="/agency/create?agencyId="/>'
						+ agencyId);
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
		  document.getElementById('BtnInfoAlertId').click();
		//alert ("Please enter search criteria to find results");
		return false;
	  }
}

function clearSearchCriteria() {

	// Below line is added as on click of clear button we have to clear records as well.				
	$('#SearchResults').hide();  
	$('.message').hide();
	$('.errors').hide();
	$('#SearchNoResults').hide();
	$('#SearchNoResults1').show();
	
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

	$("#idtin").unmask();
	$("#idtin").mask("?99-9999999");
	
}


function autoGenAgencyId() {
	var generateAutoAgencyId = "${generateAutoAgencyId}"
	var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/agency/create?generateAutoAgencyId="
				+ generateAutoAgencyId + "&editType=MASTER");
}

$(function($){
	   
	   $("#idagencyId").alphanum({
			allow 		: '-',
			allowSpace  : false
		});

	   $("#idAgencyName").alphanum({
			allow 		: '-&',
			allowSpace  : true
		});
		
	   $("#idtin").mask("?99-9999999");
	})
</script>


<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'agentMaster.label', default: 'AgencytMaster')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

 <div id="fms_content">
      <div id="fms_content_header">
        <div class="fms_content_header_note">
        </div>
       
        <div class="fms_content_title">
        <h1>Agency Maintenance</h1>
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

		<form name="searchForm" action="/${appContext.metadata['app.name']}/agency/list">
			 <input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):'agencyId'}" />
      		 <input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
      		 
      		 <input type="hidden" name="submitted" value="true">
      		
      		<!-- START - Group Search Form -->      
          <div class="fms_widget fms_form_container">
            <div class="fms_form_header">            
              <h2>Agency Search</h2>
              <a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
            </div>

          <div class="fms_form">
          	<div class="fms_form_body">

               <div class="fms_form_layout_2column">                  
                  <div class="fms_form_column fms_long_labels">
			
					<label class="control-label" id="AgencyID_label" for="AgencyID">Agency ID :</label>
                    <div class="fms_form_input">
                      <input class="form-control" type="text" name="agencyId" id="idagencyId" autofocus="autofocus" maxlength="50" value="${params.agencyId}" title= "The unique Agency ID of the Agency">
                      <div class="fms_form_error" id="AgencyID_error"></div>
                    </div>
                    
                    <label class="control-label" id="TaxID_label" for="TaxID">Tax ID : </label>
                    <div class="fms_form_input">
                      <input class="form-control" type="text" name="tin" id="idtin" maxlength="30" value="${params.tin}" title="The 9 digit Tax ID Number of the Agency">
                      <div class="fms_form_error" id="TaxID_error"></div>
                    </div>
                    
                    </div>
                  <div class="fms_form_column">
                  
                  	
                  	<label class="control-label" id="AgencyName_label" for="AgencyName">Agency Name :</label>
                    <div class="fms_form_input">
                      <input class="form-control" type="text" name="agencyName" id="idAgencyName" maxlength="60" value="${params.agencyName}" title="The Name of the Agency">
                      <div class="fms_form_error" id="AgencyName_error"></div>
                    </div>
                    
                   </div>
                </div>
              </div>

              <div class="fms_form_button">
                <input type="submit" value="Search" class="btn btn-primary" onClick="return checkForSearchCriteria()">
                <input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
                <button  type="button" id="BtnClear" class="btn btn-default" onClick="clearSearchCriteria()">Clear</button>
                <button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset MCE form." data-target="#BlankAlertModal">
              </div>
             </div>
           </div>
      </form>
      
      <!-- END  - Group Search Form -->
  
  <g:if test="${create && params.agencyId}">
		<g:checkURIAuthorization uri="/agency/create">
			<div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
				
				<button class="btn btn-primary btn-sm" id="Create_id" title="Click to create agency." onClick="createAgecny()"><i class="fa fa-plus"></i> Create an Agency - ${params.agencyId}</button>
			</div>
		</g:checkURIAuthorization>
		<br></br>
	</g:if>  
	<g:elseif test="${generateAutoAgencyId}">
		<div id="SearchNoResults1" class="fms_widget fms_widget_border fms_widget_bgnd-color">
			<input type="button" class="btn btn-primary" id="Create_id" value="Auto Assign Agency ID" onClick="autoGenAgencyId()" />
		</div>
	</g:elseif>	
		
		<g:if test="${ agencyInstanceTotal >0}">
		
		<div id="SearchResults" class="fms_widget">
        <div class="fms_widget">
        
            <h2>Agency Search Results</h2>

               <div class="row">
                <div id="DataTableFound" class="col-xs-6 fms-results-found">${agencyInstanceTotal} Results Found</div>
                <div class="col-xs-6 fms-column-selector">
                
                <div class="columnSelectorWrapper">
                     <input id="colSelect1" type="checkbox" class="hidden columnSelectorcolSelect1">
                    <label class="columnSelectorButton" for="colSelect1" title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></label>
                    <div id="columnSelector" class="columnSelector">
                      <!-- this div is where the column selector is added -->

                  </div>
                </div>
              </div>
             </div>
              
              
                
                <div class="fms_table_wrapper">
               <table id="SearchResults1" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="SearchResults_pager_info">
               <thead>
                  <tr role="row" class="tablesorter-headerRow" >
                  
                   <fmsui:sortableColumn property="agencyId" class="show-disable-icon tablesorter-header  " data-sorter="false" data-priority="1" data-column="0"  aria-disabled="false"
						title="${message(code: 'agency.agencyId.label', default: 'Agency ID')}"
						params="${[agencyId:params.agencyId]}" />
						
				   <fmsui:sortableColumn property="agencyName" class="show-disable-icon tablesorter-header  " data-sorter="false" data-priority="2" data-column="1"  aria-disabled="false"
						title="${message(code: 'agency.agencyName.label', default: 'Agency Name')}"
						params="${[agencyId:params.agencyId]}" />
						
				   <fmsui:sortableColumn property="tin" class="show-disable-icon tablesorter-header  " data-sorter="false" data-priority="3" data-column="2"  aria-disabled="false"
						title="${message(code: 'agency.tin.label', default: 'Tax ID')}"
						params="${[agencyId:params.agencyId]}" />
						
				   <th class="{sorter: false} tablesorter-header sorter-false" data-column="7" data-columnselector="disable" aria-disabled="true">Actions</th>
                  </tr>
                </thead>
              <tfoot>
           		 <g:if test="${agencyInstanceTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
               		<th colspan="12" data-column="0" class="tablesorter-headerAsc">
                      <div id="SearchResultsPager" class="pager tablesorter-pager">
                        <span class="right">
                         <div class="pagination">
                           <g:paginate total="${agencyInstanceTotal}" params="${[submitted: true, agencyName:params.agencyName, agencyId: params.agencyId, tin :params.tin, max: params.max, offset:params.offset]}" />
                         </div>
                        </span>
                      </div>               
                     </th>  
                  </g:if>  
              </tfoot>
              <tbody>
				<g:each in="${agencyInstanceList}" status="i" var="agencyInstance">
                    <tr role="row">
                    	<td>${fieldValue(bean: agencyInstance, field: "agencyId")}</td>
                    	<td>${fieldValue(bean: agencyInstance, field: "agencyName")}</td>
                    	<td>${fieldValue(bean: agencyInstance, field: "tin")}</td>
                    	
                    	<td>

                    <ul class="fms_table_action">
                      <li><g:link class="btn fms_btn_icon btn-sm" title="Click to view Master Record" action="edit" id="${agencyId}" params="${[editType:'MASTER', seqAgencyId: agencyInstance.seqAgencyId, agencyId: agencyInstance.agencyId, agencyName: agencyInstance.agencyName, tin: agencyInstance.tin]}"><i class="fa fa-folder-open"></i></g:link></li>
                      <li class="fms_table_action_sub">
                       <button class="btn fms_btn_icon btn-sm" title="Click to view more options."><i class="glyphicon glyphicon-option-horizontal"></i></button>
                        <ul>
							<li><g:link id="${agencyId}" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'ADDRESS']}">Addresses</g:link></li>
							<li><g:link id="${agencyId}" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'CONTACT']}">Contacts</g:link></li>
							<li><g:link id="${agencyId}" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'CONTRACTS']}">Contracts</g:link></li>
							<li><g:link id="${agencyId}" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'BANKING']}">Banking</g:link></li>
							<li><g:link id="${agencyId}" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'LICENSE', callingPage: 'AGENCY']}">License and Certification</g:link></li>
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


<script type="text/javascript">

		$(document).ready(function() { 
		
		    $('#BtnClear').click(function(e){
		      $('#SearchNoResults, #SearchResults').addClass('hidden');
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
				<h5>Please enter search criteria to find results.</h5>
			</div>

			<div class="modal-footer text-center">
				<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
			</div>
		</div>
	</div>
</div>
<!-- END - blank search Notice Modal -->
                    
</html>
									