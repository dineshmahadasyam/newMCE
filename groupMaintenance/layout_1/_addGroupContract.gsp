<%@ page import="com.perotsystems.diamond.bom.GroupEx"%>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<!DOCTYPE html>
<html>
<head>
<g:set var="isShowCalendarIcon" value="${PageNameEnum.GROUP_CONTRACT.equals(currentPage)?true:false}" />
<meta name="layout" content="main">
<g:set var="entityName" value="${message(code: 'groupMaster.label', default: 'GroupMaster')}" />
<g:set var="appContext" bean="grailsApplication"/>

<title><g:message code="default.list.label" args="[entityName]" /></title>

<meta name="navSelector" content="maint" />
<meta name="navChildSelector" content="groupMaintenance" />

<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<script>
$(function(){

    $(".amtNumeric").numeric({});
	
})
</script>
<script type="text/javascript">
$(document).ready(function(){

	$.validator.addMethod("alphanumeric", function(value, element) {
		return this.optional(element) || /^[a-zA-Z0-9_ ]+$/i.test(value);
	}, "Please enter only Letters, numbers or underscores only.");
	
	jQuery.validator.setDefaults({
		ignore: ":hidden",
		debug: true			 
	}); 	
	
	$(function() {		
		$("#editForm").validate({
			onfocusout: false,
			submitHandler: function (form) {
				  if ($(form).valid()) 
                      form.submit(); 
                  return false; // prevent normal form posting
	        },
	      //jQuery validate selects the first invalid element or the last focused invalid element
	        //The code below will set focus to first element that fails
	        invalidHandler: function(form, validator) {
	            var errors = validator.numberOfInvalids();
	            if (errors) {      
		            //Hide any previous message from the server when the client validation is occuring
	            	$(".message").hide();              
	                validator.errorList[0].element.focus();
	            }
	        },
	        
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",		

			 rules : {
					'contract.0.effectiveDate' :  {
						required : true
					},
					
					'contract.0.termReason' :  {
						required : function(element){														
							return $.trim($("#contract\\.0\\.termDate_year").val()).length > 0;						
						}
					},
					'contract.0.termDate' :  {
						required : function(element){														
							return $.trim($("#contract\\.0\\.termReason").val()).length > 0 	;						
						}
					},

					'contract.0.claimActionCode' :  {
						required : function(element){														
							return $.trim($("#contract\\.0\\.claimGraceDays").val()).length > 0  ;						
						}
					},
					'contract.0.claimReason' :  {
						required : function(element){														
							return $.trim($("#contract\\.0\\.claimGraceDays").val()).length > 0 &&  
							$.trim($("#contract\\.0\\.claimActionCode").val()).length > 0 ;						
						}
					},
					'contract.0.newbornOthContRsn' : {
						alphanumeric : true	
					},
					'contract.0.newbornProcRsn' : {
						alphanumeric : true
					},
					'contract.0.salespersonName' : {
						alphanumeric : true
					},
					'contract.0.termReason' : {
						alphanumeric : true
					}					
				},
				messages : {
					'contract.0.effectiveDate' :  {
						required : "Effective Date is a mandatory field, please input the value for Effective date"						
					},			
					'contract.0.termDate' :  {
						required : "Term Date is a mandatory field if Term reason is entered, please input the value for Term Date "
					},
					'contract.0.claimActionCode' :  {
						required : "claimActionCode is a mandatory field if claimGraceDays is entered, please input the value for claimActionCode"
					},
					'contract.0.claimReason' :  {
						required : "claimReason is a mandatory field if claimGraceDays and claimActionCode is entered, please input the value for claimReason"
					}
							
				} 
				
			})
		});
});

</script>
<script type="text/javascript">
$(function($){
	   $("#termReason").alphanum({
		    allow 		: '-_',
		    allowSpace  : false
		});
	   
	   $("#salespersonName").alphanum({
		    allow 		: '-_',
		    allowSpace  : false
		});
	   
	   $("#newbornProcRsn").alphanum({
		    allow 		: '-_',
		    allowSpace  : false
		});

	   $("#newbornOthContRsn").alphanum({
		    allow 		: '-_',
		    allowSpace  : false
		});
	})
	
