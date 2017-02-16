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
	.textFieldl{
		width:100px; 	
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
		//Commenting the below code as it was causing script error. This does need to be called on the Group Contact Page 
		//claimActionCodeDisabled();
		//claimReasonDisabled();
		});
	function cloneRow()
	{

		var divObjSrc = document.getElementById('newContractDiv')
		var divObjDest = document.getElementById('addContractPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addContractButton')
		divObj.style.display = "none"	
	}

	function addGroupContact() {
		var groupId = "${groupMasterInstance?.groupId}";
		var groupDBId = "${groupMasterInstance?.groupDBId}";
		var appName = "${appContext.metadata['app.name']}";
						
		window.location.assign("/"+ appName+"/groupMaintenance/addGroupContact?groupId="
				+ groupId + "&grouEditType=CONTACT&groupDBId="+groupDBId);
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
	</script> 
	 
<script type="text/javascript">
	function deleteButton(seqId){
	    document.getElementById('contactSeqId').value = seqId;
	    return true;
	}
</script>
	  
<%@ page import="com.perotsystems.diamond.dao.cdo.GroupContactPerson" %>
<g:hiddenField name="groupId" value="${groupMasterInstance?.groupId}" />
<g:hiddenField name="groupDBId" value="${groupMasterInstance?.groupDBId}" />

<div id="addContactButton" style="display:block">
	<input class="addButton" type="button" value="Add Contact" onClick="addGroupContact()">
	<br></br>
</div>
Group Contact Records for Group Id (${groupMasterInstance.getGroupId()})
<br></br>
<div style="max-width:1200px; overflow-x:scroll;">
<table border="1" id="report">

	<tr class="head">
		<th>
			Select
		</th>

		<th>
			Contact Name
		</th>
		<th>
			Title
		</th>
		<th>
			Phone Number
		</th>
		<th>
			Phone Extension
		</th>
		<th>
			Email Id
		</th>
		<th>
			Fax Number
		</th>
	</tr>
	<g:hiddenField name="contactSeqId" id="contactSeqId" value="" />
	<g:each in="${groupMasterInstance.contacts}" status="i" var="contact">
		<input type="hidden" name="seq_contact_id_${i}" value="${contact?.seqGroupContact }">
		<input type="hidden" name="contact.${i}.iterationCount" value="${i}">
		
		<tr >
			<td>
				<input type="radio" name="addressId" class="selectradio" value="${contact?.seqGroupContact}">
			</td>
			<td class="clickme" >
				${contact?.contactName}
			</td>
			<td class="clickme">
				${contact?.contactTitle}
			</td>
			<td class="clickme">
				${contact?.phoneNumber}
			</td>
			<td class="clickme">
				${contact?.extension}
			</td>
			<td class="clickme">
				${contact?.emailId}
			</td>
			<td class="clickme">
				${contact?.faxNumber}
			</td>
		</tr>	
		<tr class="hideme">
			<td colspan="13">
				<div class="divContent">
						<table class="report1" border="0">
							<tr>
	
							<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.contactName', 'error')} ">
										<label for="contactName"> <g:message
												code="groupMaster.contactName.label" default="Contact Name :" /><span class="required-indicator">*</span>
						
										</label>
										<g:secureTextField name="contact.${i}.contactName" maxlength="40"
										tableName="GROUP_CONTACT_PERSON" attributeName="contactName"
											value="${contact?.contactName}" ></g:secureTextField>
									</div>
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.contactTitle', 'error')} ">
										<label for="contactTitle"> <g:message
												code="groupMaster.contactTitle.label" default="Title :" />
						
										</label>
										<g:secureTextField name="contact.${i}.contactTitle"
										tableName="GROUP_CONTACT_PERSON" attributeName="contactTitle"
											value="${contact?.contactTitle}" ></g:secureTextField>
												<img width="25" height="25"
												style="float: none; vertical-align: bottom"
												class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
												onclick="lookup('contact.${i}.contactTitle', 'com.perotsystems.diamond.dao.cdo.ContactTitleMaster','contactTitle', 'description', null,  null, null)">
									</div>
								</td>
								</tr>
								<tr>
									<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.phoneNumber', 'error')} "> 
										<label for="phoneNumber"> <g:message
												code="groupMaster.phoneNumber.label" default="Phone Number :" /> <span class="required-indicator">*</span>
						
										</label>
										<g:secureTextField name="contact.${i}.phoneNumber" maxlength="40"
										tableName="GROUP_CONTACT_PERSON" attributeName="phoneNumber"
											value="${contact?.phoneNumber}" ></g:secureTextField>
									</div>
								</td>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.extension', 'error')} ">
										<label for="extension"> <g:message
												code="groupMaster.contactName.label" default="Phone Extension :" />
						
										</label>
										<g:secureTextField name="contact.${i}.extension" maxlength="6"
										tableName="GROUP_CONTACT_PERSON" attributeName="extension"
											value="${contact?.extension}" ></g:secureTextField>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.emailId', 'error')} ">
										<label for="emailId"> <g:message
												code="groupMaster.emailId.label" default="Email Id :" />
						
										</label>
										<g:secureTextField name="contact.${i}.emailId"  maxlength="80"
										tableName="GROUP_CONTACT_PERSON" attributeName="emailId"
											value="${contact?.emailId}" ></g:secureTextField>
									</div>
								</td>
									<td>
									<div
										class="fieldcontain ${hasErrors(bean: contact, field: 'contact.faxNumber', 'error')} ">
										<label for="faxNumber"> <g:message
												code="groupMaster.faxNumber.label" default="Fax Number :" />
						
										</label>
										<g:secureTextField name="contact.${i}.faxNumber" maxlength="20"
										tableName="GROUP_CONTACT_PERSON" attributeName="faxNumber"
											value="${contact?.faxNumber}" ></g:secureTextField>
									</div>
								</td>
							</tr>
						
				</table>	
							
							<g:actionSubmit class="addButton" action="delete" value="Delete"
								onclick="deleteButton(${contact?.seqGroupContact}); return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />			
								
						
				</div>
			</td>
		</tr>
	</g:each>
</table>
</div>
<div id="addContractPlaceHolder">
</div>
