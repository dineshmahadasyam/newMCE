<%@ page import="com.perotsystems.diamond.bom.GroupEx"%>
<%@ page import="com.perotsystems.diamond.bom.GroupType"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.States"%>
<%@ page import="com.perotsystems.diamond.bom.Country"%>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<g:javascript>
	var parentGroupIdNew=""
	function setParentLevelHidden()
	{
	var levelCode = document.getElementById('levelCode').value.trim()
	var parentGroupId=document.getElementById('parentGroupId').value.trim()	
	if(levelCode!=null){	
		if(levelCode.trim() == 3){		
		 document.getElementById('parentGroupId').disabled = true
		 document.getElementById('parentGroupId').value=""		 		 
					}else{					
							 
							if(parentGroupIdNew.trim() == ""){											
											document.getElementById('parentGroupId').value=parentGroupId
											parentGroupIdNew=parentGroupId
																	}				
							document.getElementById('parentGroupId').disabled = false
							document.getElementById('parentGroupId').value=parentGroupIdNew
						}
	}
	
		if($("#levelCode").val() != 'NaN' )
		{		
			var groupLevel = parseFloat($("#levelCode").val()) + 1;
			//display appropriate parent level code 
			$("#parentLevelHidden").val(groupLevel);
		}
		
	}	
	
	
	$(document).ready(function(){

		//list all functions after document is loaded.
		
		//initialize the parentLevelHidden for lookup
		setParentLevelHidden();
	
	$( "#holdDate_year" ).rules( "add", {  required: function(element){								
											return $.trim($("#holdReason").val()).length >0;						
												},								
							messages: {  required: "Hold Reason Year is required if hold reason is entered."    
										}}); 
	
	
	$( "#holdDate_month" ).rules( "add", {  required: function(element){								
											return $.trim($("#holdReason").val()).length >0;						
												},								
							messages: {  required: "Hold Reason Month is required if hold reason is entered."    
										}}); 
										
										
	$( "#holdDate_day" ).rules( "add", {  required: function(element){								
											return $.trim($("#holdReason").val()).length >0;						
												},								
							messages: {  required: "Hold Reason Day is required if hold reason is entered."    
										}}); 
			
		
	//end document ready
	
	});	
</g:javascript>
<script type="text/javascript">
function changeGroupIdMessage(){
	alert ("Changing Group ID is not allowed.");
}

$(function($){
	   $("#holdReason").alphanum({
		    allow 		: '-_',
		    allowSpace  : false
		});

	   $("#accountType").alphanum({
		    allow 		: '-_',
		    allowSpace  : false
		});
	})
</script>
<style type="text/css">
	#editFields label{
		width:160px;
		text-align:right;    	
	}
	#editFields input{
		width:140px;
		text-align:left;
	}
	#editFields formatDate{
		width:200px;
		text-align:left;
	}
	#editFields checkBox{
		width:10px;
		text-align:left;
 	}
 	.fieldcontain span {
	color: #0066CC;
	}
	.disabledInput {
    color: black;
		}	
</style>