</script>	 
<script type="text/javascript">

	function closeForm() {
		var groupDBId = "${params.groupDBId}";
		var groupId = "${groupMasterInstance.groupId}";
		var appName = "${appContext.metadata['app.name']}";
			window.location.assign("/"+appName+"/groupMaintenance/edit/" + groupId +
					"?groupId=" + groupId + "&groupDBId=" + groupDBId + "&groupEditType=CONTRACT");
		}

		var grpInnerWindow 
			var innerWindowClosed = true;
			function closeAllIFrames() {
				if(grpInnerWindow) {
					grpInnerWindow.close()
				}
			}
			
			function lookup(idName, cdoClassName, cdoClassAttributeName, assocFieldIds, assocFieldCdoName, updateFields, updateFieldsCdoName) {
				var htmlElementValue 
				var assocHTMLElementsValue= ""
				htmlElementValue = document.getElementById(idName).value
				//alert (assocFieldIds)
				if (assocFieldIds) {
					if(assocFieldIds.indexOf('|') == -1){			
						if (document.getElementById(assocFieldIds) && document.getElementById(assocFieldIds).value != "undefined") {
							assocHTMLElementsValue = document.getElementById(assocFieldIds).value
						}
					} else {
						var nameArray = assocFieldIds.split("|")
						for (var i =0;i<nameArray.length;i++) {			
							if (document.getElementById(nameArray[i]) && document.getElementById(nameArray[i]).value != "undefined") {
						//		alert (document.getElementById(nameArray[i]).value)
								assocHTMLElementsValue += document.getElementById(nameArray[i]).value+"|"
							}
						}
					}
				}
				//alert("assocHTMLElementsValue = "+assocHTMLElementsValue )
				var appName = "${appContext.metadata['app.name']}";
				var urlValue = "/"+appName+"/lookUp/lookUp?htmlElementIdName=" + idName
						+ "&htmlElementValue="+ htmlElementValue 
						+ "&cdoClassName="+ cdoClassName 
						+ "&cdoClassAttributeName="+ cdoClassAttributeName 
						+ (assocFieldIds?"&assocFields="+assocFieldIds :"")			
						+ (assocFieldCdoName?"&assocFieldCdoName="+assocFieldCdoName :"")
						+ (assocHTMLElementsValue? "&assocFieldValue="+ assocHTMLElementsValue : "") 
						+ (updateFieldsCdoName?  "&updateFieldsCdoName=" + updateFieldsCdoName : "")
						+ (updateFields? "&updateFields="+updateFields : "")
						+ "&offset=0"
				if (!innerWindowClosed) {
					grpInnerWindow.setUrl(urlValue)
				} else {
					innerWindowClosed = false;
					grpInnerWindow = $.window({
						showModal : true,
						title : "Lookup",
						bookmarkable : false,
						minimizable : false,
						maximizable : false,
						width : 900,
						height : 350,
						scrollable: false,
						url : urlValue, 
					 onClose: function(wnd) { // a callback function while user click close button
						 innerWindowClosed = true;
					  }
					});
				}
			}

			function isNumberKey(evt) {
				var charCode = (evt.which) ? evt.which : event.keyCode
				         if ((charCode > 47 && charCode < 58) || (charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123))
				            return true;

				         return false;
					}
			
</script>

</head>

