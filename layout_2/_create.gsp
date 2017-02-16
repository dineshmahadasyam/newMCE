<%@ page import="com.dell.diamond.fms.AgentMasterCommand" %>
<!DOCTYPE html>
<html>
	<head>
				<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'agentMaster.label', default: 'Agent')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<style>
		TD
		{
			line-height: 1.4em;
			padding: 0em 0em;
			text-align: left;
			vertical-align: middle;
		}
		.fieldcontain {
			margin-top: 0.1em;
		}
		.fieldcontain LABEL, .fieldcontain .property-label
		{
			width: 25%;
			font-size: 0.8em;
			font-weight:bold;
		}
		</style>
		<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/agentMaster/list"/>')		
		}
		</script>

<meta name="layout" content="main_2">
<g:set var="appContext" bean="grailsApplication"/>	
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>






<script>
$(document).ready(function(){
	<g:if test="${'MASTER'.equals(params.editType)}">
		
	jQuery.validator.addMethod("alphaspecialchar", function(value, element) {
		return this.optional(element) || /^[a-zA-Z0-9-,_. ]+$/i.test(value);
		//return this.optional(element) || /^[a-zA-Z0-9_ ]+$/i.test(value);
		
	}, "Please enter only Letters A through Z and characters dash, comma, hyphen, period.");

	jQuery.validator.addMethod("pinIdDigits", function(value, element) {
		return this.optional(element) || /\d{2}-\d{7}$/.test(value) || /\d{9}$/.test(value)
	}, "Pin Tin must be 9 digits");

	//Add extra validations for effective and term date.
	//New validation method to compare date fields.
	$.validator.addMethod("greaterThan", function(value, element, params) {
		//params[0]-start date field id
		//params[1]-end date field id
		//params[2]-start date field Name in error message
		//params[3]-end date field Name in error message
		//params[4]-form or tab name used to identify the date field id

		var startYear = params[0]+ "_year";
		var startMonth = params[0]+ "_month";
		var startDay = params[0]+ "_day";

		var endYear = params[1]+ "_year";
		var endMonth = params[1]+ "_month";
		var endDay = params[1]+ "_day";

		var startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
		var endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val()) ;

		return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
				&& $(startDay).val().length > 0 && startDate.getTime() <= endDate.getTime()) ;

	}, $.format("{3} must be greater than {2}") );

	  
	jQuery.validator.setDefaults({
		  debug: true,
			ignore: []
		});
    
	$(function() {		
			$("#saveAgent").validate({
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
					'agentId' : {
						 alphaspecialchar  : true,
						 required:true	
					}, 'firstName' : {
						 alphaspecialchar  : true,
						 required:true		
					}, 'middleInitial' : {
						 alphaspecialchar  : true
					}, 'lastName' : {
						 alphaspecialchar  : true,
						 required:true		
					}, 'shortName' : {
						 alphaspecialchar  : true
					}, 'agentType' : {
						 required:true		
					}		
					, 'agencys.agencyId' : {
						 alphaspecialchar  : true,
						 required: {
							 depends: 	function (){
								 var agentTypeId = document.getElementById('agentTypeValue').value;
								 if(agentTypeId=="C"){
											return true;
										} else {
											return false;
								}
							}
					   	}	
					}
					, 'agencys.agencyName' : {
						 alphaspecialchar  : true,
						 required: {
							 depends: 	function (){
								 var agentTypeId = document.getElementById('agentTypeValue').value;
								 if(agentTypeId=="C"){
											return true;
										} else {
											return false;
								}
							}
					   	}	
						 
					},'effectiveDate_day' : {
						required: {
						 depends: 	function (){
							 var agentTypeId = document.getElementById('agentTypeValue').value;
							 if(agentTypeId=="C"){
										return true;
									} else {
										return false;
							}
						}
				   	}		
					},'effectiveDate_month' : {
						required: {
						 depends: 	function (){
							 var agentTypeId = document.getElementById('agentTypeValue').value;
							 if(agentTypeId=="C"){
										return true;
									} else {
										return false;
							}
						}
				   	}		
					},'effectiveDate_year' : {
						required: {
						 depends: 	function (){
							 var agentTypeId = document.getElementById('agentTypeValue').value;
							 if(agentTypeId=="C"){
										return true;
									} else {
										return false;
							}
						}
				   	},greaterThan:[ "#dateOfBirth","#effectiveDate","Date of Birth","Effective Date"]
					},'dateOfBirth_day' :  {
						required : true
					},'dateOfBirth_month' :  {
						required : true
					},'dateOfBirth_year' :  {
						required : true
					},'status' : {
						 alphaspecialchar  : true,
						 required:true		
					},'termDate_year' :  {
					    greaterThan:[ "#effectiveDate","#termDate","Effective Date","Term Date"]							
					},'pinTid' : {
						pinIdDigits : true,
						required: true
			 		},'payType' : {
						required: true
			 		}		
										
			},
				messages : {
					 'agentId' : {
							alphaspecialchar : "Please enter a valid Agent/Broker ID. Letters, Numbers, hyphen and underscore are allowed.",	
						    required : "Agent/Broker ID  is a mandatory field, please input the value for Agent/Broker ID."
						},'firstName' : {
							alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed.",
							required : "First Name  is a mandatory field, please input the value for First Name."
						},'middleInitial' : {
							alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed."
						},'lastName' : {
							alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed.",
							required : "Last Name  is a mandatory field, please input the value for Last Name."
						},'shortName' : {
							alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed."
						},'agentType' : {
							required : "Agent /Broker Type   is a mandatory field, please input the value for Agent /Broker Type."
						},'agencyId' : {
							alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed.",
							required : "Agency ID  is a mandatory field, please input the value for Agency ID."
						},'agencys.agencyName' : {
							alphaspecialchar : "Invalid Format. Only letters, numbers, hyphen, spaces are allowed.",
							required : "Agency Name  is a mandatory field, please input the value for Agency Name."
						},
						'effectiveDate_day' : {
							required : "Effective Date  is a mandatory field, Please enter the Effective Date"
						},
						'effectiveDate_month' : {
							required : "Effective Date  is a mandatory field, Please enter the Effective Month"
						},
						'effectiveDate_year' : {
							required : "Effective Date  is a mandatory field, Please enter the Effective Year",
							greaterThan: "Effective Date must be greater than Date of Birth"	
						},
						'dateOfBirth_day' :  {
							required : "Please enter the Date Of Birth Day"
						},
						'dateOfBirth_month' :  {
							required : "Please enter the Date Of Birth Month"
						},
						'dateOfBirth_year' :  {
							required : "Please enter the Date Of Birth Year"
						},'status' : {
							alphaspecialchar : "Please enter a valid Status. Letters, Numbers, hyphen and underscore are allowed.",	
						    required : "Status is a mandatory field, please input the value for Status."
						},
						'termDate_year' :  {
							greaterThan: "Term Date must be greater than Effective Date."
						},'pinTid' : {
					 	    pinIdDigits : "Pin Tin must be 9 digits.",
					 	    required : "Pin Tin is a mandatory field, please input the value for Pin Tin."
					 	},'payType' : {
					 		required : "Pay Type is a mandatory field, please input the value for Pay Type."
				 		},					
				} 
				 
			})
		});


	$(function($){
		 $("#agentId").alphanum({
				allow 		: '-',
				allowSpace  : false
			});
		   $("#agentType").alphanum({
				allow 		: '-&',
				allowSpace  : true
			});
		   $("#firstName").alphanum({
				allow 		: '-&',
				allowSpace  : true
			});
		   $("#middleInitial").alphanum({
				allow 		: '-&',
				allowSpace  : true
			});
		   $("#lastName").alphanum({
				allow 		: '-&',
				allowSpace  : true
			});
		   $("#shortName").alphanum({
				allow 		: '-&',
				allowSpace  : true
			});
		   $("#agencyId").alphanum({
				allow 		: '-',
				allowSpace  : false
			});

		   $("#agencyName").alphanum({
				allow 		: '-',
				allowSpace  : false
			});
		
	   $(".pinTid").mask("?99-9999999");
	})

	  $('#agentType').change(function () {
		  getAgentType();
       });

	$('#agencyId').blur(function () {
		getAgentName()	
     });
    
	
    

   // CQ#:DIA00058408 Agent Master creation fails when agency id is filled up via Lookup
    $("#agencyId").live("keydown" , function (e) {
      if (e.which == 9)
    	    getAgentName()		
     });		

   //Disable and enable the agency id, agency name, effective date on the bases of agent type value
    var agentTypeId = document.getElementById('agentType');
	agentTypeIdValue = agentTypeId.options[agentTypeId.selectedIndex].value; 
	if(agentTypeIdValue=='I' || agentTypeIdValue==""){
	   document.getElementById("agencyId").disabled = true
	     document.getElementById("idAgencyName").readOnly = true
	     if(document.getElementById("effectiveDate")!=null){			
			document.getElementById("effectiveDate_day").disabled = true;
        	document.getElementById("effectiveDate_month").disabled = true;
        	document.getElementById("effectiveDate_year").disabled = true;
        	document.getElementById("effectiveDate").disabled = true;
	     }  	
	}
	else{
		 document.getElementById("agencyId").disabled = false
			document.getElementById("idAgencyName").disabled = false
			if(document.getElementById("effectiveDate")!=null){			
				document.getElementById("effectiveDate_day").disabled = false;
	       		document.getElementById("effectiveDate_month").disabled = false;
	        	document.getElementById("effectiveDate_year").disabled = false;   
	        	document.getElementById("effectiveDate").disabled = false;  
			}        
	 } 
	 
	</g:if>    
    }); 

 
   function getAgentName() {
		var appName = "${appContext.metadata['app.name']}";		
		var agentTypeId = document.getElementById('agentType');
		agentTypeIdValue = agentTypeId.options[agentTypeId.selectedIndex].value;
		
		var agencyId = document.getElementById('agencyId').value;			        
        var agentId = document.getElementById('agentId').value;		 
			  if(agentTypeIdValue=="C"){
				  	var appName = "${appContext.metadata['app.name']}";
				    		        
					var loggedInUser;
					var loginRequest = jQuery.ajax({
					url : "/"+appName+"/agentMaster/getValidationOnAgentType?agentType="+agentTypeIdValue+"&agencyId="+agencyId+"&agentId="+agentId,
					type : "POST",
					success : function(result) {
						var index = result.indexOf("-")
						var length = result.length
						var idAgencyName = result.substr(0 , index).trim();
						var agencyId = result.substr(index+1 , length).trim();	
						document.getElementById("agencyId").value = agencyId;						
							document.getElementById("idAgencyName").value = idAgencyName;
						
								
					}				
			});
		} 
   }
		function getAgentType() {
	    	 var appName = "${appContext.metadata['app.name']}";
	    	 var agentId = document.getElementById('agentId').value;		
	 		 var agentTypeId = document.getElementById('agentType');
	 		 agentTypeIdValue = agentTypeId.options[agentTypeId.selectedIndex].value;
			 if(agentTypeIdValue=='C'){
				  		document.getElementById("agencyId").value = "";
			            document.getElementById("idAgencyName").value = "";
				            
		            	var loggedInUser;
						var loginRequest = jQuery.ajax({
						url : "/"+appName+"/agentMaster/getValidationOnAgentType?agentType="+agentTypeIdValue+"&agentId="+agentId,
						type : "POST",
						success : function(result) {							
							document.getElementById("agentTypeValue").value = result;
							document.getElementById("agencyId").disabled = false;
			             	document.getElementById("idAgencyName").disabled = false;
			             	//if(document.getElementById("effectiveDate")!=null){
			            	//document.getElementById("effectiveDate").disabled = false;
			            	document.getElementById("effectiveDate_day").disabled = false;
				        	document.getElementById("effectiveDate_month").disabled = false;
				        	document.getElementById("effectiveDate_year").disabled = false;
			             	//}				
						}				
				});  
		 	}
		 		  else{
			 		document.getElementById("agencyId").value = "";
		            document.getElementById("idAgencyName").value = "";
		        	var today = new Date();
		        	var dd = today.getDate();
		        	var mm = today.getMonth()+1; //January is 0!
		        	var yyyy = today.getFullYear();
       				document.getElementById("effectiveDate_day").value = dd;
		        	document.getElementById("effectiveDate_month").value = mm;
		        	document.getElementById("effectiveDate_year").value = yyyy;  
		        	document.getElementById("effectiveDate_day").disabled = true;
		        	document.getElementById("effectiveDate_month").disabled = true;
		        	document.getElementById("effectiveDate_year").disabled = true;
        			var loggedInUser;
					var loginRequest = jQuery.ajax({
					url : "/"+appName+"/agentMaster/getValidationOnAgentType?agentType="+agentTypeIdValue+"&agentId="+agentId,
					type : "POST",
					success : function(result) {
						document.getElementById("agentTypeValue").value = result;
						document.getElementById("agencyId").disabled = true;
			        	document.getElementById("idAgencyName").disabled = true;				
						}				
					});               
				  }
	     }
	  
    function changeAgentIdMessage(){
    	alert ("Changing Agent ID is not allowed.");
    }