<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />
<table id="editFields">
	<tr>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'groupId', 'error')} required ">
				<label for="groupId"> <g:message
						code="groupMaster.groupId.label" default="Group Id :" /> <span
					class="required-indicator">*</span>
				</label>
				<g:if test="${ request.getParameter("groupId")}">
					<g:secureTextField name="cgpid" style="background-color:#CCC" readOnly="true" tableName="GROUP_MASTER" attributeName="groupId" value="${ request.getParameter("groupId")}" onClick="changeGroupIdMessage()"></g:secureTextField>
					<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />					
				</g:if>
				<g:else>
					<g:secureTextField name="groupId" 
					tableName="GROUP_MASTER" attributeName="groupId"
					value=""></g:secureTextField>
				</g:else>				
			</div>
		</td>
	</tr>
	<tr>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'levelCode', 'error')} required">
				<label for="groupLevel"> <g:message
						code="groupMaster.groupLevel.label" default="Group Level :" /> <span
					class="required-indicator">*</span>
				</label> 
				<g:secureComboBox id="levelCode" name="levelCode" style="width: 150px" 
				                                  tableName="GROUP_MASTER" attributeName="levelCode"
				                                  value="${groupMasterInstance?.levelCode?.toString()}"
				                                  from="${['' : '-- Select Level Code --', '1': 'Group' , '2': 'Super Group' , '3': 'Administrator Group']}" optionValue="value" optionKey="key">
				</g:secureComboBox>

			</div>
		</td>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'seqParentId', 'error')} ">
				<label for="parent"> <g:message
						code="groupMaster.parent.label" default="Parent :" />

				</label> <input type="hidden" id="parentLevelHidden" value="2" />
				<input type="hidden" name="seqParentId"  id="seqParentId" value="${groupMasterInstance?.seqParentId}"  />
				<g:secureTextField name="parentGroupId"
				tableName="GROUP_MASTER" attributeName="seqParentId"
					value="${groupMasterInstance?.parentGroupId != 0 ? groupMasterInstance?.parentGroupId : ""}"></g:secureTextField>

				<img width="25" height="25" 				
					style="float: none; vertical-align: bottom" class="magnifying"
					src="${resource(dir: 'images', file: 'Search-icon.png')}"
					onclick="lookup('parentGroupId', 'com.perotsystems.diamond.dao.cdo.GroupMaster','groupId','parentLevelHidden','levelCode'
					,'seqParentId', 'seqGroupId')" />

			</div>
		</td>

		<td style="white-space:nowrap">

			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'nationalEmployerId', 'error')}  ">
				<label for="nationalEmployerId"> <g:message
						code="groupMaster.nationalEmployerId.label"
						default="Natl Employer Id :" />

				</label>

				<g:secureTextField name="nationalEmployerId"
				tableName="GROUP_MASTER" attributeName="nationalEmployerId"
					value="${groupMasterInstance?.nationalEmployerId}" maxlength="9"></g:secureTextField>
			</div>
		</td>
	</tr>


	<tr>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'taxId', 'error')} ">
				<label for="federalTaxId"> <g:message
						code="groupMaster.federalTaxId.label" default="Federal Tax Id :" />

				</label>
				<g:secureTextField name="taxId" class = "taxId" 
				tableName="GROUP_MASTER" attributeName="taxId"
				value="${groupMasterInstance?.taxId}" maxlength="10"></g:secureTextField>
			</div>
		</td>
	</tr>

	<tr>
		<td colspan="3" style="white-space:nowrap">
			<h4>
				Group Information
				<h4>
					<hr>
		</td>
	</tr>
	<tr>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'shortName', 'error')} required">
				<label for="shortName"> <g:message
						code="groupMaster.shortName.label" default="Short Name :" /> <span
					class="required-indicator">*</span>
				</label>
				<g:secureTextField name="shortName"
				tableName="GROUP_MASTER" attributeName="shortName"
				value="${groupMasterInstance?.shortName}" maxlength="15"></g:secureTextField>
			</div>
		</td>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'name1', 'error')} ">
				<label for="name1"> <g:message
						code="groupMaster.name1.label" default="Name1 :" />

				</label>
				<g:secureTextField name="name1" 
				tableName="GROUP_MASTER" attributeName="groupName1"
				value="${groupMasterInstance?.name1}" maxlength="40"></g:secureTextField>
			</div>
		</td>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'name2', 'error')} ">
				<label for="name2"> <g:message
						code="groupMaster.name2.label" default="Name2 :" />

				</label>
				<g:secureTextField name="name2" 
				tableName="GROUP_MASTER" attributeName="groupName2"
				value="${groupMasterInstance?.name2}" maxlength="40"></g:secureTextField>
			</div>
		</td>
	</tr>
	<tr>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'holdReason', 'error')} ">
				<label for="holdReason"> <g:message
						code="premiumMaster.effectiveDate.label" default="Hold Reason :" />
				</label>
				<g:secureTextField name="holdReason" maxlength="5"
						tableName="GROUP_MASTER" attributeName="holdReason"
						value="${groupMasterInstance?.holdReason}"></g:secureTextField>			
			<input type="hidden" id="reasonCodeTypeHidden" value="HD" />
        <img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}" 
        onclick="lookup('holdReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode','reasonCodeTypeHidden','reasonCodeType')" />
			</div>
		</td>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'holdDate', 'error')} ">
				<label for="holdDate"> <g:message
						code="groupMasterInstance?.holdDate.label" default="Hold Date :" />
				</label>
				<g:secureGrailsDatePicker 
					name="holdDate" 
					tableName="GROUP_MASTER" attributeName="holdDate" precision="day" noSelection="['':'']"
					value="${groupMasterInstance?.holdDate}" default="none"></g:secureGrailsDatePicker>
			</div>
		</td>
	</tr>
	<tr>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'accountType', 'error')} ">
				<label for="accountType"> <g:message
						code="groupMaster.accountType.label" default="Account Type :" />
				</label>
				<g:secureTextField name="accountType" maxlength="2"
					tableName="GROUP_MASTER" attributeName="accountType"
					value="${groupMasterInstance?.accountType}"></g:secureTextField>
					
  					 <input type="hidden" id="systemCodeTypeHidden" value="GROUPACCTT"/>
					<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
					 onclick="lookup('accountType','com.perotsystems.diamond.dao.cdo.SystemCodes','systemCode','systemCodeTypeHidden','systemCodeType')" />
			
			</div>
		</td>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'groupType', 'error')} ">
				<label for="groupType"> <g:message
						code="groupMaster.groupType.label" default="Group Type :" /> <span
					class="required-indicator">*</span>
				</label> 
				<g:secureComboBox id="groupType" name="groupType" style="width: 150px"
					tableName="GROUP_MASTER" attributeName="groupType" value="${groupMasterInstance?.groupType}"
					from="${['' : '-- Select Group Type --', '1': 'Commercial' , '2': 'Individual' , '3': 'Combined', '4': 'Medicaid', '5': 'Medicare']}" optionValue="value" optionKey="key">
				</g:secureComboBox>


			</div>
		</td>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'asoIndicator', 'error')} ">
				<label for="asoIndicator"> <g:message
						code="groupMaster.asoIndicator.label" default="Aso Indicator :" />

				</label>
				<g:secureComboBox name="asoIndicator" style="width: 150px"
					tableName="GROUP_MASTER" attributeName="asoIndicator" value="${groupMasterInstance?.asoIndicator}"
					from="${['' : '', '1': 'Yes' , '2': 'No']}" optionValue="value" optionKey="key">
				</g:secureComboBox>
						
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3">
			<h4>
				Group Primary Address
				<h4>
					</h3>
					<hr>
		</td>
	</tr>
	<tr>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance?.address, field: 'address1', 'error')} ">
				<label for="address1"> <g:message
						code="groupMaster.address1.label" default="Address1 :" />

				</label>
				<g:secureTextField name="address.primary.1.address1"
					value="${groupMasterInstance?.address?.address1}"
					tableName="GROUP_MASTER" attributeName="addressLine1"
					disabled="disabled"  class="disabledInput"></g:secureTextField>
			</div>
		</td>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance?.address, field: 'address2', 'error')} ">
				<label for="address2"> <g:message
						code="groupMaster.address2.label" default="Address2 :" />

				</label>
				<g:secureTextField name="address.primary.1.address2"
					tableName="GROUP_MASTER" attributeName="addressLine2"
					value="${groupMasterInstance?.address?.address2}"
					disabled="disabled" class="disabledInput"></g:secureTextField>
			</div>
		</td>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance?.address, field: 'city', 'error')} ">
				<label for="city"> <g:message code="groupMaster.city.label"
						default="City :" disabled="disabled" />

				</label>
				<g:secureTextField name="address.primary.1.city"
				tableName="GROUP_MASTER" attributeName="city"
					value="${groupMasterInstance?.address?.city}" disabled="disabled"  class="disabledInput"></g:secureTextField>
			</div>
		</td>
	</tr>
	<tr>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance?.address, field: 'state', 'error')} ">
				<label for="groupState"> <g:message
						code="groupMaster.groupState.label" default="State :"
						disabled="disabled" />

				</label>

				<g:secureComboBox name="state" style="width: 150px"
					tableName="GROUP_MASTER" attributeName="state" value="${groupMasterInstance?.address?.state}"
					noSelection="['':'-- Select a State --']"
					onchange="${remoteFunction(controller:'groupMaintenance',action:'ajaxGetCities', params:'\'state=\' + escape(this.value)', onComplete:'updateCity(e)')}"
					from="${states}" optionValue="stateCode" optionKey="stateName"
					disabled="disabled" class="disabledInput">
				</g:secureComboBox>
				
			</div>
		</td>
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance?.address, field: 'zip', 'error')} ">
				<label for="zipCode"> <g:message
						code="groupMaster.zipCode.label" default="Zip Code :" />

				</label>
				<g:secureTextField name="address.primary.1.zip"
				tableName="GROUP_MASTER" attributeName="zipCode"
					value="${groupMasterInstance?.address?.zip}" disabled="disabled" class="disabledInput" />
			</div>
		</td>