<div id="fms_content">
	<div id="fms_content_header">
		<div class="fms_content_header_note">
		 		<a href="${createLink(uri: '/groupMaintenance/list')}">Group Maintenance</a> / 
	      		<g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Group Contract</g:link>
	      			/ Add Contract to Group with GroupId - ${groupMasterInstance?.groupId}
	  		</div>
		  	<div class="fms_content_title">
	          	<h1>Add New Contract</h1>
	        </div>
		</div> 
		<%-- START - Tabs --%>
			<div id="fms_content_tabs">
				<ul>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'MASTER']}">Master Records</g:link></li>
				 	<li><g:link class="active" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTRACT']}">Contracts</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'ADDRESS']}">Addresses</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'CONTACT']}">Contacts</g:link></li>
					<li><g:link class="list" action="edit" params="${[groupId: request.getParameter('groupId'), groupDBId : request.getParameter("groupDBId"), groupEditType :'COMMRATES']}">Group Rates</g:link></li>
				</ul>
			<div id="mobile_tabs_select"></div>
		</div>
		<%-- END - Tabs --%>

	<div id="fms_content_body">
	<div class="right-corner" align="right">GRUPC</div>
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
	<div id="show-memberMaster" class="content scaffold-show" role="main">
					&nbsp;
	<g:form action="saveContract" id="editForm" name="editForm">
			<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
			<g:hiddenField name="id" value="${groupMasterInstance?.groupId}" />
			<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
			<g:hiddenField name="groupDBId"	value="${groupMasterInstance?.groupDBId}" />

			<!-- START - WIDGET: General Information -->
			<div id="widgetGeneral" class="fms_widget">
				<fieldset class="no_border">
					<legend>
						<h2>Add New Contract</h2>
					</legend>
					<div class="fms_form_layout_2column">
						
						<div class="fms_form_column fms_long_labels">
									<label for="effectiveDate"  class="control-label fms_required"> 
											<g:message code="groupMaster.effectiveDate.label"	default="Effective Date:" />
									</label>
									<div class="fms_form_input">
										   <fmsui:jqDatePickerUIUX  datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
										  						 dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.effectiveDate)}"
										  						 dateElementId="contract.0.effectiveDate" dateElementName="contract.0.effectiveDate" 
				                                           ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='DOB_error' aria-required='false'" 
				                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                                           showIconDefault="${isShowCalendarIcon}"/>
												<div class="fms_form_error" id="effectiveDate_r2_error"></div>
									</div>

									<label for="termDate" class="control-label"> 
										<g:message	code="groupMaster.termDate.label" default="Term Date:" /></label>
									<div class="fms_form_input">
										<fmsui:jqDatePickerUIUX  datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
														dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.termDate)}"
														dateElementId="contract.0.termDate" dateElementName="contract.0.termDate" 
			                                           ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
			                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
			                                           showIconDefault="${isShowCalendarIcon}"/>
											<div class="fms_form_error" id="termDate_r2_error"></div>
									</div>

									<label for="openEnrollStart" class="control-label"> 
										<g:message	code="groupMaster.openEnrollStart.label" default="Open Enroll Start:" />
										</label>
									<div class="fms_form_input">
										<fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
														dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.openEnrollStart)}"
														dateElementId="openEnrollStart" dateElementName="openEnrollStart" 
			                                           ariaAttributes="aria-labelledby='openEnrollStart_label' aria-describedby='openEnrollStart_error' aria-required='false'" 
			                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
			                                           showIconDefault="${isShowCalendarIcon}"/>
											<div class="fms_form_error" id="openEnrollStart_r2_error"></div>
									</div>

									<label for="numberOfEmployees" class="control-label"> 
										<g:message	code="groupMaster.numberOfEmployees.label"	default="No. of Employees:" />
									</label>
									<div class="fms_form_input">
											<g:textField name="contract.0.numberOfEmployees" value="${contract?.numberOfEmployees}" class="form-control amtNumeric" maxlength="6"/>
											<div class="fms_form_error" id="numberOfEmployees_r2_error"></div>
									</div>

									<label for="contractType"  class="control-label"> 
										<g:message	code="groupMaster.contractType.label" default="Contract Type: " /></label>
									<div class="fms_form_input">
											<g:textField name="contract.0.contractType"	value="${contract?.contractType}" maxlength="1" class="form-control"
														onkeypress="return isNumberKey(event)"/>
											<div class="fms_form_error" id="contractType_r2_error"></div>
									</div>

									<label for="salespersonName" class="control-label">
										 <g:message	code="groupMaster.salespersonName.label" default="Sales Rep.:" />
										</label>
									<div class="fms_form_input">
											<g:textField name="contract.0.salespersonName" value="${contract?.salespersonName}" class="form-control" maxlength="30"/>
										<div class="fms_form_error" id="salespersonName_r2_error"></div>
									</div>
								</div>

						<div class="fms_form_column fms_long_labels">

										<label for="contract.0.termReason" class="control-label"> 
											<g:message	code="groupMaster.termReason.label" default="Term Reason:" /></label>

										<div class="fms_form_input fms_has_feedback">
												<input type="hidden" name="TermReasonType"	id="TermReasonType" value="TM" />
												<g:textField name="contract.0.termReason" value="${contract?.termReason}" class="form-control" maxlength="5"/>
												<fmsui:cdoLookup lookupElementId="contract.0.termReason"
                                                                 lookupElementName="contract.0.termReason" lookupElementValue="${contract?.termReason}"
                                                                 lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
                                                                 lookupCDOClassAttribute="reasonCode" 
																 htmlElementsToAddToQuery="TermReasonType"
																 htmlElementsToAddToQueryCDOProperty="reasonCodeType" />
													<div class="fms_form_error" id="termReason_r2_error"></div>
										</div>

										<label for="openEnrollEnd" class="control-label"> 
											<g:message	code="groupMaster.openEnrollEnd.label" default="Open Enroll End:" />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
														dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.openEnrollEnd)}"
														dateElementId="openEnrollEnd" dateElementName="openEnrollEnd" 
			                                           ariaAttributes="aria-labelledby='openEnrollEnd_label' aria-describedby='openEnrollEnd_error' aria-required='false'" 
			                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
			                                           showIconDefault="${isShowCalendarIcon}"/>
												<div class="fms_form_error" id="effectiveDate_r2_error"></div>
										</div>

										<label for="waitingPeriod" class="control-label"> 
											<g:message	code="groupMaster.waitingPeriod.label" default="Waiting period: " /></label>
										<div class="fms_form_input">
												<g:textField name="contract.0.waitingPeriod" value="${contract?.waitingPeriod}" class="form-control"/>
												<div class="fms_form_error" id="waitingPeriod_r2_error"></div>
										</div>

										<label for="recordStatus" class="control-label"> 
												<g:message	code="groupMaster.recordStatus.label" default="Record Status:" /></label>
										<div class="fms_form_input">
												<g:textField name="contract.0.recordStatus"	value="${contract?.recordStatus}" class="form-control"/>
												<div class="fms_form_error" id="recordStatus_r2_error"></div>
										</div>

										<label for="brokerName" class="control-label"> 
											<g:message code="groupMaster.brokerName.label" default="Broker:" /></label>
										<div class="fms_form_input">
												<g:textField name="contract.0.brokerName" value="${contract?.brokerName}" class="form-control"/>
												<div class="fms_form_error" id="brokerName_r2_error"></div>
										</div>
									</div>
								</div>
						</fieldset>
					</div>
					<%--II widget start --%>

					<div id="widgetGeneral" class="fms_widget">
						<fieldset class="no_border">
							<legend>
								<h2>On Enrolled New Born Processing</h2>
							</legend>
							<div class="fms_form_layout_2column">								
								<div class="fms_form_column fms_long_labels">

									<label for="newbornAgeDays" class="control-label"> 
										<g:message	code="groupMaster.newbornAgeDays.label" default="NB Age in Days:" />
										</label>
									<div class="fms_form_input">
											<g:textField name="contract.0.newbornAgeDays" value="${contract?.newbornAgeDays}" class="form-control amtNumeric" maxlength="3"/>
										<div class="fms_form_error" id="newbornAgeDays_r2_error"></div>
									</div>

									<label for="newbornAutoAdd" class="control-label"> 
										<g:message	code="groupMaster.newbornAutoAdd.label"	default="NewBorn Auto Add:" />
									</label>
									<div class="fms_form_input">
										<g:secureComboBox id="contract.0.newbornAutoAdd" name="contract.0.newbornAutoAdd"
	                                 				 tableName="GROUP_CONTRACT" attributeName="newbornAutoAdd" class="form-control"
	                                 		 		value="${contract?.newbornAutoAdd}" from="${['' : '-- Select Newborn Auto Add --', 'Y': 'Yes' , 'N': 'No']}" optionValue="value" optionKey="key">
                                   		</g:secureComboBox>
										<div class="fms_form_error" id="newbornAutoAdd_r2_error"></div>
									</div>
								</div>
								<div class="fms_form_column fms_long_labels">
								
									<label for="newbornProcRsn" class="control-label"> 
										<g:message code="groupMaster.newbornProcRsn.label" default="New Born Proc Reason:" />
								    </label>
									<div class="fms_form_input fms_has_feedback">
											<g:textField  name="contract.0.newbornProcRsn" value="${contract?.newbornProcRsn}" class="form-control"/>											
										<div class="fms_form_error" id="newbornProcRsn_r2_error"></div>
									</div>

									<label for="newbornOthContRsn" class="control-label"> 
										<g:message code="groupMaster.newbornOthContRsn.label" default="Other Contract Reason:" />
									</label>
									<div class="fms_form_input fms_has_feedback">
											<g:textField name="contract.0.newbornOthContRsn" value="${contract?.newbornOthContRsn}" class="form-control"/>											
											<div class="fms_form_error" id="newbornOthContRsn_r2_error"></div>
									</div>
								</div>
								</div>
						</fieldset>
					</div>
					<%--II widget end --%>

					<div id="widgetGeneral" class="fms_widget">
						<fieldset class="no_border">
							<legend>
								<h2>Claim Dependent/Student Age Information</h2>
							</legend>
							<div class="fms_form_layout_2column fms_long_labels">
								<div class="fms_form_column fms_long_labels">

									<label for="depConvOption" class="control-label">
										 <g:message	code="premiumMaster.depConvOption.label" default="Depnt Conversion Option:" />
									</label>
									<div class="fms_form_input">
										<g:getSystemCodeToken systemCodeType="STDEPCNVOPT" cssClass="form-control"
													languageId="0" htmlElelmentId="contract.0.depConvOption"
													blankValue="Depnt Conv Option"	defaultValue="${contract?.depConvOption}" />
										<div class="fms_form_error" id="depConvOption_r2_error"></div>
									</div>
									
									<label for="stuAgeLimitAction" class="control-label"> 
										<g:message	code="premiumMaster.stuAgeLimitAction.label" default="Stdnt Age Limit Action:" />
									</label>
									<div class="fms_form_input">
										<g:getDiamondDataWindowDetail columnName="stu_age_limit_action" dwName="dw_grupd_de"
											languageId="0" htmlElelmentId="contract.0.stuAgeLimitAction" defaultValue="${contract?.stuAgeLimitAction}"
											blankValue="Stdnt Age Limit Action" cssClass="form-control"/>
										<div class="fms_form_error" id="stuAgeLimitAction_r2_error"></div>
									</div>

									<label for="stuConvAction" class="control-label">
										 <g:message	code="premiumMaster.stuConvAction.label" default="Stdnt Conversion Action:" />
									</label>
									<div class="fms_form_input">
										<g:getSystemCodeToken systemCodeType="STDEPCNVACT" cssClass="form-control"
													languageId="0" htmlElelmentId="contract.0.stuConvAction"
													blankValue="Stdnt Conv Action" defaultValue="${contract?.stuConvAction}" />
												<div class="fms_form_error" id="stuConvAction_r2_error"></div>
									</div>																
								</div>
								
								<div class="fms_form_column fms_long_labels">

										<label for="depConvAction" class="control-label"> 
										   <g:message	code="premiumMaster.depConvAction.label" default="Depnt Conversion Action:" /></label>
										<div class="fms_form_input">
											<g:getSystemCodeToken systemCodeType="STDEPCNVACT" cssClass="form-control"
														languageId="0" htmlElelmentId="contract.0.depConvAction"
														blankValue="Depnt Conv Action" defaultValue="${contract?.depConvAction}" />
												<div class="fms_form_error" id="depConvAction_r2_error"></div>
										</div>
										
										<label for="stuConvOption" class="control-label"> 
											<g:message code="premiumMaster.stuConvOption.label" default="Stdnt Conversion Option:" />
										</label>
										<div class="fms_form_input">
												<g:getSystemCodeToken systemCodeType="STDEPCNVOPT" cssClass="form-control"
														languageId="0" htmlElelmentId="contract.0.stuConvOption"
														blankValue="Stdnt Conv Option"	defaultValue="${contract?.stuConvOption}" />
											<div class="fms_form_error" id="stuConvOption_r2_error"></div>
										</div>										
									</div>
								</div>
						</fieldset>
					</div>
					<%--III widget end  --%>

					<div id="widgetGeneral" class="fms_widget">
						<fieldset class="no_border">
							<legend>
								<h2>User Defined Fields</h2>
							</legend>
							<div class="fms_form_layout_2column">
								<div class="fms_form_column fms_long_labels">

									<label id="userDefined1" class="control-label"> 
										<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_1_t" defaultText="User Defined 1"   />
									</label>
									<div class="fms_form_input">
											<g:textField name="contract.0.userDefined1"	value="${contract?.userDefined1}" class="form-control"/>
											<div class="fms_form_error" id="userDefined1_r2_error"></div>
									</div>

									<label id="userDefined2" class="control-label "> 
										<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_2_t" defaultText="User Defined 2"   /> 
									</label>
									<div class="fms_form_input">
										<g:textField name="contract.0.userDefined2"	value="${contract?.userDefined2}" class="form-control"/>
										<div class="fms_form_error" id="userDefined2_r2_error"></div>
									</div>

									<label id="userDefined3" class="control-label">
										<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_3_t" defaultText="User Defined 3"   />
									</label>
									<div class="fms_form_input">
										<g:textField name="contract.0.userDefined3"	value="${contract?.userDefined3}" class="form-control"/>
										<div class="fms_form_error" id="userDefined3_r2_error"></div>
									</div>

									<label id="userDefined4" class="control-label">
										<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_4_t" defaultText="User Defined 4"   />
									</label>
									<div class="fms_form_input">
										<g:textField name="contract.0.userDefined4"	value="${contract?.userDefined4}" class="form-control"/>
										<div class="fms_form_error" id="userDefined4_r2_error"></div>
									</div>

									<label id="userDefined5" class="control-label"> 
										<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_5_t" defaultText="User Defined 5"   />
									</label>
									<div class="fms_form_input">
										    	 <g:textField name="contract.0.userDefined5" value="${contract?.userDefined5}" class="form-control"/>
											<div class="fms_form_error" id="userDefined5_r2_error"></div>
									</div>

									<label id="userDefined6" class="control-label"> 
										<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_6_t" defaultText="User Defined 6"   /> 
									</label>
									<div class="fms_form_input">
											<g:textField name="contract.0.userDefined6"	value="${contract?.userDefined6}" class="form-control"/>
										<div class="fms_form_error" id="userDefined6_r2_error"></div>
									</div>

									<label id="userDefined7" class="control-label "> 
										<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_7_t" defaultText="User Defined 7"   />
									</label>
									<div class="fms_form_input">
										<g:textField name="contract.0.userDefined7"	value="${contract?.userDefined7}" class="form-control"/>
										<div class="fms_form_error" id="userDefined7_r2_error"></div>
									</div>

									<label id="userDefined8" class="control-label"> 
										<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_8_t" defaultText="User Defined 8"   /> 
									</label>
									<div class="fms_form_input">
											<g:textField name="contract.0.userDefined8"	value="${contract?.userDefined8}" class="form-control"/>
										<div class="fms_form_error" id="userDefined8_r2_error"></div>
									</div>

									<label id="userDefined10" class="control-label "> 
										<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_10_t" defaultText="User Defined 10"   />
									</label>
									<div class="fms_form_input">
										<g:textField name="contract.0.userDefined10" value="${contract?.userDefined10}" class="form-control"/>
										<div class="fms_form_error" id="userDefined10_r2_error"></div>
									</div>
								</div>

								<div class="fms_form_column fms_long_labels">

										<label id="userDate1" class="control-label"> 
											<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_1_t" defaultText="User Date 1"   />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
										  					dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate1)}"
										  					dateElementId="contract.0.userDate1" dateElementName="contract.0.userDate1" 
				                                           ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='DOB_error' aria-required='false'" 
				                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                                           showIconDefault="${isShowCalendarIcon}"/>
												<div class="fms_form_error" id="userDate1_r2_error"></div>
										</div>

										<label id="userDate2" class="control-label "> 
											<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_2_t" defaultText="User Date 2"   />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
										  					dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate2)}" dateElementId="contract.0.userDate2" dateElementName="contract.0.userDate2" 
				                                           ariaAttributes="aria-labelledby='userDate2_label' aria-describedby='userDate2_error' aria-required='false'" 
				                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                                           showIconDefault="${isShowCalendarIcon}"/>
												<div class="fms_form_error" id="userDate2_r2_error"></div>
										</div>

										<label id="userDate3" class="control-label"> 
											<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_3_t" defaultText="User Date 3"   />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
										  					dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate3)}"  dateElementId="contract.0.userDate3" dateElementName="contract.0.userDate3" 
				                                           ariaAttributes="aria-labelledby='userDate3_label' aria-describedby='userDate3_error' aria-required='false'" 
				                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                                           showIconDefault="${isShowCalendarIcon}"/>
												<div class="fms_form_error" id="userDate3_r2_error"></div>
										</div>

										<label id="userDate4" class="control-label">
											<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_4_t" defaultText="User Date 4"   />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
										  					dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate4)}" dateElementId="contract.0.userDate4" dateElementName="contract.0.userDate4" 
				                                           ariaAttributes="aria-labelledby='userDate4_label' aria-describedby='userDate4_error' aria-required='false'" 
				                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                                           showIconDefault="${isShowCalendarIcon}"/>
											<div class="fms_form_error" id="userDate4_r2_error"></div>
										</div>

										<label id="userDate5" class="control-label "> 
											<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_5_t" defaultText="User Date 5"   />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
										  					dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate5)}" dateElementId="contract.0.userDate5" dateElementName="contract.0.userDate5" 
				                                           ariaAttributes="aria-labelledby='userDate5_label' aria-describedby='userDate5_error' aria-required='false'" 
				                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                                           showIconDefault="${isShowCalendarIcon}"/>
											<div class="fms_form_error" id="userDate5_r2_error"></div>
										</div>

										<label id="userDate6" class="control-label"> 
											<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_6_t" defaultText="User Date 6"   />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
										  					dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate6)}"  dateElementId="contract.0.userDate6" dateElementName="contract.0.userDate6" 
				                                           ariaAttributes="aria-labelledby='userDate6_label' aria-describedby='userDate6_error' aria-required='false'" 
				                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                                           showIconDefault="${isShowCalendarIcon}"/>
											<div class="fms_form_error" id="userDate6_r2_error"></div>
										</div>

										<label id="userDate7" class="control-label">
											 <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_7_t" defaultText="User Date 7"   />
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
										  					dateElementValue="${formatDate(format:'MM/dd/yyyy',date: contract?.userDate7)}"  dateElementId="contract.0.userDate7" dateElementName="contract.0.userDate7" 
				                                           ariaAttributes="aria-labelledby='userDate7_label' aria-describedby='userDate7_error' aria-required='false'" 
				                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
				                                           showIconDefault="${isShowCalendarIcon}"/>
												<div class="fms_form_error" id="userDate7_r2_error"></div>
										</div>

										<label id="userDefined9" class="control-label "> 
											<g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_9_t" defaultText="User Defined 9"   /> 
										</label>
										<div class="fms_form_input">
											<g:textField name="contract.0.userDefined9" value="${contract?.userDefined9}" class="form-control"/>
											<div class="fms_form_error" id="userDefined9_r2_error"></div>
										</div>
									</div>
								</div>
						</fieldset>
					</div>

					<%--IV widget End --%>

					<div class="fms_form_button">
						<g:actionSubmit class="btn btn-primary" action="saveContract" value="${message(code: 'default.button.save.label', default: 'Save')}" />
						<input class="btn btn-default" name="Reset" type="reset">
						<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>						
					</div>

				</g:form>
			</div>
		</div>
	</div>
</div>

</html>