<style type="text/css">
	.fieldcontain LABEL, .fieldcontain .property-label {
		color: #666666;
		text-align: left;
		width: 40%;
		font-size: 0.8em;
		font-weight: bold
	}
	.fieldcontain span {
	color: #0066CC;
	}
	#editFields label{
		width:140px;
		text-align:right;    	
	}
	#editFields input{
		width:140px;
		text-align:left;
	}
	#editFields datePicker{
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
 	
.hideme Label{
	text-align:left;
	padding-bottom:5px;
}
.addButton {
	-moz-box-shadow:inset -1px 1px 7px 0px #ffffff;
	-webkit-box-shadow:inset -1px 1px 7px 0px #ffffff;
	box-shadow:inset -1px 1px 7px 0px #ffffff;
	background-color:#ededed;
	-moz-border-radius:15px;
	-webkit-border-radius:15px;
	border-radius:10px;
	border:1px solid #999999;
	display:inline-block;
	color:#404040;
	font-family:arial;
	font-size:16px;
	font-weight:normal;
	padding:5px 24px;
	text-decoration:none;
	text-shadow:1px 0px 13px #ffffff;
}.addButton:hover {
	background-color:#dfdfdf;
}.addButton:active {
	position:relative;
	top:1px;
}
</style>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>

	<g:set var="appContext" bean="grailsApplication"/>


	<script type="text/javascript">
	//<![CDATA[ 
	$(window).load(function() {
		$('.hideme').find('div').hide();
		$('.clickme').click(function() {
			//CQ 56593 fix started
		   
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
		//CQ 56593 fix fixed

	});//]]>  	
	</script>
	
	<script>
	$(document).ready( function () {
		claimActionCodeDisabled();
		claimReasonDisabled();
		});
	function cloneRow()
	{

		var divObjSrc = document.getElementById('newContractDiv')
		var divObjDest = document.getElementById('addContractPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addContractButton')
		divObj.style.display = "none"	
	}

	function addGroupContract() {
		var groupId = "${groupMasterInstance?.groupId}";
		var groupDBId = "${groupMasterInstance?.groupDBId}";
		var appName = "${appContext.metadata['app.name']}";
						
		window.location.assign("/"+ appName+"/groupMaintenance/addGroupContract?groupId="
				+ groupId + "&grouEditType=CONTRACT&groupDBId="+groupDBId);
	}
	function claimActionCodeDisabled()	
	{	
        var ims = document.getElementsByName("addressId");
        for(var i = 0;i < ims.length;i++){
         var contrct = "contract."
         var i_value = i
         var clm_grce_days = ".claimGraceDays"
         var claim_id = contrct.concat(i_value,clm_grce_days)
         var k = document.getElementById(claim_id).value;                
         var clm_actn_code = ".claimActionCode"
         var clm_actn_code_conct = contrct.concat(i_value,clm_actn_code)              
         var clm_resn_code ='.claimReason'
         var clm_resn_code_conct = contrct.concat(i_value,clm_resn_code)                        
          
         var claimGraceDays = document.getElementById(claim_id).value.trim()
               if(claimGraceDays.trim() !=""  && isNaN(claimGraceDays.trim())==false){
                    document.getElementById(clm_actn_code_conct).disabled = false
                       
               }
               else{                                                         
                    document.getElementById(clm_resn_code_conct).value=""           
                    document.getElementById(clm_actn_code_conct).value=""
                    document.getElementById(clm_actn_code_conct).disabled = true
                    document.getElementById(clm_resn_code_conct).disabled = true 
                  }
                  
                  k=""
                  }			
	}

	function claimReasonDisabled()
	{
	    var ims = document.getElementsByName("addressId");
        for(var i = 0;i < ims.length;i++){
        	var contrct = "contract."
            var i_value = i
            var clm_actn_code = ".claimActionCode"
            var clm_actn_code_conct = contrct.concat(i_value,clm_actn_code)              
            var clm_resn_code ='.claimReason'
            var clm_resn_code_conct = contrct.concat(i_value,clm_resn_code)    
                
		var claimActionCode = document.getElementById(clm_actn_code_conct).value.trim()
		if(claimActionCode!=null){			
			if(claimActionCode.trim()=='D' || claimActionCode.trim()=='H'){	
			 document.getElementById(clm_resn_code_conct).disabled = false
		}else{		
			document.getElementById(clm_resn_code_conct).value=""
			document.getElementById(clm_resn_code_conct).disabled = true
			}
			}
        }		
	}

	 function isNumberKey(evt) {
			var charCode = (evt.which) ? evt.which : event.keyCode
			         if ((charCode > 47 && charCode < 58) || (charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123))
			            return true;

			         return false;
				}
	</script> 
	
<script type="text/javascript"> 

$(document).ready(function(){
		
	jQuery.validator.setDefaults({
		  	debug: true,
			ignore: ":hidden",		  
			success: "valid"
		});	
		
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
		                validator.errorList[0].element.focus();
		            }
		        },

		        errorLabelContainer: "#errorDisplay", 
				wrapper: "li",	

				rules : {
					contract.${i}.termReason {
						alphanumeric : true
					}
				},
								
				messages : 
				{	
					contract.${i}.termReason {
						alphanumeric : "Please enter only Letters, numbers or underscores only for termReason"
					}
				} //messages end tag

		}); //editform validate end tag	

		jQuery.validator.addMethod("alphanumeric", function(value, element) {
			return this.optional(element) || /^[a-zA-Z0-9_ ]+$/i.test(value);
		}, "Please enter only Letters, numbers or underscores only.");
		
});	//document ready end tag  	
	

