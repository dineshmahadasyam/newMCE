<!-- UI Selector - fmsUIThemeSelector value is in fmsEnv.properties -->

<%@ page import="com.dell.diamond.FMSAdminConstants" %>

<g:if test="${grailsApplication.config.fms.ui.theme.selector.equals(FMSAdminConstants.FMS_UI_THEME_SELECTOR_1) || grailsApplication.config.fms.ui.theme.selector.equals(FMSAdminConstants.FMS_UI_THEME_SELECTOR_2)}">
	<g:render template="../groupMaintenance/layout_${grailsApplication.config.fms.ui.theme.selector}/groupCommissionRatesForm" />
</g:if>
<g:else>
	<g:render template="../groupMaintenance/layout_2/groupCommissionRatesForm"/>
</g:else>