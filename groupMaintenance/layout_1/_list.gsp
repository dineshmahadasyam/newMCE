<%@ page import="com.perotsystems.diamond.bom.Group"%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'memberChangeEvent.label', default: 'Group')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:set var="appContext" bean="grailsApplication"/>
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="groupMaintenance"/>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
<script type="text/javascript">
// On Search Button click show results	
	
			
			
			function clearSearchCriteria() {
			var elements = document.getElementsByTagName("input");
			var firstText = true;
			for (var ii=0; ii < elements.length; ii++) {
			  if (elements[ii].type == "text") {
			    elements[ii].value = "";
			    if (firstText) {
				    firstText = false;
			    	elements[ii].focus();
			    	var clear_btn = document.getElementById('Create_id')
			    	if(clear_btn!= null)
			    	{
			    	clear_btn.style.display="none"
			    	var membr_maintaince_meaage_div = document.getElementById("grp_maintance_message_id")
		  	        if(membr_maintaince_meaage_div !=null)
		  	        {
		  	        var membr_maintaince_meaage_div_value_1 = document.getElementById("grp_maintance_message_id").innerHTML
		  	             if(membr_maintaince_meaage_div_value_1!=null)
		  	             {
		  	        	 membr_maintaince_meaage_div.style.display="none"
		  	             }
		  	        }
			    	}
			    	else
			    	{
			    	var membr_maintaince_meaage_div_1 = document.getElementById("grp_maintance_message_id")			    	
			    	if(membr_maintaince_meaage_div_1 !=null){			    				    	
				    	var membr_maintaince_meaage_div_value_1 = document.getElementById("grp_maintance_message_id").innerHTML
				    	membr_maintaince_meaage_div_1.style.display="none"
					    }
			    	}
			    	
				 }
			  }
			  if (elements[ii].type == "radio") {
				    elements[ii].checked = false;
			  }
			}
			var elements = document.getElementsByTagName("select");
			for (var ii=0; ii < elements.length; ii++) {
			    elements[ii].selectedIndex = 0;
			}
		}
	
	function createGroup() {
	    var createGroupID = "${params.groupId}"
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/groupMaintenance/layout_1/create?groupId="+ createGroupID )
	}

	function autoGenGroup() {
		var parameter1 = "${parameter1}";
		var generateAutoSubId = "${generateAutoSubId}"
		var appName = "${appContext.metadata['app.name']}";
		if(parameter1)
		{
			window.location.assign("/"+appName+"/groupMaintenance/create?generateAutoSubId="
					+ generateAutoSubId + "&groupEditType=MASTER");
		}
		
	}

	function createNew() {
		window.location.assign("create?groupId=${params.groupId}&groupEditType=MASTER");
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
//			alert ("Please enter search criteria to find Members.");
			  document.getElementById('BtnInfoAlertId').click();
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

    <div id="fms_content">
      <div id="fms_content_header">
        <div class="fms_content_header_note">
        </div>
       
        <div class="fms_content_title">
        <h1>Group Maintenance</h1>
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
         
      	 <form name="searchForm" action="/${appContext.metadata['app.name']}/groupMaintenance/list">
             <input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):'groupId'}" />
      		<input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
      		
      		<!-- START - Group Search Form -->      
          <div class="fms_widget fms_form_container">
            <div class="fms_form_header">            
              <h2>Group Search</h2>
              <a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
            </div>

          <div class="fms_form">
          	<div class="fms_form_body">

               <div class="fms_form_layout_2column">                  
                  <div class="fms_form_column fms_long_labels">

                    <label class="control-label" id="GroupID_label" for="GroupID">Group ID:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" aria-labelledby="GroupID_label" aria-describedby="GroupID_error" aria-required="false"  
                             value="${params.groupId}" name="groupId" id="IdGroupId" maxlength="50" autofocus="autofocus"/>
                      <div class="fms_form_error" id="GroupID_error"></div>
                    </div>

                    <label class="control-label" id="ShortName_label" for="ShortName">Short Name:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" id="ShortName" aria-labelledby="ShortName_label" aria-describedby="ShortName_error" aria-required="false" 
                      		name="groupShortName" id="IdGroupShortName" value="${params.groupShortName}" maxlength="15"/>
                      <div class="fms_form_error" id="ShortName_error"></div>
                    </div>            

                  </div>
                  <div class="fms_form_column">

                    <label class="control-label" id="Name1_label" for="Name1">Name 1:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" id="Name1" aria-labelledby="Name1_label" aria-describedby="Name1_error" aria-required="false" 
                      		name="groupName1" id="IdGroupName1" value="${params.groupName1}" maxlength="40"/>
                      <div class="fms_form_error" id="Name1_error"></div>
                    </div>

                    <label class="control-label" id="Name2_label" for="Name2">Name 2:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" id="Name2" aria-labelledby="Name2_label" aria-describedby="Name2_error" aria-required="false"
							name="groupName2" id="IdGroupName2" value="${params.groupName2}" maxlength="40"/>
                      <div class="fms_form_error" id="Name2_error"></div>
                    </div>

                  </div>
                </div>
              </div>

              <div class="fms_form_button">
                <input type="submit" value="Search" class="btn btn-primary" onClick="return checkForSearchCritera()">
                <input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
                <button  type="button" id="BtnClear" class="btn btn-default" onClick="clearSearchCriteria()">Clear</button>
                <button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset address form." data-target="#DeleteAlertModal"></button> 
              </div>
             </div>
           </div>
              
              
      </form>
       
  <!-- END  - Group Search Form -->
  
  <g:if test="${create && params.groupId}">
		<g:checkURIAuthorization uri="/groupMaintenance/create">
			<div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
				
				<button class="btn btn-primary btn-sm" id="Create_id" title="Click to create group." onClick="createNew()"><i class="fa fa-plus"></i> Create Group - ${params.groupId}</button>
			</div>
		</g:checkURIAuthorization>
		<br></br>
	</g:if>    	
       
