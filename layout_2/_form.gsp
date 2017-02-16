<%@ page import="com.perotsystems.diamond.bom.fms.Agency"%>
<%@ page import="com.perotsystems.diamond.bom.fms.AgencyAgent" %>

<style>
.fieldcontain LABEL, .fieldcontain .property-label {
	width : 40%
}
</style>
<input type="hidden" name="editType" value="MASTER" />
<input type="hidden" name="seqAgentId" value="${agentMasterInstance?.seqAgentId }" />
<table>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'agentId', 'error')} ">
				<label for="agentId"> 
					<g:message code="agentMaster.agentId.label" default="Agent/Broker ID" />
						<span class="required-indicator">*</span> : 
				</label>
				<g:secureTextField name="agentId" value="${agentMasterInstance?.agentId}" maxlength="15" readOnly="true" tableName="AGENT_MASTER" attributeName="agentId" title="The unique Agent or Broker ID " id="agentId" onClick="changeAgentIdMessage()"></g:secureTextField>
			</div>
		</td>
		<!-- 
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'licenseNo', 'error')} required">
				<label for="licenseNo"> 
					<g:message code="agentMaster.licenseNo.label" default="License No" /> 
						<span class="required-indicator">*</span> : 
				</label>
				<g:secureTextField name="licenseNo" 
					value="${agentMasterInstance?.licenseNo}" maxlength="22" tableName="AGENT_MASTER" attributeName="licenseNo"></g:secureTextField>
			</div>
		</td>
	 -->
	 
		
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'agentType', 'error')} ">
				<label for="agentType" style="padding-right:8px;"> 
					<g:message code="agentMaster.agentType.label" default="Agent /Broker Type" />
						<span class="required-indicator">*</span> : 
				</label>
				
		    <g:if test="${actionType.equals("Edit")}">								
			<g:getSystemCodes
					systemCodeType="AGBR_TYPE"
					systemCodeActive = "Y"
					htmlElelmentId="agentType"
					blankValue="Agent Type --"
					defaultValue="${agentMasterInstance?.agentType}" 
					width="150px"
					disable="true"
					/>
					</g:if>
					 <g:if test="${actionType.equals("Create")}">
					 <g:getSystemCodes
					systemCodeType="AGBR_TYPE"
					systemCodeActive = "Y"
					htmlElelmentId="agentType"
					blankValue="Agent Type --"
					defaultValue="${agentMasterInstance?.agentType}" 
					width="150px"					
					/>
					 </g:if>
			</div>
		</td>
	</tr>
	<tr>

	 <td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance.agencys, field: 'agencyId', 'error')} ">
				<label for="agencyId"> 
					<g:message code="agentMaster.agencys.agencyId.label" default="Agency ID" />
						<span class="required-indicator">*</span> : 
				</label>
				<input type="hidden" id="agencyType" value="C" />
				<input type="hidden" name="agencyId" value="${agentMasterInstance.agencys?.get(0).agencyId}" />
				<g:secureTextField name="agencys.agencyId" value="${agentMasterInstance.agencys?.get(0).agencyId}"   style="margin-right: 5px;" maxlength="50" tableName="AGENCY" attributeName="agencyId" id= "agencyId" title="The ID of the Agency the Agent/broker is affiliated with"></g:secureTextField>
				<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('agencyId', 'com.perotsystems.diamond.dao.cdo.Agency','agencyId','seqAgencyId','agencyType')"></td>		
											
			</div>
		</td>
		 
		
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance.agencys, field: 'agencyName', 'error')} ">
				<label for="agencyName"  style="padding-right:8px;"> 
					<g:message code="agentMaster.agencys.agencyName.label" default="Agency Name" />
						<span class="required-indicator">*</span> : 
				</label>
				<g:if test="${agentMasterInstance?.agentType.equals('C')}">
					<g:secureTextField name="agencys.agencyName" value="${agentMasterInstance.agencys?.get(0).agencyName}" 
					maxlength="60" tableName="AGENCY" attributeName="agencyName" readonly="true" id = "idAgencyName" class="idAgencyName" 
					></g:secureTextField>
				</g:if>
				<g:else>
					<g:secureTextField name="agencys.agencyName" value="${agentMasterInstance.agencys?.get(0).agencyName}" 
					maxlength="60" tableName="AGENCY" attributeName="agencyName" id = "idAgencyName" class="idAgencyName" 
					></g:secureTextField>
				</g:else>
			</div>
		</td>
	</tr>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'firstName', 'error')} ">
				<label for="firstName"> 
					<g:message code="agentMaster.firstName.label" default="First Name" /> 
						<span class="required-indicator">*</span> : 
				</label>
				<g:secureTextField name="firstName" value="${agentMasterInstance?.firstName}"  maxlength="35" tableName="AGENT_MASTER" attributeName="firstName" title="The First Name of the Agent/Broker"></g:secureTextField>
			</div>
		</td>

		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'middleInitial', 'error')} ">
				<label for="middleInitial"> 
					<g:message code="agentMaster.middleInitial.label" default="Middle Initial" /> : 
				</label>
				<g:secureTextField name="middleInitial"
					value="${agentMasterInstance?.middleInitial}"  maxlength="25" tableName="AGENT_MASTER" attributeName="middleInitial" title="The Middle Name or Middle Initial of the Agent/Broker"></g:secureTextField>
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'lastName', 'error')} ">
				<label for="lastName" style="padding-right:8px;"> 
					<g:message code="agentMaster.lastName.label" default="Last Name"  />
						<span class="required-indicator">*</span> : 
				</label>
				<g:secureTextField name="lastName" value="${agentMasterInstance?.lastName}" maxlength="60" tableName="AGENT_MASTER" attributeName="lastName" title="The Last Name of the Agent/Broker"></g:secureTextField>
			</div>
		</td>
	</tr>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'shortName', 'error')} ">
				<label for="shortName"> 
					<g:message code="agentMaster.shortName.label" default="Short Name" /> : 
				</label>
				<g:secureTextField name="shortName" value="${agentMasterInstance?.shortName}"  maxlength="15" tableName="AGENT_MASTER" attributeName="shortName" title="The Short Name for the Agent/Broker"></g:secureTextField>
			</div>
		</td>
	
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'dateOfBirth', 'error')} required">
				<label for="dateOfBirth"> 
					<g:message code="agentMaster.dateOfBirth.label" default="Date Of Birth" /> 
					<span class="required-indicator"> * </span> : 
				</label>											
				<g:secureGrailsDatePicker
					name="dateOfBirth"
					tableName="AGENT_MASTER" attributeName="dateOfBirth" precision="day" noSelection="['':'']"
					value="${agentMasterInstance?.dateOfBirth}" default="none"></g:secureGrailsDatePicker>
			</div>
		</td>
		<g:each in="${agentMasterInstance?.agencyAgents}" var="agencyAgents" status="i">
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div id="effectveDateDivId"
				class="fieldcontain ${hasErrors(bean: agentMasterInstance.agencyAgents, field: 'effectiveDate', 'error')} required">
				<label for="effectiveDate"> 
					<g:message code="agentMasterInstance.agencyAgents.effectiveDate.label" default="Effective Date" /> 
					<span class="required-indicator"> * </span> : 
				</label>
				<g:if test="${agentMasterInstance?.agentType.equals('I')}">
					<g:secureGrailsDatePicker id="effectiveDate"
						name="effectiveDate"
						tableName="AGENCY_AGENT" attributeName="effectiveDate" disabled="disabled" precision="day" noSelection="['':'']"
						value="${agencyAgents?.effectiveDate}" default="none"></g:secureGrailsDatePicker>
					
				</g:if>
				<g:else>
					<g:secureGrailsDatePicker id="effectiveDate"
						name="effectiveDate"
						tableName="AGENCY_AGENT" attributeName="effectiveDate" precision="day" noSelection="['':'']"
						value="${agencyAgents?.effectiveDate}" default="none"></g:secureGrailsDatePicker>
				</g:else>
				
			</div>
		</td>
		</g:each>

		<td  class="tdnoWrap" style="white-space: nowrap">&nbsp;</td>
	</tr>
	
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap" colspan="3">&nbsp;</td>
	</tr>
	
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'payType', 'error')} ">
				<label for="payType"> <g:message
						code="agentMaster.payType.label" default="Pay Type" />
                   <span class="required-indicator">*</span> :
				 </label>
		<!--  <g:secureTextField name="payType" value="${agentMasterInstance?.payType}"  maxlength="1" tableName="AGENT_MASTER" attributeName="payType"></g:secureTextField> -->
				<g:secureComboBox id="payType" name="payType" style="width: 150px" 
				                                  tableName="AGENT_MASTER" attributeName="payType"
				                                  value="${agentMasterInstance?.payType}"
				                                  from="${['' : '-- Select Pay Type --', 'E': 'E - EFT' , 'D': 'D - Direct Deposit']}" optionValue="value" optionKey="key">
				</g:secureComboBox>				
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'pinTid', 'error')} ">
				<label for="pinTid"> <g:message
						code="agentMaster.pinTid.label" default="Pin Tid" />
                        <span class="required-indicator">*</span> 
				: </label>
				<g:secureTextField name="pinTid" class="pinTid" value="${agentMasterInstance?.pinTid}" tableName="AGENT_MASTER" attributeName="pinTid" title="The 9 digit Tax ID Number of the Agency"></g:secureTextField>
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">&nbsp;</td>
	</tr>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'status', 'error')} ">
				<label for="status"> <g:message
						code="agentMaster.status.label" default="Status" />
                        <span class="required-indicator"> * </span> 
				: </label>
					<g:secureComboBox id="status" name="status" style="width: 150px" 
				                                  tableName="AGENT_MASTER" attributeName="status"
				                                  value="${agentMasterInstance?.status}"
				                                  from="${['' : '-- Select an Agent Status --', 'A': 'A – Active' , 'T': 'T – Terminated']}" optionValue="value" optionKey="key">
				</g:secureComboBox>	
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'termDate', 'error')} required">
				<label for="termDate"> <g:message
						code="agentMaster.termDate.label" default="Term Date" />
				: </label>
				<g:secureGrailsDatePicker
					name="termDate" id="termDate"
					tableName="AGENT_MASTER" attributeName="termDate" precision="day" noSelection="['':'']"
					value="${agentMasterInstance?.termDate}" default="none"></g:secureGrailsDatePicker>							
			</div>
		</td>
		<td class="tdnoWrap" style="white-space: nowrap">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3">User Defined Information</td>
	</tr>
	<tr>
		<td colspan="3"><hr></td>
	</tr>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'userDefined1', 'error')} ">
				<label for="userDefined1">
				<g:userDefinedFieldLabel winId="AGNTM" datawindowId ="AGNTM" userDefineTextName="user_defined_1_t" defaultText="User Defined1"/>

				</label>
				<g:secureTextField name="userDefined1"
					value="${agentMasterInstance?.userDefined1}"  maxlength="60" tableName="AGENT_MASTER" attributeName="userDefined1"></g:secureTextField>
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'userDefined2', 'error')} ">
				<label for="userDefined2">
						<g:userDefinedFieldLabel winId="AGNTM" datawindowId ="AGNTM" userDefineTextName="user_defined_2_t" defaultText="User Defined2"/>
				</label>
				<g:secureTextField name="userDefined2"
					value="${agentMasterInstance?.userDefined2}"  maxlength="60" tableName="AGENT_MASTER" attributeName="userDefined2"></g:secureTextField>
					
					
			</div>
		</td>
		<td class="tdnoWrap" style="white-space: nowrap">&nbsp;</td>
	</tr>
	<tr>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'userDate1', 'error')} required">
				<label for="userDate1"> 						
						<g:userDefinedFieldLabel winId="AGNTM" datawindowId ="AGNTM" userDefineTextName="user_date_1_t" defaultText="User Date 1"/> 
				</label>
				<%--<g:datePicker name="userDefinedDate" precision="day"
					value="${agentMasterInstance?.userDefinedDate}" />
			--%>
			
			<g:secureGrailsDatePicker
					name="userDate1"
					tableName="AGENT_MASTER" attributeName="userDate1" precision="day" noSelection="['':'']"
					value="${agentMasterInstance?.userDate1}" default="none"></g:secureGrailsDatePicker>
		
			</div>
		</td>
		<td  class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean: agentMasterInstance, field: 'userDate2', 'error')} required">
				<label for="userDate2">
					<g:userDefinedFieldLabel winId="AGNTM" datawindowId ="AGNTM" userDefineTextName="user_date_2_t" defaultText="User Date 2"/>
				</label>
				<%--<g:datePicker name="userDefinedDate" precision="day"
					value="${agentMasterInstance?.userDefinedDate}" />
			--%>
			
			<g:secureGrailsDatePicker
					name="userDate2"
					tableName="AGENT_MASTER" attributeName="userDate2" precision="day" noSelection="['':'']"
					value="${agentMasterInstance?.userDate2}" default="none"></g:secureGrailsDatePicker>
			</div>
		</td>
		<td colspan="2" class="tdnoWrap" style="white-space: nowrap">&nbsp;</td>
	</tr>
</table>