</script>

<script>
var grpInnerWindow 
var innerWindowClosed = true;
function closeAllIFrames() {
	if(grpInnerWindow) {
		grpInnerWindow.close()
	}
}

function lookup(idName, cdoClassName, cdoClassAttributeName, assocFieldIds, assocFieldCdoName, updateFields, updateFieldsCdoName) {	
	var agentTypeId = document.getElementById('agentTypeValue').value;
	if(${'MASTER'.equals(params.editType)}){
    if(agentTypeId=='I'){
   	  return false;	    
    }
    }	
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
	var urlValue = "<g:createLinkTo dir="/lookUp/lookUp?htmlElementIdName="/>" + idName
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
</script>
		<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/agentMaster/list"/>')			
		}
		</script>
		
<style>
	div.right-corner {
	    position: absolute;
	    top: 2px;
	    right: 0;
	    margin-right: 40px;
	    font:normal normal 21pt / 1 Tahoma;
	    color: #48802C;
	}
</style>		
	</head>
	<body>
		<a href="#create-agentMaster" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>		
		<div id="create-agentMaster" class="content scaffold-create" role="main">
			<h1 style="color: #48802C"><g:message code="default.create.label" args="[entityName]" /></h1>
			<div class="right-corner" align="center">AGNTM</div>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${errorMessage}">
			<div class="message" role="status">${errorMessage}</div>
			</g:if>
			<g:if test="${fieldErrors}">
			<ul class="errors" role="alert">
				<g:each in="${fieldErrors}" var="error">
					<li>${error}</li>
				</g:each>
			</ul>
			</g:if>
				<g:hasErrors bean="${agentMasterInstance}">
			    <ul class="errors" role="alert">
				<g:eachError bean="${agentMasterInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
		<div id="errorDisplay" style="display: none;" class="errors"
			style="float:left; margin: -5px 10px 0px 0px; "></div>
			<input type="hidden" id="agentTypeValue" value="${agentTypeValue}" />
			<g:form action="save" name="saveAgent" id="saveAgent">			
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="create" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					<div style="align:right;display:inline" >
						<input type="Reset" class="reset" value="Reset" />
						<input type="button" class="close" value="Close" onClick="closeForm()"/>
					</div>
				</fieldset>
			</g:form>
		</div>
		<div style="display:none">
			<input type="button" onClick="closeAllIFrames()" id="closeIframes" name="closeIframes">
		</div>
	</body>
</html>