<g:if test="${groupMasterTotal > 0}">
<% Group event = groupMasterList.get(0)
session.setAttribute('groupDBID', event.groupDBId)
session.setAttribute('groupId', event.groupId)%>

       <div id="SearchResults" class="fms_widget">
        <div class="fms_widget">
        
            <h2>Group Search Results</h2>

               <div class="row">
                <div id="DataTableFound" class="col-xs-6 fms-results-found">${groupMasterTotal} Results Found</div>
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
            </div>
              
              
                
                <div class="fms_table_wrapper">
               <table id="SearchResults1" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="SearchResults_pager_info">
               <thead>
                  <tr role="row" class="tablesorter-headerRow" >
                    <fmsui:sortableColumn property="groupId" class="show-disable-icon tablesorter-header  " data-sorter="false" data-priority="1" data-column="0"  aria-disabled="false"
						title="${message(code: 'Group.memberChangeEventId.label', default: 'Group Id')}"
						params="${[groupId:params.groupId]}" />
                    <fmsui:sortableColumn property="shortName" class="show-disable-icon tablesorter-header  " data-sorter="false" data-priority="2" data-column="1"  aria-disabled="false"
						title="${message(code: 'Group.groupId.label', default: 'Short Name')}"
						params="${[groupId:params.groupId]}" />
                    <fmsui:sortableColumn property="name1" class="show-disable-icon tablesorter-header  " data-sorter="false" data-priority="3" data-column="2"  aria-disabled="false"
						title="${message(code: 'Group.changeEventType.label', default: 'Name 1')}"
						params="${[groupId:params.groupId]}" />
                    <fmsui:sortableColumn property="name2" class="show-disable-icon tablesorter-header  " data-sorter="false" data-priority="4" data-column="3"  aria-disabled="false"
						title="${message(code: 'Group.retroEnabled.label', default: 'Name 2')}"
						params="${[groupId:params.groupId]}" />
                    <fmsui:sortableColumn property="levelCode" class="show-disable-icon tablesorter-header  " data-sorter="false" data-priority="5" data-column="4"  aria-disabled="false"
						title="${message(code: 'Group.oldPeriodStartDate.label', default: 'Group Level')}"
						params="${[groupId:params.groupId]}" />
                    <fmsui:sortableColumn property="holdDate" class="show-disable-icon tablesorter-header  " data-sorter="false" data-priority="6" data-column="5"  aria-disabled="false"
						title="${message(code: 'Group.oldPeriodEndDate.label', default: 'Hold Date')}"
						params="${[groupId:params.groupId]}" />
                    <fmsui:sortableColumn property="holdReason" class="show-disable-icon tablesorter-header  " data-sorter="false" data-priority="7" data-column="6"  aria-disabled="false"
						title="${message(code: 'Group.newPeriodStartDate.label', default: 'Hold Reason')}"
						params="${[groupId:params.groupId]}" />
                    <th class="{sorter: false} tablesorter-header sorter-false" data-column="7" data-columnselector="disable" aria-disabled="true">Actions</th>
                  </tr>
                </thead>
       
            <tfoot>
              <g:if test="${groupMasterTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
                <th colspan="12" data-column="0" class="tablesorter-headerAsc">
                        <div id="SearchResultsPager" class="pager tablesorter-pager">
                          <span class="right">
	                          <div class="pagination">
	                            <g:paginate total="${groupMasterTotal}"
									params="${[groupId:params.groupId, groupShortName:params.groupShortName, groupName1:params.groupName1, groupName2:params.groupName2]}" />
	                          </div>
                          </span>
                        </div>               
                </th>  
              </g:if>  
            </tfoot>
            
               <tbody aria-live="polite" aria-relevant="all">
				<g:each in="${groupMasterList}" status="i" var="groupMaster">
                    <tr role="row">
                	<td>${fieldValue(bean: groupMaster, field: "groupId")}</td>
                	<td>${fieldValue(bean: groupMaster, field: "shortName")}</td>
                	<td>${fieldValue(bean: groupMaster, field: "name1")}</td>
                	<td>${fieldValue(bean: groupMaster, field: "name2")}</td>
                	<td>
	                	<g:if test="${groupMaster?.levelCode?.toString().equals('1')}">
							  Group
						</g:if>
						<g:elseif test="${groupMaster?.levelCode?.toString().equals('2')}">
							Super Group
						</g:elseif>
						<g:elseif test="${groupMaster?.levelCode?.toString().equals('3')}">
							Administrator Group
						</g:elseif>
                	</td>
                	<td>
                	<g:formatDate format="yyyy-MM-dd" date="${groupMaster?.holdDate}" /></td>
                	<td>${fieldValue(bean: groupMaster, field: "holdReason")}</td>
                	<td>

                    <ul class="fms_table_action">
                      <li><g:link class="btn fms_btn_icon btn-sm" title="Click to view Master Record" action="edit" id="${groupMaster.groupId}" params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'MASTER']}" ><i class="fa fa-folder-open"></i></g:link></li>
                      <li class="fms_table_action_sub">
                       <button class="btn fms_btn_icon btn-sm" title="Click to view more options."><i class="glyphicon glyphicon-option-horizontal"></i></button>
                        <ul>
                        	<li><g:link action="edit" id="${groupMaster.groupId}" params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'CONTRACT']}">Contracts</g:link></li>
	                        <li><g:link action="edit" id="${groupMaster.groupId}" params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'DETAIL']}">Detail Records</g:link></li>
	                        <li><g:link action="edit" id="${groupMaster.groupId}" params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'ADDRESS']}">Addresses</g:link></li>
	                        <li><g:link action="edit" id="${groupMaster.groupId}" params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'CONTACT']}">Contacts</g:link></li>
	                        <li><g:link action="edit" id="${groupMaster.groupId}" params="${[groupId:groupMaster.groupId, groupDBId: groupMaster.groupDBId, groupEditType :'COMMRATES']}">Group Rates</g:link></li>
                         
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
       
<!-- START - Delete Notice Modal -->
<div class="modal fade" id="DeleteAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter search criteria to find Groups.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
<!-- END - Delete Notice Modal -->

       
<script type="text/javascript">

$(document).ready(function() { 

	$('.btnInfoAlert').hide();  
	$('.btnInfoAlert').click(function(e){ 
    	$('#DeleteAlertModal').modal('show');
    });
 	$('#DeleteAlertModal').modal({
    	backdrop: 'static',
       show: false
   	});

	      $('#BtnClear').click(function(e){
	        $('#SearchNoResults, #SearchResults, #error_Messages').addClass('hidden');
	      });
	});



$(document).ready(function() {

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
</html>           