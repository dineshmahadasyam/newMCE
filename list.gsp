<!-- UI Selector - fmsUIThemeSelector value is in myEnv.properties -->

<%@ page import="com.dell.diamond.FMSAdminConstants" %>

<g:if test="${grailsApplication.config.fms.ui.theme.selector.equals(FMSAdminConstants.FMS_UI_THEME_SELECTOR_1) || grailsApplication.config.fms.ui.theme.selector.equals(FMSAdminConstants.FMS_UI_THEME_SELECTOR_2)}">
	<g:render template="../agentMaster/layout_${grailsApplication.config.fms.ui.theme.selector}/list" />
</g:if>
<g:else>
	<g:render template="../agentMaster/layout_2/list"/>
</g:else>