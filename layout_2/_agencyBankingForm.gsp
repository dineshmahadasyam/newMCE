<%@ page import="com.dell.diamond.fms.AgentMasterCommand"%>
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

	function createBankEft() {		
		window.location.assign('<g:createLinkTo dir="/agency/createBankEft"/>?seqAgencyId=${agencyInstance?.seqAgencyId }&agencyId=${agencyInstance?.agencyId }&agencyType=${agencyInstance?.agencyType}');
	}


	function deleteEFTdetails(seqId)
	{
		
		document.getElementById('seqAgentEFTId').value = seqId
	    	if (confirm("Are you sure you want to delete this Banking?") == true) 
	   		 {
	   	    	return true;
		     } 
		    else 
			{
		    	return false;
		    }
	}
</script>

<input type="hidden" name="editType" value="BANKING" />
<input type="hidden" name="seqAgencyId" value="${agencyInstance?.seqAgencyId }" />
<input type="hidden" name="seqAgentEFTId" id="seqAgentEFTId" value="" />
<div id="${agencyInstance?.seqAgencyId}">
	<br/>
	<div id="createBankDiv" style="padding-bottom:10px;">
			<input type="button" name="createBankButton" class="load" value="Add Banking"  onClick="createBankEft()">
	</div>
	Agency Banking Records for Agency Id (${agencyInstance?.agencyId})
	<br/>
	<br/>
	<table border="1" id="report">
		<tr class="head">
			<th>&nbsp;&nbsp;Select</th>
			<th>Name on Account</th>
			<th>Bank Name</th>
			<th>Account Type</th>
			
		</tr>
		<g:each in="${agencyInstance?.agentEFTs}" var="agentEFT" status="i">
			<input type="hidden" name="seq_agent_eft_id_${i}" value="${agentEFT?.seqAgentEFTId }">
			<input type="hidden" name="agentEFT.${i}.iterationCount" value="${i}">
			<input type="hidden" name="agentEFT.${i}.seqAgentEFTId" value="${agentEFT?.seqAgentEFTId }">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				<td>
					<input type="radio" name="addressId" class="selectradio" value="${agentEFT?.seqAgentEFTId}">
				</td>
				<td class="clickme">
					${agentEFT?.nameOnAccount}
				</td>
				<td class="clickme">
					${agentEFT?.bankName}
				</td>
				<td class="clickme">
					${agentEFT?.accountType}
				</td>
			</tr>

			<tr class="hideme" id="rowToClone2">
				<td colspan="13">
					<div class="divContent" id="${agentEFT?.seqAgentEFTId}">
						<table class="report1" border="0" style="table-layout: fixed;">
							
							<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'accountNumber', 'error')} ">
									<label for="accountNumber" style="padding-right:55px;"> 
										<g:message code="agentMaster.agentEft.accountNumber.label" default="Bank Account No" />
										<span class="required-indicator">*</span> :
									</label>
									<g:if test="${accountInfoEdit.equals(true)}">									
										<g:secureTextField name="agentEFT.${i}.accountNumber" value="${agentEFT?.accountNumber}"  title="The Bank Account Number"
										maxlength="25" tableName="AGENT_EFT" attributeName="accountNumber" id="accountNumber"></g:secureTextField>
									</g:if>
									<g:else>
										<g:secureTextField name="agentEFT.${i}.accountNumber" value="${agentEFT?.accountNumber}"  title="The Bank Account Number" disabled="${!elementsEnabled?"true":"false"}"
										maxlength="25" tableName="AGENT_EFT" attributeName="accountNumber" id="accountNumber"></g:secureTextField>
									</g:else>
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'nameOnAccount', 'error')} ">
									<label for="nameOnAccount" style="padding-right:62px;"> 
										<g:message code="agentMaster.agentEft.nameOnAccount.label" default="Name on Account" />
											<span class="required-indicator">*</span> :
									</label>
								    <g:secureTextField name="agentEFT.${i}.nameOnAccount" value="${agentEFT?.nameOnAccount}" title="The Name on the Account"
								    maxlength="60" tableName="AGENT_EFT" attributeName="nameOnAccount" id="nameOnAccount"></g:secureTextField>
										  
								</div>
							</td>							
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'bankName', 'error')} ">
									<label for="bankName" style="padding-right:40px;"> 
										<g:message code="agentMaster.agentEft.bankName.label" default="Bank Name" />
											<span class="required-indicator">*</span> :
									</label>
								    <g:secureTextField name="agentEFT.${i}.bankName" value="${agentEFT?.bankName}" title="The Bank Name"
								    maxlength="60" tableName="AGENT_EFT" attributeName="bankName" id="bankName"></g:secureTextField>
										  
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'routingNumber', 'error')} ">
									<label for="routingNumber" style="padding-right:55px;"> 
										<g:message code="agentMaster.agentEft.routingNumber.label" default="ABA Routing No" /> 
										<span class="required-indicator">*</span> :
				                     </label>	
				                     <g:if test="${accountInfoEdit.equals(true)}">
									 	<g:secureTextField name="agentEFT.${i}.routingNumber"	title="The ABA Routing Number of the Bank"
											value="${agentEFT?.routingNumber}"  maxlength="9" tableName="AGENT_EFT" attributeName="routingNumber"></g:secureTextField>
									 </g:if>
									 <g:else>
									 	<g:secureTextField name="agentEFT.${i}.routingNumber"	title="The ABA Routing Number of the Bank" disabled="${!elementsEnabled?"true":"false"}"
											value="${agentEFT?.routingNumber}"  maxlength="9" tableName="AGENT_EFT" attributeName="routingNumber"></g:secureTextField>
									 </g:else>
								</div>
							</td>
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'description', 'error')} ">
									<label for="description" style="padding-right:62px;"> 
										<g:message code="agentMaster.agentEft.description.label" default="Account Description"  /> :
									</label>
									<g:secureTextField name="agentEFT.${i}.description" title="The Bank Account Description"	
										value="${agentEFT?.description}"  maxlength="60" tableName="AGENT_EFT" attributeName="description"></g:secureTextField>
								</div>
							</td>
							
							<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'accountType', 'error')} ">
									<label for="accountType" style="padding-right:40px;"> 
										<g:message code="agentMaster.agentEft.accountType.label" default="Account Type"  />
										<span class="required-indicator">*</span> :
									</label>
									<g:secureComboBox id="accountType" name="agentEFT.${i}.accountType" title="The Bank Account Type" 
				                                  tableName="AGENT_EFT" attributeName="accountType"
				                                  value="${agentEFT?.accountType}"
				                                  from="${['' : '-- Select the Account Type --', 'C': 'C – Checking' , 'S': 'S – Savings']}" optionValue="value" optionKey="key">
				                    </g:secureComboBox>		
								</div>
							</td>
						</tr>					
						<tr>
						<td class="tdnoWrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'statusFlag', 'error')} ">
									<label for="statusFlag" style="padding-right:55px;"> 
										<g:message code="agentMaster.agentEft.statusFlag.label" default="Status"  />
										<span class="required-indicator">*</span> :
									</label>
									<g:secureComboBox id="statusFlag" name="agentEFT.${i}.statusFlag" title="The Account Status" 
				                                  tableName="AGENT_EFT" attributeName="statusFlag"
				                                  value="${agentEFT?.statusFlag}"
				                                  from="${['' : '-- Select the Status --', 'P': 'P – Primary' , 'S': 'S - Secondary']}" optionValue="value" optionKey="key">
				                    </g:secureComboBox>		
								</div>
							</td>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'effectiveDate', 'error')} ">
									<label for="effectiveDate" style="padding-right:62px;"> 
										<g:message code="agentMaster.agentEft.effectiveDate.label" default="Effective Date " />
										<span class="required-indicator">*</span> :
										</label>
										<g:secureGrailsDatePicker
										name="agentEFT.${i}.effectiveDate" 
										title="The Bank Account Effective Date"
										tableName="AGENT_EFT" attributeName="effectiveDate" precision="day" noSelection="['':'']"
										value="${agentEFT?.effectiveDate}" default="none"></g:secureGrailsDatePicker>	
								</div>
							</td>						
							<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'termDate', 'error')} ">
									<label for="termDate" style="padding-right:40px;"> 
										<g:message code="agentMaster.agentEFT.termDate.label" default="Term Date " /> :
									</label>
									<g:secureGrailsDatePicker
										name="agentEFT.${i}.termDate" 
										title="The Bank Account Term Date"
										tableName="AGENT_EFT" attributeName="termDate" precision="day" noSelection="['':'']"
										value="${agentEFT?.termDate}" default="none"></g:secureGrailsDatePicker>	
								</div>
							</td>		
						</tr>
						<tr>
						<td class="tdnoWrap" style="white-space: nowrap">
								<div class="fieldcontain ${hasErrors(bean: agentEFT, field: 'termReason', 'error')} ">
									<label for="termReason" style="padding-right:55px;"> 
										<g:message code="agentEFT.termReason.label" default="Term Reason " /> :
									</label>
									<g:secureTextField maxlength="5" title="The Bank Account Term Reason"
											name="agentEFT.${i}.termReason" 
											tableName="AGENT_EFT" attributeName="termReason" 
											value="${agentEFT?.termReason}"></g:secureTextField>
									<input type="hidden" id="reasonCodeTypeHidden" value="TM" />
									<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
										src="${resource(dir: 'images', file: 'Search-icon.png')}"
										onclick="lookup('agentEFT.0.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode','reasonCodeTypeHidden','reasonCodeType')">
								</div>
							</td>		
						
						
						<td></td>
														
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap">
								</td>
							</tr>
							<tr>
								<td class="tdnoWrap" style="white-space: nowrap"></td>
							</tr>
							<tr>
								<td colspan="2"><g:actionSubmit class="load" action="deleteEFTdetails" value="Delete" onclick="return deleteEFTdetails(${agentEFT?.seqAgentEFTId});" />
								</td>
							</tr>
						</table>
			
					</div>
				</td>
			</tr>
		</g:each>
	</table>
</div>