</script>	 
	  
<%@ page import="com.perotsystems.diamond.bom.GroupContract" %>
<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />

<div id="addContractButton" style="display:block">
	<input class="addButton" type="button" value="Add Contract" onClick="addGroupContract()">	
	<g:actionSubmit class="addButton" action="renewSingleGroup" value="Renew Contract" disabled="${disabled}"/>
	<br></br>
</div>
Group Contract Records for Group Id (${groupMasterInstance.getGroupId()})
<br></br>
<table border="1" id="report">
	<tr class="head">
		<th>Select</th>
		<th>Effective Date</th>
		<th>Term Date</th>
		<th>Term Reason</th>
		<th>OE Start</th>
		<th>OE End</th>
		<th>Record Status</th>
	</tr>
	<g:each in="${groupMasterInstance.contracts}" status="i" var="contract">
		<input type="hidden" name="seq_contract_id_${i}" value="${contract?.seqGroupContract }">
		<input type="hidden" name="contract.${i}.iterationCount" value="${i}">
	
	
		<tr>
			<td><input type="radio" name="addressId" class="selectradio" value="${contract?.seqGroupContract}"></td>
			<td class="clickme"><g:formatDate  format="yyyy-MM-dd"  date="${contract?.effectiveDate}" /></td>
			<td class="clickme"><g:formatDate  format="yyyy-MM-dd"  date="${contract?.termDate}" /></td>
			<td class="clickme">${contract?.termReason}</td>
			<td class="clickme"><g:formatDate  format="yyyy-MM-dd"  date="${contract?.openEnrollStart}"/></td>
			<td class="clickme"><g:formatDate  format="yyyy-MM-dd"  date="${contract?.openEnrollEnd}"/></td>
			<td class="clickme">${contract?.recordStatus}</td>
		</tr>	
		<tr class="hideme">
			<td colspan="13">
				<div class="divContent">
						<table class="report1" border="0">
							<tr>
								<td style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.effectiveDate', 'error')} ">
										<label for="effectiveDate"> <g:message
												code="groupMaster.effectiveDate.label" default="Effective Date:" /> <span class="required-indicator">*</span>
									</label>
										<g:secureGrailsDatePicker name="contract.${i}.effectiveDate" precision="day" noSelection="['':'']"
									tableName="GROUP_CONTRACT" attributeName="effectiveDate"
									value="${contract?.effectiveDate}" default="none" ></g:secureGrailsDatePicker>

									</div>
								</td>
								</tr>
								<tr>
								<td style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.termDate', 'error')} ">
										<label for="termDate"> <g:message
												code="groupMaster.termDate.label" default="Term Date:" />
										</label>
											<g:secureGrailsDatePicker name="contract.${i}.termDate" precision="day" noSelection="['':'']"
									tableName="GROUP_CONTRACT" attributeName="termDate"
									value="${contract?.termDate}" default="none" ></g:secureGrailsDatePicker>
									</div>
								</td>
								<td style="white-space: nowrap" >
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.termReason', 'error')} ">
										<label for="termReason"> <g:message
												code="groupMaster.termReason.label" default="Term Reason:" />
										</label>
									<input type="hidden" name="TermReasonType" id="TermReasonType" value="TM"/>
										<g:secureTextField name="contract.${i}.termReason" maxlength="5"
											tableName="GROUP_CONTRACT" attributeName="termReason" class="RemoveSpecialChars"
											value="${contract?.termReason}" ></g:secureTextField>
										<img width="25" height="25"
											style="float: none; vertical-align: bottom"
											class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
											onclick="lookup('contract.${ i }.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'TermReasonType', 'reasonCodeType', null, null)">												
									</div>
								</td>
							</tr>
							<tr>
								<td style="white-space: nowrap">
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.openEnrollStart', 'error')} ">
										<label for="openEnrollStart"> <g:message
												code="groupMaster.openEnrollStart.label" default="Open Enroll Start:" />
						  				</label>
										<g:secureGrailsDatePicker name="contract.${i}.openEnrollStart" precision="day" noSelection="['':'']"
									tableName="GROUP_CONTRACT" attributeName="openEnrollStart"
									value="${contract?.openEnrollStart}" default="none" ></g:secureGrailsDatePicker>										
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.openEnrollEnd', 'error')} ">
										<label for="openEnrollEnd"> <g:message
												code="groupMaster.openEnrollEnd.label" default="Open Enroll End:" />
										</label>
										<g:secureGrailsDatePicker name="contract.${i}.openEnrollEnd" precision="day" noSelection="['':'']"
									tableName="GROUP_CONTRACT" attributeName="openEnrollEnd"
									value="${contract?.openEnrollEnd}" default="none" ></g:secureGrailsDatePicker>
										
									</div>
								</td>
							</tr>
							<tr>
							<td>
								<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.numberOfEmployees', 'error')} ">
										<label for="numberOfEmployees"> <g:message
												code="groupMaster.numberOfEmployees.label" default="No. of Employees:" />
										</label>
										<g:secureTextField type="number" name="contract.${i}.numberOfEmployees" size="6" min="0" 
										tableName="GROUP_CONTRACT" attributeName="numberOfEmployees" maxlength="6" class="amtNumeric"
										value="${contract?.numberOfEmployees}"></g:secureTextField>
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.waitingPeriod', 'error')} ">
										<label for="waitingPeriod"> <g:message
												code="groupMaster.waitingPeriod.label" default="Waiting period: " />
						
						  				</label>
										<g:secureTextField name="contract.${i}.waitingPeriod"
										tableName="GROUP_CONTRACT" attributeName="waitingPeriod"
											value="${contract?.waitingPeriod}" ></g:secureTextField>
									</div>
								</td>
								</tr>
								<tr>
									<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.contractType', 'error')} ">
										<label for="contractType"> <g:message
												code="groupMaster.contractType.label" default="Contract Type: " />
										</label>
										<g:secureTextField name="contract.${i}.contractType"
										tableName="GROUP_CONTRACT" attributeName="contractType" maxlength="1" onkeypress="return isNumberKey(event)"
											value="${contract?.contractType}" ></g:secureTextField>
									</div>
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contract, field: 'contract.recordStatus', 'error')} ">
										<label for="recordStatus"> <g:message
												code="groupMaster.recordStatus.label" default="Record Status: " />
										</label>
										<g:secureTextField name="contract.${i}.recordStatus"
										tableName="GROUP_CONTRACT" attributeName="recordStatus"
											value="${contract?.recordStatus}" ></g:secureTextField>
									</div>
								</td>
							</tr>
							<!--<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contract, field: 'contract.claimGraceDays', 'error')} ">
										<label for="claimGraceDays"> <g:message
												code="groupMaster.claimGraceDays.label" default="Claim Grace Days:" />
						
										</label>
										<g:secureTextField name="contract.${i}.claimGraceDays"
										tableName="GROUP_CONTRACT" attributeName="claimGraceDays"
											value="${contract?.claimGraceDays}" onkeyup="claimActionCodeDisabled(this)"></g:secureTextField>
									</div>
								</td>
								 <td>
									<div
										class="fieldcontain ${hasErrors(bean: contract, field: 'contract.claimActionCode', 'error')} ">
										<label for="claimActionCode"> <g:message
												code="groupMaster.claimActionCode.label" default="Claim Action: " />
						
										</label>
										<g:secureDiamondDataWindowDetail columnName="claim_action_code"
										tableName="GROUP_CONTRACT" attributeName="claimActionCode"
												dwName="dw_group_contract_de" languageId="0"
												htmlElelmentId="contract.${i}.claimActionCode"
												defaultValue="${contract?.claimActionCode}"
												blankValue="claimActionCode" width="150px"  disable="disabled" onchange="claimReasonDisabled()" />		
									</div>
								</td> 	
							</tr>-->
							<tr>
								<!-- <td>
									<div
										class="fieldcontain ${hasErrors(bean: contract, field: 'contract.claimReason', 'error')} ">
										<label for="claimReason"> <g:message
												code="groupMaster.claimReason.label" default="Claim Reason: " />
						
										</label>
     											<g:secureTextField name="contract.${i}.claimReason"
     											tableName="GROUP_CONTRACT" attributeName="claimReason"
											 value="${contract?.claimReason}"  disabled="true" ></g:secureTextField>											
											
											 <img width="25" height="25" id="claimReasonimg" disabled
									style="float: none; vertical-align: bottom"
									class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
									onclick="lookup('contract.${i}.claimReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'holdReasonType', 'reasonCodeType', null, null)">																							
									</div>
								</td> -->	
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.salespersonName', 'error')} ">
										<label for="salespersonName"> <g:message
												code="groupMaster.salespersonName.label" default="Sales Rep.: " />
										</label>
										<g:secureTextField name="contract.${i}.salespersonName" class="RemoveSpecialChars"
										tableName="GROUP_CONTRACT" attributeName="salespersonName" maxlength="30"
											value="${contract?.salespersonName}" ></g:secureTextField>
									</div>
								</td>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.brokerName', 'error')} ">
										<label for="brokerName"> <g:message
												code="groupMaster.brokerName.label" default="Broker: " />
										</label>
										<g:secureTextField name="contract.${i}.brokerName"
										tableName="GROUP_CONTRACT" attributeName="brokerName"
											value="${contract?.brokerName}" ></g:secureTextField>
									</div>
								</td>
							</tr>							
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2">On Enrolled New Born Processing</td>
							</tr>
							<tr>
								<td colspan="2"><hr></td>
							</tr>
							<tr>
								<td>
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornAgeDays', 'error')} ">
										<label for="newbornAgeDays"> <g:message
												code="groupMaster.newbornAgeDays.label" default="NB Age in Days:" />
										</label>
										<g:secureTextField name="contract.${i}.newbornAgeDays" maxlength="3"
										tableName="GROUP_CONTRACT" attributeName="newbornAgeDays" class="amtNumeric"
										value="${contract?.newbornAgeDays}" ></g:secureTextField>

									</div>
								</td>						
								<!-- <td>
									<div
										class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornProcMthd', 'error')} ">
										<label for="newbornProcMthd"> <g:message
												code="groupMaster.newbornProcMthd.label" default="New Born Proc Method:" />
						
										</label>
										<g:secureTextField name="contract.${i}.newbornProcMthd" 
										tableName="GROUP_CONTRACT" attributeName="newbornProcMthd"
										value="${contract?.newbornProcMthd}" ></g:secureTextField>
									</div>
								</td> -->
								<td>
									<!--<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornProcRsn', 'error')} ">
										<label for="newbornProcRsn"> <g:message
												code="groupMaster.newbornProcRsn.label" default="New Born Proc Reason:" />
										</label>
										<g:secureTextField name="contract.${i}.newbornProcRsn"
										tableName="GROUP_CONTRACT" attributeName="newbornProcRsn"
											value="${contract?.newbornProcRsn}" ></g:secureTextField>
									</div>-->
									<div class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'contract.newbornProcRsn', 'error')} ">
				                           <label for="contract.newbornProcRsn"> <g:message
						                         code="groupMaster.newbornProcRsn.label" default="New Born Proc Reason:" />
				                           </label>
				                           <g:secureTextField name="contract.${i}.newbornProcRsn" maxlength="5"
				                           tableName="GROUP_CONTRACT" attributeName="newbornProcRsn" class="RemoveSpecialChars"
					                           value="${contract?.newbornProcRsn}"></g:secureTextField>			
			                            <input type="hidden" id="reasonCodeTypeHidden" value="HD" />
                                        <img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}" 
                                        onclick="lookup('contract.${ i }.newbornProcRsn','com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'newbornProcRsnType', 'reasonCodeType', null, null)">
			                        </div>
								</td>
							</tr>
							<tr>
								<td>
									<!-- <div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornAutoAdd', 'error')} ">
										<label for="newbornAutoAdd"> <g:message
												code="groupMaster.newbornAutoAdd.label" default="NewBorn Auto Add:" />
						
										</label>
										<g:secureTextField name="contract.${i}.newbornAutoAdd" 
										tableName="GROUP_CONTRACT" attributeName="newbornAutoAdd"
										value="${contract?.newbornAutoAdd}" ></g:secureTextField>

									</div>-->
									<div class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornAutoAdd', 'error')} ">
										<label for="newbornAutoAdd"> <g:message
												code="groupMaster.newbornAutoAdd.label" default="NewBorn Auto Add:" />
						
										</label>
																												
										
										<g:secureComboBox id="contract.${i}.newbornAutoAdd" name="contract.${i}.newbornAutoAdd" style="width: 150px" 
				                                  tableName="GROUP_CONTRACT" attributeName="newbornAutoAdd"
				                                  value="${contract?.newbornAutoAdd}"
				                                  from="${['' : '-- Select Newborn Auto Add --', 'Y': 'Yes' , 'N': 'No']}" optionValue="value" optionKey="key">
                                        </g:secureComboBox>

									</div>
								</td>
							
							<!-- <td>
									<div
										class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornOthContMthd', 'error')} ">
										<label for="newbornOthContMthd"> <g:message
												code="groupMaster.newbornOthContMthd.label" default="Other Contract Method:" />
						
										</label>
										<g:secureTextField name="contract.${i}.newbornOthContMthd" 
										tableName="GROUP_CONTRACT" attributeName="newbornOthContMthd"
										value="${contract?.newbornOthContMthd}" ></g:secureTextField>
									</div>
								</td> -->	
								<td>
									<!-- <div
										class="fieldcontain ${hasErrors(bean: contract, field: 'contract.newbornOthContRsn', 'error')} ">
										<label for="newbornOthContRsn"> <g:message
												code="groupMaster.newbornOthContRsn.label" default="Other Contract Reason:" />
						
										</label>
										<g:secureTextField name="contract.${i}.newbornOthContRsn"
										tableName="GROUP_CONTRACT" attributeName="newbornOthContRsn"
											value="${contract?.newbornOthContRsn}" ></g:secureTextField>
									</div>-->
									<div class="fieldcontain ${hasErrors(bean: groupMasterInstance, field: 'contract.newbornOthContRsn', 'error')} ">
				                           <label for="contract.newbornOthContRsn"> <g:message
						                         code="groupMaster.newbornOthContRsn.label" default="Other Contract Reason:" />
				                           </label>
				                           <g:secureTextField name="contract.${i}.newbornOthContRsn" class="RemoveSpecialChars"
				                          		tableName="GROUP_CONTRACT" attributeName="newbornOthContRsn" maxlength="5"
					                           value="${contract?.newbornOthContRsn}"></g:secureTextField>			
			                            <input type="hidden" id="reasonCodeTypeHidden" value="HD" />
                                        <img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}" 
                                        onclick="lookup('contract.${ i }.newbornOthContRsn','com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'newbornOthContRsnType', 'reasonCodeType', null, null)">
			                        </div>
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2">Claim Dependent/Student Age Information</td>
							</tr>
							<tr>
								<td colspan="2"><hr></td>
							</tr>
				<!-- <tr>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'depAgeLimit', 'error')} ">
								<label for="depAgeLimit"> <g:message
										code="premiumMaster.depAgeLimit.label" default="Depnt Age Limit:" />
								</label>
								<g:textField name="contract.${ i }.depAgeLimit" />
							</div>
						</td>
						<td>
							<div
								class="fieldcontain ${hasErrors(bean: contract, field: 'stuAgeLimit', 'error')} ">
								<label for="stuAgeLimit"> <g:message
										code="premiumMaster.stuAgeLimit.label" default="Stdnt Age Limit:" />
								</label>
								<g:textField name="contract.${ i }.stuAgeLimit"  />
							</div>
						</td>
					</tr>
					 <tr>
						 <td>

							<div
								class="fieldcontain ${hasErrors(bean: contract, field: 'depAgeLimitAction', 'error')} ">
								<label for="depAgeLimitAction"> <g:message
										code="premiumMaster.depAgeLimitAction.label" default="Depnt Age Limit Action:" />
								</label>
								<g:secureDiamondDataWindowDetail columnName="dep_age_limit_action"
								tableName="GROUP_CONTRACT" attributeName="depAgeLimitAction"
												dwName="dw_grupd_de" languageId="0"
												htmlElelmentId="contract.${ i }.depAgeLimitAction"
												defaultValue="${contract?.depAgeLimitAction}"
												blankValue="Depnt Age Limit Action" width="150px"/>	
							</div>
						</td> 
						<td>

							<div
								class="fieldcontain ${hasErrors(bean: contract, field: 'depAgeLimitReason', 'error')} ">
								<label for="depAgeLimitReason"> <g:message
										code="premiumMaster.depAgeLimitReason.label" default="Depnt Age Reason:" />
								</label>
								<input type="hidden" name="holdReasonType" id="holdReasonType" value="HD"/>								
								<g:secureTextField name="contract.${ i }.depAgeLimitReason" 
								tableName="GROUP_CONTRACT" attributeName="depAgeLimitReason"
								value="${contract?.depAgeLimitReason}" ></g:secureTextField>
								<img width="25" height="25"
									style="float: none; vertical-align: bottom"
									class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
									onclick="lookup('contract.${ i }.depAgeLimitReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'holdReasonType', 'reasonCodeType', null, null)">												
							</div>
						</td>
					</tr>-->
					<tr>						
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'depConvOption', 'error')} ">
								<label for="depConvOption"> <g:message
										code="premiumMaster.depConvOption.label" default="Depnt Conversion Option:" />
								</label>
								<g:secureSystemCodeToken
											tableName="GROUP_CONTRACT" attributeName="depConvOption"
											systemCodeType="STDEPCNVOPT" languageId="0"
											htmlElelmentId="contract.${ i }.depConvOption"
											blankValue="Depnt Conv Option" 
											defaultValue="${contract?.depConvOption}" 
											width="150px"></g:secureSystemCodeToken>													
							</div>
						</td>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'depConvAction', 'error')} ">
								<label for="depConvAction"> <g:message
										code="premiumMaster.depConvAction.label" default="Depnt Conversion Action:" />
								</label>
								<g:secureSystemCodeToken
											tableName="GROUP_CONTRACT" attributeName="depConvAction"
											systemCodeType="STDEPCNVACT" languageId="0"
											htmlElelmentId="contract.${ i }.depConvAction"
											blankValue="Depnt Conv Action" 
											defaultValue="${contract?.depConvAction}" 
											width="150px"></g:secureSystemCodeToken>									
							</div>
						</td>
					</tr>
					<!-- <tr>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuAgeLimitAction', 'error')} ">
								<label for="stuAgeLimitAction"> <g:message
										code="premiumMaster.stuAgeLimitAction.label" default="Stdnt Age Limit Action:" />
								</label>
								<g:secureDiamondDataWindowDetail columnName="stu_age_limit_action"
												tableName="GROUP_CONTRACT" attributeName="stuAgeLimitAction"
												dwName="dw_grupd_de" languageId="0"
												htmlElelmentId="contract.${ i }.stuAgeLimitAction"
												defaultValue="${contract?.stuAgeLimitAction}"
												blankValue="Stdnt Age Limit Action" width="150px"></g:secureDiamondDataWindowDetail>	
							</div>
						</td>
						<td>
						 <div class="fieldcontain ${hasErrors(bean: contract, field: 'stuAgeLimitReason', 'error')} ">
								<label for="stuAgeLimitReason"> <g:message
										code="premiumMaster.stuAgeLimitReason.label" default="Stdnt Age Reason:" />
								</label>
								<g:secureTextField name="contract.${ i }.stuAgeLimitReason" 
								tableName="GROUP_CONTRACT" attributeName="stuAgeLimitReason"
								value="${contract?.stuNoVerificationReason}" ></g:secureTextField>
								<img width="25" height="25"
									style="float: none; vertical-align: bottom"
									class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
									onclick="lookup('contract.${ i }.stuAgeLimitReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'holdReasonType', 'reasonCodeType', null, null)">
							</div>
						</td>	
					</tr> -->
					<tr>			
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuAgeLimitAction', 'error')} ">
								<label for="stuAgeLimitAction"> <g:message
										code="premiumMaster.stuAgeLimitAction.label" default="Stdnt Age Limit Action:" />
								</label>
								<g:secureDiamondDataWindowDetail columnName="stu_age_limit_action"
												tableName="GROUP_CONTRACT" attributeName="stuAgeLimitAction"
												dwName="dw_grupd_de" languageId="0"
												htmlElelmentId="contract.${ i }.stuAgeLimitAction"
												defaultValue="${contract?.stuAgeLimitAction}"
												blankValue="Stdnt Age Limit Action" width="150px"
												value="${contract?.stuAgeLimitAction}"></g:secureDiamondDataWindowDetail>
							</div>
						</td>
									
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuConvOption', 'error')} ">
								<label for="stuConvOption"> <g:message
										code="premiumMaster.stuConvOption.label" default="Stdnt Conversion Option:" />
								</label>
								<g:secureSystemCodeToken
											tableName="GROUP_CONTRACT" attributeName="stuConvOption"
											systemCodeType="STDEPCNVOPT" languageId="0"
											htmlElelmentId="contract.${ i }.stuConvOption"
											blankValue="Stdnt Conv Option" 
											defaultValue="${contract?.stuConvOption}" 
											width="150px"></g:secureSystemCodeToken>														
							</div>
						</td>						
					</tr>	
					<tr>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuConvAction', 'error')} ">
								<label for="stuConvAction"> <g:message
										code="premiumMaster.stuConvAction.label" default="Stdnt Conversion Action:" />
								</label>
								<g:secureSystemCodeToken
											tableName="GROUP_CONTRACT" attributeName="stuConvAction"
											systemCodeType="STDEPCNVACT" languageId="0"
											htmlElelmentId="contract.${ i }.stuConvAction"
											blankValue="Stdnt Conv Action" 
											defaultValue="${contract?.stuConvAction}" 
											width="150px"></g:secureSystemCodeToken>								
							</div>
						</td>
						<td></td>
					</tr>		
					<!-- <tr>					
					<td>
						<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuAgeLimitAction', 'error')} ">
								<label for="stuNoVerificationAction"> <g:message
										code="premiumMaster.stuNoVerificationAction.label" default="Stdnt No Verif Age Action:" />
								</label>
								<g:secureDiamondDataWindowDetail columnName="stu_age_limit_action"
												tableName="GROUP_CONTRACT" attributeName="stuNoVerificationAction"
												dwName="dw_grupd_de" languageId="0"
												htmlElelmentId="contract.${ i }.stuNoVerificationAction"
												defaultValue="${contract?.stuNoVerificationAction}"
												blankValue="Stdnt No Verif Age Action" width="150px"></g:secureDiamondDataWindowDetail>
							</div>
						</td> 	
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'stuNoVerificationReason', 'error')} ">
								<label for="stuNoVerificationReason"> <g:message
										code="premiumMaster.stuNoVerificationReason.label" default="Stdnt No Verif Age Reason:" />
								</label>
								<g:secureTextField name="contract.${ i }.stuNoVerificationReason" 
								tableName="GROUP_CONTRACT" attributeName="stuNoVerificationReason"
								value="${contract?.stuNoVerificationReason}" ></g:secureTextField>
								<img width="25" height="25"
									style="float: none; vertical-align: bottom"
									class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
									onclick="lookup('detail.${ i }.stuNoVerificationReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'holdReasonType', 'reasonCodeType', null, null)">							
							</div>
						</td>
					</tr>
					 <tr>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'handcapNoVerfcnAgeAction', 'error')} ">
								<label for="handcapNoVerfcnAgeAction"> <g:message
										code="premiumMaster.handcapNoVerfcnAgeAction.label" default="Handicap No Verif Age Action:" />
								</label>
								<g:getDiamondDataWindowDetail columnName="stu_age_limit_action"
												dwName="dw_grupd_de" languageId="0"
												htmlElelmentId="contract.${ i }.handcapNoVerfcnAgeAction"
												defaultValue="${contract?.handcapNoVerfcnAgeAction}"
												blankValue="Handicap no verif Action" width="150px"/>
							</div>
						</td>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'handcapNoVerfcnAgeReason', 'error')} ">
								<label for="handcapNoVerfcnAgeReason"> <g:message
										code="premiumMaster.handcapNoVerfcnAgeReason.label" default="Handicap No Verif Age Reason:" />
								</label>
								<g:textField name="contract.${ i }.handcapNoVerfcnAgeReason" value="${contract?.stuNoVerificationReason}" />
								<img width="25" height="25"
									style="float: none; vertical-align: bottom"
									class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
									onclick="lookup('contract.${ i }.handcapNoVerfcnAgeReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode', 'holdReasonType', 'reasonCodeType', null, null)">
							</div>
						</td>
					</tr> -->
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2">User Defined Fields</td>
					</tr>
					<tr>
						<td colspan="2"><hr></td>
					</tr>
					<tr>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined1', 'error')} ">
									<label for="userDefined1"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_1_t"
													defaultText="User Defined 1"   />
									</label>
									<g:secureTextField name="contract.${ i }.userDefined1" 
									tableName="GROUP_CONTRACT" attributeName="userDefined1"
									value="${contract?.userDefined1}" ></g:secureTextField>
	
								</div>
						</td>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate1', 'error')} ">
									<label for="userDefined2"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_1_t"
													defaultText="User Date 1"   />
									</label>									
									<g:secureGrailsDatePicker name="contract.${i}.userDate1" precision="day" noSelection="['':'']"
									tableName="GROUP_CONTRACT" attributeName="userDate1"
									value="${contract?.userDate1}" default="none" ></g:secureGrailsDatePicker>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined2', 'error')} ">
									<label for="userDefined2"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_2_t"
													defaultText="User Defined 2"   /> 
									</label>
									<g:secureTextField name="contract.${ i }.userDefined2" 
									tableName="GROUP_CONTRACT" attributeName="userDefined2"
									value="${contract?.userDefined2}" ></g:secureTextField>
	
								</div>
						</td>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate2', 'error')} ">
									<label for="userDefined2"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_2_t"
													defaultText="User Date 2"   /> 
									</label>									
									<g:secureGrailsDatePicker name="contract.${i}.userDate2" precision="day" noSelection="['':'']"
									tableName="GROUP_CONTRACT" attributeName="userDate2"
									value="${contract?.userDate2}" default="none" ></g:secureGrailsDatePicker>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined3', 'error')} ">
									<label for="userDefined3"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_3_t"
													defaultText="User Defined 3"   /> 
									</label>
									<g:secureTextField name="contract.${ i }.userDefined3" 
									tableName="GROUP_CONTRACT" attributeName="userDefined3"
									value="${contract?.userDefined3}" ></g:secureTextField>
	
								</div>
						</td>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate3', 'error')} ">
									<label for="userDefined2"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_3_t"
													defaultText="User Date 3"   /> 
									</label>									
									<g:secureGrailsDatePicker name="contract.${i}.userDate3" precision="day" noSelection="['':'']"
									tableName="GROUP_CONTRACT" attributeName="userDate3"
									value="${contract?.userDate3}" default="none" ></g:secureGrailsDatePicker>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined4', 'error')} ">
									<label for="userDefined4"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_4_t"
													defaultText="User Defined 4"   />
									</label>
									<g:secureTextField name="contract.${ i }.userDefined4" 
									tableName="GROUP_CONTRACT" attributeName="userDefined4"
									value="${contract?.userDefined4}" ></g:secureTextField>
	
								</div>
						</td>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate4', 'error')} ">
									<label for="userDefined2"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_4_t"
													defaultText="User Date 4"   />
									</label>									
									<g:secureGrailsDatePicker name="contract.${i}.userDate4" precision="day" noSelection="['':'']"
									tableName="GROUP_CONTRACT" attributeName="userDate4"
									value="${contract?.userDate4}" default="none" ></g:secureGrailsDatePicker>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined5', 'error')} ">
									<label for="userDefined5"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_5_t"
													defaultText="User Defined 5"   />
													
									</label>
									<g:secureTextField name="contract.${ i }.userDefined5" 
									tableName="GROUP_CONTRACT" attributeName="userDefined5"
									value="${contract?.userDefined5}" ></g:secureTextField>
	
								</div>
						</td>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate5', 'error')} ">
									<label for="userDefined2"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_5_t"
													defaultText="User Date 5"   />
									</label>									
									<g:secureGrailsDatePicker name="contract.${i}.userDate5" precision="day" noSelection="['':'']"
									tableName="GROUP_CONTRACT" attributeName="userDate5"
									value="${contract?.userDate5}" default="none" ></g:secureGrailsDatePicker>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined6', 'error')} ">
									<label for="userDefined6"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_6_t"
													defaultText="User Defined 6"   /> 
									</label>
									<g:secureTextField name="contract.${ i }.userDefined6" 
									tableName="GROUP_CONTRACT" attributeName="userDefined6"
									value="${contract?.userDefined6}" ></g:secureTextField>
	
									</div>
						</td>
						<td>
							<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate6', 'error')} ">
									<label for="userDefined2"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_6_t"
													defaultText="User Date 6"   /> 
									</label>									
									<g:secureGrailsDatePicker name="contract.${i}.userDate6" precision="day" noSelection="['':'']"
									tableName="GROUP_CONTRACT" attributeName="userDate6"
									value="${contract?.userDate6}" default="none" ></g:secureGrailsDatePicker>
							</div>
						</td>
						</tr>
						<tr>
							<td>
								<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined7', 'error')} ">
										<label for="userDefined7"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_defined_7_t" defaultText="User Defined 7"/></label>
										<g:secureTextField name="contract.${ i }.userDefined7" 
										tableName="GROUP_CONTRACT" attributeName="userDefined7"
										value="${contract?.userDefined7}" ></g:secureTextField>
								</div>
							</td>
							<td>
								<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDate7', 'error')} ">
										<label for="userDefined2"> <g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_group_contract_de" userDefineTextName="user_date_7_t" defaultText="User Date 7"/></label>									
										<g:secureGrailsDatePicker name="contract.${i}.userDate7" precision="day" noSelection="['':'']" 
										tableName="GROUP_CONTRACT" attributeName="userDate7"
										value="${contract?.userDate7}" default="none" ></g:secureGrailsDatePicker>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined8', 'error')} ">
										<label for="userDefined8"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_8_t" defaultText="User Defined 8"/></label>
										<g:secureTextField name="contract.${ i }.userDefined8" 
										tableName="GROUP_CONTRACT" attributeName="userDefined8"
										value="${contract?.userDefined8}" ></g:secureTextField>
								</div>
							</td>
							<td>
								<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined9', 'error')} ">
										<label for="userDefined9"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_9_t" defaultText="User Defined 9"/></label>
										<g:secureTextField name="contract.${ i }.userDefined9" 
										tableName="GROUP_CONTRACT" attributeName="userDefined9"
										value="${contract?.userDefined9}" ></g:secureTextField>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="fieldcontain ${hasErrors(bean: contract, field: 'userDefined10', 'error')} ">
										<label for="userDefined10"><g:userDefinedFieldLabel winId="GRUPC" datawindowId ="dw_groupc_user_fields_de" userDefineTextName="user_defined_10_t" defaultText="User Defined 10"/></label>
										<g:secureTextField name="contract.${ i }.userDefined10" 
										tableName="GROUP_CONTRACT" attributeName="userDefined10"
										value="${contract?.userDefined10}" ></g:secureTextField>
								</div>
							</td>
							<td>
								<div>										
								</div>
							</td>
						</tr>
				</table>
				</div>
			</td>
		</tr>
	</g:each>
</table>
<div id="addContractPlaceHolder">
</div>
