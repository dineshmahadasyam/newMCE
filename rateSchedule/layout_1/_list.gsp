<%@ page import="com.perotsystems.diamond.bom.AgencyRateScheduleHdr"%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="searchJobs"/>
		
		<g:set var="entityName"	value="${message(code: 'AgencyRateSchedule.label', default: 'AgencyRateSchedule')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:set var="appContext" bean="grailsApplication"/>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		
		<script type="text/javascript">
		
			function createRateSchedule() {
				var rateId = "${params.rateId}";
				window.location
						.assign('<g:createLinkTo dir="/rateSchedule/create?rateId="/>'
								+ rateId);
			}
	
			function checkForSearchCritera() {
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
				for (var ii=1; ii < selects.length; ii++) {
				  if (selects[ii]) {
				    if(selects[ii].value != ""){
					    searchCriteria = true;
					}
				  }
				}
					
				if(searchCriteria == false){
				//alert ("Please enter search criteria to find Members.");
					  document.getElementById('BtnInfoAlertId').click();
				  }
				return searchCriteria;
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
	</head>
	<div id="fms_content">
    	<div id="fms_content_header">
    		<div class="fms_content_header_note">
				<a href="/FMSAdminConsole/commissions/searchJobs">Commissions Maintenance</a> / Rate Schedule
        	</div>
	        <div class="fms_content_title">
	        	<h1>Commission - Incentive Rate Schedule</h1>
	        </div>
	    </div>
	    <div id="fms_content_tabs" class="fms_tab_action">
			<ul>
				<li><a class="list" href="<g:createLinkTo dir="/commissions/searchJobs"/>">Search Jobs</a></li>
				<li><a class="list" href="<g:createLinkTo dir="/commissions/batchSearch"/>">Search Batch</a></li>
				<li><a class="active" href="<g:createLinkTo dir="/rateSchedule/list"/>">Commission - Incentive Rate Schedule</a></li>
			</ul>
			<div id="mobile_tabs_select"></div>
		</div>
		
		<div id="fms_content_body">
	     	<div id="SearchNoResults">
			<%-- Error messages start--%>
				<g:if test="${flash.message}">
					<div class="message" role="status" id="rate_schedue_message_id">
						${flash.message}
					</div>
				</g:if>
			</div>
			<g:if test="${fieldErrors}">
				<ul class="errors" role="alert">
					<g:each in="${fieldErrors}" var="error">
						<li>${error}</li>
					</g:each>
				</ul>
			</g:if>
			<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
			<%-- Error messages end--%>
			
			<form name="searchForm" action="/${appContext.metadata['app.name']}/rateSchedule/list">
			<input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):'rateId'}" />
      		<input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
	        <input type="hidden" name="submitted" value="true"/>
      		<!-- START - Rate Schedule Search Form -->      
			<div class="fms_widget fms_form_container">
	            <div class="fms_form_header">            
	              <h2>Commissions – Incentive Rate Schedule Search</h2>
	            </div>		
	          	<div class="fms_form">
		          	<div class="fms_form_body">
						<div class="fms_form_layout_2column">                  
		                	<div class="fms_form_column fms_long_labels">
			                	<label class="control-label" id="rateId_label" for="idrateId">Rate ID:</label>
			                  	<div class="fms_form_input">
				                	<input type="text" class="form-control" name="rateId" id="idrateId" maxlength="15" autofocus="autofocus" value="${params.rateId}"
											title= "The unique Rate ID for the Rate schedule" aria-labelledby="rateId_label" aria-describedby="rateId_error" aria-required="false">
				                  	<div class="fms_form_error" id="rateId_error"></div>
			                  	</div>
			                  	<label class="control-label" id="calcType_label" for="calcType">Calc Type : </label>
		                    	<div class="fms_form_input">
		                    		<g:secureComboBox class="form-control" name="calcType" id="calcType" tableName="AGENCY_RATE_SCHEDULE_HDR" attributeName="calcType" value="${params.calcType}"
		                    						aria-labelledby="calcType_label" aria-describedby="calcType_error" aria-required="false"
								  		from="${['' : '', 'I': 'I - Incentive' , 'C': 'C - Commission']}" optionValue="value" optionKey="key">
							  		</g:secureComboBox>
			                      	<div class="fms_form_error" id="calcType_error"></div>
	                    	  	</div>
		                  	</div>
		                  	<div class="fms_form_column fms_long_labels">
		                  		<label class="control-label" id="description_label" for="idDescription">Description :</label>
			                   	<div class="fms_form_input">
			                     	<input type="text" class="form-control" name="description" id="idDescription" maxlength="60" value="${params.description}"
			                     		aria-labelledby="description_label" aria-describedby="description_error" aria-required="false"
										title="The Description of the Rate schedule">
			                     	<div class="fms_form_error" id="description_error"></div>
			                   	</div>
		                 	</div>
		            	</div>
		        	</div>
	                <div class="fms_form_button">
		                <button id="BtnSearch" type="submit" value="Search" onClick="return checkForSearchCritera()" class="btn btn-primary">Search</button>
		                <input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
		              	<button type="button" id="BtnClear" class="btn btn-default" onClick="clearSearchCriteria()">Clear</button> 
				    	<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset plan form." data-target="#BlankAlertModal"></button>              
				    </div>
			    </div>
			</div>
			<!-- END  - Rate Schedule Search Form -->
			</form>
			<g:if test="${create && params.rateId}">
				<g:checkURIAuthorization uri="/rateSchedule/create">
					<div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
						<button class="btn btn-primary btn-sm" id="Create_id" title="Click to create Rate Schedule." onClick="createRateSchedule()"><i class="fa fa-plus"></i> Create a Rate Schedule - ${params.rateId}</button>
					</div>
				</g:checkURIAuthorization>
				<br></br>
			</g:if>  
			<g:if test="${ rateSchInstanceTotal >0}">
				<div id="SearchResults" class="fms_widget">
	           		<div class="fms_widget">
	           			<h2>Rate Schedule Search Results</h2>
						<div class="row fms-col_selector_row">
			                <div id="DataTableFound" class="col-xs-6 fms-results-found">${rateSchInstanceTotal} Results Found</div>
			                <div class="col-xs-6 fms-column-selector">
			                	<div class="columnSelectorWrapper">
	                   				<input id="colSelect1" type="checkbox" class="hidden columnSelectorcolSelect1">
	                   				<label class="columnSelectorButton" for="colSelect1" title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></label>
	                   				<div id="columnSelector" class="columnSelector">
	                        		</div>
	               				</div>
	             			</div>
	            		</div>
	           		</div>
	           		<div class="fms_table_wrapper">
	                	<table id="SearchResults1" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="SearchResults_pager_info">
	                 		<thead>
	                    		<tr role="row" class="tablesorter-headerRow">
				                    <fmsui:sortableColumn property="rateId" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0" aria-disabled="false"
														  title="${message(code: 'AgencyRateScheduler.rateId.label', default: 'Rate ID')}" 
														  params="${[rateId:params.rateId, description:params.description, calcType:params.calcType]}" />
									<fmsui:sortableColumn property="description" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="2" data-column="1" aria-disabled="false"
														  title="${message(code: 'AgencyRateSchedule.description.label', default: 'Description')}" 
														  params="${[rateId:params.rateId, description:params.description, calcType:params.calcType]}"/>
									<fmsui:sortableColumn property="calcType" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="3" data-column="2" aria-disabled="false"
														  title="${message(code: 'AgencyRateSchedule.calcType.label', default: 'Calc Type')}" 
														  params="${[rateId:params.rateId, description:params.description, calcType:params.calcType]}"/>
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="3" data-columnselector="disable" aria-disabled="true">Actions</th>
	                    		</tr>
	                    	</thead>
	                   		<tfoot>
					            <g:if test="${rateSchInstanceTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
					            	<th colspan="12" data-column="0" class="tablesorter-headerAsc">
				                        <div id="SearchResultsPager" class="pager tablesorter-pager">
				                          <span class="right">
					                          <div class="pagination">
					                            <g:paginate total="${rateSchInstanceTotal}"
													params="${[submitted: true, rateId: params.rateId, description: params.description, calcType:params.calcType, max: params.max, offset:params.offset]}" />
					                          </div>
				                          </span>
				                        </div>               
					                </th>  
					            </g:if>  
				            </tfoot>
	                		<tbody aria-live="polite" aria-relevant="all">
	                  			<g:each in="${rateSchInstanceList}" status="i" var="rateSchInstance">
	                   				<tr id="Row${i}" role="row" class="tablesorter-hasChildRow" style="">
		                      			<td>${fieldValue(bean: rateSchInstance, field: "rateId")}</td>
										<td>${fieldValue(bean: rateSchInstance, field: "description")}</td>								
										<td><g:if test="${fieldValue(bean: rateSchInstance, field: "calcType").equals('C') }">Commission</g:if>
											<g:elseif test="${fieldValue(bean: rateSchInstance, field: "calcType").equals('I') }">Incentive</g:elseif>
											<g:else>${fieldValue(bean: rateSchInstance, field: "calcType")}</g:else>														
										</td>
										<td>
		                      				<ul class="fms_table_action">
		                      					<li>
							                       	<g:link class="btn fms_btn_icon btn-sm BtnEditRow" 
							                       			title="Click to edit Rate Schedule." 
							                       			action="edit"
							                       			id="${rateSchInstance.description}"
							                       			params="${[editType:'MASTER', seqRateId: rateSchInstance.seqRateId]}">
							                       			<i class="fa fa-folder-open"></i>
												    </g:link>
												</li> 
											    <li class="fms_table_action_sub">
											    	<button class="btn fms_btn_icon btn-sm" title="Click to view more options."><i class="glyphicon glyphicon-option-horizontal"></i></button>
										        	<ul>
									                   	<li><g:link class="list" 
							                       				action="edit"
							                       				params="${[editType:'DETAIL', seqRateId: rateSchInstance.seqRateId]}">
							                       				Detail Records
											    			</g:link>
											    		</li>
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
	<!-- START - BlankAlertModal -->
	<div class="modal fade" id="BlankAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
 		<div class="modal-dialog">
      		<div class="modal-content fms_modal_error-sm">
		        <div class="modal-body">
		          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		          <h5>Please enter search criteria to find results.</h5>            
		        </div>
        		<div class="modal-footer text-center">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
        		</div>
      		</div>
    	</div>
	</div>
	<!-- END - BlankAlertModal -->
</html>