<%--	<td>
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance?.address, field: 'county', 'error')} ">
				<label for="county"> <g:message
						code="groupMaster.county.label" default="County :" />

				</label>
				<g:textField name="address.primary.1.county"
					value="${groupMasterInstance?.address?.county}" disabled="disabled" />
			</div>
		</td>  --%>	
		<td style="white-space:nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: groupMasterInstance?.address, field: 'country', 'error')} ">
				<label for="country"><g:message code="groupMaster.country.label" default="Country :" /></label>
				
							
				<g:secureComboBox name="country" style="width: 150px"
					tableName="GROUP_MASTER" attributeName="country" value="${groupMasterInstance?.address?.country}"
					onchange="${remoteFunction(controller:'groupMaintenance',action:'ajaxGetCities', params:'\'state=\' + escape(this.value)', onComplete:'updateCity(e)')}"
					from="${countries}" optionValue="countryCode" optionKey="country" noSelection="['':'']" 
					disabled="disabled" class="disabledInput">
				</g:secureComboBox>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<h4>
				User Defined Fields
			<h4>
			</h3>
			<hr>
		</td>
	</tr>
	<tr>
		<td style="white-space:nowrap">
			<div class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'userDefined1', 'error')} ">
				<label for="userDefined1">
					<g:userDefinedFieldLabel winId="GROUP" datawindowId ="dw_group_de" userDefineTextName="user_defined_1_t" defaultText="User Defined 1"   />
				</label>
				<g:secureTextField name="userDefined1" 
				tableName="GROUP_MASTER" attributeName="userDefined1"
				value="${groupMasterInstance?.userDefined1}"></g:secureTextField>
			</div>
		</td>
		<td style="white-space:nowrap">
			<div class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'userDefined2', 'error')} ">
				<label for="userDefined2">
					<g:userDefinedFieldLabel winId="GROUP" datawindowId ="dw_group_de" userDefineTextName="user_defined_2_t" defaultText="User Defined 2"   /> 
				</label>
				<g:secureTextField name="userDefined2" 
				tableName="GROUP_MASTER" attributeName="userDefined2"
				value="${groupMasterInstance?.userDefined2}"></g:secureTextField>
			</div>
		</td>
	</tr>
	<tr>
		<td style="white-space:nowrap">
			<div class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'userDefined3', 'error')} ">
				<label for="userDefined3">
					<g:userDefinedFieldLabel winId="GROUP" datawindowId ="dw_group_de" userDefineTextName="user_defined_3_t" defaultText="User Defined 3"   /> 
				</label>
				<g:secureTextField name="userDefined3" tableName="GROUP_MASTER" attributeName="userDefined3" value="${groupMasterInstance?.userDefined3}"></g:secureTextField>
			</div>
		</td>
		<td style="white-space:nowrap">
			<div class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'userDefined4', 'error')} ">
				<label for="userDefined4"> 
					<g:userDefinedFieldLabel winId="GROUP" datawindowId ="dw_group_de" userDefineTextName="user_defined_4_t" defaultText="User Defined 4"   />
				</label>
				<g:secureTextField name="userDefined4" 
				tableName="GROUP_MASTER" attributeName="userDefined4"
				value="${groupMasterInstance?.userDefined4}"></g:secureTextField>
			</div>
		</td>
	</tr>
	<tr>
		<td style="white-space:nowrap">
			<div class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'userDefined5', 'error')} ">
				<label for="userDefined5"> 
					<g:userDefinedFieldLabel winId="GROUP" datawindowId ="dw_group_de" userDefineTextName="user_defined_5_t" defaultText="User Defined 5"   />
				</label>
				<g:secureTextField name="userDefined5"
				tableName="GROUP_MASTER" attributeName="userDefined5"
				value="${groupMasterInstance?.userDefined5}"></g:secureTextField>
			</div>
		</td>
	</tr>
</table>				