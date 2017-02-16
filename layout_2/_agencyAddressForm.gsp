<%@ page import="com.perotsystems.diamond.dao.cdo.Agency"%>
<g:set var="appContext" bean="grailsApplication"/>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript">

	//<![CDATA[ 
	$(window).load(function() {
		
		$('.hideme').find('div').hide();
		
		$('.clickme').click(function() {
			
			if($(this).parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().children().get(0).checked = false;
			}else{
				$(this).parent().children().children().get(0).checked = true;
			}
			
			$(this).parent().next('.hideme').find('div').slideToggle(500);
			return false;
		});

		$(".selectradio").click(function(){
			if($(this).parent().parent().next('.hideme').find('div').is(":visible")){
				$(this).parent().children().get(0).checked = false;
			}else{
				$(this).parent().children().get(0).checked = true;
			}
			$(this).parent().parent().next('.hideme').find('div').slideToggle(500);
		});
		

	});//]]>

	function addAddress() {		
		window.location.assign('<g:createLinkTo dir="/agency/addAgencyAddress"/>?seqAgencyId=${agencyInstance?.seqAgencyId}');
	}
	
</script>

<input type="hidden" name="editType" value="ADDRESS" />
<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId }" />

<div id="${agencyInstance?.seqAgencyId}">
	<br/>
	<div id="addAddressDiv" style="padding-bottom:10px;">
			<input type="button" name="addAddressButton" class="load" value="Add Address"  onClick="addAddress()">
	</div>
	Agency Address Records for Agency Id (${agencyInstance?.agencyId}) 
	<br/>
	<br/>
	<table border="1" id="report">
		<tr class="head">
			<th>&nbsp;&nbsp;Select</th>
			<th>Effective Date</th>
			<th>Term Date</th>
			<th>Address Type</th>
			<th>Address Line 1</th>
			<th>City</th>
			<th>County</th>
			<th>State</th>
			<th>Zip Code</th>
			<th>Country</th>
		</tr>
		<g:each in="${agencyInstance?.agentAddresses }" var="agencyAddress" status="i">
			<input type="hidden" name="seq_address_id_${i}" value="${agencyAddress?.seqAgentAddress }">
			<input type="hidden" name="agencyAddress.${i}.iterationCount" value="${i}">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				<td>
					<input type="radio" name="addressId" class="selectradio" value="${agencyAddress?.seqAgentAddress}">
				</td>
				<td class="clickme">
					<g:formatDate format="yyyy-MM-dd" date="${agencyAddress.effectiveDate}" />
				</td>
				<td class="clickme">
					<g:formatDate format="yyyy-MM-dd" date="${agencyAddress.termDate}" />
				</td>
				<td class="clickme">
					${agencyAddress?.addressType}
				</td>
				<td class="clickme">
					${agencyAddress?.addressLine1}
				</td>
				<td class="clickme">
					${agencyAddress?.city}
				</td>
				<td class="clickme">
					${agencyAddress?.county}
				</td>
				<td class="clickme">
					${agencyAddress?.state}
				</td>
				<td class="clickme"><g:if
						test="${agencyAddress?.zipCode?.length() > 5}">
						${agencyAddress?.zipCode?.with {length()? getAt(0..4):''}}-${agencyAddress?.zipCode?.with {length()? getAt(5..length()-1):''}}
					</g:if> <g:elseif test="${agencyAddress?.zipCode?.length() == 5}">
						${agencyAddress?.zipCode?.with {length()? getAt(0..4):''}}
					</g:elseif> <g:else></g:else>
				</td>
				<td class="clickme">
					${agencyAddress?.country}
				</td>
			</tr>

			<tr class="hideme" id="rowToClone2">
				<td colspan="13">
					<div class="divContent" id="${agencyAddress?.seqAgentAddress}">
						<table class="report1" border="0" style="table-layout: fixed;">
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'addressLine1', 'error')} ">
										<label for="addressLine1"> 
											<g:message code="agencyAddress.addressLine1.label" default="Address Line 1 :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureTextField name="agencyAddress.${i}.addressLine1" title="The first Address line" maxlength="60" 
											value="${agencyAddress?.addressLine1}" tableName="AGENT_ADDRESS" attributeName="addressLine1"></g:secureTextField>
									</div>
								</td>							
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'addressLine2', 'error')} ">
										<label for="addressLine2"> 
											<g:message code="agencyAddress.addressLine2.label" default="Address Line 2 :" />
										</label>
										<g:secureTextField name="agencyAddress.${i}.addressLine2" title="The 2nd Address line" maxlength="60" 
											value="${agencyAddress?.addressLine2}" tableName="AGENT_ADDRESS" attributeName="addressLine2"></g:secureTextField>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'city', 'error')} ">
										<label for="lastName"> 
											<g:message code="agencyAddress.city.label" default="City :" />
											<span class="required-indicator">*</span>
										</label>
											<g:secureTextField name="agencyAddress.${i}.city" value="${agencyAddress?.city}" title="The City" maxlength="30" 
											tableName="AGENT_ADDRESS" attributeName="city"></g:secureTextField>
									</div>
								</td>	
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'state', 'error')} ">
										<label for="state"> 
											<g:message code="agencyAddress.state.label" default="State :" />
											<span class="required-indicator">*</span> 
										</label>
										<g:secureComboBox name="agencyAddress.${i}.state"  optionKey="stateCode"
												tableName="AGENT_ADDRESS" attributeName="state" 
												optionValue="stateName" id="agencyAddress.${i}.state" from="${states}"
												noSelection="['':'-- Select a State --']"
												value="${agencyAddress?.state}">
										</g:secureComboBox>
									</div>
								</td>								
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'county', 'error')} ">
										<label for="county"> 
											<g:message code="agencyAddress.county.label" default="County :" />
										</label>
										<g:secureTextField name="agencyAddress.${i}.county" maxlength="30" 
											value="${agencyAddress?.county}" tableName="AGENT_ADDRESS" title="The County"
											attributeName="county"></g:secureTextField>
									</div>
								</td>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'country', 'error')} ">
										<label for="country"> 
											<g:message code="agencyAddress.country.label" default="Country :" />
										</label>
										<g:secureTextField name="agencyAddress.${i}.country" maxlength="30" 
												value="${agencyAddress?.country}" tableName="AGENT_ADDRESS" title="The Country"
												attributeName="country"></g:secureTextField>
									</div>
								</td>					
							</tr>
							<tr>	
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'zipCode', 'error')} ">
										<label for="zipCode"> 
											<g:message code="agencyAddress.zipCode.label" default="Zip Code :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureTextField name="agencyAddress.${i}.zipCode"  title="5 or 9 digit Zip Code. Enter numbers only" 
										value="${agencyAddress?.zipCode}" tableName="AGENT_ADDRESS" class="maskZip"
										attributeName="zipCode"></g:secureTextField>
									</div>
								</td>					
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'addressType', 'error')} ">
										<label for="addressType"> 
											<g:message code="agencyAddress.addressType.label" default="Address Type :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureSystemCodeToken
													tableName="AGENT_ADDRESS" attributeName="addressType"
													systemCodeType="AGENTAGENCYADDR" languageId="0"
													htmlElelmentId="agencyAddress.${i}.addressType"
													blankValue="Address Type" 
													defaultValue="${agencyAddress?.addressType}" 
													value="${agencyAddress?.addressType}"
													width="135px">
										</g:secureSystemCodeToken>
									</div>
								</td>	
							</tr>  
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'effectiveDate', 'error')} ">
										<label for="effectiveDate"> 
											<g:message code="agencyAddress.effectiveDate.label" default="Effective Date :" />
											<span class="required-indicator">*</span>
										</label>
										<g:secureGrailsDatePicker
										name="agencyAddress.${i}.effectiveDate" 
										title ="The Effective date of the Address"
										tableName="AGENT_ADDRESS" attributeName="effectiveDate" precision="day" noSelection="['':'']"
										value="${agencyAddress?.effectiveDate}" default="none"></g:secureGrailsDatePicker>
									</div>
								</td>						
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'termDate', 'error')} ">
										<label for="termDate"> 
											<g:message code="agencyAddress.termDate.label" default="Term Date :" />
										</label>
										<g:secureGrailsDatePicker
										name="agencyAddress.${i}.termDate" 
										title ="The Termination date of the Address"
										tableName="AGENT_ADDRESS" attributeName="termDate" precision="day" noSelection="['':'']"
										value="${agencyAddress?.termDate}" default="none"></g:secureGrailsDatePicker>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'termReason', 'error')} ">
										<label for="termReason"> 
											<g:message code="agencyAddress.termReason.label" default="Term Reason :" />
										</label>
										<g:secureTextField maxlength="5" title="The Termination Reason of the Address"
											name="agencyAddress.${i}.termReason" 
											tableName="AGENT_ADDRESS" attributeName="termReason" 
											value="${agencyAddress?.termReason}"></g:secureTextField>
											<input type="hidden" id="reasonCodeTypeHidden" name ="reasonCodeTypeHidden" value="TM" />
											<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
											src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('agencyAddress.${i}.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode','reasonCodeTypeHidden','reasonCodeType')">
									</div>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap" colspan="2">
									User Defined Information: <hr>
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDefined1', 'error')} ">
										<label for="userDefined1"> 
											<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_defined_1_t" defaultText="User Defined 1 "/>
										</label>
											<g:secureTextField name="agencyAddress.${i}.userDefined1" maxlength="60" 
											value="${agencyAddress?.userDefined1}" tableName="AGENT_ADDRESS" attributeName="userDefined1"></g:secureTextField>
									</div>
								</td>							
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDefined2', 'error')} ">
										<label for="userDefined2"> 
											<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_defined_2_t" defaultText="User Defined 2 "/>
										</label>
										<g:secureTextField name="agencyAddress.${i}.userDefined2" maxlength="60" 
											value="${agencyAddress?.userDefined2}" tableName="AGENT_ADDRESS" attributeName="userDefined2"></g:secureTextField>
									</div>
								</td>
							</tr>
							<tr>				
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDate1', 'error')} ">
										<label for="userDate1"> 
											<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_date_1_t" defaultText="User Date 1 "/>
										</label>
										<g:secureGrailsDatePicker
										name="agencyAddress.${i}.userDate1" 
										tableName="AGENT_ADDRESS" attributeName="userDate1" precision="day" noSelection="['':'']"
										value="${agencyAddress?.userDate1}" default="none"></g:secureGrailsDatePicker>
									</div>
								</td>
								<td class="tdnoWrap" style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: agentAddress, field: 'userDate2', 'error')} ">
										<label for="userDate2"> 
											<g:userDefinedFieldLabel winId="AGNCA" datawindowId ="AGNCA" userDefineTextName="user_date_2_t" defaultText="User Date 2 "/>
										</label>
										<g:secureGrailsDatePicker
											name="agencyAddress.${i}.userDate2" 
											tableName="AGENT_ADDRESS" attributeName="userDate2" precision="day" noSelection="['':'']"
											value="${agencyAddress?.userDate2}" default="none"></g:secureGrailsDatePicker>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
								</td>
							</tr>
						</table>
			
					</div>
				</td>
			</tr>
		</g:each>
	</table>
</div>