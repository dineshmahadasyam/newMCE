<html>
<head>
<meta name="layout" content="main">
<title><g:message code="default.list.label" args="[entityName]" /></title>
<g:set var="appContext" bean="grailsApplication"/>
<meta name="navSelector" content="maint"/> 
<meta name="navChildSelector" content="agentMaster"/> 

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>


<script type="text/javascript">

function isNumberKey(evt) {
	var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode == 46 && evt.srcElement.value.split('.').length>1) {
    	//alert("Please enter numbers and decimal only for Rate Amount");
    	document.getElementById('overrideAmtAlertInfo').click();    	
        return false;
    }
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)){
    	//alert("Please enter numbers and decimal only for Rate Amount");
    	document.getElementById('overrideAmtAlertInfo').click();    	
    	return false;
        }
        
    return true;
}


function closeForm() {
	var seqAgentId = "${agentMasterInstance?.seqAgentId}";
	var agentId = "${agentMasterInstance?.agentId}";
	var agentType = "${agentMasterInstance?.agentType}";
	var creationDate = "${params.creationDate}";
	var appName = "${appContext.metadata['app.name']}";

	window.location.assign("/"+appName+"/agentMaster/edit?seqAgentId="
			+ seqAgentId +"&agentId="+agentId +"&agentType="+agentType + "&editType=CONTRACTS" +"&creationDate="+creationDate);			
}		


function populateDescription() {
	 var groupId = document.getElementById("groupId").value;

	 if(groupId != null && groupId != ""){
		 var descr = jQuery.ajax({
				url : '<g:createLinkTo dir="/agency/ajaxPopulateDescription"/>',
								
				type : "GET",
				data : {groupId:groupId},
				success : function(result) {

					var index = result.indexOf("-")
					
					if(index != null && index > 0){
						var seqDBId = result.substr(0 , index).trim()
						
						var desc = result.substr(index+1 , result.length)
						if(seqDBId != null && seqDBId != ""){
							document.getElementById("agentGroupContract.0.seqGroupId").value = seqDBId
							}
						else{
							document.getElementById("agentGroupContract.0.seqGroupId").value = null
							}

						if(desc != null){
							document.getElementById("description").value = desc
							}
						else{
							document.getElementById("description").value = ""
							}
					}
					else{
						document.getElementById("agentGroupContract.0.seqGroupId").value = null
						document.getElementById("description").value = ""
						}
				}
			});
	}
	 else{
		 document.getElementById("description").value=""
		 }
}

function upperMe() { 
	document.getElementById("groupId").value = document.getElementById("groupId").value.toUpperCase(); 
}

function lookupplanId(idName, cdoClassName, cdoClassAttributeName, setToIdName, setToIdName1) {
	var groupId = document.getElementById(idName).value
	if(groupId == null || groupId == "") {
		//alert ("Please enter Group Id");
		document.getElementById('GroupIdAlertInfo').click();
		return false;
	}

	var isValidGroupId= "";
	 var descr = jQuery.ajax({
			url : '<g:createLinkTo dir="/agency/ajaxValidateGroupId"/>',
			async: false,				
			type : "POST",
			data : {groupId:groupId},
			success : function(result) {
				isValidGroupId = result
			}
		});
	
	if(isValidGroupId == null || isValidGroupId != "true"){
		//alert ("Please enter a valid Group Id");
		document.getElementById('GroupIdAlert').click();
		return false;
	}
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
	var appName = "${appContext.metadata['app.name']}";
	$('#LookupModal').modal('show');
	var urlValue = "/"+appName+"/lookUp/lookUpPlanId?htmlElementIdName=" + idName
					+ "&htmlElementValue=" + htmlElementValue 
					+ "&cdoClassName="+ cdoClassName 
					+ "&cdoClassAttributeName="+ cdoClassAttributeName 
					+ "&assocHTMLElementsValue="+ assocHTMLElementsValue 
					+ "&setToIdName=" + setToIdName
					+ "&setToIdName1=" + setToIdName1
					+ "&offset=0"
	document.getElementById('LookupSrc').setAttribute('src', urlValue);
}

$(document).ready(function() {
	
	$('.groupIdAlert').hide();  
	$('.groupIdAlert').click(function(e){ 
    	$('#SearchAlertModal').modal('show');
    });
 	$('#SearchAlertModal').modal({
    	backdrop: 'static',
       show: false
   	});

 	$('.groupIdAlertInfo').hide();  
	$('.groupIdAlertInfo').click(function(e){ 
    	$('#SearchAlertModalInfo').modal('show');
    });
 	$('#SearchAlertModalInfo').modal({
    	backdrop: 'static',
       show: false
   	});

 	$('.overrideAmtAlertInfo').hide();  
	$('.overrideAmtAlertInfo').click(function(e){ 
    	$('#OverrideAmtAlertModal').modal('show');
    });
 	$('#OverrideAmtAlertModal').modal({
    	backdrop: 'static',
       show: false
	});

	
});
	$(document).ready(function(){

		//$(".amtNumeric").numeric({});
		
		$(function() {	
		$( "#editForm" ).validate({
			onfocusout: false,
			submitHandler: function (form) {
				isInvalidForm = 'false';				
				  if ($(form).valid()) 
		              form.submit(); 
		          return false; // prevent normal form posting
		    },
		  	
		    	invalidHandler: function(form, validator) {
		    	isInvalidForm = 'true';
		        var errors = validator.numberOfInvalids();
		        if (errors) {      
		        	$(".message").hide();              
		            validator.errorList[0].element.focus();
		        }
		    },
		    
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",	

			rules : {
				 	'groupId' : {
						required : true
				 	},
		 			'0.planRiderCode' : {
		 				required : true
			 		},
			 		'agentGroupContract.0.seqGroupId' : {
			 			required : true
					 }
			},
		    messages : {
			 	'groupId' : {
					required : "Please enter Group ID"
			 	},
			 	'0.planRiderCode' : {
			 		required : "Please enter Plan/Rider Code"
			 	},
			 	'agentGroupContract.0.seqGroupId' : {
			 		required : "Please enter valid Group ID"
			 	}
			}
		})
		});

		});


</script>
</head>
<div id="fms_content">
	<div id="fms_content_header">
		<div class="fms_content_header_note">
		 		<a href="${createLink(uri: '/agentMaster/list')}">Agent Maintenance</a> / 
	      		<g:link class="list" action="edit" params="${[seqAgentId: agentMasterInstance?.seqAgentId, agentId: agentMasterInstance?.agentId, agentType: agentMasterInstance?.agentType, editType :'CONTRACTS', creationDate:params.creationDate]}">Agent Contract</g:link>
	      			/ Add Contract to Agent : ${agentMasterInstance?.agentId }
	  		</div>
		  	<div class="fms_content_title">
	          	<h1>Add Agent Contract</h1>
	        </div>
		</div>
		
<div id="fms_content_body">
	<div class="right-corner" align="right">COMMC</div>
		<div class="fms_required_legend fms_required">= required</div>
		<div class="fms_form_border">
			<div class="fms_form_body fms_form_border">
			

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
	
	<g:form action="saveContract" id="editForm" name="editForm">
		<input type="hidden" name="agentGroupContract.0.seqAgencyId" value="${agentMasterInstance?.seqAgencyId} ">
		<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId} ">
			
			<!-- START - WIDGET: General Information -->
			<div id="widgetGeneral" class="fms_widget">
				<fieldset class="no_border">
					<legend>
						<h2>Add Agent Contract</h2>
					</legend>
					<div class="fms_form_layout_2column">						
						<div class="fms_form_column fms_long_labels">
						
							<div class="fieldcontain ${hasErrors(bean: agentGroupContract, field: 'groupId', 'error')} ">
								<label id="groupId_r2_label" for="groupId" class="control-label fms_required" > 
									<g:message code="agentGroupContract.groupId.label" default="Group ID :" />
								</label>
							</div>	
								<div class="fms_form_input fms_has_feedback">	
									<input type="hidden" id="agentGroupContract.0.seqGroupId" name="agentGroupContract.0.seqGroupId" value="${agentGroupContract?.seqGroupId}"/>
									<g:textField name="groupId" id="groupId" value="${params.groupId }" title="The Group ID" class="form-control" 
												 onblur = "upperMe();populateDescription()" aria-labelledby="groupId_r2_label"  
												 aria-describedby="groupId_r2_error" aria-required="false"/>									
									<fmsui:cdoLookup 
											    lookupElementId="groupId"
											    lookupElementName="groupId" 
											    lookupElementValue="${params.groupId}"
											    lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupMaster"
											    lookupCDOClassAttribute="groupId"
											    htmlElementsToUpdate="agentGroupContract.0.seqGroupId"
											    htmlElementsToUpdateCDOProperty="seqGroupId"/>
									<div class="fms_form_error" id="groupId_error"></div>
								</div>
							
							<div class="fieldcontain ${hasErrors(bean: agentGroupContract, field: 'planRiderCode', 'error')} ">
								<label  id="planRiderCode_r2_label" for="planRiderCode" class="control-label fms_required" > 
									<g:message code="agentGroupContract.planRiderCode.label" default="Plan/Rider Code :" />
								</label>
							</div>	
								<div class="fms_form_input fms_has_feedback">
										<input type="hidden" id="agentGroupContract.0.seqPremId" name="agentGroupContract.0.seqPremId" value="${agentGroupContract?.seqPremId}"/>										
										<g:textField name="0.planRiderCode" id="0.planRiderCode" value="${params.planRiderCode }" class="form-control" 
													 readonly="readonly" aria-labelledby="planRiderCode_r2_label" aria-describedby="planRiderCode_r2_error" aria-required="false"/>
										
										<button type="button" id="0.planRiderCode" class="btn fms_btn_icon btn-sm fms_form_control_feedback" 
													title="Click to do full search." 
													onclick="lookupplanId('groupId', 'com.perotsystems.diamond.dao.cdo.PremiumMaster','seqGroupId', '0.planRiderCode','agentGroupContract.0.seqPremId')">
												<i class="glyphicon glyphicon-search"></i>
										</button>								 	
																	
										<button id="GroupIdAlertInfo" type="button" class="btn fms_btn_icon btn-sm groupIdAlertInfo" title="Click to reset plan form." data-target="#SearchAlertModalInfo"><span class="glyphicon glyphicon-repeat"></span></button>
										<button id="GroupIdAlert" type="button" class="btn fms_btn_icon btn-sm groupIdAlert" title="Click to reset plan form." data-target="#SearchAlertModal"><span class="glyphicon glyphicon-repeat"></span></button>
										<div class="fms_form_error" id="planRiderCode_error"></div>
								</div>						
						</div>					
						
						
						<div class="fms_form_column fms_long_labels">
							<label id="description_r2_label" for="description" class="control-label " > 
									<g:message code="description.label" default="Description :" />
								</label>
								<div class="fms_form_input">										
										<g:textField name="description" id="description" value="${params.description }"	 readonly="readonly" class="form-control"
														aria-labelledby="description_r2_label" aria-describedby="description_r2_error" aria-required="false"/>	
										<div class="fms_form_error" id="description_error"></div>
								</div>	
								
								<label id="overrideAmount_r2_label" for="overrideAmount" class="control-label"> 
									<g:message code="agentGroupContract.overrideAmount.label" default="Override Amt :"/>
								</label>
								<div class="fms_form_input">										
											<g:textField name="agentGroupContract.0.overrideAmount" value="${agentGroupContract?.overrideAmount}" class="form-control" 
														onkeypress="return isNumberKey(event)"	maxlength="30" aria-labelledby="overrideAmount_r2_label" aria-describedby="overrideAmount_r2_error" aria-required="false"/>	
											<button id="overrideAmtAlertInfo" type="button" class="btn fms_btn_icon btn-sm overrideAmtAlertInfo" title="Click to reset plan form." data-target="#OverrideAmtAlertModal"><span class="glyphicon glyphicon-repeat"></span></button>
										<div class="fms_form_error" id="overrideAmount_error"></div>
								</div>	
						</div>						
					</div>
				</fieldset>
			</div>
			<%--IV widget End --%>

					<div class="fms_form_button">
						<g:actionSubmit class="btn btn-primary" action="saveContract" value="${message(code: 'default.button.create.label', default: 'Create')}" />
						<input class="btn btn-default" name="Reset" type="reset">
						<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>						
					</div>
		</g:form>
	</div>
</div>
</div>
</div>	

<!-- START - Search Group ID Modal -->
<div class="modal fade" id="SearchAlertModalInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter Group Id.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
<!-- END - Delete Notice Modal -->	

<!-- START - Search Valid Group ID Modal -->
<div class="modal fade" id="SearchAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter a valid Group Id.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
<!-- END - Delete Notice Modal -->			

<!-- START - Override amount validation -->
	<div class="modal fade" id="OverrideAmtAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter numbers and decimal only for Rate Amount.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
      
 </html>     