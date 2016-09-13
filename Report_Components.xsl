<?xml version="1.0" encoding="utf-8" ?>
<!-- Common Pillar Node FW - Components - By CPN Dev Core Team
	  XXTBDXX : Means To be deleted in next Version -->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<!--xsl:character-map name="no-control-characters">
		<xsl:output-character character="&#127;" string=" "/>
		<xsl:output-character character="&#128;" string=" "/>
		<xsl:output-character character="&#129;" string=" "/>
		<xsl:output-character character="&#130;" string=" "/>
		<xsl:output-character character="&#131;" string=" "/>
		<xsl:output-character character="&#132;" string=" "/>
		<xsl:output-character character="&#133;" string=" "/>
		<xsl:output-character character="&#134;" string=" "/>
		<xsl:output-character character="&#135;" string=" "/>
		<xsl:output-character character="&#136;" string=" "/>
		<xsl:output-character character="&#137;" string=" "/>
		<xsl:output-character character="&#138;" string=" "/>
		<xsl:output-character character="&#139;" string=" "/>
		<xsl:output-character character="&#140;" string=" "/>
		<xsl:output-character character="&#141;" string=" "/>
		<xsl:output-character character="&#142;" string=" "/>
		<xsl:output-character character="&#143;" string=" "/>
		<xsl:output-character character="&#144;" string=" "/>
		<xsl:output-character character="&#145;" string=" "/>
		<xsl:output-character character="&#146;" string=" "/>
		<xsl:output-character character="&#147;" string=" "/>
		<xsl:output-character character="&#148;" string=" "/>
		<xsl:output-character character="&#149;" string=" "/>
		<xsl:output-character character="&#150;" string=" "/>
		<xsl:output-character character="&#151;" string=" "/>
		<xsl:output-character character="&#152;" string=" "/>
		<xsl:output-character character="&#153;" string=" "/>
		<xsl:output-character character="&#154;" string=" "/>
		<xsl:output-character character="&#155;" string=" "/>
		<xsl:output-character character="&#156;" string=" "/>
		<xsl:output-character character="&#157;" string=" "/>
		<xsl:output-character character="&#158;" string=" "/>
		<xsl:output-character character="&#159;" string=" "/>
	</xsl:character-map-->
	
	<!-- Logging 
	==Report_Components==
	* added Template Pivot for Dynamic Pivot Table with Graph but NO Drill-Down
	* Language Default value parameter set on $vLANG for several Templates
	* Added Security Template
	* Removed Script (Agressive Modal) if Language param is missing
	* Moved Template Footer to Node_Config.xsl 
	* Template Layout optimization
	* Queries Used Refactored (Template DBWeb_Decryptor)
	* css pading for search is 0 instead of 4
	* Fixed : Column visibility counter in Template Node_Std_Table
	* Fixed : DataTable type 99	Initialisation in Template Node_Std_Table
	* Fixed : Node Settings are talen into account in Template TNotif
	* Fixed : Error check during Initialisation in Template Node_Std_Table
	==Node_Config==
	* added variable vQUOTE for Security Mechanism
	* vQUOTE is used for vPROFILE Calculation
	* Added param tLOPSource in Template BListOfPrompts/BListOfPromptsNoDataModel ensure possibility for user so select prefered way to visualize Prompting
	* POC and Responsible are now tokenize and YOU Must use quote and coma ... example : 'IBANEZ.C','DUBUS.R' for POC (Security issue) 
	* Added Link to permit easy Debugging in Toolbox (Report)
	==CPN.css==
	* added other colorization of Totals in XTable
	* Visualisation For Column sorting is improved
	* Queries Used Refactored (Template DBWeb_Decryptor)
	==CPN.js==
	* Added function for localstorage View and Reset
	* Added Node for notification
	* Heatmap limited to Crosstab values and NOT ANYMORE Horiz Total
	==Default2==
	in CPN/Extra
	* added DHTMLX Pro Suite and Scheduler (Gantt Soon also be included)
	* added Highligth
	==Miseallenous==
	* Modified : Page Settings now user can select prefered way to visualize Prompting
	* Modified : Page Settings now user can select Pop-up Color to be displayed by color
	* Navbar HomePage is now complete (page width)
	-->
 
<!--**************************************************
	***   			  CPN Templates					**
	**************************************************
	***   	Contains :								**
	***   	- CPN Report All-in-One Report			**
	***   	or 										**
	***   	- Classical CPN Report Page Structure	**
	***   	- Components Used in CPN Reports		**
	************************************************** -->

<!--**********************************************
	***   	CPN Report All-in-One Report		**
	********************************************** -->
	
	<xsl:template name="GenerateReport"> 			<!-- Generate a Report Sample 00 -->
		<xsl:param name="DBWEB_Name" select="'TO_BE_FILLED'"/>	<!-- MANDATORY 		DBWeb Query Name -->
		<xsl:param name="dictionary" select="document('IL_MR_RepDic.xml')"/> 	<!-- MANDATORY   	Dictionary Document (Required for All reports). Per Default and for avoiding errors Main RepDic as Default (Use Individual Report RepDic) -->
		<xsl:param name="UdTN" select="'NADA'"/>				<!-- Unique dT Name (usefull if use several times same DBWEB -->
		<xsl:param name="Lang" select="$vLANG"/>					<!-- Language. Default 'EN'/'FR'/'NL' -->
		<xsl:param name="Node_Conf" select="$vNodeConfig"/>		<!-- Node Configuration. See Template Node_Std_Head for Config -->
		<xsl:param name="dT_Type" select="$vNodedT"/>				<!-- Datatable Configuration. See Template Node_Std_Table for Config -->
		<xsl:param name="Show_Empty" select="'Y'"/>				<!-- Show Result if DBWeb empty (no row) : 'Y' / 'N' -->
		<xsl:param name="Frame" select="'YO'"/>					<!-- Frame Layout. Default YO (YO-FrameOpen/YC-FrameClose/N-NoFrame/NT-NoFrameWith Title) -->
		<xsl:param name="ForcedTitle"/>							<!-- Title Text for Frame  (use concat() to make dynamic Title -->
		<xsl:param name="MaxRecords" select="-1"/> 				<!-- Number exact of rows for Limit Warning (=limit MySQL) -1 don't show number of records found = warning wordt enkel getoond indien SQL-limiet (LIMIT 20) gelijk is aan dit getal -->
		<xsl:param name="NRT" select="$vNodeNRT"/>					<!-- Frame Color. Default 'NRT' (Grey) / 'RT' (Blue) kleur van de balk boven de tabel-->
		<xsl:param name="TableWidth" select="'90%'"/>			<!-- Frame Width, Default '80%' -->
		<xsl:param name="Col_Hidden" select="'None'"/>			<!-- Hide Columns Nbr in dT. Default is 'None' / Example '2,3' -->
		<xsl:param name="Col_Sorting" select="'None'"/>			<!-- Table Sorting on Column Nbr in dT. Default 'None' / Example '1-asc' or '2-desc' -->
		<xsl:param name="Col_Total" select="'None'"/> 			<!-- Include Dynamic Total on Column Nbr None (Default) or Column Number -->
		<xsl:param name="Detail_Data" select="'Generic'"/>  	<!-- Generation of DBWeb Layout. Default 'Generic' / Name of template containing Data -->
		
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
	  	<meta http-equiv="x-ua-compatible" content="IE=EDGE"/>
	  	<meta charset="utf-8"/>
	  	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	  	<meta name="description" content="Bootstrap Sidebar Template for CPN HomePage"/>
	  	<meta name="author" content="Ibanez Crescencio"/>
		    <head>
		      <xsl:call-template name="Node_Std_Head"/><!--@remark ajax calls also load all css files , not necessary ?-->
		      <title>
		        <xsl:call-template name="FromDic2Rep">
		            <xsl:with-param name="Title2S" select="'PAGE_NAME'"/>
		            <xsl:with-param name="tDDConfig" select="'C'"/>
		          </xsl:call-template>
		      </title>
		    </head>
		    <body>
		      <xsl:call-template name="Body_Start"/>
		      <center>
		        <h1>
		          <xsl:call-template name="FromDic2Rep">
		            <xsl:with-param name="Title2S" select="'REPORT_TITLE'"/>
		          </xsl:call-template>
		        </h1>
		      </center>   
		      <br/>
		      <xsl:call-template name="Generic_Table_DBWEB">
		        <xsl:with-param name="DBWEB_Name" select="$DBWEB_Name"/>    <!--  -->
		        <xsl:with-param name="dictionary" select="$dictionary"/> 	<!-- MANDATORY   	Dictionary Document (Required for All reports). Per Default and for avoiding errors Main RepDic as Default (Use Individual Report RepDic) -->
				<xsl:with-param name="UdTN" select="$UdTN"/>				<!-- Unique dT Name (usefull if use several times same DBWEB -->
				<xsl:with-param name="Lang" select="$Lang"/>				<!-- Language. Default 'EN'/'FR'/'NL' -->
				<xsl:with-param name="Show_Empty" select="'Y'"/>			<!-- Show Result if DBWeb empty (no row) : 'Y' / 'N' -->
				<xsl:with-param name="Frame" select="$Frame"/>				<!-- Frame Layout. Default YO (YO-FrameOpen/YC-FrameClose/N-NoFrame/NT-NoFrameWith Title) -->
				<xsl:with-param name="ForcedTitle" select="$ForcedTitle"/>	<!-- Title Text for Frame  (use concat() to make dynamic Title -->
				<xsl:with-param name="MaxRecords" select="$MaxRecords"/> 	<!-- Number exact of rows for Limit Warning (=limit MySQL) -1 don't show number of records found -->
				<xsl:with-param name="NRT" select="$NRT"/>					<!-- Frame Color. Default 'NRT' (Grey) / 'RT' (Blue) -->
				<xsl:with-param name="TableWidth" select="$TableWidth"/>	<!-- Frame Width, Default '80%' -->
				<xsl:with-param name="Col_Hidden" select="$Col_Hidden"/>	<!-- Hide Columns Nbr in dT. Default is 'None' / Example '2,3' -->
				<xsl:with-param name="Col_Sorting" select="$Col_Sorting"/>	<!-- Table Sorting on Column Nbr in dT. Default 'None' / Example '1-asc' or '2-desc' -->
				<xsl:with-param name="Col_Total" select="$Col_Total"/> 		<!-- Include Dynamic Total on Column Nbr None (Default) or Column Number -->
				<xsl:with-param name="Detail_Data" select="$Detail_Data"/>  <!-- Generation of DBWeb Layout. Default 'Generic' / Name of template containing Data -->
		      </xsl:call-template>
		      <xsl:call-template name="Body_End"/>
		    </body>
  		<xsl:text disable-output-escaping='yes'>&lt;/html></xsl:text>
	</xsl:template>

<!--**********************************************
	***   Classical CPN Report Page Structure	**
	********************************************** -->
	
	<xsl:template name="Node_Std_Head"> 			<!-- Std loading of JS/CSS in Report Head -->
		<xsl:param name="Node_Conf" select="$vNodeConfig"/>
			
		<xsl:choose>
			<xsl:when test="$Node_Conf='CPN'">
				<!-- JS and CSS Common Pilar Node -->
					<!-- js -->
						<!-- Jquery -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/jQuery-2.1.4/jquery-2.1.4.min.js"></script>

						<!-- dataTable -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/JSZip-2.5.0/jszip.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/pdfmake-0.1.18/build/pdfmake.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/pdfmake-0.1.18/build/vfs_fonts.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/DataTables-1.10.9/js/jquery.dataTables.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Buttons-1.0.3/js/dataTables.buttons.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Buttons-1.0.3/js/buttons.colVis.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Buttons-1.0.3/js/buttons.flash.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Buttons-1.0.3/js/buttons.html5.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Buttons-1.0.3/js/buttons.print.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/ColReorder-1.2.0/js/dataTables.colReorder.js"></script>
						<!--script type="text/javascript" charset="utf-8" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/ColReorderWithResize/js/ColReorderWithResize.js"></script--> 

						
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Responsive-1.0.7/js/dataTables.responsive.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Scroller-1.3.0/js/dataTables.scroller.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Select-1.0.1/js/dataTables.select.js"></script>
						
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/dataTables_Bootstrap/js/dataTables.bootstrap.js"></script>

						<!-- Bootstrap -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/bootstrap-3.3.5/js/bootstrap.min.js"></script>
						
						<!-- Bootstrap Datepicker -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/datepicker/js/bootstrap-datepicker.js"></script>
						<!-- Bootstrap Validator -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/bootstrap-validator/validator.js"></script>
						<!-- CNP Defense - Allows Backwards compatibilty with FW2 -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/js/CPN.js"></script>
						<!-- Old Scripts but usefull LoadDiv -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/js/local.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/js/overlib.js"></script>
						<!-- Non-intrusive Popup --> 
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/toastr/toastr.js"></script>
						<!-- Enhanced Tooltip System -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/opentip/opentip-jquery.js"></script>
						<!-- Highlight -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/highlight/highlight.pack.js"></script>
						<!-- Graphical Lib - Flot -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/flot/jquery.flot.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/flot/jquery.flot.stack.js"></script>	
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/flot/jquery.flot.time.js"></script>	
						<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/flot/jquery.flot.symbol.js"></script>
						<!-- Modal Popup (To be removed) -->
						<script type="text/javascript" src="/Default2/CPN/extras/mpopup/jquery.magnific-popup.js"></script>
						
						
					<!-- CSS -->
						
						<!-- Bootstrap -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/bootstrap-3.3.5/css/bootstrap.css" />
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/bootstrap-3.3.5/css/bootstrap-theme.css" />
						<!-- DatePicker -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/datepicker/css/bootstrap-datepicker3.css" />
						
						<!-- dataTable -->		
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/dataTables_Bootstrap/css/dataTables.bootstrap.css"/>
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Buttons-1.0.3/css/buttons.dataTables.css"/>
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/ColReorder-1.2.0/css/colReorder.dataTables.css"/>
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Responsive-1.0.7/css/responsive.dataTables.css"/>
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Scroller-1.3.0/css/scroller.dataTables.css"/>
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/DataTables_Pkg/Select-1.0.1/css/select.dataTables.css"/>
						
						<!-- Modal Popup -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/mpopup/magnific-popup.css" media="all"/>
						<!-- Non-intrusive Popup --> 
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/toastr/toastr.css"/>
						<!-- Graphical Lib - Flot -->
						<style>.flot-x-axis {color: #2e92cf;}</style> <!-- To have the chart x-axis labels "anchor blue" -->
						<!-- Enhanced Tooltip System -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/opentip/opentip.css"/>
						<!-- Highlight -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/highlight/default.css"/>
						<!-- CNP Defense - Allows Backwards compatibilty with FW2 -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/css/CPN.css" media="all"/>
						
						<!-- Favicon -->
						<link rel="shortcut icon" type="image/x-icon" href="/{$vHtDocsConfig}/CPN/img/logo/{$vNodeConfig}/favicon.ico" />		
			</xsl:when>
			
			<xsl:when test="$Node_Conf='MRN_Prod'">
				<!-- Call Std Common Node Pilar Head -->
				<xsl:call-template name="Node_Std_Head">
		            <xsl:with-param name="Node_Conf" select="'CPN'" />
		        </xsl:call-template>
				<!-- JS and CSS based on MR Node production-->
					<!-- js -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/MRN_Prod/js/MRN.js"></script>
						
					<!-- CSS -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/MRN_Prod/css/MRN.css" />
						<!-- Colorized NavBar : http://work.smarchal.com/twbscolor/css/e74c3cc0392becf0f1ffbbbc1 -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/MRN_Prod/css/ColorizedNavBar.css" />
				<!-- Add Std KPI Title if KPI -->
				<xsl:if test="$vKPI!='' and $vVKEYD!=''">
					<title>KPI<xsl:value-of select="$vKPI"/> : <xsl:value-of select="$vVKEYD"/></title>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$Node_Conf='MRN_Accept'">
				<!-- Call Std Common Node Pilar Head -->
				<xsl:call-template name="Node_Std_Head">
		            <xsl:with-param name="Node_Conf" select="'CPN'" />
		        </xsl:call-template>
				<!-- JS and CSS based on MR Node production-->
					<!-- js -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/MRN_Prod/js/MRN.js"></script>
						
					<!-- CSS -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/MRN_Prod/css/MRN.css" />
						<!-- Colorized NavBar : http://work.smarchal.com/twbscolor/css/e74c3cc0392becf0f1ffbbbc1 -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/MRN_Accept/css/ColorizedNavBar.css" />
						<!-- Add Pink Color for BackGround -->
						<style>
							body {
								background-color:#F6CEF5;
							}
						</style>
				<!-- Add Std KPI Title if KPI -->
				<xsl:if test="$vKPI!='' and $vVKEYD!=''">
					<title>KPI<xsl:value-of select="$vKPI"/> : <xsl:value-of select="$vVKEYD"/></title>
				</xsl:if>

			</xsl:when>
			<xsl:when test="$Node_Conf='Local'">
				<!-- Call Std Common Node Pilar Head -->
				<xsl:call-template name="Node_Std_Head">
		            <xsl:with-param name="Node_Conf" select="'CPN'" />
		        </xsl:call-template>
				<!-- JS and CSS based on MR Node production-->
					<!-- js -->
						
					<!-- CSS -->
						<!-- Colorized NavBar : http://work.smarchal.com/twbscolor/css/e74c3cc0392becf0f1ffbbbc1 -->
						<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/Local/css/ColorizedNavBar.css" />
					

			</xsl:when>
			<xsl:when test="$Node_Conf='MRN_Basic'">
				<!-- JS and CSS based on version 1 of MR Node -->
					<!-- js -->
						<script type="text/javascript" src="/{$vHtDocsConfig}/js/table.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/js/local.js"></script>
						<script type="text/javascript" src="/{$vHtDocsConfig}/js/overlib.js"></script>
					<!-- CSS -->

					
			</xsl:when><xsl:when test="$Node_Conf='QRNI_Prod'">
				<!-- Call Std Common Node Pilar Head -->
				<xsl:call-template name="Node_Std_Head">
		            <xsl:with-param name="Node_Conf" select="'CPN'" />
		        </xsl:call-template>
				<!-- JS and CSS -->
					<!-- js -->
					<!-- CSS -->
			</xsl:when>
			<xsl:when test="$Node_Conf='OPSN_Prod'">
                <!-- Call Std Common Node Pilar Head -->
                <xsl:call-template name="Node_Std_Head">
                    <xsl:with-param name="Node_Conf" select="'CPN'" />
                </xsl:call-template>
                <!-- JS and CSS -->
                    <!-- js -->
                    <!-- CSS -->
	                    <!-- Colorized NavBar : http://work.smarchal.com/twbscolor/css/e74c3cc0392becf0f1ffbbbc1 -->
	                    <link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/OPSN_Prod/css/ColorizedNavBar.css" />
            </xsl:when>
			<xsl:otherwise>
				<!-- Nada -->	
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Body_Start"> 				<!-- To be placed just after Start Body Tag-->	
		<xsl:param name="tSecType" select="'None'"/> 	<!-- Security Type None per Default -->
		<xsl:param name="tDebug" select="'YES'"/> 		<!-- YES or No (Default) - Depreacated Do Not Use -->
		<xsl:param name="tRepDic" select="'NO'"/> 		<!-- Dictionary ? Type relative Path or No (Default) -->
		<xsl:param name="tLocal" select="'NO'"/> 		<!-- Yes for Local and NO (Default) for MR Node - Depreacated Do Not Use -->
		<xsl:param name="tLanguage" select="$vLANG"/> 		<!-- EN (Default) - English/FR - Français/NL - Nederlands -->
		<!-- Loading GIF -->
		<div style="top:25%" id="wait"  class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" >
		  <div class="modal-dialog modal-sm">
			<div class="modal-content">
				<center>
					<img src="/Default2/CPN/img/HorWait.gif"/><br/>
						Page Loading					
				</center>
			</div>
		  </div>
		</div>
		<script>
		$('#wait').modal();
		</script>
		<!-- Security -->
		<xsl:call-template name="ReportSecurity">
			<xsl:with-param name="tSecType" select="$tSecType"/>
		</xsl:call-template>
		<!-- Classical checks -->
		<xsl:call-template name="Checks"/>

		<!-- Look and Feel -->
		<xsl:choose>
			<!-- Header is ALWAYS Present except if KPI in Explorer mode or Drill-down or Pop-Up -->
			<xsl:when test="//dbquery[1]/descriptor/parameters/param[@name='pMODE']/@value='Drill-Down' or //dbquery[1]/descriptor/parameters/param[@name='pMODE']/@value='Pop-Up' or //dbquery[1]/descriptor/parameters/param[@name='pMODE']/@value='Drill-Down2'">
			<!-- Don't Show Header / Don't Show KPI Toolbar -->
			</xsl:when>
			<!-- KPI value found and Exploring Mode is NO -->
			<xsl:when test="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value and //dbquery[1]/descriptor/parameters/param[@name='pEXPLORE']/@value='NO'">
				<!-- Don't Show Header / Show KPI Toolbar -->
				<xsl:call-template name="KPI_Toolbar">
					<xsl:with-param name="tDebug" select="$tDebug"/>
					<xsl:with-param name="tEXPLORE" select="//dbquery[1]/descriptor/parameters/param[@name='pEXPLORE']/@value"/>
					<xsl:with-param name="tKPI" select="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value"/>
					<xsl:with-param name="tVKEYD" select="//dbquery[1]/descriptor/parameters/param[@name='pVKEYD']/@value"/>
					<xsl:with-param name="tLanguage" select="$tLanguage"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="(//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value and //dbquery[1]/descriptor/parameters/param[@name='pEXPLORE']/@value='YES')">
				<!-- Show Header / Show Title / Show KPI Toolbar -->
				<!-- Bootstrap Navbar CPN1 -->
				<xsl:call-template name="Report_NavBar"/>
				<!-- <to be removed after CNP Roll-Out 
				<xsl:call-template name="Header">
					<xsl:with-param name="tLocal" select="$tLocal"/>
					<xsl:with-param name="tRepDic" select="$tRepDic"/>
					<xsl:with-param name="tLanguage" select="$tLanguage"/>
				</xsl:call-template>
				-->
				<center>
						<h1>
							<xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_denom_en"/> for <xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pVKEYD']/@value"/>
						</h1>
						<h2>
							Exploration of KPI<xsl:value-of select="$vKPI"/>
						</h2>
				</center>
				<!-- Show KPI Toolbar -->
				<xsl:call-template name="KPI_Toolbar">
					<xsl:with-param name="tDebug" select="$tDebug"/>
					<xsl:with-param name="tEXPLORE" select="//dbquery[1]/descriptor/parameters/param[@name='pEXPLORE']/@value"/>
					<xsl:with-param name="tKPI" select="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value"/>
					<xsl:with-param name="tVKEYD" select="//dbquery[1]/descriptor/parameters/param[@name='pVKEYD']/@value"/>
					<xsl:with-param name="tLanguage" select="$tLanguage"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- Show Header ONLY - Normal Calling Report -->
				<!-- Bootstrap Navbar CPN1 -->
				<xsl:call-template name="Report_NavBar"/>
				<!-- <to be removed after CNP Roll-Out 
				<xsl:call-template name="Header">
					<xsl:with-param name="tLocal" select="$tLocal"/>
					<xsl:with-param name="tRepDic" select="$tRepDic"/>
					<xsl:with-param name="tLanguage" select="$tLanguage"/>
				</xsl:call-template>
				-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Body_End"> 					<!-- To be placed just before End Body Tag -->
		<xsl:param name="tDebug" select="'NO'"/> 		<!-- YES or No (Default) - Depreacated Do Not Use -->
		<xsl:param name="tRepDic" select="'NO'"/> 		<!-- Dictionary ? Type relative Path or No (Default) -->
		<xsl:param name="tLocal" select="'NO'"/> 		<!-- Yes for Local and NO (Default) for MR Node - Depreacated Do Not Use -->
		<xsl:param name="tLanguage" select="$vLANG"/> 	<!-- EN (Default) - English/FR - Français/NL - Nederlands -->
		<!-- pop-up wait-->
		<script>$('#wait').modal('hide')</script>
		<!-- Generation of DataDic List-->
		<xsl:variable name="GenRepDicParam" select="distinct-values(//dbquery[1]/descriptor/parameters/param[@name='pINFO']/@value)"/>
		<xsl:if test="contains($GenRepDicParam,'G')">
			<xsl:call-template name="TNotif">
				<xsl:with-param name="tMsg" select="'You have called Report in Data Dictionary Mode. A file will be generated will all Data Dictionary Used in this Report'"/>
				<xsl:with-param name="tTitle" select="'T32 - Data Dictionary Generation'"/> 
				<xsl:with-param name="tType" select="1"/> 	
				<xsl:with-param name="tAppear" select="1000"/>
				<xsl:with-param name="tDuration" select="2000"/>  	
			</xsl:call-template>
			<!-- Lodal Form -->
			<div id="CPN_Generate_DataDic" class="modal modal-wide fade">
		        <div class="modal-dialog">
	            	<!-- Modal content-->
		            <div class="modal-content">	            
			            <div class="modal-header">
	        				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	        				<h4 class="modal-title">Data Dictionary Used in Report</h4>
	      				</div>
	      				<div class="modal-body">
					        <p>
								<center>
									<table class="cell-border" cellpadding="0" cellspacing="0" border="0" width="80%" id="dT_GeneratedDD">
								        <thead>
								        	<tr>
								        		<th>DBWeb</th>
								        		<th>Type</th>
								        		<th>SubType</th>
								        		<th>Mode</th>
								        		<th>Report Id</th>
								        		<th>ILIAS Hint</th>
								        		<th>Field Name</th>
								        		<th>Lang</th>
								        		<th>Caption</th>
								        		<th>PopUp</th>
								        		<th>Show</th>
								        	</tr>
								        </thead>
								        <tbody>
											<xsl:for-each select = "//dbquery[not(@id='Report_Info' or @id='Report_Prompt' or @id='KPI' or @id='DATA_DICTIONARY' or @id='TEMPLATE' or @id='ILIAS_GROUP' or @id='ILIAS_USER' or @id='NODE_SECURITY' or @id='NISM' or @id='USER' or @id='ALL_DATA_DICTIONARY')]/columns/column">
							                	<xsl:variable name="DDField" select="@name"/>
								                <xsl:if test="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField]/@HINT_NO=''">
								                	<tr>
								                		<td><xsl:value-of select="../../@id"/></td>
								                		<td>REPORT</td>
								                		<td>FIELD</td>
														<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='FR']/@MODE"/>
								                		</td>
								                		<td><xsl:value-of select="$vRID"/></td>
														<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='FR']/@HINT_NO"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='FR']/@NAME"/>
								                		</td>
								                		<td>FR</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='FR']/@FIELD_NAME"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='FR']/@HINT"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='FR']/@POPUP"/>
								                		</td>
								                	</tr>
								                	<tr>
								                		<td><xsl:value-of select="../../@id"/></td>
								                		<td>REPORT</td>
								                		<td>FIELD</td>
														<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='NL']/@FIELD_NAME"/>
								                		</td>
								                		<td><xsl:value-of select="$vRID"/></td>
														<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='NL']/@HINT_NO"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='NL']/@MODE"/>
								                		</td>
								                		<td>NL</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='NL']/@FIELD_NAME"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='NL']/@HINT"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='NL']/@POPUP"/>
								                		</td>
								                	</tr>
								                	<tr>
								                		<td><xsl:value-of select="../../@id"/></td>
								                		<td>REPORT</td>
								                		<td>FIELD</td>
														<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='EN']/@FIELD_NAME"/>
								                		</td>
								                		<td><xsl:value-of select="$vRID"/></td>
														<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='EN']/@HINT_NO"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='EN']/@MODE"/>
								                		</td>
								                		<td>EN</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='EN']/@FIELD_NAME"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='EN']/@HINT"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField and @LANG='EN']/@POPUP"/>
								                		</td>
								                	</tr>
								                </xsl:if>
								                <xsl:if test="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField]/@HINT_NO!=''">
								                	<tr>
								                		<td><xsl:value-of select="../../@id"/></td>
								                		<td>REPORT</td>
								                		<td>FIELD</td>
														<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField]/@FIELD_NAME"/>
								                		</td>
								                		<td><xsl:value-of select="$vRID"/></td>
														<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField]/@HINT_NO"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField]/@MODE"/>
								                		</td>
								                		<td>IL</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField]/@FIELD_NAME"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField]/@HINT"/>
								                		</td>
								                		<td>
								                			<xsl:value-of select="//dbquery[@id='ALL_DATA_DICTIONARY']/rows/row[@COLUMN_DATA=$DDField]/@POPUP"/>
								                		</td>
								                	</tr>
								                </xsl:if>
							                </xsl:for-each>		
								        </tbody>
								    </table>
								    <xsl:call-template name="Node_Std_Table">
										<xsl:with-param name="Table_Name" select="'GeneratedDD'"/>
										<xsl:with-param name="dT_Type" select="'99'"/>
										<xsl:with-param name="Records" select="-1"/>
										<xsl:with-param name="Col_Filtering" select="'N'"/>
										<xsl:with-param name="Col_Hidden" select="'0'"/>
										<xsl:with-param name="dT_XLS" select="'Y'"/>		
									</xsl:call-template>
								</center>
					        </p>
					    </div>   
				     	<div class="modal-footer">
	        				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      				</div> 
		            </div>
		        </div>
		    </div>
		</xsl:if>
		
		<xsl:choose>
			<!-- Header is ALWAYS Present except if KPI in Explorer mode or Drill-down -->
			<xsl:when test="//dbquery[1]/descriptor/parameters/param[@name='pMODE']/@value='Drill-Down' or //dbquery[1]/descriptor/parameters/param[@name='pMODE']/@value='Pop-Up' or //dbquery[1]/descriptor/parameters/param[@name='pMODE']/@value='Drill-Down2'">
				<!-- Include this Decryptor for Details if Drill-Down -->
				<xsl:if test="$vMODE='Drill-Down'">
					<xsl:variable name="UQDDD_BL">UQDDD_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pVKEYD']/@value"/>_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value"/></xsl:variable>
					<xsl:call-template name="DBWeb_Decryptor">
						<xsl:with-param name="tUQD" select="$UQDDD_BL"/>
					</xsl:call-template>
				</xsl:if>
				
			</xsl:when>
			<xsl:when test="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value and //dbquery[1]/descriptor/parameters/param[@name='pEXPLORE']/@value='NO'">
				<!-- Don't Show FOOTER / Show END KPI Toolbar -->
				<xsl:variable name="UQD">UQD_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pVKEYD']/@value"/>_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value"/></xsl:variable>
				<xsl:variable name="UDDD">UDDD_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pVKEYD']/@value"/>_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value"/></xsl:variable>
				<!-- Call Query Id Decryptor -->
				<xsl:call-template name="DBWeb_Decryptor">
					<xsl:with-param name="tUQD" select="$UQD"/>
				</xsl:call-template>
				<!-- Call Data Dictionarry Details -->
				<xsl:call-template name="DataDic_Decryptor">
					<xsl:with-param name="tUDDD" select="$UDDD"/>
					<xsl:with-param name="tLanguage" select="$tLanguage"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="(//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value and //dbquery[1]/descriptor/parameters/param[@name='pEXPLORE']/@value='YES')">
				<!-- Show Footer / Show Decryptor and DD -->
				<xsl:variable name="UQD">UQD_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pVKEYD']/@value"/>_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value"/></xsl:variable>
				<xsl:variable name="UDDD">UDDD_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pVKEYD']/@value"/>_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value"/></xsl:variable>
				<!-- Call Query Id Decryptor -->
				<xsl:call-template name="DBWeb_Decryptor">
					<xsl:with-param name="tUQD" select="$UQD"/>
				</xsl:call-template>
				<!-- Call Data Dictionarry Details -->
				<xsl:call-template name="DataDic_Decryptor">
					<xsl:with-param name="tUDDD" select="$UDDD"/>
					<xsl:with-param name="tLanguage" select="$tLanguage"/>
				</xsl:call-template>
				<!-- Call Footer-->
				<xsl:call-template name="Footer">
					<xsl:with-param name="tDebug" select="$tDebug"/> 	
					<xsl:with-param name="tRepDic" select="$tRepDic"/> 
					<xsl:with-param name="tLocal" select="$tLocal"/> 
					<xsl:with-param name="tLanguage" select="$tLanguage"/>
				</xsl:call-template>
				<!-- Show Improve Report Bloc - No more Needed
				<xsl:if test="$tLocal='NO'">
					<xsl:call-template name='Report2Improve'>
						<xsl:with-param name="tRepDic" select="$tRepDic"/>
						<xsl:with-param name="tLocal" select="$tLocal"/>
						<xsl:with-param name="tLanguage" select="$tLanguage"/>
					</xsl:call-template>
				</xsl:if>
				-->
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="UQD">UQD_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pVKEYD']/@value"/>_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value"/></xsl:variable>
				<xsl:variable name="UDDD">UDDD_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pVKEYD']/@value"/>_<xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pKPI']/@value"/></xsl:variable>
				<!-- Call Query Id Decryptor -->
				<xsl:call-template name="DBWeb_Decryptor">
					<xsl:with-param name="tUQD" select="$UQD"/>
				</xsl:call-template>
				<!-- Call Data Dictionarry Details -->
				<xsl:call-template name="DataDic_Decryptor">
					<xsl:with-param name="tUDDD" select="$UDDD"/>
					<xsl:with-param name="tLanguage" select="$tLanguage"/>
				</xsl:call-template>
				<!-- Call Footer ONLY -->
				<xsl:call-template name="Footer">
					<xsl:with-param name="tDebug" select="$tDebug"/> 	
					<xsl:with-param name="tRepDic" select="$tRepDic"/> 
					<xsl:with-param name="tLocal" select="$tLocal"/> 
					<xsl:with-param name="tLanguage" select="$tLanguage"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
<!--**********************************************
	***   	Components Used in CPN Reports		**
	********************************************** -->

	<xsl:template name="Checks"> 					<!-- Several Checks -->
		<!-- Check if Node Settings are defined if no go Message and redirect to Settings -->
			<script>			
				if(localStorage.getItem('<xsl:value-of select="$vNodeConfig"/>_Settings')===null) {
					SettingsInitialize('<xsl:value-of select="$vNodeConfig"/>');
					$.magnificPopup.open({
					 	items: {
				    	  src: '<div class="white-popup"><center><img src="/{$vHtDocsConfig}/CPN/img/logo/{$vNodeConfig}/TextLogo.png"/><h3><u>Welcome on New <xsl:value-of select="$vNodeName"/> Homepage</u></h3></center><br/>A Std Settings Profile with basic settings has been created for you.<br/>A new Window called (Settings @ <xsl:value-of select="$vNodeName"/>) will be opened where you can adapt your Settings (choose the correct language, skin color, Dashboards Links and Favorites).<br/>Don t forget to <u>save</u> your settings to see modifications in <xsl:value-of select="$vNodeName"/> Homepage.<center><br/><xsl:value-of select="$vNodeName"/> Administrators</center></div>',
				      	  type: 'inline'
						  },
						  closeBtnInside: true,
						  closeOnContentClick : false,
						  closeOnBgClick : false,
						  modal : false,
						  callbacks: {
						    close: function() {
							    // Will fire when popup is closed
							    window.open("/LRF/XMLWeb/ProcessDescriptor/descriptor/HOME/Settings.xml","_blank");
						    	}
					    	},
					});
				} else {
					// Retrieve Settings
					var NodeSetArr =JSON.parse(localStorage.getItem('<xsl:value-of select="$vNodeConfig"/>_Settings'));
					//if('<xsl:value-of select="distinct-values(upper-case(//dbquery[1]/descriptor/parameters/param[@name='pcCDN']/@value))"/>'=='') {
					  if('<xsl:value-of select="$vCDN"/>'=='') {
						// Do Nothing because User not Identified
						} else {
						//NodeSetArr.user='<xsl:value-of select="distinct-values(upper-case(//dbquery[1]/descriptor/parameters/param[@name='pcCDN']/@value))"/>';
						NodeSetArr.user='<xsl:value-of select="$vCDN"/>';
						localStorage.setItem('<xsl:value-of select="$vNodeConfig"/>_Settings',JSON.stringify(NodeSetArr));
						};
					};
			</script>
		<!-- Usage Local Storage for Storage of Debug Infos. Initialisation -->
			<script>
				<!-- TO DEBUG - Check if Debug Length is greater that 1000 char. If yes -> Clear 
				if(localStorage.getItem('<xsl:value-of select="$vNodeConfig"/>_Debug').length>1000) {
					localStorage.removeItem('<xsl:value-of select="$vNodeConfig"/>_Debug');
					delete window.localStorage['<xsl:value-of select="$vNodeConfig"/>_Debug'];
					alert('add Notif Debug too big ... cleared')
					};
				localStorage['<xsl:value-of select="$vNodeConfig"/>_Debug'] = "<h2><u>Report Id=<xsl:value-of select="$vRID"/></u></h2>";
				//alert(localStorage.getItem('<xsl:value-of select="$vNodeConfig"/>_Debug'));
				-->
			</script>
		<!-- Check metaData. Only for Pilar Nodes/Can be used on Local Node ... To be tested -->
			<xsl:if test="$vPROFILE!='User'">
				<xsl:choose>
					<xsl:when test="count(//ws-query[@id='METADATA']/ws-rows)=0">
						<xsl:variable name="MMsg" select="'It seems that DBWeb do not contains a MetaData WS. Please use Report Feedback to Report this problem. Thanks. Node Admin.'"/>
						<xsl:variable name="MTitle" select="'T39 - MetaData WebService is Missing'"/>
						<xsl:call-template name="TNotif">
							<xsl:with-param name="tMsg" select="$MMsg"/>
							<xsl:with-param name="tTitle" select="$MTitle"/> 
							<xsl:with-param name="tType" select="4"/> 	
							<xsl:with-param name="tAppear" select="1000"/>
							<xsl:with-param name="tDuration" select="3000"/>  	
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="count(//ws-query[@id='METADATA']/ws-rows/dbquery/error)>0">			
						<xsl:variable name="MMsg">
							<xsl:choose>
								<xsl:when test="count(//ws-query[@id='METADATA']/ws-rows/dbquery/error)>1">Several errors found</xsl:when>
								<xsl:otherwise>One error found</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="MTitle" select="'T40 - MetaData Called but Error(s) found'"/>
						<xsl:call-template name="TNotif">
							<xsl:with-param name="tMsg" select="$MMsg"/>
							<xsl:with-param name="tTitle" select="$MTitle"/> 
							<xsl:with-param name="tType" select="4"/> 	
							<xsl:with-param name="tAppear" select="1000"/>
							<xsl:with-param name="tDuration" select="3000"/>  	
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="count(//ws-query[@id='METADATA']/ws-rows/error)>0">
						<xsl:variable name="MMsg" select="substring(//ws-query[@id='METADATA']/ws-rows/error/cause,0,90)"/>
						<xsl:variable name="MTitle" select="'T41 - MetaData Called but in Error'"/>
						<xsl:call-template name="TNotif">
							<xsl:with-param name="tMsg" select="$MMsg"/>
							<xsl:with-param name="tTitle" select="$MTitle"/> 
							<xsl:with-param name="tType" select="4"/> 	
							<xsl:with-param name="tAppear" select="1000"/>
							<xsl:with-param name="tDuration" select="3000"/>  	
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="MMsg" select="//ws-query[@id='METADATA']/ws-rows/dbquery/@id"/>
						<xsl:variable name="MTitle" select="'T42 - MetaData Correctly Called'"/>
						<xsl:call-template name="TNotif">
							<xsl:with-param name="tMsg" select="$MMsg"/>
							<xsl:with-param name="tTitle" select="$MTitle"/> 
							<xsl:with-param name="tType" select="1"/> 	
							<xsl:with-param name="tAppear" select="1000"/>
							<xsl:with-param name="tDuration" select="3000"/>  	
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		<!-- pRID Missing Notification -->
			<xsl:if test="$vRID='' or not($vRID) or $vRID='0' or //dbquery[@id='Report_Info']/rows/row/@dbn_rep_id=''">
				<xsl:if test="$vKPI='' or not($vKPI)">
					<xsl:call-template name="TNotif">
						<xsl:with-param name="tMsg" select="'Parameter pRID is Missing or Empty'"/>
						<xsl:with-param name="tTitle" select="'T02 - Parameter Problem (pRID)'"/> 
						<xsl:with-param name="tType" select="3"/> 	
						<xsl:with-param name="tAppear" select="1000"/>
						<xsl:with-param name="tDuration" select="3000"/>  	
					</xsl:call-template>
				</xsl:if>	
			</xsl:if>
		<!-- pLANG not correct -->
			<!-- DEPREACATED 2016.0 Check first in URL 
			<script>
				if (document.URL.indexOf("pLANG=FR")==-1 &amp;&amp; document.URL.indexOf("pLANG=NL")==-1 &amp;&amp; document.URL.indexOf("pLANG=EN")==-1) {
					LangMsg='<center><h1>Incorrect Language parameter <small>(pLANG)</small></h1><h2>in your URL</h2></center>Parameter pLANG <u><b>MUST</b></u> be present in your URL and only 3 values are allowed : FR, NL or EN.<br/>Incorrect use of pLANG can cause bad report rendering (Layout).<br/>Possible Cause :<ul><li>Parameter Language not defined in the <a href="/" target="_blank">Node Homepage</a>. Go on Homepage and select language on the Upper Right Part of Homepage</li><li>Bad Link. Modify link or communicate bad link to Report Owner. For Pilar Node contact per EMail <xsl:value-of select="$vWebMaster"/></li></ul>You can also modify link manually<br/>'
					MagPopUp(LangMsg);
				};
			</script>
			-->
			<xsl:if test="not($vLANG='FR' or $vLANG='NL' or $vLANG='EN')">
				<xsl:call-template name="TNotif">
					<xsl:with-param name="tMsg" select="'Parameter pLANG is Missing,Empty or not equal to FR-NL-EN. The Default Value EN has been applied. Please Check.'"/>
					<xsl:with-param name="tTitle" select="'T03 - Parameter Problem (pLANG)'"/> 
					<xsl:with-param name="tType" select="4"/> 	
					<xsl:with-param name="tAppear" select="1000"/>
					<xsl:with-param name="tDuration" select="2000"/>  	
				</xsl:call-template>
			</xsl:if>
		<!-- Check if Language pLANG is FR/NL/EN -->
			<xsl:if test="not(substring(distinct-values(//dbquery[1]/descriptor/parameters/param[@name='pLANG']/@value),1,2)='FR' or substring(distinct-values(//dbquery[1]/descriptor/parameters/param[@name='pLANG']/@value),1,2)='NL' or substring(distinct-values(//dbquery[1]/descriptor/parameters/param[@name='pLANG']/@value),1,2)='EN')">
				<xsl:call-template name="TNotif">
					<xsl:with-param name="tMsg" select="'You have called Redirection page without language parameter. English Language applied. Use correct pLANG parameter in the future ...'"/>
					<xsl:with-param name="tTitle" select="'T28 - Parameter language missing in URL'"/> 
					<xsl:with-param name="tType" select="4"/> 	
					<xsl:with-param name="tAppear" select="1000"/>
					<xsl:with-param name="tDuration" select="2000"/>  	
				</xsl:call-template>
			</xsl:if>
		<!-- Local Report Used throught intranet -->
			<script>
				if (document.URL.indexOf("mrnode")==-1 &amp;&amp; document.URL.indexOf("opsnode")==-1 &amp;&amp; document.URL.indexOf("qrnode")==-1 &amp;&amp; document.URL.indexOf("localhost")==-1) {
					MRNNotif('3','T19 - Using a Local Dev Node ... Be Aware','You are requesting a report on a Local Node. No garanties are provided on data validity',10,"ALL",'<xsl:value-of select="$vNodeConfig"/>');
				};
			</script>
		<!-- Main Notification (For Administrators) only for Direct report (Main) -->
			<xsl:if test="$vMODE='Main' or not($vMODE) or $vMODE=''">
				<!-- Notifications only for Node Admin and Local Node Admin -->
				<xsl:if test="$vPROFILE!='User'">
					<!-- Debug Mode Activated -->
					<xsl:call-template name="TNotif">
						<xsl:with-param name="tMsg" select="'Debugging Mode is Available'"/>
						<xsl:with-param name="tTitle" select="'T01 - Debug Activated'"/> 
						<xsl:with-param name="tType" select="2"/> 	
						<xsl:with-param name="tAppear" select="1000"/>
						<xsl:with-param name="tDuration" select="5000"/> 	
					</xsl:call-template>
					<!-- pMode Check -->
					<xsl:if test="$vMODE='' or not($vMODE)">
						<xsl:call-template name="TNotif">
							<xsl:with-param name="tMsg" select="'Parameter pMODE is Missing or Empty in DBWeb'"/>
							<xsl:with-param name="tTitle" select="'T14 - Parameter Problem (pMODE)'"/> 
							<xsl:with-param name="tType" select="3"/> 	
							<xsl:with-param name="tAppear" select="1000"/>
							<xsl:with-param name="tDuration" select="5000"/> 	
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
				
			</xsl:if>	
		<!-- Report Status Notification -->
			<xsl:choose>
				<!-- Status 8 - Report Replaced -->
				<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_stat='8'">
					<xsl:call-template name="TNotif">
						<xsl:with-param name="tMsg" select="'This Report has been Replaced. Please use the new one.'"/>
						<xsl:with-param name="tTitle" select="'T08 - Report Replaced'"/> 
						<xsl:with-param name="tType" select="3"/> 	
						<xsl:with-param name="tAppear" select="1000"/>
						<xsl:with-param name="tDuration" select="2000"/>  	
					</xsl:call-template>
				</xsl:when>
				<!-- Status 9 - Report Suppressed -->
				<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_stat='9'">
					<xsl:call-template name="TNotif">
						<xsl:with-param name="tMsg" select="'This report has been suppressed. If you need to use this report, contact MR-Mgt (Call EMS) and justify the usage of this report.'"/>
						<xsl:with-param name="tTitle" select="'T09 - Report Suppressed'"/> 
						<xsl:with-param name="tType" select="3"/> 	
						<xsl:with-param name="tAppear" select="1000"/>
						<xsl:with-param name="tDuration" select="2000"/>  	
					</xsl:call-template>
				</xsl:when>
				<!-- Status 10 - Report Disabled -->
				<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_stat='10'">
					<xsl:call-template name="TNotif">
						<xsl:with-param name="tMsg" select="'This Report has been disabled for Performance Reason.'"/>
						<xsl:with-param name="tTitle" select="'T10 - Report Disabled'"/> 
						<xsl:with-param name="tType" select="3"/> 	
						<xsl:with-param name="tAppear" select="1000"/>
						<xsl:with-param name="tDuration" select="2000"/>  	
					</xsl:call-template>
				</xsl:when>
				<!-- Status 11 - Disabled -->
				<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_stat='11'">
					<xsl:call-template name="TNotif">
						<xsl:with-param name="tMsg" select="'This report is disabled. Please contact MR-Mgt if you need to use it by means of an EMS Call.'"/>
						<xsl:with-param name="tTitle" select="'T11 - Report Disabled'"/> 
						<xsl:with-param name="tType" select="3"/> 	
						<xsl:with-param name="tAppear" select="1000"/>
						<xsl:with-param name="tDuration" select="2000"/>  	
					</xsl:call-template>
				</xsl:when>
				<!-- Report in Soon Replaced -->
				<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_accept='109'">
					<xsl:call-template name="TNotif">
						<xsl:with-param name="tMsg" select="'This Report will be soon replaced please test the new version and modify your favorite'"/>
						<xsl:with-param name="tTitle" select="'T12 - Report Soon Replaced'"/> 
						<xsl:with-param name="tType" select="3"/> 	
						<xsl:with-param name="tAppear" select="1000"/>
						<xsl:with-param name="tDuration" select="2000"/>  	
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<!-- Do Nothing -->
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>
	<xsl:template name="ReportSecurity"> 			<!-- Security Mechanism -->
		<xsl:param name="tSecType" select="'None'"/>	<!-- MANDATORY 'None'/'User'/		Security Type -->
		<xsl:param name="tSecOutput" select="'html'"/>	<!-- MANDATORY 'html'/'pdf'/		Security Output -->
		
		<!-- If Security is activated ... Check if URL is matching with RepId Notification only for Main Report -->
			<!-- Retrieve theorical URL -->
			<xsl:if test="$tSecType!='None'">
				<xsl:variable name="vURL" select="distinct-values(//dbquery[@id='Report_Info']/rows/row/@dbn_rep_url)"/>
				<script>
					CheckURL('<xsl:value-of select="$vURL"/>','<xsl:value-of select="$vPROFILE"/>','<xsl:value-of select="$vNodeConfig"/>');
				</script>
			</xsl:if>

		<!-- Security Mechanism -->	
			<xsl:choose>
				<xsl:when test="$tSecType='None'">
			    	<xsl:if test="$vPROFILE!='User'">
				    	<xsl:call-template name="TNotif">
							<xsl:with-param name="tMsg" select="'Report Security has NOT been activated on this Report. If you consider that contents can be sensible, please contact Report Developper or Node Administrator'"/>
							<xsl:with-param name="tTitle" select="'T33 - Security Not Activated'"/> 
							<xsl:with-param name="tType" select="2"/> 	
							<xsl:with-param name="tAppear" select="1000"/>
							<xsl:with-param name="tDuration" select="3000"/>  	
						</xsl:call-template>
					</xsl:if>
			    </xsl:when>
			    <xsl:when test="$tSecType='Contributor'">
			    	<xsl:choose>
						<xsl:when test="$vPROFILE!='User'">
							<xsl:call-template name="TNotif">
								<xsl:with-param name="tMsg" select="'Contributor Report Security has been activated on this Report and you are granted to access this Report.'"/>
								<xsl:with-param name="tTitle" select="'T34 - Contributor Security Activated : Access granted'"/> 
								<xsl:with-param name="tType" select="1"/> 	
								<xsl:with-param name="tAppear" select="1000"/>
								<xsl:with-param name="tDuration" select="3000"/>  
							</xsl:call-template>	
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="TNotif">
								<xsl:with-param name="tMsg" select="'Contributor Report Security has been activated on this Report and you are granted to access this Report.'"/>
								<xsl:with-param name="tTitle" select="'T35 - Security Activated : Access Denied'"/> 
								<xsl:with-param name="tType" select="4"/> 	
								<xsl:with-param name="tAppear" select="1000"/>
								<xsl:with-param name="tDuration" select="3000"/>  
							</xsl:call-template>
							<script>
								$.magnificPopup.open({
								 	items: {
							    	  src: '<div class="white-popup"><center><img src="/Default2/CPN/img/access-denied.jpg" width="200px"/><hr/><h1><u>Report Access Denied</u></h1><h2>You are NOT authorized to consult this report  (Rule:1).</h2><br/><hr/><h2>Please contact <xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_poc"/> for grant.</h2></center><div align="center" id="mTimer"></div></div>',
							      	  type: 'inline'
									  },
									  closeBtnInside: true,
									  closeOnContentClick : false,
									  closeOnBgClick : false,
									  modal : false,
									  callbacks: {
									    open: function() {
										      // Will fire when popup is closed
											  $().html(TimerPopUp(15,'/'),"mTimer"));
									    	},
									    close: function() {
										      // Will fire when popup is closed
										      window.location='/';
									    	}
								    	},
								});
							</script>
						</xsl:otherwise>
					</xsl:choose>
			    </xsl:when>
			    <xsl:when test="$tSecType='ReportDM'">
			    	<xsl:choose>
						<xsl:when test="$vPROFILE!='User' or count(//dbquery[@id='NODE_SECURITY']/rows/row)>0">
							<xsl:call-template name="TNotif">
								<xsl:with-param name="tMsg" select="'DataModel based Report Security has been activated on this Report and you are granted to access this Report.'"/>
								<xsl:with-param name="tTitle" select="'T37 - DataModel based Security Activated : Access granted'"/> 
								<xsl:with-param name="tType" select="1"/> 	
								<xsl:with-param name="tAppear" select="1000"/>
								<xsl:with-param name="tDuration" select="3000"/>  
							</xsl:call-template>	
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="TNotif">
								<xsl:with-param name="tMsg" select="'DataModel based Contributor Report Security has been activated on this Report and you are NOT granted to access this Report.'"/>
								<xsl:with-param name="tTitle" select="'T38 - DataModel based Security Activated : Access Denied'"/> 
								<xsl:with-param name="tType" select="4"/> 	
								<xsl:with-param name="tAppear" select="1000"/>
								<xsl:with-param name="tDuration" select="3000"/>  
							</xsl:call-template>
							<script>
								$.magnificPopup.open({
								 	items: {
							    	  src: '<div class="white-popup"><center><img src="/Default2/CPN/img/access-denied.jpg" width="200px"/><hr/><h1><u>Report Access Denied </u></h1><h2>You are not authorized to consult this report (Rule:2)</h2><br/><hr/><h2>Please contact <xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_poc"/> for grant.</h2></center><div align="center" id="mTimer"></div></div>',
							      	  type: 'inline'
									  },
									  closeBtnInside: true,
									  closeOnContentClick : false,
									  closeOnBgClick : false,
									  modal : false,
									  callbacks: {
									    open: function() {
										      // Will fire when popup is closed
											  $().html(TimerPopUp(15,'/',"mTimer"));
									    	},
									    close: function() {
										      // Will fire when popup is closed
										      window.location='/';
									    	}
								    	},
								});
							</script>
						</xsl:otherwise>
					</xsl:choose>
			    </xsl:when>
			    <xsl:otherwise>
			    	<xsl:call-template name="TNotif">
						<xsl:with-param name="tMsg" select="'Report Security has been activated on this Report but Security Type is unknown. Please contact Report Developper'"/>
						<xsl:with-param name="tTitle" select="'T36 - Security Activated : Unknown Type Code'"/> 
						<xsl:with-param name="tType" select="4"/> 	
						<xsl:with-param name="tAppear" select="1000"/>
						<xsl:with-param name="tDuration" select="3000"/>  	
					</xsl:call-template>
			    </xsl:otherwise>
			</xsl:choose> 
	</xsl:template>
	<xsl:template name="SPE_Feature">				<!-- Special Features -->
		<xsl:param name="FieldVal"/>
		<xsl:choose>
			<xsl:when test="substring($FieldVal,1,7)='MRN_SPE'">
				<xsl:variable name="SPE_Type"><xsl:value-of select="substring($FieldVal,8,2)"/></xsl:variable>
				<xsl:variable name="SPE_Val"><xsl:value-of select="substring-after($FieldVal,'#')"/></xsl:variable>
				<xsl:choose>
					<xsl:when test="$SPE_Type='00'"> <!-- Treat as Html Syntax -->
						<!-- Example : ILIAS="MRN_SPE00#<ul><li>1</li></ul>" donnera du Html pure et donc un bullet -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<!--  Commented out Attribute align left : not usable with MRN_SPE50 (xsl:attribute cannot appear after content) -->
							<!-- <xsl:attribute name="align">Left</xsl:attribute> -->
							<!-- <xsl:copy-of select="substring-after($FieldVal,'#')"/> -->
							
							<script>
								document.write("<xsl:value-of select='$SPE_Val'/>");
							</script>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='01'"> <!-- Link To ILIAS -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:choose>
								<xsl:when test="$vLANG='FR'">
									<a target="ILIAS" href="{$vURL_IOLP}fr&amp;fun={$SPE_Val}"><img src="/{$vHtDocsConfig}/CPN/img/IOLP_FR.png" alt="Aller en ILIAS (Fr) pour voir cet enregistrement" border="0px" width="15px" style="vertical-align:Top"/></a>
								</xsl:when>
								<xsl:when test="$vLANG='NL'">
									<a target="ILIAS" href="{$vURL_IOLP}nl&amp;fun={$SPE_Val}"><img src="/{$vHtDocsConfig}/CPN/img/IOLP_NL.png" alt="Ga na ILIAS Nl om deze record te consulteren" border="0px" width="15px" style="vertical-align:Top"/></a>
								</xsl:when>
								<xsl:otherwise>
									<a target="ILIAS" href="{$vURL_IOLP}en&amp;fun={$SPE_Val}"><img src="/{$vHtDocsConfig}/CPN/img/IOLP_EN.png" alt="See this record in ILIAS En" border="0px" width="15px" style="vertical-align:Top"/></a>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='02'"> <!-- Link To MR Node Report via Redirect -->
						<xsl:variable name="NODEUrl">
							<xsl:value-of select="concat($vNodeRedirect,'?pLANG=',$vLANG,'&amp;pRID=')"/>
						</xsl:variable>
									
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="ValToShow">
								<xsl:value-of select="substring-after($SPE_Val,'#')"/>
							</xsl:variable>
							<xsl:variable name="Report_Param">
								<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<a Title="Click to Open MR Node Report" target="MRNode" href="{$NODEUrl}{$Report_Param}">
								<xsl:value-of select="$ValToShow"/>
							</a>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='03'"> <!-- Field Colorization (*) -->
						<!-- exemple : "MRN_SPE03#04#Y" -->
						<xsl:variable name="ValToShow">
							<xsl:value-of select="substring-after($SPE_Val,'#')"/>
						</xsl:variable>
						<xsl:variable name="MRN_Param">
							<xsl:value-of select="substring-before($SPE_Val,'#')"/>
						</xsl:variable>
						<xsl:attribute name="class">MRNC<xsl:value-of select="$MRN_Param"/></xsl:attribute>
						<xsl:choose>
							<xsl:when test="substring($ValToShow,1,7)='MRN_SPE'">
								<xsl:call-template name="SPE_Feature">
								<xsl:with-param name="FieldVal" select="$ValToShow"/>
							</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$ValToShow"/>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$SPE_Type='04'"> <!-- Field Alignment (*) -->
						<!-- exemple : "MRN_SPE04#L#lkjsqlkjd" -->
						<xsl:variable name="ValToShow" select="substring-after($SPE_Val,'#')"/>
						<xsl:variable name="MRN_Param" select="substring-before($SPE_Val,'#')"/>
						<xsl:choose>
							<xsl:when test="$MRN_Param='L'">
								<xsl:attribute name="align">Left</xsl:attribute>
							</xsl:when>
							<xsl:when test="$MRN_Param='R'">
								<xsl:attribute name="align">Right</xsl:attribute>
							</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="substring($ValToShow,1,7)='MRN_SPE'">
								<xsl:call-template name="SPE_Feature">
									<xsl:with-param name="FieldVal" select="$ValToShow"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$ValToShow"/>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$SPE_Type='05'"> <!-- Drill Down -->
						<!-- exemple : "MRN_SPE05#TAB01_15DI#15DI" -->
						<xsl:attribute name='class'>details-control</xsl:attribute>
						<xsl:variable name="DDCriteria" select="substring-after($SPE_Val,'#')"/>							
						<xsl:variable name="DDidTD" select="substring-before($SPE_Val,'#')"/>
						<xsl:attribute name='id'><xsl:value-of select="translate($DDidTD,'|','')"/></xsl:attribute>
						<xsl:attribute name='crit'><xsl:value-of select="translate($DDCriteria,'|','')"/></xsl:attribute>
					</xsl:when>
					<xsl:when test="$SPE_Type='06'"> <!-- Define Width in % (*) -->
						<!-- exemple : "MRN_SPE06#30#15DI" -->
						<xsl:variable name="ValToShow">
							<xsl:value-of select="substring-after($SPE_Val,'#')"/>
						</xsl:variable>
						<xsl:variable name="MRN_Param">
							<xsl:value-of select="substring-before($SPE_Val,'#')"/>
						</xsl:variable>
						<xsl:attribute name='width'><xsl:value-of select="$MRN_Param"/>%</xsl:attribute>
						<xsl:choose>
							<xsl:when test="substring($ValToShow,1,7)='MRN_SPE'">
								<xsl:call-template name="SPE_Feature">
									<xsl:with-param name="FieldVal" select="$ValToShow"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$ValToShow"/>						
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$SPE_Type='07'"> <!-- 2 Fields on same cell -->
						<!-- exemple : "MRN_SPE07#Value1#value2" --> 
						<xsl:variable name="Value1" select="substring-before($SPE_Val,'#')"/>
						<xsl:variable name="Value2" select="substring-after($SPE_Val,'#')"/>
						<xsl:value-of select="$Value1"/><br/><xsl:value-of select="$Value2"/>
					</xsl:when>
					<xsl:when test="$SPE_Type='08'"> <!-- Hide Cell Content -->
						<!-- exemple : "MRN_SPE08#red#Value1" --> 
						<xsl:variable name="ValToShow" select="substring-after($SPE_Val,'#')"/>						
						<xsl:variable name="MRN_Param" select="substring-before($SPE_Val,'#')"/>
						<xsl:element name="font">
							<xsl:attribute name="color"><xsl:value-of select="$MRN_Param"/></xsl:attribute>		<!--@todo shorthand kan-->	
							<xsl:value-of select="$ValToShow"/>
						</xsl:element>
					</xsl:when>
					<xsl:when test="$SPE_Type='09'"> <!-- Dynamic Pop-Up -->
						<!-- exemple : "MRN_SPE09#TYPE#SUBTYPE#VALUE#CLICKTO#TEXT" --> 
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<!-- Pop-Up Type -->
							<xsl:variable name="Param_1">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="1"/>
									<xsl:with-param name="tLength" select="5"/>
								</xsl:call-template>
							</xsl:variable>
							<!-- Pop-Up SubType -->
							<xsl:variable name="Param_2">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="2"/>
									<xsl:with-param name="tLength" select="5"/>
								</xsl:call-template>
							</xsl:variable>
							<!-- Pop-Up value -->
							<xsl:variable name="Param_3">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="3"/>
									<xsl:with-param name="tLength" select="5"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="POPREP_URL">
								<xsl:choose>
									<!-- Organism -->
									<xsl:when test="$Param_1='01'">http://mrnode.mil.intra/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_I4/IL_MR_I4.xml?pRID=321&amp;pORG=<xsl:value-of select="$Param_3"/></xsl:when>
									<!-- Person -->
									<xsl:when test="$Param_1='02'">http://mrnode.mil.intra/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_I0/IL_MR_I0.xml?pRID=320&amp;pIDENTIFIER=<xsl:value-of select="$Param_3"/>&amp;pTYPE=<xsl:value-of select="$Param_2"/></xsl:when>
									<!-- Lookup -->
									<xsl:when test="$Param_1='03'">http://mrnode.mil.intra/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_LOOKUP/IL_MR_LOOKUP.xml?pRID=322&amp;pTYPE=<xsl:value-of select="$Param_2"/>&amp;pCODE=<xsl:value-of select="$Param_3"/></xsl:when>
									<!-- EMS -->
									<xsl:when test="$Param_1='04'">http://mrnode.mil.intra/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/OT_EMS/OT_EMS.xml?pRID=323&amp;pCALLEMS=<xsl:value-of select="$Param_3"/></xsl:when>
									<!-- NSN -->
									<xsl:when test="$Param_1='05'">http://mrnode.mil.intra/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_I2/IL_MR_I2.xml?pRID=319&amp;pNSN=<xsl:value-of select="$Param_3"/></xsl:when>
									<!-- ASSET -->
									<xsl:when test="$Param_1='06'">http://mrnode.mil.intra/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_I1/IL_MR_I1.xml?pRID=318&amp;pASSET=<xsl:value-of select="$Param_3"/></xsl:when>
									<xsl:otherwise>
										<!-- Undefined -->
									</xsl:otherwise>	
								</xsl:choose>
							</xsl:variable>
							<!-- Click on Report -->
							<xsl:variable name="Param_4">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="4"/>
									<xsl:with-param name="tLength" select="5"/>
								</xsl:call-template>
							</xsl:variable>
							<!-- Text To Display -->
							<xsl:variable name="Param_5">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="5"/>
									<xsl:with-param name="tLength" select="5"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:element name='a'>
								<xsl:choose>
									<xsl:when test="$Param_4='1'">
										<xsl:attribute name='title'>Cursor on Value to See Pop-Up and Click to Open Associated Report</xsl:attribute>
										<xsl:attribute name='href'><xsl:value-of select="$POPREP_URL"/>&amp;pLANG=<xsl:value-of select="$vLANG"/></xsl:attribute>
										<xsl:attribute name='target'>_blank</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name='title'>Cursor on Value to See Pop-Up</xsl:attribute><xsl:attribute name='href'>javascript:void(0);</xsl:attribute>
										<xsl:attribute name='style'>color: #228A06;cursor:help;</xsl:attribute>
									</xsl:otherwise>	
								</xsl:choose>
								<xsl:attribute name='onmouseover'>return showPopup('<xsl:value-of select="$POPREP_URL"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;pMODE=Pop-Up&amp;XXX='+Math.floor(Math.random()*1001),400);</xsl:attribute>	
								<xsl:attribute name='onmouseout'>return nd();</xsl:attribute>
								<xsl:choose>
									<xsl:when test="not($Param_5) or $Param_5!=''">
										<xsl:value-of select="$Param_5"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$Param_3"/>
									</xsl:otherwise>	
								</xsl:choose>
							</xsl:element>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='17'"> <!-- Green/Red Square 1/0 -->
						<!-- Lien Pour afficher un bloc coloré
						exemple : NSN="MRN_SPE17#1#Lettre#Texte à afficher en Pop-Up" -->
							<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="Param_1">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="1"/>
									<xsl:with-param name="tLength" select="3"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="Param_2">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="2"/>
									<xsl:with-param name="tLength" select="3"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="Param_3">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="3"/>
									<xsl:with-param name="tLength" select="3"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:element name='img'>
								<xsl:choose>
									<xsl:when test="number($Param_1)=1">
										<xsl:attribute name='src'>/<xsl:value-of select="$vHtDocsConfig"/>/CPN/img/SPE17_1.png</xsl:attribute>
									</xsl:when>
									<xsl:when test="number($Param_1)=0">
										<xsl:attribute name='src'>/<xsl:value-of select="$vHtDocsConfig"/>/CPN/img/SPE17_0.png</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name='src'>/<xsl:value-of select="$vHtDocsConfig"/>/CPN/img/SPE17_X.png</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:attribute name='width'>17px</xsl:attribute>
								<xsl:if test="$Param_3!=''">
									<xsl:attribute name='title'><xsl:value-of select="$Param_3"/></xsl:attribute>	
								</xsl:if>
								<xsl:attribute name='style'>vertical-align:middle</xsl:attribute>
							</xsl:element>
							<xsl:if test="$Param_2!=''">
								<font color="white"><xsl:value-of select="$Param_2"/></font>
							</xsl:if>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='18'"> <!-- Bloc Lettre -->
						<!-- Lien Pour afficher un bloc coloré
						exemple : NSN="MRN_SPE18#Texte dans lequel on recherchera les lettres" -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:call-template name="Recurse_Image">
							    <xsl:with-param name="num" select="number('1')" />
							    <xsl:with-param name="text" select="$SPE_Val" />
							</xsl:call-template>						
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='20'"> <!-- Create a Link -->
						<!-- MRN_SPE20#Link#Target#Icon#Text# -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="MRN_Param">
								<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<xsl:variable name="URL_1">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="1"/>
									<xsl:with-param name="tLength" select="4"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="URL_2Pre">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="2"/>
									<xsl:with-param name="tLength" select="4"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="URL_2" select="if($URL_2Pre='') then '_blank' else $URL_2Pre"/>
							<xsl:variable name="URL_3">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="3"/>
									<xsl:with-param name="tLength" select="4"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="URL_4">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="4"/>
									<xsl:with-param name="tLength" select="4"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:element name='a'>
								<xsl:attribute name='target'><xsl:value-of select="$URL_2"/></xsl:attribute>
								<xsl:attribute name='href'><xsl:value-of select="translate($URL_1,'|','')"/></xsl:attribute>
								<xsl:choose>
									<!-- No Icon -->
									<xsl:when test="$URL_3=0">
									</xsl:when>
									<!-- MR Node -->
									<xsl:when test="$URL_3=1">
										<xsl:attribute name='title'>MR Node Report</xsl:attribute>
										<xsl:element name='img'>
											<xsl:attribute name='src'>/<xsl:value-of select="$vHtDocsConfig"/>/CPN/img/logo/MRN_Prod/Logo.png</xsl:attribute>
											<xsl:attribute name='height'>17px</xsl:attribute>
											<xsl:attribute name='style'>vertical-align:middle;border:0px</xsl:attribute>
										</xsl:element>CPN
									</xsl:when>
									<!-- QR Node -->
									<xsl:when test="$URL_3=2">
										<xsl:attribute name='title'>QR Node ILIAS Report</xsl:attribute>
										<xsl:element name='img'>
											<xsl:attribute name='src'>/<xsl:value-of select="$vHtDocsConfig"/>/CPN/img/logo/QRNI_Prod/Logo.png</xsl:attribute>
											<xsl:attribute name='height'>17px</xsl:attribute>
											<xsl:attribute name='style'>vertical-align:middle;border:0px</xsl:attribute>
										</xsl:element>
									</xsl:when>
									<!-- OPS Node -->
									<xsl:when test="$URL_3=3">
										<xsl:attribute name='title'>Ops Node Report</xsl:attribute>
										<xsl:element name='img'>
											<xsl:attribute name='src'>/<xsl:value-of select="$vHtDocsConfig"/>/CPN/img/logo/OPSN_Prod/Logo.png</xsl:attribute>
											<xsl:attribute name='height'>17px</xsl:attribute>
											<xsl:attribute name='style'>vertical-align:middle;border:0px</xsl:attribute>
										</xsl:element>
									</xsl:when>
									<!-- CIS Node -->
									<xsl:when test="$URL_3=4">
										<xsl:attribute name='title'>CIS Node Report</xsl:attribute>
										<xsl:element name='img'>
											<xsl:attribute name='src'>/<xsl:value-of select="$vHtDocsConfig"/>/CPN/img/SPE17_X.png</xsl:attribute>
											<xsl:attribute name='height'>17px</xsl:attribute>
											<xsl:attribute name='style'>vertical-align:middle;border:0px</xsl:attribute>
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name='title'>External Report (Other)</xsl:attribute>
										<xsl:element name='img'>
											<xsl:attribute name='src'>/<xsl:value-of select="$vHtDocsConfig"/>/CPN/img/SPE17_X.png</xsl:attribute>
											<xsl:attribute name='height'>17px</xsl:attribute>
											<xsl:attribute name='style'>vertical-align:middle;border:0px</xsl:attribute>
										</xsl:element>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text> </xsl:text> 
								<xsl:value-of select="$URL_4"/>
							</xsl:element>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='21'"> <!-- Add image -->
						<!-- MRN_SPE21#Image Name#Alt#Width#Height#class# -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="MRN_Param">
								<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<xsl:element name='img'>
								<!-- Image name -->
								<xsl:variable name="Img_1">
									<xsl:call-template name="Decode_FDC_MultipleValue">
										<xsl:with-param name="tText" select="$SPE_Val"/>
										<xsl:with-param name="tDelim" select="'#'" />
										<xsl:with-param name="tStart" select="1"/> 
										<xsl:with-param name="tPos" select="1"/>
										<xsl:with-param name="tLength" select="5"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="substring($Img_1,4)!='http'">
										<xsl:attribute name='src'>/{$vHtDocsConfig}/{$vNodeConfig}/img/<xsl:value-of select="$Img_1"/></xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name='src'>"DUMMY_FOR_ERROR.PNG"</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:attribute name='onerror'>this.src='<xsl:value-of select="$Img_1"/>'</xsl:attribute>
								<!-- Alt Text -->
								<xsl:variable name="Img_2">
									<xsl:call-template name="Decode_FDC_MultipleValue">
										<xsl:with-param name="tText" select="$SPE_Val"/>
										<xsl:with-param name="tDelim" select="'#'" />
										<xsl:with-param name="tStart" select="1"/> 
										<xsl:with-param name="tPos" select="2"/>
										<xsl:with-param name="tLength" select="5"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:if test="$Img_2!=''">								
									<xsl:attribute name='title'><xsl:value-of select="$Img_2"/></xsl:attribute>
								</xsl:if>
								<!-- Width -->
								<xsl:variable name="Img_3">
									<xsl:call-template name="Decode_FDC_MultipleValue">
										<xsl:with-param name="tText" select="$SPE_Val"/>
										<xsl:with-param name="tDelim" select="'#'" />
										<xsl:with-param name="tStart" select="1"/> 
										<xsl:with-param name="tPos" select="3"/>
										<xsl:with-param name="tLength" select="5"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:if test="$Img_3!=''">								
									<xsl:attribute name='width'><xsl:value-of select="$Img_3"/></xsl:attribute>
								</xsl:if>
								<!-- height -->
								<xsl:variable name="Img_4">
									<xsl:call-template name="Decode_FDC_MultipleValue">
										<xsl:with-param name="tText" select="$SPE_Val"/>
										<xsl:with-param name="tDelim" select="'#'" />
										<xsl:with-param name="tStart" select="1"/> 
										<xsl:with-param name="tPos" select="4"/>
										<xsl:with-param name="tLength" select="5"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:if test="$Img_4!=''">								
									<xsl:attribute name='height'><xsl:value-of select="$Img_4"/></xsl:attribute>
								</xsl:if>
								<xsl:attribute name='style'>vertical-align:middle;border:0px</xsl:attribute>
								<!-- class -->
								<xsl:variable name="Img_5">
									<xsl:call-template name="Decode_FDC_MultipleValue">
										<xsl:with-param name="tText" select="$SPE_Val"/>
										<xsl:with-param name="tDelim" select="'#'" />
										<xsl:with-param name="tStart" select="1"/> 
										<xsl:with-param name="tPos" select="5"/>
										<xsl:with-param name="tLength" select="5"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:if test="$Img_5!=''">								
									<xsl:attribute name='class'><xsl:value-of select="$Img_5"/></xsl:attribute>
								</xsl:if>
								<!-- Add Misceallenous -->
								<xsl:attribute name='style'>vertical-align:middle;border:0px</xsl:attribute>
							</xsl:element>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='22'"> <!-- Call Template in a Cell -->
						<!-- MRN_SPE22#Param1#Param2#Param3#Param4#Template# -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<!-- Variable_1 -->
							<xsl:variable name="tP1">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="1"/>
									<xsl:with-param name="tLength" select="5"/>
								</xsl:call-template>
							</xsl:variable>
							<!-- Variable_2 -->
							<xsl:variable name="tP2">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="2"/>
									<xsl:with-param name="tLength" select="5"/>
								</xsl:call-template>
							</xsl:variable>
							<!-- Variable_3 -->
							<xsl:variable name="tP3">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="3"/>
									<xsl:with-param name="tLength" select="5"/>
								</xsl:call-template>
							</xsl:variable>
							<!-- Variable_4 -->
							<xsl:variable name="tP4">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="4"/>
									<xsl:with-param name="tLength" select="5"/>
								</xsl:call-template>
							</xsl:variable>
							<!-- Variable_Template -->
							<xsl:variable name="tTemplate">
								<xsl:call-template name="Decode_FDC_MultipleValue">
									<xsl:with-param name="tText" select="$SPE_Val"/>
									<xsl:with-param name="tDelim" select="'#'" />
									<xsl:with-param name="tStart" select="1"/> 
									<xsl:with-param name="tPos" select="5"/>
									<xsl:with-param name="tLength" select="5"/>
								</xsl:call-template>
							</xsl:variable>
							<!-- Call Template Row Based -->
							<xsl:if test="$tTemplate!=''">								
								<xsl:apply-templates select="//dbquery[@id='TEMPLATE']/rows">		
									<xsl:with-param name="tPD1" select="translate($tP1,'|','')"/>
									<xsl:with-param name="tPD2" select="translate($tP2,'|','')"/>
									<xsl:with-param name="tPD3" select="translate($tP3,'|','')"/>
									<xsl:with-param name="tPD4" select="translate($tP4,'|','')"/>
									<xsl:with-param name="Detail_Data" select="$tTemplate"/>
								</xsl:apply-templates>
							</xsl:if>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='23'"> <!-- Text Parser -->
						<!-- exemple : "MRN_SPE23#Value1(What)#value2(in)" --> 
						<xsl:variable name="Value1" select="concat(substring-before($SPE_Val,'#'),':')"/>
						<xsl:variable name="Value2" select="substring-after($SPE_Val,'#')"/>
						<xsl:value-of select="substring-before(substring-after(../@*[local-name() = $Value2],$Value1),'=====')"/>
					</xsl:when>
					<xsl:when test="$SPE_Type='50'"> <!-- Combine multiple special features -->
						<!-- multiple special features on a Cell 
						exemple : "MRN_SPE50#SPE1;SPE2;SPE3;SPE..." -->					
						<xsl:for-each select="distinct-values(tokenize($SPE_Val,';'))">
							<xsl:variable name="ValToShow"><xsl:value-of select="."/></xsl:variable>						
							<xsl:call-template name="SPE_Feature"><xsl:with-param name="FieldVal" select="$ValToShow"/></xsl:call-template>
						</xsl:for-each>					
					</xsl:when>		
					<xsl:when test="$SPE_Type='51'"> <!-- Format number - Belgian format -->
						<!-- multiple special features on a Cell 
						exemple : "MRN_SPE51#Number to format" -->				
						<xsl:variable name="Value">
							<xsl:choose>
								<xsl:when test="not($SPE_Val)"><xsl:value-of select='format-number(0,"#.##0,00","Fmt_Curr_Euro")'/></xsl:when>
								<xsl:when test="$SPE_Val = '' "><xsl:value-of select='format-number(0,"#.##0,00","Fmt_Curr_Euro")'/></xsl:when>
								<xsl:otherwise><xsl:value-of select='format-number($SPE_Val,"#.##0,00","Fmt_Curr_Euro")'/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:value-of select="$Value"/>										
					</xsl:when>
					
					<!--**********************************************
						***   	DEPREACATED DO NOT USE ANYMORE		**
						********************************************** -->
					
					<xsl:when test="$SPE_Type='10'"> <!-- Depreacated (Linked to SPE09) - PopUp LookUp Code -->
						<!-- Lien Pour ouvrir un PopUp LLOOK Rapport de MR Node
						exemple : 
							LABEL=Feature Code 10#Code du TYPE#Valeur à décoder et valeur à montrer 
							ASSET="MRN_SPE10#TT#CH001" utiliser des | pour empecher le paramêtre d'être utilisé -->
						
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="ValToShow">
								<xsl:value-of select="substring-after($SPE_Val,'#')"/>
							</xsl:variable>
							<xsl:variable name="MRN_Param">
								<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<!-- Use SPE09	-->
							<xsl:call-template name="SPE_Feature">
								<xsl:with-param name="FieldVal" select="concat('MRN_SPE09#03#',$MRN_Param,'#',$ValToShow,'#0#',$ValToShow)"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='11'"> <!-- Depreacated (Linked to SPE09) - PopUp Org Code -->
						<!-- Lien Pour ouvrir un PopUp Organism Rapport de MR Node
						exemple : 
							LABEL=Feature Code 11#Valeur à décoder et valeur à montrer 
							ORG="MRN_SPE10#10DI" utiliser des | pour empecher le paramêtre d'être utilisé -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
						<xsl:variable name="ValToShow">
								<xsl:value-of select="substring-after($SPE_Val,'#')"/>
							</xsl:variable>
							<xsl:variable name="MRN_Param">
								<xsl:choose>
									<xsl:when test="$SPE_Val=''">
										<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$SPE_Val"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<!-- Use SPE09	-->
							<xsl:call-template name="SPE_Feature">
								<xsl:with-param name="FieldVal" select="concat('MRN_SPE09#01##',$ValToShow,'#1#',$ValToShow)"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='12'"> <!-- Depreacated (Linked to SPE09) - PopUp User -->
						<!-- Lien Pour ouvrir un PopUp User Rapport de MR Node
						exemple : 
							LABEL=Feature Code 12#Valeur du ID du user 
							USER="MRN_SPE10#123456" utiliser des | pour empecher le paramêtre d'être utilisé -->			
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="ValToShow">
								<xsl:value-of select="substring-after($SPE_Val,'#')"/>
							</xsl:variable>
							<xsl:variable name="MRN_Param">
								<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<!-- Use SPE09	-->
							<xsl:choose>
								<xsl:when test="$MRN_Param='1'">
									<xsl:call-template name="SPE_Feature">
										<xsl:with-param name="FieldVal" select="concat('MRN_SPE09#02#01#',$ValToShow,'#1#',$ValToShow)"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="$MRN_Param='2'">
									<xsl:call-template name="SPE_Feature">
										<xsl:with-param name="FieldVal" select="concat('MRN_SPE09#02#02#',$ValToShow,'#1#',$ValToShow)"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="$MRN_Param='3'">
									<xsl:call-template name="SPE_Feature">
										<xsl:with-param name="FieldVal" select="concat('MRN_SPE09#02#03#',$ValToShow,'#1#',$ValToShow)"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									Bad SPE Formating (<xsl:value-of select="$MRN_Param"/>)
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='13'"> <!-- Depreacated (Linked to SPE09) - PopUp NSN Small Image (Not Yet Implemented) -->
						<!-- Lien Pour ouvrir un PopUp Image (Small) pour un NSN avec Indication présence d'une image 
						exemple : NSN="MRN_SPE13#1234-12-123-1234" -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="MRN_Param">
								<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<xsl:variable name="MRN_Value">
								<xsl:value-of select="translate(substring-after($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<!-- Use SPE09	-->
							<xsl:call-template name="SPE_Feature">
								<xsl:with-param name="FieldVal" select="concat('MRN_SPE09#05##',$MRN_Param,'#1#',$MRN_Param)"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='14'"> <!-- Depreacated (Linked to SPE09) - PopUp NSN Big Image -->
						<!-- Lien Pour ouvrir un PopUp Image (Big) pour un NSN avec Indication présence d'une image 
						exemple : NSN="MRN_SPE14#1234-12-123-1234" -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="MRN_Param">
								<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<xsl:variable name="MRN_Value">
								<xsl:value-of select="translate(substring-after($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<!-- Use SPE09	-->
							<xsl:call-template name="SPE_Feature">
								<xsl:with-param name="FieldVal" select="concat('MRN_SPE09#05##',$MRN_Param,'#1#',$MRN_Param)"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='15'"> <!-- Depreacated (Linked to SPE09) - PopUp ASSET Small Image (Not Yet Implemented) -->
						<!-- Lien Pour ouvrir un PopUp Image (Small) pour un NSN avec Indication présence d'une image 
						exemple : NSN="MRN_SPE13#1234-12-123-1234" -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="MRN_Param">
								<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<xsl:variable name="MRN_Value">
								<xsl:value-of select="translate(substring-after($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<!-- Use SPE09	-->
							<xsl:call-template name="SPE_Feature">
								<xsl:with-param name="FieldVal" select="concat('MRN_SPE09#06##',$MRN_Param,'#1#',$MRN_Param)"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$SPE_Type='16'"> <!-- Depreacated (Linked to SPE09) - PopUp ASSET Big Image (4) -->
						<!-- Lien Pour ouvrir un PopUp Image (Big) pour un NSN avec Indication présence d'une image 
						exemple : NSN="MRN_SPE16#FA211" -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="MRN_Param">
								<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<xsl:variable name="MRN_Value">
								<xsl:value-of select="translate(substring-after($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<!-- Use SPE09	-->
							<xsl:call-template name="SPE_Feature">
								<xsl:with-param name="FieldVal" select="concat('MRN_SPE09#06##',$MRN_Param,'#1#',$MRN_Param)"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>	
					<xsl:when test="$SPE_Type='19'"> <!-- Depreacated (Linked to SPE09) - PopUp EMS -->
						<!-- Lien Pour ouvrir un PopUp EMS et via un click ouvrir le rapport EMS -->
						<xsl:if test="not($SPE_Val) or $SPE_Val!=''">
							<xsl:variable name="MRN_Param">
								<xsl:value-of select="translate(substring-before($SPE_Val,'#'),'|','')"/>
							</xsl:variable>
							<!-- Use SPE09	-->
							<xsl:call-template name="SPE_Feature">
								<xsl:with-param name="FieldVal" select="concat('MRN_SPE09#04##',$MRN_Param,'#1#',$MRN_Param)"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>				
					<xsl:otherwise>
						?Special?
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$FieldVal"/>
				<!-- Comment from MC -->
				<!--xsl:copy>
					<xsl:apply-templates select="node()|@*"/>
				</xsl:copy-->
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>
	<xsl:template match="@*" mode="genericTableCel">	<!-- Special Feature outside SQL: Usage is xsl:template match="node()|@*" mode="genericTableCel" From MC (Claerhout) -->		
		<td align="center">		
			<xsl:choose>
				<xsl:when test="starts-with(.,'MRN_SPE')">
					<xsl:call-template name="SPE_Feature">
						<xsl:with-param name="FieldVal" select="."/>
					</xsl:call-template>
				</xsl:when>				
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</xsl:template>
	<xsl:template name="Generic_Table_DBWEB"> 		<!-- Generation of BS Frame with Content (Generic or Not) -->
		<xsl:param name="DBWEB_Name" select="'TO_BE_FILLED'"/>	<!-- MANDATORY 		DBWeb Query id-attribute  -->
		<xsl:param name="dictionary" select="document('IL_MR_RepDic.xml')"/> 	
																<!-- MANDATORY   	Dictionary Document (Required for All reports). Per Default and for avoiding errors Main RepDic as Default (Use Individual Report RepDic) -->
		
		<xsl:param name="UdTN" select="'NADA'"/>				<!-- Unique dT Name (usefull if use several times same DBWEB -->
		<xsl:param name="RepDic" select="'Y'"/>					<!-- Use of Report Dictionnary. Default 'Y' / 'N' / 'C' (C for Caption Only/Y for Caption AND Popup / WARNING : Filtering problem when using N) -->
		<xsl:param name="Lang" select="$vLANG"/>					<!-- Language. Default 'EN'/'FR'/'NL' -->
		<xsl:param name="Node_Conf" select="$vNodeConfig"/>		<!-- Node Configuration. See Template Node_Std_Head for Config -->
		<xsl:param name="dT_Type" select="$vNodedT"/>				<!-- Datatable Configuration. See Template Node_Std_Table for Config -->
		<xsl:param name="Show_Empty" select="'Y'"/>				<!-- Show Result if DBWeb empty (no row) : 'Y' / 'N' -->
		<xsl:param name="Frame" select="'YO'"/>					<!-- Frame Layout. Default YO (YO-FrameOpen/YC-FrameClose/N-NoFrame/NT-NoFrameWith Title) -->
		<xsl:param name="ForcedTitle"/>							<!-- Title Text for Frame  (use concat() to make dynamic Title -->
		<xsl:param name="MaxRecords" select="-1"/> 				<!-- Number exact of rows for Limit Warning (=limit MySQL) -1 don't show number of records found -->
		<xsl:param name="NRT" select="$vNodeNRT"/>					<!-- Frame Color. Default 'NRT' (Grey) / 'RT' (Blue) -->
		<xsl:param name="TableWidth" select="'90%'"/>			<!-- Frame Width, Default '80%' -->
		<xsl:param name="ForceFooter" select="'Y'"/> 			<!-- Force Footer (because disabled with dT_Type=99 and less than 20 records). This footer allows Total calculation (Col_Total) and Individual Column Filtering (Col_Filtering). N (Default) or Y -->
		<xsl:param name="Col_Hidden" select="'None'"/>			<!-- Hide Columns Nbr in dT. Default is 'None' / Example '2,3' -->
		<xsl:param name="Col_Sorting" select="'None'"/>			<!-- Table Sorting on Column Nbr in dT. Default 'None' / Example '1-asc' or '2-desc' tot nu toe is slechts 1 mogelijk, maakt order by niet nodig in DB, wordt lokaal bewaard -->
		<xsl:param name="Alphabet" select="'None'"/> 			<!-- DEPREACATED - Include Alphabetic Summary Filtering None (Default) or Column Number -->
		<xsl:param name="Col_Filtering" select="'Y'"/> 			 <!--Include on ALL Column Filtering None (Default) or Y -->
		<xsl:param name="Col_Total" select="'None'"/> 			<!-- Include Dynamic Total on Column Nbr None (Default) or Column Number -->
		<xsl:param name="TableClass" select="'cell-border'"/>	<!-- Table Class for Table Frame, Default 'cell-border'/'Display' -->
		<xsl:param name="TableDetClass" select="'cell-border'"/><!-- Table Class for Table Detail, Default 'cell-border'/'Display' -->
		<xsl:param name="Detail_Data" select="'Generic'"/>  	<!-- Generation of DBWeb Layout. Default 'Generic' / Name of template containing Data -->
		<xsl:param name="dT_Info" select="'Y'"/>				<!-- Allows Info on Filtering  -->	
		<xsl:param name="dT_Buttons" select="'Y'"/>				<!-- Show Buttons  -->	
		<xsl:param name="dT_Col_Order" select="'Y'"/>			<!-- Allows Ordering Asc/Desc  -->	
		<xsl:param name="dT_Filter" select="'Y'"/>				<!-- Allows Global Filtering  -->	
		<xsl:param name="dT_Paging" select="$vNodedTPaging"/>	<!-- Allows Paging -->	
		<xsl:param name="dT_XLS" select="$vNodedTXLS"/>			<!-- Allows XLS Export of dT -->	
		<xsl:param name="dT_PDF" select="$vNodedTPDF"/>			<!-- Allows pdf Export of dT -->	
		<xsl:param name="dT_Print" select="'Y'"/>				<!-- Allows Print of dT -->	
		<xsl:param name="DDURL" select="'N'"/>					<!-- Drill-Down URL. Default 'N'. Must be used in combination of MRNSPE05. You must mention here the URL for Drill-Down. This URL ends with the value of MRNSPE05 which provides the interrogation key. CAUTION the parameter PLANG is automatically added and the pMODE=Drill-Down2 also. Example : 'IL_MR_SAMPLE05.xml?pRID=24&amp;pASSET=' -->
		<xsl:param name="dT_HeatMap" select="'N'"/>				<!-- Show heatmap button -->
		
		<xsl:variable name="RecFound" select="count(//dbquery[@id=$DBWEB_Name]/rows/row)"/>
		<xsl:variable name="UniqdTN">
			<xsl:choose>
				<xsl:when test="$UdTN='NADA'">
					<xsl:value-of select="translate(normalize-space($DBWEB_Name),' ','')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate(normalize-space($UdTN),' ','')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
		<!-- Show -->
		<xsl:if test="not($Show_Empty='N' and $RecFound=0 and count(//dbquery[@id=$DBWEB_Name]/error)=0)">
			<xsl:choose>
				<!-- Use Frame (Block Query) -->
				<xsl:when test="substring($Frame,1,1)='Y'">
					<!-- XXTBDXX by MIB : Localstorage Viewer 
					<script>
						function dTLocalStorage(dTid) {
							var keyValue = localStorage.getItem(dTid);
							alert(dTid+' : '+keyValue)
						}
					</script>
					-->
					
					<!-- BootStrap Navigation Block -->
					<center>
						<div style="width:95%">
							<nav role="navigation">
								<xsl:attribute name="class">
									<xsl:choose>
										<xsl:when test="count(//dbquery[@id=$DBWEB_Name]/error)=1">navbar-BRMRN-ERR</xsl:when>
										<xsl:when test="$NRT='RT'">navbar-BRMRN-RT</xsl:when>
										<!-- Used ? -->
										<xsl:when test="$NRT='KPI'">navbar-BRMRN-KPI</xsl:when>
										<xsl:otherwise>navbar-BRMRN</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>	
								<div class="container-fluid">
									<!-- Brand and toggle get grouped for better mobile display -->
									<div class="navbar-header">
										<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
											<span class="sr-only">Toggle navigation</span>
											<span class="icon-bar"></span>
											<span class="icon-bar"></span>
											<span class="icon-bar"></span>
										</button>
									</div>

									<!-- Collect the nav links, forms, and other content for toggling -->
									<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
										<ul class="nav navbar-nav">
											<li class="active">
												<a href="#!">
													<xsl:attribute name="onclick">if(GT_<xsl:value-of select="$UniqdTN"/>.style.display=='none'){$('#GT_<xsl:value-of select="$UniqdTN"/>').slideDown('1000');$("#S<xsl:value-of select="$UniqdTN"/>").attr('class', 'glyphicon glyphicon-triangle-top');} else {$('#GT_<xsl:value-of select="$UniqdTN"/>').slideUp('1000');$("#S<xsl:value-of select="$UniqdTN"/>").attr('class', 'glyphicon glyphicon-triangle-bottom');}</xsl:attribute>
													<xsl:if test="substring($Frame,2,1)='O'">
														<span id="S{$UniqdTN}" class="glyphicon glyphicon-triangle-top" aria-hidden="true"></span>
													</xsl:if>
													<xsl:if test="substring($Frame,2,1)='C'">
														<span id="S{$UniqdTN}" class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"></span>
													</xsl:if>
												</a>
											</li>
										</ul>
										<p class="navbar-text">
											<xsl:choose>
												<xsl:when test="$ForcedTitle!='' and $RepDic='Y'">
													<!-- Forced Title -->
													<xsl:call-template name="FromDic2Rep">
														<xsl:with-param name="Title2S" select="$ForcedTitle"/>
														<xsl:with-param name="Lang" select="$Lang"/>
														<xsl:with-param name="dictionary" select="$dictionary"/>
													</xsl:call-template>
												</xsl:when>
												<!-- Caption Force Title with DD -->
												<xsl:when test="$ForcedTitle!='' and $RepDic='C'">
													<xsl:call-template name="FromDic2Rep">
														<xsl:with-param name="Title2S" select="$ForcedTitle"/>
														<xsl:with-param name="Lang" select="$Lang"/>
														<xsl:with-param name="tDDConfig" select="'C'"/>
														<xsl:with-param name="dictionary" select="$dictionary"/>
													</xsl:call-template>
												</xsl:when>
												<!-- Force Title -->
												<xsl:when test="$ForcedTitle!='' and $RepDic='N'">
													<xsl:value-of select="$ForcedTitle"/>
												</xsl:when>
												<!-- Caption DBWeb with DD -->
												<xsl:when test="$ForcedTitle='' and $RepDic='C'">
													<xsl:call-template name="FromDic2Rep">
														<xsl:with-param name="Title2S" select="$DBWEB_Name"/>
														<xsl:with-param name="Lang" select="$Lang"/>
														<xsl:with-param name="tDDConfig" select="'C'"/>
														<xsl:with-param name="dictionary" select="$dictionary"/>
													</xsl:call-template>
												</xsl:when>
												<!-- Caption and Pop-Up DBWeb with DD -->
												<xsl:when test="$ForcedTitle='' and $RepDic='Y'">
													<xsl:call-template name="FromDic2Rep">
														<xsl:with-param name="Title2S" select="$DBWEB_Name"/>
														<xsl:with-param name="Lang" select="$Lang"/>
														<xsl:with-param name="dictionary" select="$dictionary"/>
													</xsl:call-template>
												</xsl:when>
												<!-- Force Title -->
												<xsl:when test="$ForcedTitle='' and $RepDic='N'">
													<xsl:value-of select="$DBWEB_Name"/>
												</xsl:when>
												<!-- Caption DBWeb with DD -->
												<xsl:otherwise>
													Trap Error on Generic DBWeb Title
												</xsl:otherwise>
											</xsl:choose>
											<xsl:if test="$NRT='RT'"> (Real-Time)</xsl:if>
										</p> 
										<ul class="nav navbar-nav navbar-right">
											<p class="navbar-text">
												<xsl:choose>
													<!-- Error in DBWeb -->
													<xsl:when test="count(//dbquery[@id=$DBWEB_Name]/error)=1">
														Error in DBWeb
													</xsl:when>
													<!-- No Error in DBWeb -->
													<xsl:otherwise>
													<!-- <input type="text" id="myInputTextField"></input>
													<script>
														oTable = $('#dT_DD_REPORT_LIST').DataTable();
															$('#myInputTextField').keypress(function(){
																oTable.fnFilter($(this).val()); ;})
													</script> -->
														<xsl:if test="$MaxRecords!=-1">
															<b><xsl:value-of select="$RecFound"/></b> Record<xsl:if test="$RecFound>1">s</xsl:if> found 
														</xsl:if>
														<xsl:if test="$MaxRecords=$RecFound"> at Least (<img src="/{$vHtDocsConfig}/CPN/img/Alert32.png" width="14px" alt="Limit Reached" style="padding:-30px 1px 3px 5px"/> Limit Reached)
														</xsl:if>
													</xsl:otherwise>
												</xsl:choose>
											</p> 
											<li class="dropdown">
									          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Help <span class="caret"></span></a>
									          <ul class="dropdown-menu">
									            <li>
									            	<a href="#" data-toggle="modal" data-target="#CPN_BReport_Infos_{$UniqdTN}" role="button">
														Bloc Infos
													</a> 
												</li>
									            <li role="separator" class="divider"></li>
									            <li><a href="#" data-toggle="modal" data-target="#CPN_BReport_Toolbox_{$UniqdTN}" role="button"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> ToolBox </a></li>
									          </ul>
									        </li>
									      </ul>
									</div><!-- /.navbar-collapse -->
								</div><!-- /.container-fluid -->
							</nav>
						</div>
					</center>
					<!-- Generate Block Report Infos -->
					<div id="CPN_BReport_Infos_{$UniqdTN}" class="modal fade" role="dialog">
					        <div class="modal-dialog modal-lg">
					            <!-- Modal content-->
					            <div class="modal-content">
					                <div class="modal-header">
					                    <button type="button" class="close" data-dismiss="modal">X</button>
					                    <h4 class="modal-title">Block Report Information : '<xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_name"/>'</h4>
					                </div>
					                <div class="modal-body">
					                    <div class="row">
					                        <div class="col-md-12">
					                            <p style="font-style:italic">This page summarize all <b>General</b> information about this Block Report.</p>
					                        </div>
					                    </div>
					                    <div class="row">
					                        <div class="col-md-5">
					                            <h4>General Data</h4>
					                            <p><b>Name : </b> <xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_long_desc_en"/></p>
					                            <ul>
					                                <li>
					                                	<b>Type : </b>
					                                	<xsl:if test="$Detail_Data!='Generic'">
					                                		Block generated on base of Template <xsl:value-of select="$Detail_Data"/>
					                                	</xsl:if>
					                                	<xsl:if test="$Detail_Data='Generic'">
					                                		Generic Generation based on QuerySting <xsl:value-of select="$DBWEB_Name"/>
					                                	</xsl:if>
					                                </li>
					                            </ul>
					                            <xsl:if test="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_remarks!=''">
					                            	<p>
					                            		<b>Remarks :</b>
					                            		<xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_remarks"/>
					                            	</p>
					                            </xsl:if>
					                        </div>
					                    </div>
					                    <xsl:if test="$Detail_Data='Generic'">
				                            <div class="row">
					                            <div class="col-md-12">
						                            <h4>SQL Used for Generic Generation</h4>
						                            <p style="font-style:italic"><xsl:value-of select="//dbquery[@id=$DBWEB_Name]/descriptor/querystring"/></p>
						                            - This block used Special Features listed <a href="#" target="_blank">here</a>
						                        </div>
						                    </div>
			                            </xsl:if>
										
					                </div>
					                <div class="modal-footer">
					                    <center>
										        <div class="col-md-10">
						                            <p style="font-style:italic;color:red">This report has been build with <b>Report CPN (Common Pilar Node Framework)</b></p>
						                        </div>
						                </center>
					                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					                </div>
					            </div>
					        </div>
				    </div>
					<!-- Generate Block Report Toolbox -->
					<div id="CPN_BReport_Toolbox_{$UniqdTN}" class="modal fade" role="dialog">
					        <div class="modal-dialog modal-lg">
					            <!-- Modal content-->
					            <div class="modal-content">
					                <div class="modal-header">
					                    <button type="button" class="close" data-dismiss="modal">X</button>
					                    <h4 class="modal-title">Report Block '???' Toolbox</h4>
					                </div>
					                <div class="modal-body">
					                    <div class="row">
					                        <div class="col-md-12">
					                            <p style="font-style:italic">This page summarize all <b>Tools</b> about this Block Report.</p>
					                        </div>
					                    </div>
					                    <!-- RegEx -->
										<div class="row">
				                            <div class="col-md-6">
					                            <h4>Allow Regular Expression</h4>
												<p>
													<center>
													<table class="display">
														<thead>
															<th></th><th>RegEx</th><th>Smart Search</th><th>Explanation</th>
														</thead>
														<tbody>
															<tr>
																<td>Column</td>
																<td>
																	<input class="global_filter" type="checkbox" value="on">
																		<xsl:attribute name="id"><xsl:value-of select="$UniqdTN"/>_indiv_regex</xsl:attribute>
																	</input>
																</td>
																<td>
																	<input class="global_filter" type="checkbox" value="on">
																		<xsl:attribute name="id"><xsl:value-of select="$UniqdTN"/>_indiv_smart</xsl:attribute>
																	</input>
																</td>
																<td>Use | for Or Criteria (XX|YY)<br/>^((?!XXX).)*$ for Everithing except 'XXX'</td>
															</tr>
														</tbody>
													</table>
													</center>
												</p>
											</div>
											<div class="col-md-6">
					                            <h4>dataTable Setting</h4>
												<p>
													<div class="row">
														<div class="col-md-6">
								                            <h4>View Localstorage</h4> 	
							                            	<p>
								                                <center>
																	<button type="button" class="btn btn-primary" >
																		<xsl:attribute name="onclick">var url = window.location.href;var URLRep = url.substring(0,url.indexOf("?")).substring(url.substring(0,url.indexOf("?")).indexOf("LRF/XMLWeb/Process")-1);dTLocalStorage('DataTables_dT_<xsl:value-of select="$UniqdTN"/>_'+URLRep)</xsl:attribute>
																		View LocalStorage Properties
																	</button>
								                                </center>
							                                </p>
								                        </div>
								                        <div class="col-md-6">
							                            	<h4>Reset</h4> 	
							                            	<p>
								                                <center>
																	<button type="button" class="btn btn-danger" >
																		<xsl:attribute name="onclick">var url = window.location.href;var URLRep = url.substring(0,url.indexOf("?")).substring(url.substring(0,url.indexOf("?")).indexOf("LRF/XMLWeb/Process")-1);localStorage.removeItem('DataTables_dT_<xsl:value-of select="$UniqdTN"/>_'+URLRep);delete window.localStorage['DataTables_dT_<xsl:value-of select="$UniqdTN"/>_'+URLRep];MRNNotif('1','T06 - Tables Result Personnalization Cleared','State Cleared (Column Filters, Visibility and Ordering). Reset will take effect on next Refresh or Query for the table contained in this block',10,'ALL','<xsl:value-of select="$vNodeConfig"/>');$("#CPN_BReport_Toolbox_<xsl:value-of select="$UniqdTN"/>").modal('hide')</xsl:attribute>
																		Reset Report Block Layout
																	</button>
								                                </center>
							                                </p>
							                        	</div>
								                    </div>
												</p>
											</div>
										</div>
					                </div>
					                <div class="modal-footer">
					                    <center>
										        <div class="col-md-10">
						                            <p style="font-style:italic;color:red">This report has been build with <b>Report CPN (Common Pilar Node Framework)</b></p>
						                        </div>
						                </center>
					                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					                </div>
					            </div>
					        </div>
				    </div>
					<!-- Frame -->
					<table border="0" align="center">
						<xsl:attribute name="class"><xsl:value-of select="$TableClass"/></xsl:attribute>
						<xsl:attribute name="width"><xsl:value-of select="$TableWidth"/></xsl:attribute>
						<tbody>
							<tr>
								<td style="background-color:#ffffff;">
									<xsl:attribute name="id">GT_<xsl:value-of select="$UniqdTN"/></xsl:attribute>	
									<xsl:attribute name="style">width:50%</xsl:attribute>	
									<xsl:choose>
										<!-- Trap DBWeb Error -->
										<xsl:when test="count(//dbquery[@id=$DBWEB_Name]/error)=1">
											<xsl:attribute name="style">display:none</xsl:attribute>
											<center>
												<br/><b>Error in the DBWeb QueryString : <font color='red'><u><xsl:value-of select="$DBWEB_Name"/></u></font> used for generation of this Report. <br/>
												Cause (Probably) : ... 
												<font color='red'>
													<xsl:choose>
														<xsl:when test="contains(substring(//dbquery[@id=$DBWEB_Name]/error/message,1,400),'reset')">No ILIAS Connection</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="substring(//dbquery[@id=$DBWEB_Name]/error/message,1,400)"/>
														</xsl:otherwise>
													</xsl:choose>
												</font>
												<br/>
												Please Report this Error to <xsl:value-of select="$vNodeName"/> Administrators (<xsl:value-of select="$vWebMaster"/>)</b><br/>
											</center>
										</xsl:when>
										<!-- DBWeb Not in Error -->
										<xsl:otherwise>
											<xsl:choose>
												<xsl:when test="substring($Frame,2,1)='O'">
													<!-- Opened Frame when call report -->
													<xsl:attribute name="style">display:Block</xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
													<!-- Closed Frame when call report -->
													<xsl:attribute name="style">display:none</xsl:attribute>
												</xsl:otherwise>
											</xsl:choose>
											<!-- Check for detailled Content -->
											<!-- if only one record change Config from initial to 01 (Only for Generic) -->
											<xsl:variable name="Refine_DT" select="'99'"/>
											<!-- XXTBDXX by MIB : for JF Test
											<xsl:variable name="Refine_DT">
												<xsl:choose>
													<xsl:when test="$RecFound=0">01</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="$dT_Type"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											-->
											<xsl:choose>
												<xsl:when test="$Detail_Data='Generic'">
													<!-- Call Generic DBWeb Content in a Table -->
													<xsl:call-template name="Generic_Detailed_Table">
														<xsl:with-param name="DBWEB_Name" select="$DBWEB_Name"/>
														<xsl:with-param name="UdTN" select="$UniqdTN"/>
														<xsl:with-param name="TableClass" select="$TableDetClass"/>
														<xsl:with-param name="Lang" select="$Lang"/>
														<xsl:with-param name="RepDic" select="$RepDic"/> 
														<xsl:with-param name="dictionary" select="$dictionary"/>
														<xsl:with-param name="ForceFooter" select="$ForceFooter"/>
													</xsl:call-template>
													<xsl:call-template name="Node_Std_Table">
														<xsl:with-param name="Table_Name" select="$UniqdTN"/>
														<xsl:with-param name="Records" select="$RecFound"/>
														<xsl:with-param name="Node_Conf" select="$Node_Conf"/>
														<xsl:with-param name="Col_Hidden" select="$Col_Hidden"/>
														<xsl:with-param name="Col_Sorting" select="$Col_Sorting"/>
														<xsl:with-param name="dT_Type" select="$Refine_DT"/>
														<xsl:with-param name="DDURL" select="$DDURL"/>
														<xsl:with-param name="Lang" select="$Lang"/>
														<xsl:with-param name="Alphabet" select="$Alphabet"/>
														<xsl:with-param name="Col_Filtering" select="$Col_Filtering"/>
														<xsl:with-param name="Col_Total" select="$Col_Total"/>
														<xsl:with-param name="dT_Col_Order" select="$dT_Col_Order"/>	
														<xsl:with-param name="dT_Filter" select="$dT_Filter"/>
														<xsl:with-param name="dT_Paging" select="$dT_Paging"/>
														<xsl:with-param name="dT_XLS" select="$dT_XLS"/>
														<xsl:with-param name="dT_PDF" select="$dT_PDF"/>
														<xsl:with-param name="dT_Print" select="$dT_Print"/>
														<xsl:with-param name="dT_Info" select="$dT_Info"/>
														<xsl:with-param name="dT_Buttons" select="$dT_Buttons"/>
														<xsl:with-param name="dT_HeatMap" select="'N'"/>
													</xsl:call-template>
												</xsl:when>
												<xsl:otherwise>
													<!-- Call Manual template -->
													<xsl:apply-templates select="//dbquery[@id='TEMPLATE']/rows">		
														<xsl:with-param name="DBWEB_Name" select="$DBWEB_Name"/>
														<xsl:with-param name="UdTN" select="$UniqdTN"/>
														<xsl:with-param name="Node_Conf" select="$Node_Conf"/>
														<xsl:with-param name="dT_Type" select="$dT_Type"/>
														<xsl:with-param name="TableClass" select="$TableClass"/>
														<xsl:with-param name="Lang" select="$Lang"/>
														<xsl:with-param name="RepDic" select="$RepDic"/>
														<xsl:with-param name="dictionary" select="$dictionary"/>	
														<xsl:with-param name="Detail_Data" select="$Detail_Data"/>		
													</xsl:apply-templates>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>
									<br/>
								</td>
							</tr>				
						</tbody>
					</table>
				</xsl:when>
				<xsl:otherwise>
					<!-- No Frames arount DBWeb Table content -->
					<xsl:if test="substring($Frame,2,1)='T' or count(//dbquery[@id=$DBWEB_Name]/error)=1">
						<xsl:choose>
							<xsl:when test="$ForcedTitle!=''">
								<!-- Forced Title -->
								<center><h2><xsl:value-of select="$ForcedTitle"/></h2></center>
							</xsl:when>
							<xsl:otherwise>
								<!-- No Forced Title check in Dic if not found DBWeb Name -->
								<h2>
									<xsl:choose>
										<xsl:when test="$RepDic='N'">
											<xsl:value-of select="@name"/>
										</xsl:when>
										<xsl:when test="$RepDic='C'">
											<xsl:call-template name="FromDic2Rep">
												<xsl:with-param name="Title2S" select="$UdTN"/>
												<xsl:with-param name="Lang" select="$Lang"/>
												<xsl:with-param name="tDDConfig" select="'C'"/>
												<xsl:with-param name="dictionary" select="$dictionary"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="FromDic2Rep">
												<xsl:with-param name="Title2S" select="$UdTN"/>
												<xsl:with-param name="Lang" select="$Lang"/>
												<xsl:with-param name="dictionary" select="$dictionary"/>
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</h2>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="count(//dbquery[@id=$DBWEB_Name]/error)=1">
							<center>
								<br/><b>Error in the DBWeb QueryString : <font color='red'><u><xsl:value-of select="$DBWEB_Name"/></u></font> used for generation of this Report.
								<br/>
								Please Report this Error to COL/G4 (Lt Dolphen or 1SM Nourry)</b><br/>
							</center>
						</xsl:if>
					</xsl:if>
					<!-- Check for detailled Content -->
					<!-- if only one record change Config from initial to 01 (Only for Generic) -->
					<xsl:variable name="Refine_DT" select="'99'"/>
					<!-- XXTBDXX by MIB : Removed for JF Test
					<xsl:variable name="Refine_DT">
						<xsl:choose>
							<xsl:when test="$RecFound=0">01</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$dT_Type"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					-->
					<xsl:choose>
						<xsl:when test="$Detail_Data='Generic'">
							<!-- Call Generic DBWeb Content in a Table -->
							<xsl:call-template name="Generic_Detailed_Table">
								<xsl:with-param name="DBWEB_Name" select="$DBWEB_Name"/>
								<xsl:with-param name="UdTN" select="$UdTN"/>
								<xsl:with-param name="TableClass" select="$TableDetClass"/>
								<xsl:with-param name="Lang" select="$Lang"/>
								<xsl:with-param name="RepDic" select="$RepDic"/> 
								<xsl:with-param name="dictionary" select="$dictionary"/> 
								<xsl:with-param name="ForceFooter" select="$ForceFooter"/>							
							</xsl:call-template>
							<!-- Call dataTable -->
							<xsl:call-template name="Node_Std_Table">
								<xsl:with-param name="Table_Name" select="$UniqdTN"/>
								<xsl:with-param name="Node_Conf" select="$Node_Conf"/>
								<xsl:with-param name="Records" select="$RecFound"/>
								<xsl:with-param name="dT_Type" select="$Refine_DT"/>
								<xsl:with-param name="Col_Hidden" select="$Col_Hidden"/>
								<xsl:with-param name="Col_Sorting" select="$Col_Sorting"/>
								<xsl:with-param name="DDURL" select="$DDURL"/>
								<xsl:with-param name="Lang" select="$Lang"/>
								<xsl:with-param name="Alphabet" select="$Alphabet"/>
								<xsl:with-param name="Col_Filtering" select="$Col_Filtering"/>
								<xsl:with-param name="Col_Total" select="$Col_Total"/>
								<xsl:with-param name="dT_Col_Order" select="$dT_Col_Order"/>	
								<xsl:with-param name="dT_Filter" select="$dT_Filter"/>
								<xsl:with-param name="dT_Paging" select="$dT_Paging"/>
								<xsl:with-param name="dT_XLS" select="$dT_XLS"/>
								<xsl:with-param name="dT_PDF" select="$dT_PDF"/>
								<xsl:with-param name="dT_Print" select="$dT_Print"/>
								<xsl:with-param name="dT_Info" select="$dT_Info"/>
								<xsl:with-param name="dT_Buttons" select="$dT_Buttons"/>
								<xsl:with-param name="dT_HeatMap" select="'N'"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<!-- Call Manual template -->
							<xsl:apply-templates select="//dbquery[@id='TEMPLATE']/rows">		
								<xsl:with-param name="DBWEB_Name" select="$DBWEB_Name"/>
								<xsl:with-param name="UdTN" select="$UdTN"/>
								<xsl:with-param name="Node_Conf" select="$Node_Conf"/>
								<xsl:with-param name="dT_Type" select="$dT_Type"/>
								<xsl:with-param name="TableClass" select="$TableClass"/>
								<xsl:with-param name="Lang" select="$Lang"/>
								<xsl:with-param name="RepDic" select="$RepDic"/>
								<xsl:with-param name="dictionary" select="$dictionary"/>								
								<xsl:with-param name="Detail_Data" select="$Detail_Data"/> 		
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>		
	</xsl:template>
	<xsl:template name="Generic_Detailed_Table"> 	<!-- Automatic Generation of Detailed Table (wo dT) -->	
		<xsl:param name="DBWEB_Name" select="'TO_BE_FILLED'"/>	<!-- DBWeb Query Name -->
		<xsl:param name="UdTN" select="'NADA'"/>				<!-- Unique dT Name (usefull if use several times same DBWEB -->
		<xsl:param name="Lang" select="$vLANG"/>					<!-- Language. Default 'EN'/'FR'/'NL' -->
		<xsl:param name="dictionary"/> 							<!-- Dictionary Document. Mandatory if RepDic is 'Y' -->
		<xsl:param name="TableClass" select="'cell-border'"/>	<!-- Table Class for Table Frame, Default 'cell-border'/'Display' -->
		<xsl:param name="RepDic" select="'N'"/>					<!-- Use of Report Dictionnary. Default 'N' / 'Y' -->
		<xsl:param name="ForceFooter" select="'N'"/>					<!-- Use of Report Dictionnary. Default 'N' / 'Y' -->
			
		<xsl:variable name="UniqdTN">
			<xsl:choose>
				<xsl:when test="$UdTN='NADA'">
					<xsl:value-of select="translate(normalize-space($DBWEB_Name),' ','')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate(normalize-space($UdTN),' ','')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
<!-- 		<br/>
 -->		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<xsl:attribute name="id">dT_<xsl:value-of select="$UniqdTN"/></xsl:attribute>
			<xsl:attribute name="class"><xsl:value-of select="$TableClass"/></xsl:attribute>
			<thead class="MRBlock">			
				<tr>
					<xsl:for-each select = "(//dbquery[@id=$DBWEB_Name])[1]/columns/column">
						<th>
							<xsl:choose>
								<xsl:when test="$RepDic='N'">
									<xsl:value-of select="@name"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="FromDic2Rep">
										<xsl:with-param name="Title2S" select="@name"/>
										<xsl:with-param name="Lang" select="$Lang"/>
										<xsl:with-param name="dictionary" select="$dictionary"/>
										<xsl:with-param name="tDDConfig" select="'C'"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</th>
					</xsl:for-each>
				</tr>
			</thead>						
			<tbody>
				<xsl:for-each select = "//dbquery[@id=$DBWEB_Name]/rows/row">
					<tr>
						<xsl:apply-templates select="@*" mode="genericTableCel"/>
					</tr>
				</xsl:for-each>
			</tbody>
			<!-- @remark gebruik de parameter recFound-->
			<xsl:if test="count(//dbquery[@id=$DBWEB_Name]/rows/row)>=1 or $ForceFooter='Y'">
				<tfoot>			
					<tr>
						<!--xsl:if test="$RepDic='Y'"-->
							<xsl:for-each select = "(//dbquery[@id=$DBWEB_Name])[1]/columns/column">
								<th class="CPN_Search">
									<xsl:choose>
										<xsl:when test="$RepDic='N'">
											<!--xsl:value-of select="@name"/-->
										</xsl:when>
										<xsl:when test="$RepDic='C'">
											<!--xsl:call-template name="FromDic2Rep">
												<xsl:with-param name="Title2S" select="@name"/>
												<xsl:with-param name="Lang" select="$Lang"/>
												<xsl:with-param name="dictionary" select="$dictionary"/>
												<xsl:with-param name="tDDConfig" select="'C'"/>
											</xsl:call-template-->
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="FromDic2Rep">
												<xsl:with-param name="Title2S" select="@name"/>
												<xsl:with-param name="Lang" select="$Lang"/>
												<xsl:with-param name="dictionary" select="$dictionary"/>
												<xsl:with-param name="tDDConfig" select="'IP'"/>
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</th>
							</xsl:for-each>	
						<!--/xsl:if-->
					</tr>
				</tfoot>
			</xsl:if>
		</table>	
	</xsl:template>
	<xsl:template name="Node_Std_Table">			<!-- dataTable (dT) Configuration and Generation -->
		
		<xsl:param name="Node_Conf" select="$vNodeConfig"/>		<!-- Node Configuration. DEPREACATED Not used anymore -->
		<xsl:param name="dT_Type" select="$vNodedT"/>			<!-- dataTable Configuration. See Template Node_Std_Table for Config -->
		<xsl:param name="Col_Hidden" select="'None'"/>			<!-- Hide Columns Nbr in dT. Default is 'None' / Example '2,3' -->
		<xsl:param name="Col_Sorting" select="'None'"/>			<!-- Table Sorting on Column Nbr in dT. Default 'None' / Example '1-asc' or '2-desc' -->
		<xsl:param name="DDURL" select="'N'"/>					<!-- Drill-Down URL -->
		<!-- Depreacated - Do Not Use -->
		<xsl:param name="Alphabet" select="'None'"/> 			<!-- Include Alphabetic Summary Filtering None (Default) or Y -->
		<xsl:param name="Col_Filtering" select="'None'"/> 		<!-- Include on ALL Column Filtering None (Default) or Y -->
		<xsl:param name="Col_Total" select="'None'"/> 			<!-- Include Dynamic Total on Column Nbr None (Default) or 0,3,5 -->
		<xsl:param name="Table_Name"/> 							<!-- Table Name for DataTable. Will be prefixed by dT_ for TableId  -->
		<xsl:param name="Lang" select="$vLANG"/>
		<xsl:param name="Records" select="1"/> 					<!-- Number of Records found in Table  -->	
		<!-- New Global Configuration -->
		<xsl:param name="dT_Col_Order" select="'Y'"/>			<!-- Allows Ordering Asc/Desc  -->	
		<xsl:param name="dT_Filter" select="'Y'"/>				<!-- Allows Global Filtering  -->	
		<xsl:param name="dT_Info" select="'Y'"/>				<!-- Allows Info on Filtering  -->	
		<xsl:param name="dT_Buttons" select="'Y'"/>				<!-- Show Buttons  -->	
		<xsl:param name="dT_Paging" select="$vNodedTPaging"/>	<!-- Allows Paging -->	
		<xsl:param name="dT_XLS" select="$vNodedTXLS"/>			<!-- Allows XLS Export of dT -->	
		<xsl:param name="dT_PDF" select="$vNodedTPDF"/>			<!-- Allows pdf Export of dT -->	
		<xsl:param name="dT_Print" select="'Y'"/>				<!-- Allows Print of dT -->
		<xsl:param name="dT_HeatMap" select="'N'"/>				<!-- Allows HeatMap of dT -->
		<!-- Defined Config
		000 : Zero Congiguration
		00 : Minimal
		01 : Basic for summary (No Sort, No Filter, No Info) Only Hide Fields
		95 : For List of Reports/KPI
		96 : One Row (minimum) for KPI
		97 : ??
		98 : For KPI Structure
		99 : Full - All options activated
		-->
		
		<!-- Alphabet is NOW DEPREACATED - DO NOT USE ANYMORE -->
		<xsl:if test="$Alphabet!='None'">
			<xsl:call-template name="TNotif">
				<xsl:with-param name="tMsg" select="'Alphabet visualization is a Depreacated Feature. It will be removed next CPN Update. If you see this message, please inform Node Manager that Report has to be adapted. Thank You. CPN Core Development Team'"/>
				<xsl:with-param name="tTitle" select="'T06 - Depreacated Feature Used'"/> 
				<xsl:with-param name="tType" select="4"/> 	
				<xsl:with-param name="tAppear" select="1000"/>
				<xsl:with-param name="tDuration" select="3000"/>  	
			</xsl:call-template>
		</xsl:if>
		<!-- Alphabet is NOW DEPREACATED - DO NOT USE ANYMORE -->
		<xsl:choose>
			<xsl:when test="$dT_Type='99'"> 	<!-- For Std Table Result, all features activated (Version to Copy) -->
				<script>
					<!-- No more needed - Solved with last version of dataTable.
						RemoveGhost('dT_<xsl:value-of select="$Table_Name"/>'); 
					-->					
					<!-- Column Based Filtering Box Part 1/2-->
					<xsl:if test="$Col_Filtering!='None'">
						<!-- Setup - add a text input to each footer cell -->
					    var keyValue2 = [];
						var url = window.location.href;
						var URLRep = url.substring(0,url.indexOf("?")).substring(url.substring(0,url.indexOf("?")).indexOf("LRF/XMLWeb/Process")-1);
						keyValue2=JSON.parse(localStorage.getItem('DataTables_dT_<xsl:value-of select="$Table_Name"/>_'+URLRep));
						$('#dT_<xsl:value-of select="$Table_Name"/> tfoot th.CPN_Search').each( function () {
					        if(keyValue2===null){
					        	var Filtervalue = '';
					        	$(this).append( ' <input class="f{$Table_Name}" type="text" size="1" value="'+ Filtervalue +'" placeholder="" />' );
					        	} else {
					        	var Filtervalue = keyValue2.columns[$(this).index()].search.search;
					        	if (Filtervalue==='') {
					        		<!-- Inputbox Initialisation -->
					        		$(this).append( ' <input class="f{$Table_Name}" type="text" size="1" value="'+ Filtervalue +'" placeholder="" />' );
					        		} else {
					        		<!-- Inputbox Filled with filter -->
					        		$(this).append( ' <input class="f{$Table_Name}" type="text" size="1" style="background-color:#f1c40f" value="'+ Filtervalue +'" placeholder="" />' );
					        		}
					        	};
					    } );
					</xsl:if>
					
					<!-- Used in XTable if Records is set = 0. Calculation of XTab Rows and determine if Paging is activated -->
					if($('#dT_<xsl:value-of select="$Table_Name"/> tr').length &lt; 25) {
						var CalcXTNbrRec=false
						} else {
						var CalcXTNbrRec=true
						};
					<!-- dataTable Parametrization -->
					$.fn.dataTable.ext.errMode = 'none';
					var oTable_dT_<xsl:value-of select="$Table_Name"/> = $('#dT_<xsl:value-of select="$Table_Name"/>').on('error.dt', function(e, settings, techNote, message){
							MRNNotif('4','DataTables error',message,30,'ALL','<xsl:value-of select="$vNodeConfig"/>');
							$('#dT_<xsl:value-of select="$Table_Name"/>').DataTable();
						}).DataTable( {
						dom: 'lB<xsl:if test="$dT_Filter!='N'">f</xsl:if><xsl:if test="$dT_Paging='Y' or ($dT_Paging='N' and $Records=0)">p</xsl:if>AR&lt;"clear">C<xsl:if test="$dT_Info!='N'">i</xsl:if>rt',
						<xsl:choose>
							<!-- For XTab must be in first Position) -->
							<xsl:when test="$Records=0">
								"paging":   CalcXTNbrRec,
							</xsl:when>
							<xsl:when test="$dT_Paging!='Y'">
								"paging":   false,
							</xsl:when>
							<xsl:when test="$Records&lt;=50">
								"paging":   false,
							</xsl:when>
							<xsl:otherwise>
								"paging":   true,
							</xsl:otherwise>
						</xsl:choose>
						"autoWidth":true,
						<xsl:if test="$dT_Buttons='Y'">
							"buttons": [
							{
								extend: 'colvis',
								text: function() {
									var totCols = $('#dT_<xsl:value-of select="$Table_Name"/> thead th').length;
									<xsl:choose>
										<xsl:when test="$Col_Hidden!='None'">
											var arrHiddenCols = [<xsl:value-of select="$Col_Hidden"/>];
											var hiddenCols = arrHiddenCols.length;
										</xsl:when>
										<xsl:otherwise>
											var hiddenCols = 0;
										</xsl:otherwise>
									</xsl:choose>
									var shownCols = totCols - hiddenCols;
									return 'Column visibility (' + shownCols + ' of ' + totCols + ')';
									},
								prefixButtons: [
									{
										extend:'colvisGroup',
										text:'Show all',
										show:':hidden'
									},
									{
										extend:'colvisRestore',
										text:'Restore'
									}
								]
							},
					        <xsl:if test="$dT_XLS='Y' or $dT_PDF='Y'">{
					            extend: 'collection',
					            text: 'Export',
					            buttons: [ 
					            <xsl:if test="$dT_XLS='Y'">
					            	{
					                text: 'Export to XLS',
					                extend: 'excelHtml5',
					                exportOptions: {
					                    columns: ':visible'
					                }
           						 }
					            </xsl:if><xsl:if test="$dT_PDF='Y'">
					            ,{
					                text: 'PDF Html5 (Port)',
					                extend: 'pdfHtml5',
					                message: 'CPN FW : Generated by <xsl:value-of select="$vCDN"/>',
					                exportOptions: {
					                    columns: ':visible'
					                }
           						 }
           						 ,{
					                text: 'PDF Html5 (Land)',
					                extend: 'pdfHtml5',
					                message: 'CPN FW : Generated by <xsl:value-of select="$vCDN"/>',
					                orientation: 'landscape',
					                exportOptions: {
					                    columns: ':visible'
					                }
           						 },
           						{
					                text: 'PDF (alt Port)',
					                extend: 'pdfFlash',
					                message: 'CPN FW : Generated by <xsl:value-of select="$vCDN"/>',
					                exportOptions: {
					                    columns: ':visible'
					                }
					             },
           						{
					                text: 'PDF (alt Land)',
					                extend: 'pdfFlash',
					                message: 'CPN FW : Generated by <xsl:value-of select="$vCDN"/>',
					                orientation: 'landscape',
					                exportOptions: {
					                    columns: ':visible'
					                }
           						 }</xsl:if>
           						  ]
					        },</xsl:if>
							{
					            extend: 'collection',
					            text: 'Tools',
					            buttons: [ 
									{
                     					text: "View Settings",
										action: function() {
											var url = window.location.href;
											var URLRep = url.substring(0,url.indexOf("?")).substring(url.substring(0,url.indexOf("?")).indexOf("LRF/XMLWeb/Process")-1);
											dTLocalStorage('DataTables_dT_<xsl:value-of select="$Table_Name"/>_'+URLRep)
											}
                					},
                					{
                     					text: "Reset",
										action: function() {
											var url = window.location.href;
											var URLRep = url.substring(0,url.indexOf("?")).substring(url.substring(0,url.indexOf("?")).indexOf("LRF/XMLWeb/Process")-1);localStorage.removeItem('DataTables_dT_<xsl:value-of select="$Table_Name"/>_'+URLRep);
											delete window.localStorage['DataTables_dT_<xsl:value-of select="$Table_Name"/>_'+URLRep];
											MRNNotif('1','T06 - Tables Result Personnalization Cleared','State Cleared (Column Filters, Visibility and Ordering). Reset will take effect on next Refresh or Query for the table contained in this block',10,'ALL','<xsl:value-of select="$vNodeConfig"/>');
											}
                					},
                					<xsl:if test="$dT_Print='Y'">'print'</xsl:if>
					            ]
					        }
					        <xsl:if test="$dT_HeatMap='Y'">
					        ,{
								extend: 'collection',
								text: 'Heatmap',
								buttons: [
									{
										text: 'Reset',
										action: function(){
											heatMap(255,255,255,'dT_<xsl:value-of select="$Table_Name"/>','reset','<xsl:value-of select="$vNodeConfig"/>');
										}
									},
									{
										text: 'Global',
										action: function() {
											heatMap(118,246,68,'dT_<xsl:value-of select="$Table_Name"/>','global','<xsl:value-of select="$vNodeConfig"/>');
										}
									},
									{
										text: 'By Rows',
										action: function() {
											heatMap(118,246,68,'dT_<xsl:value-of select="$Table_Name"/>','rows','<xsl:value-of select="$vNodeConfig"/>');
										}
									},
									{
										text: 'By Columns',
										action: function() {
											heatMap(118,246,68,'dT_<xsl:value-of select="$Table_Name"/>','columns','<xsl:value-of select="$vNodeConfig"/>');
										}
									}
								]
					        }
					        </xsl:if>
						],
						</xsl:if>
						"bSortCellsTop": true,	// Necessary for Column Filter
						"stateSave": true,
						"stateDuration": 60 * 60 * 24 * 31, // Save for 1 Month
						"lengthMenu": [[15, 25, 50, -1], [15, 25, 50, "All"]],
						"pagingType": "full_numbers", // use simple,simple_numbers,full,full_numbers
						<xsl:if test="$Col_Hidden!='None'">
							"columnDefs": [{ "visible": false, "targets": [ <xsl:value-of select="$Col_Hidden"/> ] }],
						</xsl:if>
						<xsl:choose>
							<xsl:when test="$dT_Col_Order='Y'">"ordering": true,</xsl:when>
							<xsl:otherwise>"ordering": false,</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="$Col_Sorting='None'">
								"order": [[ "0","asc" ]],
							</xsl:when>
							<xsl:otherwise>
								"order": [[ "<xsl:value-of select='substring-before($Col_Sorting,"-")'/>","<xsl:value-of select='substring-after($Col_Sorting,"-")'/>" ]],
							</xsl:otherwise>
						</xsl:choose>
						"language": {            
								"decimal": ",",	
								"thousands": ".", 
								"lengthMenu": "Display _MENU_ records per page (Select 'ALL' to disable Paging)",
								"zeroRecords": "Nothing Found",
								"info": "Filter Result : _START_ to _END_ of _TOTAL_ entries",
								//"info": "Showing page _PAGE_ of _PAGES_",
								"infoEmpty": "No records available",
								"infoFiltered": "(Filtered from _MAX_ total records)",
								"search": "Search in all columns : ",
								"paginate": {
										"first":    "First",
										"previous": "Previous",
										"next":     "Next",
										"last":     "Last"
									},
							},
						"info": true
    					<!-- Column based Totals -->
						<xsl:if test="$Col_Total!='None'">
							,"footerCallback": function ( row, data, start, end, display ) {
					            var api = this.api(), data;
					 
					            //Loop for Each Total

								var NbrTotal=[<xsl:value-of select="$Col_Total"/>]  
								for (var j=0; j&lt;NbrTotal.length; j++) {
									// Remove the formatting to get integer data for summation
						            var ColNbr=NbrTotal[j]
						            var intVal = function ( i ) {
						                return typeof i === 'string' ?
											// US Formatted
											//i.replace(/[\$,]/g, '')*1 :
											//Belgian Formatted number
											i.replace(/[^0-9,\-]/g, "").replace(/,/g, ".")*1 :							                   
						                    typeof i === 'number' ?
						                        i : 0;
						            };

						            // Total over all pages
						            data = api.column( ColNbr ).data();
						            total = data.length ?
						                data.reduce( function (a, b) {
						                        return intVal(a) + intVal(b);
						                } ) :
						                0;
						            
						            // Total over this page
						            data = api.column( ColNbr, { page: 'current'} ).data();
						            pageTotal = data.length ?
						                data.reduce( function (a, b) {
						                        return intVal(a) + intVal(b);
						                } ) :
						                0;

						           $( api.column( ColNbr ).footer() ).html(
										// FORMAT TO BELGIAN STYLED NUMBER
											(total == 0) ? fn_formatNr_BE(0) : fn_formatNr_BE(Math.round(pageTotal*10)/10) +'<br/><small> on '+ fn_formatNr_BE(Math.round(total*10)/10) +'<br/>('+ Math.round(pageTotal/total*1000)/10 +'%)</small>'
										// NUMBER WITHOUT FORMATIING
										//(total == 0) ? '0' : Math.round(pageTotal*10)/10 +'<br/><small> on '+ Math.round(total*10)/10 +'<br/>('+ Math.round(pageTotal/total*1000)/10 +'%)</small>'
						            );
						        }					                
              				}
              			</xsl:if>
						,"initComplete": function(settings, json){
							<!-- Code to move Tfoot on Thead second line -->
							var r = $('#dT_<xsl:value-of select="$Table_Name"/> tfoot tr');
							r.find('th').each(function(){
								$(this).css('padding', 4);
								$(this).css('line-height', 1);
							});
							$('#dT_<xsl:value-of select="$Table_Name"/> thead').append(r);
							$('#search_0').css('text-align', 'center');
							<!-- Force re-render -->
							<!-- Check column visibility Initialised VS Local Storage -->
							var url = window.location.href;
							var URLRep = url.substring(0,url.indexOf("?")).substring(url.substring(0,url.indexOf("?")).indexOf("LRF/XMLWeb/Process")-1);
							var testLS = get_dTLocalStorage_Cols('DataTables_dT_<xsl:value-of select="$Table_Name"/>_'+URLRep);
							var dtID = 'dT_<xsl:value-of select="$Table_Name"/>';
							if(testLS=='Empty'){
									var visCols = $('#'+dtID+' thead tr:first th').length;
									var tblCols = $('.dt-button-collection a[aria-controls='+dtID+']').length - 2; //Minus 2 because of the 2 extra buttons Show all and Restore
									$('.buttons-colvis[aria-controls='+dtID+'] span').html('Column visibility (' + visCols + ' of ' + tblCols + ')');
								} else {
									$('.buttons-colvis[aria-controls='+dtID+'] span').html(testLS);
								}
							<!-- ON CLICK EVENT: Adjust hidden columns counter text in button -->
							$('#dT_<xsl:value-of select="$Table_Name"/>').on('column-visibility.dt', function(e,settings,column,state) {
								var parentID = $(this).parent().attr('id');
								var dtID = parentID.substring(0,parentID.indexOf('_wrapper'));
								var visCols = $('#'+dtID+' thead tr:first th').length;
								var tblCols = $('.dt-button-collection a[aria-controls='+dtID+']').length - 2; //Minus 2 because of the 2 extra buttons Show all and Restore
								$('.buttons-colvis[aria-controls='+dtID+'] span').html('Column visibility (' + visCols + ' of ' + tblCols + ')');
								e.stopPropagation();
							});
						}
					});
					<!-- Column Based Filtering Box Part 2/2-->
					<xsl:if test="$Col_Filtering!='None'">
						// Apply the search
					   
					    oTable_dT_<xsl:value-of select="$Table_Name"/>.columns().eq( 0 ).each( function ( colIdx ) {
					        $( 'input.f<xsl:value-of select="$Table_Name"/>', oTable_dT_<xsl:value-of select="$Table_Name"/>.column( colIdx ).footer() ).on( 'keyup change', function () {
					            if(this.value.length>0){$(this).css("background-color","#f1c40f");}else{$(this).css("background-color","white");};
					            oTable_dT_<xsl:value-of select="$Table_Name"/>
					                .column( colIdx )
					                .search( this.value ,
					                $('#<xsl:value-of select="$Table_Name"/>_indiv_regex').prop('checked'),
					                $('#<xsl:value-of select="$Table_Name"/>_indiv_smart').prop('checked')
	    						).draw();
					        } );
					    } );

					</xsl:if>
					<!-- If Drill-Down is Activated (not N) -->
					<xsl:if test="$DDURL!='N'">
						// Call dataTable Details Row
						var dT_URL='<xsl:value-of select="$DDURL"/>';
						
						dt_Table_Detail ('dT_<xsl:value-of select="$Table_Name"/>',oTable_dT_<xsl:value-of select="$Table_Name"/>,dT_URL,'<xsl:value-of select="$vLANG"/>','<xsl:value-of select="$vNodeConfig"/>');
					</xsl:if>
					
				</script>	 					
			</xsl:when>
			<xsl:when test="$dT_Type='98'">
				<!-- Used for KPI Dashboard for Structure -->
				<script>
					RemoveGhost('dT_<xsl:value-of select="$Table_Name"/>');
					var oTable_dT_<xsl:value-of select="$Table_Name"/> = $('#dT_<xsl:value-of select="$Table_Name"/>').DataTable( {
						dom: '&lt;"testbuttonarea">RCf&lt;"clear">lrtip',
						"paging":   false,
						"columnDefs": [
								{"searchable": false, "visible": true, "targets": [3,4] },
								{"searchable": false, "visible": true, "targets": [8] },
							],
						"autoWidth":true,
						"stateSave": true,
						"pagingType": "full_numbers", // use simple,simple_numbers,full,full_numbers
						"ordering": true,
						"order": [[ 0, "asc" ]], // Default ordering asc or desc
						"language": {            
								"decimal": ".",	// Fonctionne PAS
								"thousands": ",", // Fonctionne PAS
								"lengthMenu": "Display _MENU_ records per page",
								"zeroRecords": "Nothing found - Sorry",
								//"info": "Showing page _PAGE_ of _PAGES_",
								"infoEmpty": "No records available",
								"infoFiltered": "(filtered from _MAX_ total records)",
								"search": "Search all columns : ",
								"paginate": {
										"first":    "First",
										"previous": "Previous",
										"next":     "Next",
										"last":     "Last"
									}
							},
						"info":     true    
					} );
					// If Drill-Down is Activated (not N)
					<xsl:if test="$DDURL!='N'">
						// Call dataTable Details Row
						var dT_URL='<xsl:value-of select="$DDURL"/>';
						dt_Table_Detail ('dT_<xsl:value-of select="$Table_Name"/>',oTable_dT_<xsl:value-of select="$Table_Name"/>,dT_URL,,<xsl:value-of select="$Lang"/>);
					</xsl:if>
				</script>	 					
			</xsl:when>
			<xsl:when test="$dT_Type='000'">
				<script>
					alert('DT Type:00 (Zero Configuration)');
					var oTable_dT_<xsl:value-of select="$Table_Name"/> = $('#dT_<xsl:value-of select="$Table_Name"/>').DataTable();	
				</script>	 					
			</xsl:when>
			<xsl:otherwise>
				<!-- Call Std dt_Type 99 with Notification -->
				<xsl:call-template name="TNotif">
					<xsl:with-param name="tMsg" select="concat('For Result &lt;b>',$Table_Name,'&lt;/b> dataTable configuration &lt;b>',$dT_Type,'&lt;/b> is not defined in CPN Framework. Result Layout may be incorrect. Please contact Node Administrator with Feedback (Upper Right in Main Report Menu) and report this bug. Thank You')"/>
					<xsl:with-param name="tTitle" select="concat('T24 - dataTable Configuration ',$dT_Type,' not Defined')"/> 
					<xsl:with-param name="tType" select="3"/> 	
					<xsl:with-param name="tAppear" select="1000"/>
					<xsl:with-param name="tDuration" select="3000"/>  	
				</xsl:call-template>
				<xsl:call-template name="Node_Std_Table">
		            <xsl:with-param name="dT_Type" select="'99'" />
		        </xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>
	<xsl:template name="DynamicXTable"> 			<!-- Dynamic Crosstable and DD on Detail  -->
		<xsl:param name="XTable_Name" select="'XTABName01'"/> 		<!-- Unique Name for dataTable -->
		<xsl:param name="DBWEB" select="'KPI_SUMMARY'"/>
		<xsl:param name="vKPI" select="'NONE'"/>
		<xsl:param name="vVKEYD" select="'NONE'"/>
		<xsl:param name="XMLFileName" select="'name.xml'"/> 		<!-- Name of File for Drill-Down on Value WITHOUT additionnal parameters. With param DD ='NO', this param must not be provided -->
		<xsl:param name="XMLFileParamName" select="'name.xml'"/> 	<!-- Name of File for Drill-Down on Value WITH additionnal parameters. With param DD ='NO', this param must not be provided -->
		<xsl:param name="vR1" select="'XXX'"/> 			<!-- First Horizontal Grouping -->
		<xsl:param name="vR2" select="'YYY'"/> 			<!-- Second Horizontal Grouping. If value is equal to vR1 only one column will be displayed -->
		<xsl:param name="vInfoR1" select="''"/> 			<!-- Additional Info First Horizontal Grouping -->
		<xsl:param name="vInfoR2" select="''"/> 			<!-- Additional Info Second Horizontal Grouping --> 
		<xsl:param name="vC1" select="'ZZZ'"/> 		<!-- Vertical Grouping. One column per value found -->
		<xsl:param name="vCodeR1" select="'NONE'"/> 		<!-- Allow PopUp with LookUps Code. Code Type must be provided. Value found will display Code explanation for R1 -->
		<xsl:param name="vCodeR2" select="'NONE'"/> 		<!-- Allow PopUp with LookUps Code. Code Type must be provided. Value found will display Code explanation for R2 -->
		<xsl:param name="vCodeC1" select="'NONE'"/> 		<!-- Allow PopUp with LookUps Code. Code Type must be provided. Value found will display Code explanation for C1 -->
		<xsl:param name="CalcType" select="'SUM'"/> 		<!-- Calculation Type for Totals. Default 'SUM'/ 'AVG' /'VAL' With Sum HORTOT and VERTOT are available and with 'VAL' Special Features can be used -->
		<xsl:param name="HORTOT" select="'YES'"/> 			<!-- Show Horizontal Total (Right). Default 'YES'/'NO' -->
		<xsl:param name="VERTOT" select="'YES'"/> 			<!-- Show Vertical Total (Bottom). Default 'YES'/'NO' -->
		<xsl:param name="NRT" select="'NRT'"/>				<!-- Default NRT (RT) -->
		<xsl:param name="NREC" select="'NO'"/>				<!-- Show value in NREC. Defult 'NO'/'YES' -->
		<xsl:param name="DD" select="'YES'"/>				<!-- Values in XTABLE are Hyperlinks. Defult 'NO'/'YES' -->
		<xsl:param name="dictionary" select="document('IL_MR_RepDic.xml')"/> 	
		<xsl:param name="Lang" select="$vLANG"/>
		<xsl:param name="RepDic" select="'Y'"/>				<!-- Use of Report Dictionnary. Default 'N' / 'Y' -->
		<xsl:param name="dT_HeatMap" select="$vNodeHeatMap"/>			<!-- Show heatmap button. Default 'Y' / 'Y' -->
		<xsl:param name="vAddInfo1" select="''"/> 			<!-- Additional Info 1 at end -->
		<xsl:param name="vAddInfo2" select="''"/> 			<!-- Additional Info 2 at end -->
		
		<br/>
		<table class="display cell-border" align="center">
			<xsl:attribute  name="id">dT_<xsl:value-of select="$XTable_Name"/></xsl:attribute>
			<thead>
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="$NRT='RT'">MRBlockRT</xsl:when>
						<xsl:when test="$NRT='NONE'">NONE</xsl:when>
						<xsl:otherwise>MRBlock</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<tr>
					<th>
						<xsl:value-of select="$vR1"/>
					</th>
					<xsl:if test="$vInfoR1!=''">
						<th>
							<xsl:attribute name="class">MRNC11</xsl:attribute>
							<xsl:value-of select="$vInfoR1"/>
						</th>
					</xsl:if>
					<xsl:if test="$vR1!=$vR2 and $vR2!='NONE'">
						<th>
							<xsl:value-of select="$vR2"/>
						</th>
					</xsl:if>
					<xsl:if test="$vInfoR2!=''">
						<th>
							<xsl:attribute name="class">MRNC11</xsl:attribute>
							<xsl:value-of select="$vInfoR2"/>
						</th>
					</xsl:if>
					<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vC1]">
						<xsl:sort select='current-grouping-key()'/>
						<xsl:if test="$vCodeC1='NONE'">
							<th align="center">
								<xsl:attribute name="class">MRNC11</xsl:attribute>
								<!--xsl:value-of select='current-grouping-key()'/-->
								<xsl:call-template name="FromDic2Rep">
									<xsl:with-param name="Title2S" select="current-grouping-key()"/>
									<xsl:with-param name="Lang" select="$Lang"/>
									<xsl:with-param name="dictionary" select="$dictionary"/>
									<xsl:with-param name="tDDConfig" select="'C'"/>
								</xsl:call-template>
							</th>
						</xsl:if>
						<xsl:if test="$vCodeC1!='NONE'">
							<xsl:variable name="SpeXTab">MRN_SPE10#<xsl:value-of select='$vCodeC1'/>#<xsl:value-of select='current-grouping-key()'/></xsl:variable>
							<th align="center">
								<xsl:attribute name="class">MRNC11</xsl:attribute>
								<xsl:call-template name="SPE_Feature">
									<xsl:with-param name="FieldVal" select="$SpeXTab"/>
								</xsl:call-template>
							</th>
						</xsl:if>
					</xsl:for-each-group>
					<xsl:if test="$HORTOT='YES'">
						<th align='center'>Totals</th>
					</xsl:if>
					<xsl:if test="$vAddInfo1!=''">
						<th>
							<xsl:attribute name="class">MRNC11</xsl:attribute>
							<xsl:value-of select="$vAddInfo1"/>
						</th>
					</xsl:if>
					<xsl:if test="$vAddInfo2!=''">
						<th>
							<xsl:attribute name="class">MRNC11</xsl:attribute>
							<xsl:value-of select="$vAddInfo2"/>
						</th>
					</xsl:if>
				</tr>
			</thead>
			<!-- begin loop to create crosstab body -->
			<tbody>
				<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vR1]">
					<xsl:sort select="@*[local-name() = $vR1]" order="ascending"/>
					<xsl:variable name="v1Row"><xsl:value-of select='current-grouping-key()'/></xsl:variable>
					
					<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row]" group-by="@*[local-name() = $vR2]">
						<xsl:variable name="v2Row"><xsl:value-of select='current-grouping-key()'/></xsl:variable>
						<tr>
							<xsl:if test="$vCodeR1='NONE'">
								<td>
									<xsl:attribute name="data-order"><xsl:value-of select="replace($v1Row,',','.')"/></xsl:attribute>
									<xsl:attribute name="class">MRNC11</xsl:attribute>
									<xsl:value-of select="$v1Row"/>
								</td>
							</xsl:if>
							<xsl:if test="$vCodeR1!='NONE'">
								<xsl:variable name="SpeXTab">MRN_SPE10#<xsl:value-of select='$vCodeR1'/>#<xsl:value-of select='$v1Row'/></xsl:variable>
								<td>
									<xsl:attribute name="data-order"><xsl:value-of select="replace($v1Row,',','.')"/></xsl:attribute>
									<xsl:attribute name="class">MRNC11</xsl:attribute>
									<xsl:call-template name="SPE_Feature">
										<xsl:with-param name="FieldVal" select="$SpeXTab"/>
									</xsl:call-template>
								</td>
							</xsl:if>
							<xsl:if test="$vInfoR1!=''">
								<td>
									<xsl:attribute name="class">MRNC12</xsl:attribute>
									<xsl:call-template name="SPE_Feature">
										<xsl:with-param name="FieldVal" select="@*[local-name() = $vInfoR1]"/>
									</xsl:call-template>
								</td>
							</xsl:if>
							<xsl:if test="$vR1!=$vR2 and $vR2!='NONE'">
								<xsl:if test="$vCodeR2='NONE'">
									<td>
										<xsl:attribute name="data-order"><xsl:value-of select="replace($v2Row,',','.')"/></xsl:attribute>
										<xsl:attribute name="class">MRNC12</xsl:attribute>
										<xsl:value-of select="$v2Row"/>
									</td>
								</xsl:if>
								<xsl:if test="$vCodeR2!='NONE'">
									<xsl:variable name="SpeXTab">MRN_SPE10#<xsl:value-of select='$vCodeR2'/>#<xsl:value-of select='$v2Row'/></xsl:variable>
									<td>
										<xsl:attribute name="data-order"><xsl:value-of select="replace($v2Row,',','.')"/></xsl:attribute>
										<xsl:attribute name="class">MRNC12</xsl:attribute>
										<xsl:call-template name="SPE_Feature">
											<xsl:with-param name="FieldVal" select="$SpeXTab"/>
										</xsl:call-template>
									</td>
								</xsl:if>
								<xsl:if test="$vInfoR2!=''">
									<td>
										<xsl:attribute name="class">MRNC12</xsl:attribute>
										<xsl:call-template name="SPE_Feature">
											<xsl:with-param name="FieldVal" select="@*[local-name() = $vInfoR2]"/>
										</xsl:call-template>
									</td>
								</xsl:if>
							</xsl:if>
							<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vC1]">
								<xsl:sort select="@*[local-name() = $vC1]"/>
								<xsl:variable name="vCol"><xsl:value-of select="@*[local-name() = $vC1]"/></xsl:variable>
								<xsl:variable name="vVALUE"><xsl:value-of select="count(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and(@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol])"/></xsl:variable>
								<xsl:choose>
									 <xsl:when test="$vVALUE=0">
										<td data-order="0"></td>
									 </xsl:when>
									 <xsl:otherwise>
										<td align="center">
											<xsl:attribute name="data-order">
												<xsl:choose>
													<xsl:when test="$CalcType='SUM'">
														<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NBR),'###.###')" />
													</xsl:when>
													<xsl:when test="$CalcType='AVG'">
														<xsl:value-of select="format-number(avg(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NBR),'###.###')" />
													</xsl:when>
													<xsl:when test="$CalcType='VAL'">
														<xsl:value-of select="format-number(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NBR,'###.###')" />
													</xsl:when>
													<xsl:otherwise>
														???
													</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
											<xsl:if test="$DD='YES'">
												<xsl:element name='a'>
													<xsl:attribute name='href'>#!</xsl:attribute>
													<xsl:attribute name='title'>Click to See Details <xsl:if test="$NREC='YES'">(<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NREC),'###,###')" /> Records)</xsl:if></xsl:attribute>
													<!-- File name without extra parameter -->
													<xsl:if test="$XMLFileName!='name.xml'">
														<xsl:attribute name='onclick'>var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;p<xsl:value-of select="$vR1"/>=<xsl:value-of select="$v1Row"/><xsl:if test="$vR1!=$vR2 and $vR2!='NONE'">&amp;p<xsl:value-of select="$vR2"/>=<xsl:value-of select="$v2Row"/></xsl:if>&amp;p<xsl:value-of select="$vC1"/>=<xsl:value-of select="$vCol"/>&amp;pMODE=Drill-Down&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;XXX='+Math.floor(Math.random()*1001);loadDiv(TargetDiv,TargetLoad);MRNNotif('1','Drill-Down','Load : &lt;a href="'+TargetLoad+'" target="_blank">'+TargetLoad+' &lt;/a> in '+TargetDiv,10,'ALL','<xsl:value-of select="$vNodeConfig"/>')</xsl:attribute>
													</xsl:if>
													<!-- File name with extra parameter -->
													<xsl:if test="$XMLFileParamName!='name.xml'">
														<xsl:attribute name='onclick'>var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;p<xsl:value-of select="$vR1"/>=<xsl:value-of select="$v1Row"/><xsl:if test="$vR1!=$vR2 and $vR2!='NONE'">&amp;p<xsl:value-of select="$vR2"/>=<xsl:value-of select="$v2Row"/></xsl:if>&amp;p<xsl:value-of select="$vC1"/>=<xsl:value-of select="$vCol"/>&amp;pMODE=Drill-Down&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;XXX='+Math.floor(Math.random()*1001);loadDiv(TargetDiv,TargetLoad);MRNNotif('1','Drill-Down Called','Load : &lt;a href="'+TargetLoad+'" target="_blank">'+TargetLoad+' &lt;/a> in '+TargetDiv,10,'ALL','<xsl:value-of select="$vNodeConfig"/>')</xsl:attribute>
													</xsl:if>
													<xsl:choose>
														<xsl:when test="$CalcType='SUM'">
															<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NBR),'###,###')" />
														</xsl:when>
														<xsl:when test="$CalcType='AVG'">
															<xsl:value-of select="format-number(avg(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NBR),'###,###')" />
														</xsl:when>
														<xsl:when test="$CalcType='VAL'">
															<xsl:value-of select="//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NBR" />
														</xsl:when>
														<xsl:otherwise>
															???
														</xsl:otherwise>
													</xsl:choose>
												</xsl:element>
											</xsl:if>
											<xsl:if test="$DD='NO'">
												<xsl:choose>
													<xsl:when test="$CalcType='SUM'">
														<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NBR),'###,###')" />
													</xsl:when>
													<xsl:when test="$CalcType='AVG'">
														<xsl:value-of select="format-number(avg(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NBR),'###,###')" />
													</xsl:when>
													<!-- Only in this Case SPE can be used -->
													<xsl:when test="$CalcType='VAL'">
														<xsl:call-template name="SPE_Feature">
															<xsl:with-param name="FieldVal" select="//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NBR"/>
														</xsl:call-template>
														<!-- 
														<xsl:value-of select="//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row and (@*[local-name() = $vC1])=$vCol]/@NBR" />
														-->
													</xsl:when>
													<xsl:otherwise>
														???
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
										</td> 
									</xsl:otherwise>
								</xsl:choose>       
							</xsl:for-each-group>  
							<xsl:if test="$HORTOT='YES' and $CalcType='SUM'">
								<td align="center">
									<xsl:if test="$DD='YES'">
										<xsl:attribute name="class">MRNCF18</xsl:attribute>
										<xsl:choose>
											<xsl:when test="$CalcType='SUM'">
												<xsl:attribute name="data-order"><xsl:value-of select="sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row]/@NBR)"/></xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="data-order">???</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<b><xsl:element name='a'>
											<xsl:attribute name='href'>#!</xsl:attribute>
											<xsl:attribute name='title'>Click to See Details <xsl:if test="$NREC='YES'">(<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row]/@NREC),'###,###')" /> Records)</xsl:if></xsl:attribute>
											<!-- File name without extra parameter -->
											<xsl:if test="$XMLFileName!='name.xml'">
												<xsl:attribute name='onclick'>var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;p<xsl:value-of select="$vR1"/>=<xsl:value-of select="$v1Row"/><xsl:if test="$vR1!=$vR2 and $vR2!='NONE'">&amp;p<xsl:value-of select="$vR2"/>=<xsl:value-of select="$v2Row"/></xsl:if>&amp;pMODE=Drill-Down&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;XXX='+Math.floor(Math.random()*1001);loadDiv(TargetDiv,TargetLoad);MRNNotif('1','Drill-Down','Load : &lt;a href="'+TargetLoad+'" target="_blank">'+TargetLoad+' &lt;/a> in '+TargetDiv,10,'ALL','<xsl:value-of select="$vNodeConfig"/>')</xsl:attribute>
											</xsl:if>
											<!-- File name with extra parameter -->
											<xsl:if test="$XMLFileParamName!='name.xml'">
												<xsl:attribute name='onclick'>var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;p<xsl:value-of select="$vR1"/>=<xsl:value-of select="$v1Row"/><xsl:if test="$vR1!=$vR2 and $vR2!='NONE'">&amp;p<xsl:value-of select="$vR2"/>=<xsl:value-of select="$v2Row"/></xsl:if>&amp;pMODE=Drill-Down&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;XXX='+Math.floor(Math.random()*1001);loadDiv(TargetDiv,TargetLoad);MRNNotif('1','Drill-Down','Load : &lt;a href="'+TargetLoad+'" target="_blank">'+TargetLoad+' &lt;/a> in '+TargetDiv,10,'ALL','<xsl:value-of select="$vNodeConfig"/>')</xsl:attribute>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="$CalcType='SUM'">
													<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row]/@NBR),'###,###')" />
												</xsl:when>
												<xsl:otherwise>
													???
												</xsl:otherwise>
											</xsl:choose>
										</xsl:element></b>
									</xsl:if>
									<xsl:if test="$DD='NO'">
										<xsl:attribute name="class">MRNC04</xsl:attribute>
										<xsl:choose>
											<xsl:when test="$CalcType='SUM'">
												<xsl:attribute name="data-order"><xsl:value-of select="sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row]/@NBR)"/></xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="data-order">???</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<b>
											<xsl:choose>
												<xsl:when test="$CalcType='SUM'">
													<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vR1])=$v1Row and (@*[local-name() = $vR2])=$v2Row]/@NBR),'###,###')" />
												</xsl:when>
												<xsl:otherwise>
													???
												</xsl:otherwise>
											</xsl:choose>
										</b>
									</xsl:if>
								</td> 			
							</xsl:if>
							<xsl:if test="$vAddInfo1!=''">
								<td>
									<xsl:call-template name="SPE_Feature">
										<xsl:with-param name="FieldVal" select="@*[local-name() = $vAddInfo1]"/>
									</xsl:call-template>
								</td>
							</xsl:if>	
							<xsl:if test="$vAddInfo2!=''">
								<td>
									<xsl:call-template name="SPE_Feature">
										<xsl:with-param name="FieldVal" select="@*[local-name() = $vAddInfo2]"/>
									</xsl:call-template>
								</td>
							</xsl:if>			
						</tr>
					</xsl:for-each-group>
				</xsl:for-each-group>
			</tbody>
			<xsl:if test="$VERTOT='YES' and $CalcType='SUM'">	
				<tfoot>
					<tr class="MRNCF18">
						<th class="CPN_Search">
							<xsl:call-template name="FromDic2Rep">
								<xsl:with-param name="Title2S" select="@name"/>
								<xsl:with-param name="Lang" select="$Lang"/>
								<xsl:with-param name="dictionary" select="$dictionary"/>
								<xsl:with-param name="tDDConfig" select="'IP'"/>
							</xsl:call-template>
						</th>
						<xsl:if test="$vInfoR1!=''">
							<th class="CPN_Search">
								<xsl:call-template name="FromDic2Rep">
									<xsl:with-param name="Title2S" select="@name"/>
									<xsl:with-param name="Lang" select="$Lang"/>
									<xsl:with-param name="dictionary" select="$dictionary"/>
									<xsl:with-param name="tDDConfig" select="'IP'"/>
								</xsl:call-template>
							</th>
						</xsl:if>
						<xsl:if test="$vR1!=$vR2 and $vR2!='NONE'">
							<th class="CPN_Search">
								<xsl:call-template name="FromDic2Rep">
									<xsl:with-param name="Title2S" select="@name"/>
									<xsl:with-param name="Lang" select="$Lang"/>
									<xsl:with-param name="dictionary" select="$dictionary"/>
									<xsl:with-param name="tDDConfig" select="'IP'"/>
								</xsl:call-template>
							</th>
							<xsl:if test="$vInfoR2!=''">
								<th class="CPN_Search">
									<xsl:call-template name="FromDic2Rep">
										<xsl:with-param name="Title2S" select="@name"/>
										<xsl:with-param name="Lang" select="$Lang"/>
										<xsl:with-param name="dictionary" select="$dictionary"/>
										<xsl:with-param name="tDDConfig" select="'IP'"/>
									</xsl:call-template>
								</th>
							</xsl:if>
						</xsl:if>
						<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vC1]">
							<xsl:sort select="@*[local-name() = $vC1]"/>
							<xsl:variable name="vCol"><xsl:value-of select="@*[local-name() = $vC1]"/></xsl:variable>
							<th align="center">
								<xsl:if test="$DD='YES'">
									<xsl:element name='a'>
										<xsl:attribute name='href'>#!</xsl:attribute>
										<xsl:attribute name='title'>Click to See Details <xsl:if test="$NREC='YES'">(<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vC1])=$vCol]/@NREC),'###,###')" /> Records)</xsl:if></xsl:attribute>
										<!-- File name without extra parameter -->
										<xsl:if test="$XMLFileName!='name.xml'">
											<xsl:attribute name='onclick'>var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;p<xsl:value-of select="$vC1"/>=<xsl:value-of select="$vCol"/>&amp;pMODE=Drill-Down&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;XXX='+Math.floor(Math.random()*1001);loadDiv(TargetDiv,TargetLoad);MRNNotif('1','Drill-Down','Load : &lt;a href="'+TargetLoad+'" target="_blank">'+TargetLoad+' &lt;/a> in '+TargetDiv,10,'ALL','<xsl:value-of select="$vNodeConfig"/>')</xsl:attribute>
										</xsl:if>
										<!-- File name with extra parameter -->
										<xsl:if test="$XMLFileParamName!='name.xml'">
											<xsl:attribute name='onclick'>var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;p<xsl:value-of select="$vC1"/>=<xsl:value-of select="$vCol"/>&amp;pMODE=Drill-Down&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;XXX='+Math.floor(Math.random()*1001);loadDiv(TargetDiv,TargetLoad);MRNNotif('1','Drill-Down','Load : &lt;a href="'+TargetLoad+'" target="_blank">'+TargetLoad+' &lt;/a> in '+TargetDiv,10,'ALL','<xsl:value-of select="$vNodeConfig"/>')</xsl:attribute>
										</xsl:if>
										<xsl:choose>
											<xsl:when test="$CalcType='SUM'">
												<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vC1])=$vCol]/@NBR),'###,###')" />
											</xsl:when>
											<xsl:otherwise>
												???
											</xsl:otherwise>
										</xsl:choose>
									</xsl:element>
								</xsl:if>
								<xsl:if test="$DD='NO'">
									<xsl:choose>
										<xsl:when test="$CalcType='SUM'">
											<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vC1])=$vCol]/@NBR),'###,###')" />
										</xsl:when>
										<xsl:otherwise>
											???
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
							</th>							
						</xsl:for-each-group>
						<xsl:if test="$HORTOT='YES' and $VERTOT='YES' and $CalcType='SUM'">
							<th align="center">
								<xsl:attribute name="class">MRNCF19</xsl:attribute>
								<xsl:if test="$DD='YES'">
									<xsl:element name='a'>
										<xsl:attribute name='href'>#!</xsl:attribute>
										<xsl:attribute name='title'>Click to See Details <xsl:if test="$NREC='YES'">(<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row/@NREC),'###,###')" /> Records)</xsl:if></xsl:attribute>
										<!-- File name without extra parameter -->
										<xsl:if test="$XMLFileName!='name.xml'">
											<xsl:attribute name='onclick'>var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pMODE=Drill-Down&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;XXX='+Math.floor(Math.random()*1001);loadDiv(TargetDiv,TargetLoad);MRNNotif('1','Drill-Down','Load : &lt;a href="'+TargetLoad+'" target="_blank">'+TargetLoad+' &lt;/a> in '+TargetDiv,10,'ALL',,'<xsl:value-of select="$vNodeConfig"/>')</xsl:attribute>
										</xsl:if>
										<!-- File name with extra parameter -->
										<xsl:if test="$XMLFileParamName!='name.xml'">
											<xsl:attribute name='onclick'>var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pMODE=Drill-Down&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;XXX='+Math.floor(Math.random()*1001);loadDiv(TargetDiv,TargetLoad);MRNNotif('1','Drill-Down','Load : &lt;a href="'+TargetLoad+'" target="_blank">'+TargetLoad+' &lt;/a> in '+TargetDiv,10,'ALL','<xsl:value-of select="$vNodeConfig"/>')</xsl:attribute>
										</xsl:if>
										<xsl:choose>
											<xsl:when test="$CalcType='SUM'">
												<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row/@NBR),'###,###')" />
											</xsl:when>
											<xsl:otherwise>
												???
											</xsl:otherwise>
										</xsl:choose>
									</xsl:element>
								</xsl:if>
								<xsl:if test="$DD='NO'">
									<xsl:choose>
										<xsl:when test="$CalcType='SUM'">
											<xsl:value-of select="format-number(sum(//dbquery[@id=$DBWEB]/rows/row/@NBR),'###,###')" />
										</xsl:when>
										<xsl:otherwise>
											???
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
							</th>
						</xsl:if>
						<xsl:if test="$vAddInfo1!=''">
							<th class="CPN_Search">
								<xsl:call-template name="FromDic2Rep">
									<xsl:with-param name="Title2S" select="@name"/>
									<xsl:with-param name="Lang" select="$Lang"/>
									<xsl:with-param name="dictionary" select="$dictionary"/>
									<xsl:with-param name="tDDConfig" select="'IP'"/>
								</xsl:call-template>
							</th>
						</xsl:if>
						<xsl:if test="$vAddInfo2!=''">
							<th class="CPN_Search">
								<xsl:call-template name="FromDic2Rep">
									<xsl:with-param name="Title2S" select="@name"/>
									<xsl:with-param name="Lang" select="$Lang"/>
									<xsl:with-param name="dictionary" select="$dictionary"/>
									<xsl:with-param name="tDDConfig" select="'IP'"/>
								</xsl:call-template>
							</th>
						</xsl:if>
					</tr>
				</tfoot>
			</xsl:if>
		</table>

		<xsl:call-template name="Node_Std_Table">
			<xsl:with-param name="Table_Name" select="$XTable_Name"/>
			<xsl:with-param name="dT_Type" select="'99'"/>
			<xsl:with-param name="Col_Filtering" select="'Y'"/>
			<!-- Special Case for XTable Nbr records retrieved after XT Generation -->
			<xsl:with-param name="Records" select="0"/> 
			<xsl:with-param name="dT_HeatMap" select="$dT_HeatMap"/>
		</xsl:call-template>
		
		<xsl:if test="$CalcType='SUM' and sum(//dbquery[@id=$DBWEB]/rows/row/@NBR)&lt;=50 and count(//dbquery[@id=$DBWEB]/descriptor/error) != 0">
			<script>
				var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';
				<!-- File name without extra parameter -->
				<xsl:if test="$XMLFileName!='name.xml'">
					var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
				</xsl:if>
				<!-- File name with extra parameter -->
				<xsl:if test="$XMLFileParamName!='name.xml'">
					var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
				</xsl:if>	
				loadDiv(TargetDiv,TargetLoad);
			</script>
		</xsl:if>
	</xsl:template>
	<xsl:template name="old_DynamicGraph_old"> 				<!-- Dynamic (Stacked) Graph and DD on Detail -->
		<xsl:param name="XTable_Name" select="'XTABName01'"/>
		<xsl:param name="DBWEB" select="'KPI_SUMMARY'"/>
		<xsl:param name="vKPI" select="'NONE'"/>
		<xsl:param name="vVKEYD" select="'NONE'"/>
		<xsl:param name="XMLFileName" select="'name.xml'"/>
		<xsl:param name="XMLFileParamName" select="'name.xml'"/>
		<xsl:param name="vR1" select="'YEAR'"/>
		<xsl:param name="vR2" select="'STATUS'"/>
		<xsl:param name="vC1" select="'PRIORITY'"/>
		<xsl:param name="vCodeR1" select="'NONE'"/>
		<xsl:param name="vCodeR2" select="'NONE'"/>
		<xsl:param name="vCodeC1" select="'NONE'"/>
		<xsl:param name="CalcType" select="'SUM'"/> <!-- SUM or AVG -->

		<!-- Start Graph Component -->
		<script>
			$(function(){		
				// Allows Drill-Down on Legend Value
				function DDGraphLegend(val){
					var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';
					<!-- File name without extra parameter -->
					<xsl:if test="$XMLFileName!='name.xml'">
						var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vC1"/>='+val+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
					</xsl:if>
					<!-- File name with extra parameter -->
					<xsl:if test="$XMLFileParamName!='name.xml'">
						var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>p<xsl:value-of select="$vC1"/>='+val+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
					</xsl:if>
					loadDiv(TargetDiv,TargetLoad);
				}
				// Create href string to call report with extra parameters
				function clickToHref() {

					// Url of the report up to the "?" character
					var sReportURL = '<xsl:value-of select="/dbqueries/dbquery[@id='Report_Info']/rows/row/@dbn_rep_node_url" /><xsl:value-of select="/dbqueries/dbquery[@id='Report_Info']/rows/row/@dbn_rep_url" />' + '?';

					// Array containing all possible report parameters
					var aReportParam = [
						<xsl:for-each select="/dbqueries/dbquery[@id='Report_Info']/descriptor/parameters/param">
							'<xsl:value-of select="@name" />', '<xsl:value-of select="@value" />',
						</xsl:for-each>
					];

					// Update the parameters array using the functions arguments
					for(var i = 0; i &lt; arguments.length; i=i+2) {
						aReportParam[aReportParam.indexOf(arguments[i])+1] = arguments[i+1]
					}

					// Convert the parameters array into a formatted parameters string
					var sReportParam = ''
					for (var i=0; i &lt; aReportParam.length; i=i+2) {
						sReportParam = sReportParam + aReportParam[i] + '=' + escape(aReportParam[i+1]) + '&amp;';
					}

					// Concatenate and return the base url and its new parameters
					//alert(sReportURL + sReportParam);
					return sReportURL + sReportParam;
				};

				// Function to chart
				$.fn.chartMRN<xsl:value-of select='$XTable_Name'/> = (function() {
					// Variable to hold xaxis tick labels and their anchor formatting. href is defined at click event.
					var ticksLabels = [
						<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vR1]">
							<xsl:sort select="@*[local-name() = $vR1]" data-type="text" order="ascending" />
							[<xsl:value-of select="position()" />,'<xsl:value-of select="@*[local-name() = $vR1]"/>'],
						</xsl:for-each-group>
					];

					// Variable Holding the series' specific data
					var chartData = [
						<!-- Group and sort to create the series -->
						<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vC1]">
							<xsl:sort select="@*[local-name() = $vC1]" data-type="text" order="ascending" />
							<xsl:variable name="vVROW1"><xsl:value-of select="@*[local-name() = $vC1]" /></xsl:variable>
							{
								label: '<xsl:value-of select="$vVROW1" />',
								data: [
									<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vR1]">
										<xsl:sort select="@*[local-name() = $vR1]" data-type="text" order="ascending" />
										<xsl:variable name="vVCOL1"><xsl:value-of select="@*[local-name() = $vR1]" /></xsl:variable>
										[
											<xsl:value-of select="position()" />,
											<xsl:choose>
												<xsl:when test="$CalcType='SUM'">
													<xsl:value-of select="sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vC1])=$vVROW1 and (@*[local-name() = $vR1]) = $vVCOL1]/@NBR)" />
												</xsl:when>
												<xsl:when test="$CalcType='AVG'">
													<xsl:value-of select="avg(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vC1])=$vVROW1 and (@*[local-name() = $vR1]) = $vVCOL1]/@NBR)" />
												</xsl:when>
												<xsl:otherwise>
													???
												</xsl:otherwise>
											</xsl:choose>
										],
									</xsl:for-each-group>
								]
							},
						</xsl:for-each-group>
					];
					
					// Variable to hold the global chart options
					var chartOptions = {

						grid: {
							borderWidth: 0,
							margin: 0,
							hoverable: true,
							clickable: true,
						},

						legend: {
							container: $("#legendIniMrc"),
							noColumns: 2,
							labelFormatter: function(label,series){
								//return '&lt;a href=' + clickToHref('pSTATUS',label) + '&gt;' + label + '&lt;/a&gt;';
								//return "&lt;span onclick='DDGraphLegend(\"" + label + "\")'&gt;" + label + "&lt;/span&gt;";
								//return "&lt;span onclick='alert(\"" + label + "\")'&gt;" + label + "&lt;/span&gt;";
								return "&lt;span onclick='var TargetDiv = \"DD_<xsl:value-of select='$vKPI'/>_<xsl:value-of select='$vVKEYD'/>\";var TargetLoad = \"<xsl:if test="$XMLFileName!='name.xml'"><xsl:value-of select='$XMLFileName'/>?</xsl:if><xsl:if test="$XMLFileParamName!='name.xml'"><xsl:value-of select='$XMLFileParamName'/>&amp;</xsl:if>pRID=<xsl:value-of select='$vRID'/>&amp;pKPI=<xsl:value-of select='$vKPI'/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select='$vVKEYD'/>&amp;p<xsl:value-of select='$vC1'/>="+label+"&amp;pMODE=Drill-Down&amp;XXX=\"+Math.floor(Math.random()*1001);loadDiv(TargetDiv,TargetLoad);'&gt;" + label + "&lt;/span&gt;";
							},
						},

						xaxis: {
							mode: null,
							tickSize: 1,
							tickLength: 0,
							ticks: ticksLabels,
						},

						series: {
							bars: {
								show: true,
								fill: .75, // 0 and false are fully tranparent, 1 fully opaque, true = default
								lineWidth: 0, // Remove bar border
								barWidth: .5,
								align: 'center' // To algin with tick
							},
							stack: 0
						}

					};

					// Function to build the chart and place it in its container
					$.plot("#chartMRN<xsl:value-of select='$XTable_Name'/>", chartData, chartOptions);

					// Rotate xaxis tick labels to avoid overlapping ticks. Maximum to be defined manually.
					if (ticksLabels.length > 18) {
						$("#chartMRN .flot-x-axis div.flot-tick-label").css(
							"transform", "translateX(25%) translateY(25%) rotate(45deg)",
							"transform-origin", "0 0",
							"cursor", "pointer"
						);
					};

					// Interactive xaxis labels. Needs to increase zIndex to access the tick by clicking.
					$(".flot-tick-label").css(
						"zIndex","1000",
						"cursor", "pointer"
					);
					$(".flot-x-axis .flot-tick-label").click(function() {
						
						// OK - alert('Action 1 on X Label. Value :'+$(this).text());
						
						var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';
						<!-- File name without extra parameter -->
						<xsl:if test="$XMLFileName!='name.xml'">
							var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vR1"/>='+$(this).text()+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
						</xsl:if>
						<!-- File name with extra parameter -->
						<xsl:if test="$XMLFileParamName!='name.xml'">
							var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vR1"/>='+$(this).text()+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
						</xsl:if>
						loadDiv(TargetDiv,TargetLoad);
					} );

					// Interactive chart bars
					// Strange 2 times VKEYD
					$("#chartMRN<xsl:value-of select='$XTable_Name'/>").bind("plotclick", function(event, pos, item) {
						if (item) {
							//OK - alert('Action 2 on details. Value :'+ item.series.xaxis.ticks[item.dataIndex].label + ' and '+item.series.label);
							var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';
							<!-- File name without extra parameter -->
							<xsl:if test="$XMLFileName!='name.xml'">
								var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;p<xsl:value-of select="$vR1"/>='+ item.series.xaxis.ticks[item.dataIndex].label + '&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vC1"/>='+item.series.label+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
							</xsl:if>
							<!-- File name with extra parameter -->
							<xsl:if test="$XMLFileParamName!='name.xml'">
								var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vR1"/>='+ item.series.xaxis.ticks[item.dataIndex].label + '&amp;p<xsl:value-of select="$vC1"/>='+item.series.label+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
							</xsl:if>
							loadDiv(TargetDiv,TargetLoad);
						}

					} );

				} );

				// Call the plot function
				$().chartMRN<xsl:value-of select='$XTable_Name'/>();
				$(".flot-x-axis .flot-tick-label").css('cursor', 'pointer');
				$("#legendIniMrc").css('cursor', 'pointer');

			});
		</script>
		<br/>
		<table width="100%" border="0">
			<td width="80%" align="center">
				<div class="demo-placeholder" style="width:800px; height:450px;">
					<xsl:attribute name="id">chartMRN<xsl:value-of select='$XTable_Name'/></xsl:attribute>
				</div>
			</td>
			<td width="20%" align="center"><div class="" id="legendIniMrc"></div></td>
		</table>
		<!-- End Graph Component--> 
	</xsl:template>
	<xsl:template name="PivotTable">
		<xsl:param name="tDBWeb" select="'PIVOT'"/>                                                              <!-- QueryString Name -->
		<xsl:param name="tUPN" select="generate-id(//dbquery[@id=$tDBWeb]/@id)"/>                <!-- Unique Pivot Name -->
		<xsl:param name="tRows" select="''"/>                                                               <!-- Rows Fields Names (QueryString) -->
		<xsl:param name="tCols" select="''"/>                                                  <!-- Columns Fields Names (QueryString) -->
		<xsl:param name="tRender" select="'Table'"/>                                <!-- Rendering Type : Table/Heatmap ... See DropDown -->
		<xsl:param name="tAgg" select="'Sum'"/>                                          <!-- Aggregation Type Sum,Count, ... See dropDown -->
		<xsl:param name="tVals" select="'NBR'"/>                                         <!-- Aggregation value : Field name in QueryString -->
                                    
        <script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/PivotTable/jquery-ui.min.js"></script>
        <link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/PivotTable/pivot.css"/>
        <script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/PivotTable/pivot.js"></script>
        <script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/PivotTable/d3.min.js"></script>
        
        <!-- C3 Module -->
        <script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/PivotTable/d3_renderers.min.js"></script>
        <style>
            body {font-family: Verdana;}
            .node {
              border: solid 1px white;
              font: 10px sans-serif;
              line-height: 12px;
              overflow: hidden;
              position: absolute;
              text-indent: 2px;
            }
        </style>
        <!-- D3 Module -->
        <link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/PivotTable/c3.min.css"/>
        <script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/PivotTable/c3.min.js"></script>
        <script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/PivotTable/c3_renderers.js"></script>
        <style>
            body {font-family: Verdana;}
                        .c3-line, .c3-focused {stroke-width: 3px !important;}
                        .c3-bar {stroke: white !important; stroke-width: 1;}
                        .c3 text { font-size: 12px; color: grey;}
                        .tick line {stroke: white;}
                        .c3-axis path {stroke: grey;}
                        .c3-circle { opacity: 1 !important; }
        </style>
                                
        <script>
            $(function(){
                    var derivers = $.pivotUtilities.derivers;
                    var renderers = $.extend(	$.pivotUtilities.renderers, 
												$.pivotUtilities.c3_renderers,
												$.pivotUtilities.d3_renderers);
                                
            $("#<xsl:value-of select='$tUPN'/>").pivotUI(
				[
					<xsl:for-each select = "//dbquery[@id=$tDBWeb]/rows/row">
						{
							<xsl:for-each select="@*">
								<xsl:value-of select="local-name()"/>:'<xsl:value-of select="."/>',
							</xsl:for-each>
						},
					</xsl:for-each>
				],
					{rows: [
						<xsl:for-each select="tokenize($tRows,',')">
								'<xsl:value-of select="."/>',
						</xsl:for-each>
									],
					cols: [
						<xsl:for-each select="tokenize($tCols,',')">
								'<xsl:value-of select="."/>',
						</xsl:for-each>
									],
					vals: ['<xsl:value-of select="$tVals"/>'],
					aggregatorName: "<xsl:value-of select="$tAgg"/>",
					rendererName: "<xsl:value-of select="$tRender"/>"}
			);
	 });

		</script>
                <div id="{$tUPN}" style="width: 90%;"></div>
    </xsl:template>
	<!-- New From NN And improved by MIB 1.0.4 -->
	<xsl:template name="DynamicGraph"> 			<!-- DHTMLX_Graph test -->
		<xsl:param name="DBWEB" select="'GRAPH'"/> 								<!-- QueryString Name -->
		<xsl:param name="XTable_Name" select="generate-id(//dbquery[@id=$DBWEB]/@id)"/> 	<!-- Unique DHTMLX_Graph Name -->
		<xsl:param name="tLibrary" select="'Flot'"/> 		<!-- Library : Flot/DHTMLX/HighCharts --> 
		<xsl:param name="tview" select="'stackedBar'"/> 	
			<!-- Graph Type : 
					Flot : stackedBar
					DHTMLX : pie/bar/donut (1D) and stackedBar (2D)
					Highcharts : area/column/line (2D and 1D)
					See Doc on Wiki -->
		<xsl:param name="tVals" select="'NBR'"/> 			<!-- Aggregation value : Field name in QueryString -->
		<xsl:param name="vR1" select="''"/> 		<!-- X axis -->
		<xsl:param name="vR2" select="''"/> 		<!-- Y axis -->
		<xsl:param name="vC1" select="''"/> 			<!--  -->
		<xsl:param name="vCodeR1" select="'NONE'"/> 		<!--  -->
		<xsl:param name="vCodeR2" select="'NONE'"/> 		<!--  -->
		<xsl:param name="vCodeC1" select="'NONE'"/> 		<!--  -->
		<xsl:param name="CalcType" select="'SUM'"/> 		<!-- SUM or AVG -->
		<xsl:param name="tGraphWidth" select="'900px'"/> 		<!-- Graph Width -->
		<xsl:param name="tGraphHeigth" select="'400px'"/> 		<!-- graph Height -->
		<xsl:param name="vKPI" select="'NONE'"/> 				<!-- For MR Node Only -->
		<xsl:param name="vVKEYD" select="'NONE'"/> 				<!-- For MR Node Only -->
		<xsl:param name="XMLFileName" select="'name.xml'"/> 	<!-- Depreacated -->
		<xsl:param name="XMLFileParamName" select="'name.xml'"/> 	<!-- For Drill-Down -->
		<xsl:param name="InTab" select="'NO'"/> 				<!-- YES/NO for DHTMLX only -->
		
		<!-- Depreacated Notification -->
		<xsl:if test="$XMLFileName!='name.xml'">
			<xsl:call-template name="TNotif">
				<xsl:with-param name="tMsg" select="'Message for Developpers : Parameter XMLFileName is used in Template DynamicGraph. We recommend to use only XMLFileParamName. Please warn Developpers or Administrators if this message appears.'"/>
				<xsl:with-param name="tTitle" select="'T46 - Param XMLFileName Depracated'"/> 
				<xsl:with-param name="tType" select="3"/> 	
				<xsl:with-param name="tAppear" select="1000"/>
				<xsl:with-param name="tDuration" select="2000"/>  	
			</xsl:call-template>
		</xsl:if>
		
		<xsl:choose>
			<xsl:when test="$tLibrary='Flot'">
				<!-- Start Graph Component -->
				<script>
					$(function(){		
						// Allows Drill-Down on Legend Value
						function DDGraphLegend(val){
							var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';
							<!-- File name without extra parameter -->
							<xsl:if test="$XMLFileName!='name.xml'">
								var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vC1"/>='+val+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
							</xsl:if>
							<!-- File name with extra parameter -->
							<xsl:if test="$XMLFileParamName!='name.xml'">
								var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>p<xsl:value-of select="$vC1"/>='+val+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
							</xsl:if>
							loadDiv(TargetDiv,TargetLoad);
						}
						// Create href string to call report with extra parameters
						function clickToHref() {

							// Url of the report up to the "?" character
							var sReportURL = '<xsl:value-of select="/dbqueries/dbquery[@id='Report_Info']/rows/row/@dbn_rep_node_url" /><xsl:value-of select="/dbqueries/dbquery[@id='Report_Info']/rows/row/@dbn_rep_url" />' + '?';

							// Array containing all possible report parameters
							var aReportParam = [
								<xsl:for-each select="/dbqueries/dbquery[@id='Report_Info']/descriptor/parameters/param">
									'<xsl:value-of select="@name" />', '<xsl:value-of select="@value" />',
								</xsl:for-each>
							];

							// Update the parameters array using the functions arguments
							for(var i = 0; i &lt; arguments.length; i=i+2) {
								aReportParam[aReportParam.indexOf(arguments[i])+1] = arguments[i+1]
							}

							// Convert the parameters array into a formatted parameters string
							var sReportParam = ''
							for (var i=0; i &lt; aReportParam.length; i=i+2) {
								sReportParam = sReportParam + aReportParam[i] + '=' + escape(aReportParam[i+1]) + '&amp;';
							}

							// Concatenate and return the base url and its new parameters
							//alert(sReportURL + sReportParam);
							return sReportURL + sReportParam;
						};

						// Function to chart
						$.fn.chartMRN<xsl:value-of select='$XTable_Name'/> = (function() {
							// Variable to hold xaxis tick labels and their anchor formatting. href is defined at click event.
							var ticksLabels = [
								<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vR1]">
									<xsl:sort select="@*[local-name() = $vR1]" data-type="text" order="ascending" />
									[<xsl:value-of select="position()" />,'<xsl:value-of select="@*[local-name() = $vR1]"/>'],
								</xsl:for-each-group>
							];

							// Variable Holding the series' specific data
							var chartData = [
								<!-- Group and sort to create the series -->
								<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vC1]">
									<xsl:sort select="@*[local-name() = $vC1]" data-type="text" order="ascending" />
									<xsl:variable name="vVROW1"><xsl:value-of select="@*[local-name() = $vC1]" /></xsl:variable>
									{
										label: '<xsl:value-of select="$vVROW1" />',
										data: [
											<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vR1]">
												<xsl:sort select="@*[local-name() = $vR1]" data-type="text" order="ascending" />
												<xsl:variable name="vVCOL1"><xsl:value-of select="@*[local-name() = $vR1]" /></xsl:variable>
												[
													<xsl:value-of select="position()" />,
													<xsl:choose>
														<xsl:when test="$CalcType='SUM'">
															<xsl:value-of select="sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vC1])=$vVROW1 and (@*[local-name() = $vR1]) = $vVCOL1]/@NBR)" />
														</xsl:when>
														<xsl:when test="$CalcType='AVG'">
															<xsl:value-of select="avg(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vC1])=$vVROW1 and (@*[local-name() = $vR1]) = $vVCOL1]/@NBR)" />
														</xsl:when>
														<xsl:otherwise>
															???
														</xsl:otherwise>
													</xsl:choose>
												],
											</xsl:for-each-group>
										]
									},
								</xsl:for-each-group>
							];
							
							// Variable to hold the global chart options
							var chartOptions = {

								grid: {
									borderWidth: 0,
									margin: 0,
									hoverable: true,
									clickable: true,
								},

								legend: {
									container: $("#legendIniMrc"),
									noColumns: 2,
									labelFormatter: function(label,series){
										//return '&lt;a href=' + clickToHref('pSTATUS',label) + '&gt;' + label + '&lt;/a&gt;';
										//return "&lt;span onclick='DDGraphLegend(\"" + label + "\")'&gt;" + label + "&lt;/span&gt;";
										//return "&lt;span onclick='alert(\"" + label + "\")'&gt;" + label + "&lt;/span&gt;";
										return "&lt;span onclick='var TargetDiv = \"DD_<xsl:value-of select='$vKPI'/>_<xsl:value-of select='$vVKEYD'/>\";var TargetLoad = \"<xsl:if test="$XMLFileName!='name.xml'"><xsl:value-of select='$XMLFileName'/>?</xsl:if><xsl:if test="$XMLFileParamName!='name.xml'"><xsl:value-of select='$XMLFileParamName'/>&amp;</xsl:if>pRID=<xsl:value-of select='$vRID'/>&amp;pKPI=<xsl:value-of select='$vKPI'/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select='$vVKEYD'/>&amp;p<xsl:value-of select='$vC1'/>="+label+"&amp;pMODE=Drill-Down&amp;XXX=\"+Math.floor(Math.random()*1001);loadDiv(TargetDiv,TargetLoad);'&gt;" + label + "&lt;/span&gt;";
									},
								},

								xaxis: {
									mode: null,
									tickSize: 1,
									tickLength: 0,
									ticks: ticksLabels,
								},

								series: {
									bars: {
										show: true,
										fill: .75, // 0 and false are fully tranparent, 1 fully opaque, true = default
										lineWidth: 0, // Remove bar border
										barWidth: .5,
										align: 'center' // To algin with tick
									},
									stack: 0
								}

							};

							// Function to build the chart and place it in its container
							$.plot("#chartMRN<xsl:value-of select='$XTable_Name'/>", chartData, chartOptions);

							// Rotate xaxis tick labels to avoid overlapping ticks. Maximum to be defined manually.
							if (ticksLabels.length > 18) {
								$("#chartMRN .flot-x-axis div.flot-tick-label").css(
									"transform", "translateX(25%) translateY(25%) rotate(45deg)",
									"transform-origin", "0 0",
									"cursor", "pointer"
								);
							};

							// Interactive xaxis labels. Needs to increase zIndex to access the tick by clicking.
							$(".flot-tick-label").css(
								"zIndex","1000",
								"cursor", "pointer"
							);
							$(".flot-x-axis .flot-tick-label").click(function() {
								
								// OK - alert('Action 1 on X Label. Value :'+$(this).text());
								
								var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';
								<!-- File name without extra parameter -->
								<xsl:if test="$XMLFileName!='name.xml'">
									var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vR1"/>='+$(this).text()+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
								</xsl:if>
								<!-- File name with extra parameter -->
								<xsl:if test="$XMLFileParamName!='name.xml'">
									var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vR1"/>='+$(this).text()+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
								</xsl:if>
								loadDiv(TargetDiv,TargetLoad);
							} );

							// Interactive chart bars
							// Strange 2 times VKEYD
							$("#chartMRN<xsl:value-of select='$XTable_Name'/>").bind("plotclick", function(event, pos, item) {
								if (item) {
									//OK - alert('Action 2 on details. Value :'+ item.series.xaxis.ticks[item.dataIndex].label + ' and '+item.series.label);
									var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';
									<!-- File name without extra parameter -->
									<xsl:if test="$XMLFileName!='name.xml'">
										var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;p<xsl:value-of select="$vR1"/>='+ item.series.xaxis.ticks[item.dataIndex].label + '&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vC1"/>='+item.series.label+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
									</xsl:if>
									<!-- File name with extra parameter -->
									<xsl:if test="$XMLFileParamName!='name.xml'">
										var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vR1"/>='+ item.series.xaxis.ticks[item.dataIndex].label + '&amp;p<xsl:value-of select="$vC1"/>='+item.series.label+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
									</xsl:if>
									loadDiv(TargetDiv,TargetLoad);
								}

							} );

						} );

						// Call the plot function
						$().chartMRN<xsl:value-of select='$XTable_Name'/>();
						$(".flot-x-axis .flot-tick-label").css('cursor', 'pointer');
						$("#legendIniMrc").css('cursor', 'pointer');

					});
				</script>
				<!-- End Graph Component-->
				<br/>
				<table width="100%" border="0">
					<td width="80%" align="center">
						<div class="demo-placeholder" style="width:800px; height:450px;">
							<xsl:attribute name="id">chartMRN<xsl:value-of select='$XTable_Name'/></xsl:attribute>
						</div>
					</td>
					<td width="20%" align="center"><div class="" id="legendIniMrc"></div></td>
				</table> 
			</xsl:when>
			<xsl:when test="$tLibrary='DHTMLX'">
				<!-- DHTMLX Graph Module -->
				<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/dhtmlxSuite_v401_pro/codebase/dhtmlx.css"/>
				<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/dhtmlxSuite_v401_pro/codebase/dhtmlx.js"/>
	       		<script>		
					function Chart2DD(val1,val2){
						var TargetDiv = 'DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/>';
						<xsl:choose>
							<xsl:when test="$XMLFileParamName!='name.xml' and $vR1=$vC1">								
								var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vR1"/>='+val1+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
								loadDiv(TargetDiv,TargetLoad);
							</xsl:when>
							<!-- Depreacated do not use Use ALWAYS this -->
							<xsl:when test="$XMLFileName!='name.xml' and $vR1=$vC1">
								var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vR1"/>='+val1+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);	
								loadDiv(TargetDiv,TargetLoad);
							</xsl:when>
							<xsl:when test="$XMLFileParamName!='name.xml' and $vR1!=$vC1">								
								var TargetLoad = '<xsl:value-of select="$XMLFileParamName"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vR1"/>='+val1+'&amp;p<xsl:value-of select="$vC1"/>='+val2+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);
								loadDiv(TargetDiv,TargetLoad);
							</xsl:when>
							<!-- Depreacated do not use Use ALWAYS this -->
							<xsl:when test="$XMLFileName!='name.xml' and $vR1!=$vC1">
								var TargetLoad = '<xsl:value-of select="$XMLFileName"/>?pRID=<xsl:value-of select="$vRID"/>&amp;pKPI=<xsl:value-of select="$vKPI"/>&amp;pEXPLORE=Yes&amp;pVKEYD=<xsl:value-of select="$vVKEYD"/>&amp;pLANG=<xsl:value-of select="$vLANG"/>&amp;p<xsl:value-of select="$vR1"/>='+val1+'&amp;p<xsl:value-of select="$vC1"/>='+val2+'&amp;pMODE=Drill-Down&amp;XXX='+Math.floor(Math.random()*1001);	
								loadDiv(TargetDiv,TargetLoad);
							</xsl:when>
							<xsl:otherwise>
								alert('No XMLFileParamName Parameter defined in Graph Template for Drill-Down');
							</xsl:otherwise>
						</xsl:choose>
					};

					var <xsl:value-of select="//dbquery[@id=$DBWEB]/@id"/>_dataset = [
					<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vR1]">
						<xsl:sort select="@*[local-name() = $vR1]" data-type="text" order="ascending" />
						<xsl:variable name="vVROW1" select="@*[local-name() = $vR1]"/>
							<xsl:choose>
								<!-- Graph with one value based on R1 -->
								<xsl:when test="$vR1=$vC1">
									{<xsl:value-of select="$vR1"/>:"<xsl:value-of select="@*[local-name() = $vR1]" />",
									NBR:"<xsl:value-of select='sum(current-group()/@NBR)'/>",},
								</xsl:when>
								<!-- Graph based on 2 values R1 and R2 -->
								<xsl:when test="$vR1!=$vC1">
									<xsl:for-each-group select = "current-group()" group-by="@*[local-name() = $vR1]">
										<xsl:variable name="vVCOL1" select="@*[local-name() = $vR1]"/>
										{<xsl:value-of select="$vR1"/>:"<xsl:value-of select="@*[local-name() = $vR1]" />",
										<xsl:for-each-group select="current-group()" group-by="@*[local-name() = $vC1]">
											<xsl:sort select="$vC1"/>
											<xsl:variable name="vVCOL1" select="@*[local-name() = $vC1]"/>
											"<xsl:value-of select="@*[local-name() = $vC1]" />":"<xsl:value-of select='sum(current-group()/@NBR)'/>",
										</xsl:for-each-group>},
									</xsl:for-each-group>
									
								</xsl:when>
								<xsl:otherwise>
									
								</xsl:otherwise>
							</xsl:choose>	
					</xsl:for-each-group>];
					<xsl:choose>
						<xsl:when test="$vR1=$vC1">
							$(function () {
								var chart =  new dhtmlXChart({
									view:"<xsl:value-of select="$tview"/>",
									container:"<xsl:value-of select="$XTable_Name"/>",
									value:"#NBR#",
									tooltip:"#NBR#",
									label:"#<xsl:value-of select='$vR1'/>#",
									<!--pieInnerText:"#<xsl:value-of select='$vR1'/>#",-->
									gradient:1,
									legend:{
										<!--width: 75,-->
										align:"right",
										valign:"middle",
										template:"#<xsl:value-of select='$vR1'/>#"
									},

									shadow:false
								});
								
								chart.parse(<xsl:value-of select = "//dbquery[@id=$DBWEB]/@id"/>_dataset,"json");
								chart.attachEvent("onItemClick", function(id){
								    <!--alert(chart.get(id).<xsl:value-of select='$vR1'/>);-->
								    Chart2DD(chart.get(id).<xsl:value-of select='$vR1'/>,'NONE');
								})
								chart.attachEvent("onLegendClick", function(object){
								    <!--alert(object);-->
								    return true;
								});
							});
						</xsl:when>
						<xsl:when test="$vR1!=$vC1">
							<xsl:if test="$InTab='NO'">
								$(function () {
							</xsl:if>
							<xsl:if test="$InTab='YES'">
								function Generate_<xsl:value-of select="$XTable_Name"/> () {
							</xsl:if>
								var colors = ["#E33FC7","#A244EA","#476CEE","#36ABEE","#58DCCD","#A7EE70","#D3EE36","#EED236","#EE9336","#EE4339"];
								var chart =  new dhtmlXChart({
									view:"<xsl:value-of select="$tview"/>", //stackedArea,stackedBar
									container:"<xsl:value-of select="$XTable_Name"/>",
								    value:"#DUMMY#",
						            label:"#DUMMY#",
						            color: "#58dccd",
						            gradient:"falling",
									<!--width:60,-->
									tooltip:{
										template:"#DUMMY#"
									},
									xAxis:{
										template:"'#<xsl:value-of select='$vR1'/>#"
									},
									yAxis:{},
									legend:{
										values:[
										<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vC1]">
											<xsl:sort select="$vC1"/>
											<xsl:variable name="vColor" select="@*[local-name() = $vC1]"/>
											{text:"<xsl:if test="vCodeC1!='NONE'"><xsl:value-of select='$vCodeC1'/></xsl:if><xsl:value-of select='$vColor'/>",color:colors[<xsl:value-of select='position()-1'/>]},
										</xsl:for-each-group>
										],
										valign:"middle",
										align:"right",
										width:90,
										layout:"y"
									}
								});

								<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vC1]">
									<xsl:sort select="$vC1"/>
									<xsl:variable name="vCOlG" select="@*[local-name() = $vC1]"/>
									chart.addSeries({
									    value:"#<xsl:value-of select='$vCOlG'/>#",
										color:colors[<xsl:value-of select='position()-1'/>],
										label:"#<xsl:value-of select='$vCOlG'/>#",
										tooltip:{
											template:"#<xsl:value-of select='$vCOlG'/>#"
										}
									});
								</xsl:for-each-group>
								chart.parse(<xsl:value-of select = "//dbquery[@id=$DBWEB]/@id"/>_dataset,"json");
								<!--
								chart.attachEvent("onItemClick", function(id){
								    alert(chart.get(id).<xsl:value-of select='$vR1'/>);
									Chart2DD(chart.get(id).<xsl:value-of select='$vR1'/>);
								})
								-->
								chart.attachEvent("onItemClick", function(id, event){
									var LegendTitle =
									[
									<xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vC1]">
										<xsl:sort select="$vC1"/>
										'<xsl:value-of select='@*[local-name() = $vC1]'/>',
									</xsl:for-each-group>
									];
										
									var target = event.target||event.srcElement;
									<!--alert(chart.get(id).<xsl:value-of select='$vR1'/>+' / '+LegendTitle[target.getAttribute("userdata")-1]);-->
									Chart2DD(chart.get(id).<xsl:value-of select='$vR1'/>,LegendTitle[target.getAttribute("userdata")-1]);
									
								});
								chart.attachEvent("onLegendClick", function(object){
								    <!--alert(object);-->
								    return true;
								});
							}<xsl:if test="$InTab='NO'">)</xsl:if>;
							
						</xsl:when>
						<xsl:otherwise>
							<script>
								alert('???');
							</script>
						</xsl:otherwise>
					</xsl:choose>
				</script>	
				<div id="{$XTable_Name}" style="width:{$tGraphWidth};height:{$tGraphHeigth};border:1px solid #A4BED4;">
					<xsl:if test="$InTab='YES'">
						<div id="Warning_{$XTable_Name}">
							<br/>
							<center>
								<button class="btn btn-primary" type="button" onclick="Generate_{$XTable_Name}();$('#Warning_{$XTable_Name}').hide()">A DHTMLX Graph in Tab must be Generated. Please click ...</button>
							</center>
						</div>
					</xsl:if>
				</div>
				
			</xsl:when>
			<xsl:when test="$tLibrary='HighCharts'">
				<xsl:choose>
					<xsl:when test="$vR1=$vC1">
						<script>
							alert('HighCharts 1D Later');
						</script>
					</xsl:when>
					<xsl:when test="$vR1!=$vC1">
						<script>
							$(function () {
							    $('#<xsl:value-of select='$XTable_Name'/>').highcharts({
							        chart: {
							            type: '<xsl:value-of select="$tview"/>' 
							        },
							        title: {
							            text: 'Title ... FromDic2Rep'
							        },
							        xAxis: {
							            categories: [
							            <xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vR1]">
											<xsl:sort select="$vR1"/>
											'<xsl:value-of select='@*[local-name() = $vR1]'/>',
										</xsl:for-each-group>
										]
							        },
							        yAxis: {
							            min: 0,
							            title: {
							                text: 'Total fruit consumption'
							            },
							            stackLabels: {
							                enabled: true,
							                style: {
							                    fontWeight: 'bold',
							                    color: (Highcharts.theme &amp;&amp; Highcharts.theme.textColor) || 'gray'
							                }
							            }
							        },
							        legend: {
							            align: 'right',
							            x: -30,
							            verticalAlign: 'top',
							            y: 25,
							            floating: true,
							            backgroundColor: (Highcharts.theme &amp;&amp; Highcharts.theme.background2) || 'white',
							            borderColor: '#CCC',
							            borderWidth: 1,
							            shadow: false
							        },
							        tooltip: {
							            headerFormat: '<b>{point.x}</b><br/>',
							            pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
							        },
							        plotOptions: {
							            column: {
							                stacking: 'normal',
							                dataLabels: {
							                    enabled: true,
							                    color: (Highcharts.theme &amp;&amp; Highcharts.theme.dataLabelsColor) || 'white',
							                    style: {
							                        textShadow: '0 0 3px black'
							                    },
							                }
							            },
							        },
							        series: [
							        <xsl:for-each-group select = "//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vC1]">
										<xsl:variable name="vVCOL1" select="@*[local-name() = $vC1]"/>
										{name: "<xsl:value-of select="$vVCOL1"/>",
										data : [
											<xsl:for-each-group select="//dbquery[@id=$DBWEB]/rows/row" group-by="@*[local-name() = $vR1]">
												<xsl:sort select="$vR1"/>
												<xsl:variable name="vVROW1" select="@*[local-name() = $vR1]"/>
												<xsl:value-of select='sum(//dbquery[@id=$DBWEB]/rows/row[(@*[local-name() = $vC1])=$vVCOL1 and (@*[local-name() = $vR1]) = $vVROW1]/@NBR)'/>,
											</xsl:for-each-group>
										]},
									</xsl:for-each-group>
									]		
							    });
							});
						</script>
					</xsl:when>
					<xsl:otherwise>
						<script>
							alert('HighCharts 3D perhaps later');
						</script>
					</xsl:otherwise>
				</xsl:choose>
						
				<script src="/{$vHtDocsConfig}/CPN/extras/Highcharts-4.1.9/js/highcharts.js"></script>
				<script src="/{$vHtDocsConfig}/CPN/extras/Highcharts-4.1.9/js/modules/exporting.js"></script>
				<div id="{$XTable_Name}" style="width:{$tGraphWidth};height:{$tGraphHeigth};border:1px solid #A4BED4;"></div>
			</xsl:when>
			<xsl:otherwise>
				<script>
					alert('Library Graph Unknown');
				</script>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>
	<xsl:template name="DHTMLX_Graph"> <!-- DHTMLX_Graph test -->
	
		<xsl:param name="tDBWeb" select="'GRAPH'"/>                                              <!-- QueryString Name -->
		<xsl:param name="tUGN" select="generate-id(//dbquery[@id=$tDBWeb]/@id)"/>                <!-- Unique DHTMLX_Graph Name -->
		<xsl:param name="tview" select="'pie'"/>                                				 <!-- view Type : pie/bar ... See DropDown -->
		<xsl:param name="tVals" select="'NBR'"/>                                        		 <!-- Aggregation value : Field name in QueryString -->
                                    
        
        
        <!-- graph Module -->
		<link rel="stylesheet" type="text/css" href="/{$vHtDocsConfig}/CPN/extras/dhtmlxSuite_v401_pro/codebase/dhtmlx.css"/>
		<script type="text/javascript" src="/{$vHtDocsConfig}/CPN/extras/dhtmlxSuite_v401_pro/codebase/dhtmlx.js"></script>
        <xsl:variable name="fGR1" select="//dbquery[1]/descriptor/parameters/param[@name='pGR2']/@value"/>
		<xsl:variable name="fGC1" select="//dbquery[1]/descriptor/parameters/param[@name='pGC1']/@value"/>

                                
    <script>		
		<xsl:for-each select = "//dbquery[@id=$tDBWeb]">							
				var <xsl:value-of select="@id"/>_dataset = [
						<xsl:for-each select="rows/row">
							{<xsl:for-each select="@*">
								<xsl:value-of select="local-name()"/>:"<xsl:value-of select='.'/>",
							</xsl:for-each>},
						</xsl:for-each>
									
													];
		</xsl:for-each>
	</script>
	<script>
		window.onload = function(){
			var chart =  new dhtmlXChart({
				view:"<xsl:value-of select="$tview"/>",
				container:"<xsl:value-of select='$tUGN'/>",
				value:"#NBR#",
				tooltip:"#NBR#",
				label:"#<xsl:value-of select='$fGR1'/>#",
				pieInnerText:"#<xsl:value-of select='$fGC1'/>#",
				gradient:1,
				legend:{
					width: 75,
					align:"right",
					valign:"middle",
					template:"#<xsl:value-of select='$fGR1'/>#"
				},

				shadow:false
			});
			chart.parse(<xsl:value-of select = "//dbquery[@id=$tDBWeb]/@id"/>_dataset,"json");}
				</script>
                <div class="dhx_chart" id="{$tUGN}" style="width:400px;height:250px;border:1px solid #A4BED4;"></div>
    </xsl:template>

	
	<xsl:template name="FromDic2Rep"> 				<!-- Automatic Generation of Labels/Pop-Up (DataDic) -->
		<xsl:param name="Title2S" select="'Title2S is missing'"/> 	<!-- Text to be translated with DataDic --> 
		<xsl:param name="dictionary" select="NONE"/> 	<!-- RepDic.xml Path -->
		<xsl:param name="Lang" select="$vLANG"/> 		<!-- Language -->
		<xsl:param name="tDDType" select="'REPORT'"/> 	<!-- Depreacated Do not use anymore -->
		<xsl:param name="tDDKey" select="0"/> 			<!-- Depreacated Do not use anymore -->
		<xsl:param name="tDDConfig" select="'CP'"/> 	<!-- C(aption)+I(con)+P(op-Up) - Default : CP (!Order!) --> 
		
		<xsl:variable name="vDic4TitleDD" select="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@FIELD_NAME"/>
		<xsl:variable name="vDicHint" select="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@HINT_NO"/>
		<xsl:variable name="vDic4TitleLDD" select="$dictionary//Label[@ID=$Title2S]/LabelText[upper-case(@lang)=$Lang]"/>

		<xsl:choose>
			<!-- Field is in DBWeb -->
			<xsl:when test="$vDic4TitleDD!='' or $vDic4TitleDD">
				<!-- Not ILIAS -->
				<xsl:if test="$vDicHint=''">
					<xsl:choose>
						<!-- Caption - NO Icon - Popup (Normal Rule) -->
						<!-- Caption - No Icon - No Popup (Field Title) -->
						<xsl:when test="$tDDConfig='C'">
							<xsl:value-of select="$vDic4TitleDD"/>
						</xsl:when>
						<!-- Caption - (Icon) - Popup -->
						<xsl:when test="$tDDConfig='CIP' or $tDDConfig='CP' or $tDDConfig='IP'">
							<span>
								<xsl:if test="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@POPUP=-1">
									<xsl:attribute name="id">DDToBeChanged</xsl:attribute>
								</xsl:if>
								<xsl:if test="$tDDConfig!='IP'">
									<span><xsl:value-of select="$vDic4TitleDD"/></span>
									<xsl:if test="count(//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S])>1">
										<xsl:text> </xsl:text><font color="red">(M)</font>
									</xsl:if>
								</xsl:if>
								<xsl:if test="$tDDConfig='CIP' or $tDDConfig='IP'">
									<xsl:text> </xsl:text>
									<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
								</xsl:if>
							</span>
							<xsl:if test="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@POPUP=-1">
								<!-- Green-->
								<script>
									var unIdDD= uniqueid();
									var NodeSetArr =JSON.parse(localStorage.getItem('<xsl:value-of select="$vNodeConfig"/>_Settings'));
									if (NodeSetArr.DebugMode.substring(0,1) === 'Y') { 
										var DeBugText="&lt;br/>&lt;i>&lt;small>Source (DD3A) : DBWeb Node with Lang Param '<xsl:value-of select='$Lang'/>'.&lt;br/>Original Field Name : '<xsl:value-of select='$Title2S'/>'.&lt;/i>&lt;/small>";
										} else {
										var DeBugText="";
									 };
							
									$('#DDToBeChanged').attr('id',unIdDD);
									new Opentip("#"+unIdDD, "&lt;b>&lt;u>&lt;i>Explanation&lt;/i>&lt;/u>&lt;/b>&lt;br/><xsl:value-of select="if(//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@HINT='' or not(//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@HINT)) then 'No Explanation Provided' else (//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@HINT)" />&lt;br/><xsl:if test="count(//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S])>1">&lt;br/>&lt;b>Warning : Multiple DataDic Entry in RepDic (Correction Required)&lt;/b>&lt;br/></xsl:if>"+DeBugText, {background: "#d3fedf", target: false, tipJoint: "bottom left"});
								</script>
							</xsl:if>
						</xsl:when>
						<!-- Trapping -->
						<xsl:otherwise>
							<span>
								<xsl:if test="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@POPUP=-1">
									<xsl:attribute name="id">DDToBeChanged</xsl:attribute>
								</xsl:if>
								<i>Error</i>
								<img src="/{$vHtDocsConfig}/CPN/img/Alert32.png" width="15px"/>
							</span>
							<xsl:if test="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@POPUP=-1">
								<script>
									var unIdDD= uniqueid();
									$('#DDToBeChanged').attr('id',unIdDD);
									new Opentip("#"+unIdDD, "&lt;b>&lt;u>&lt;i>Error in Data Dic&lt;/i>&lt;/u>&lt;/b>&lt;br/>Label and Pop-Up defined in DataDic DBWeb Node BUT Bad Data Dic Congiguration Type (only C/CP/IP/CIB are allowed).&lt;br/>&lt;br/>&lt;i>&lt;small>Source (DD3B) : DBWeb Node '<xsl:value-of select='$Lang'/>'.&lt;br/>Original Field Name : '<xsl:value-of select='$Title2S'/>'.&lt;/i>&lt;/small>", {style: "alert", target: false, tipJoint: "bottom left"});
								</script>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<!-- ILIAS -->
				<xsl:if test="$vDicHint!=''">
					<xsl:choose>
						<!-- Caption - NO Icon - Popup (Normal Rule) -->
						<!-- Caption - No Icon - No Popup (Field Title) -->
						<xsl:when test="$tDDConfig='C'">
							<xsl:value-of select="$vDic4TitleDD"/>
						</xsl:when>
						<!-- Caption - (Icon) - Popup -->
						<xsl:when test="$tDDConfig='CIP' or $tDDConfig='CP' or $tDDConfig='IP'">
							<span>
								<xsl:if test="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@POPUP=-1">
									<xsl:attribute name="id">DDToBeChanged</xsl:attribute>
								</xsl:if>
								<xsl:if test="$tDDConfig!='IP'">
									<span><xsl:value-of select="$vDic4TitleDD"/></span>
									<xsl:if test="count(//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S])>1">
										<xsl:text> </xsl:text><font color="red">(M)</font>
									</xsl:if>
								</xsl:if>
								<xsl:if test="$tDDConfig='CIP' or $tDDConfig='IP'">
									<xsl:text> </xsl:text>
									<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
								</xsl:if>
							</span>
							<xsl:if test="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@POPUP=-1">
								<!-- Blue -->
								<script>
									var unIdDD= uniqueid();
									var NodeSetArr =JSON.parse(localStorage.getItem('<xsl:value-of select="$vNodeConfig"/>_Settings'));
									if (NodeSetArr.DebugMode.substring(0,1) === 'Y') { 
										var DeBugText="&lt;br/>&lt;i>&lt;small>&lt;u>Original Field Name&lt;/u> : '<xsl:value-of select='$Title2S'/>'.&lt;/i>&lt;br/>&lt;u>ILIAS Hint&lt;/u> : Nbr <xsl:value-of select="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@HINT_NO"/> in Screen <xsl:value-of select="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@FUNCTION"/>.&lt;br/>&lt;u>View Used&lt;/u> : <xsl:value-of select="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@VIEWNAME"/> in ILIAS (See in MITONE Screen).&lt;br/>&lt;u>Source (DD4A)&lt;/u> : DBWeb Node with Lang Param '<xsl:value-of select='$Lang'/>'.&lt;/small>";
										} else {
										var DeBugText="";
									 };

									$('#DDToBeChanged').attr('id',unIdDD);
									new Opentip("#"+unIdDD, "&lt;b>&lt;u>&lt;i>Explanation&lt;/i>&lt;/u>&lt;/b>&lt;br/><xsl:value-of select="if(//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@HINT='' or not(//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@HINT)) then 'No Explanation Provided' else (//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@HINT)" />&lt;br/><xsl:if test="count(//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S])>1">&lt;br/>&lt;b>Warning : Multiple DataDic Entry in RepDic (Correction Required)&lt;/b>&lt;br/></xsl:if>"+DeBugText, {background: "#e6f8ff", target: false, tipJoint: "bottom left"});
								</script>
							</xsl:if>
						</xsl:when>
						<!-- Trapping -->
						<xsl:otherwise>
							<span>
								<xsl:if test="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@POPUP=-1">
									<xsl:attribute name="id">DDToBeChanged</xsl:attribute>
								</xsl:if>
								<i>Error</i>
								<img src="/{$vHtDocsConfig}/CPN/img/Alert32.png" width="15px"/>
							</span>
							<xsl:if test="//dbquery[@id='DATA_DICTIONARY']/rows/row[@NAME=$Title2S]/@POPUP=-1">
								<script>
									var unIdDD= uniqueid();
									$('#DDToBeChanged').attr('id',unIdDD);
									new Opentip("#"+unIdDD, "&lt;b>&lt;u>&lt;i>Error in Data Dic&lt;/i>&lt;/u>&lt;/b>&lt;br/>Label and Pop-Up defined in DataDic DBWeb Node BUT Bad Data Dic Congiguration Type (only C/CP/IP/CIB are allowed).&lt;br/>&lt;br/>&lt;i>&lt;small>Source (DD4B) : DBWeb Node '<xsl:value-of select='$Lang'/>'.&lt;br/>Original Field Name : '<xsl:value-of select='$Title2S'/>'.&lt;/i>&lt;/small>", {style: "alert", target: false, tipJoint: "bottom left"});
								</script>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:when>
			<!-- Field is in RepDic -->
			<xsl:when test="$vDic4TitleLDD!='' or $vDic4TitleLDD">
				<xsl:choose>
					<!-- Caption - NO Icon - Popup (Normal Rule) -->
					<!-- Caption - No Icon - No Popup (Field Title) -->
					<xsl:when test="$tDDConfig='C'">
						<xsl:value-of select="$vDic4TitleLDD"/>
					</xsl:when>
					<!-- Caption - (Icon) - Popup -->
					<xsl:when test="$tDDConfig='CIP' or $tDDConfig='CP' or $tDDConfig='IP'">
						<span id="DDToBeChanged">
							<xsl:if test="$tDDConfig!='IP'">
								<span><xsl:value-of select="$vDic4TitleLDD"/></span>
								<xsl:if test="count($dictionary//Label[@ID=$Title2S]/LabelText[upper-case(@lang)=$Lang])>1">
									<xsl:text> </xsl:text><font color="red">(M)</font>
								</xsl:if>
							</xsl:if>
							<xsl:if test="$tDDConfig='CIP' or $tDDConfig='IP'">
								<xsl:text> </xsl:text>
								<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
							</xsl:if>
						</span>
						<!-- Yellow -->
						<script>
							var unIdDD= uniqueid();
							var NodeSetArr =JSON.parse(localStorage.getItem('<xsl:value-of select="$vNodeConfig"/>_Settings'));
							if (NodeSetArr.DebugMode.substring(0,1) === 'Y') { 
								var DeBugText="&lt;br/>&lt;i>&lt;small>Source (DD2A) : Local XML (...RepDic.xml) with Lang Param '<xsl:value-of select='$Lang'/>'.&lt;br/>Original Field Name : '<xsl:value-of select='$Title2S'/>'.&lt;/i>&lt;/small>";
								} else {
								var DeBugText="";
							 };
							$('#DDToBeChanged').attr('id',unIdDD);
							new Opentip("#"+unIdDD, "&lt;b>&lt;u>&lt;i>Explanation&lt;/i>&lt;/u>&lt;/b>&lt;br/><xsl:value-of select="if($dictionary//Label[@ID=$Title2S]/PopupText[upper-case(@lang)=$Lang]='' or not($dictionary//Label[@ID=$Title2S]/PopupText[upper-case(@lang)=$Lang])) then 'No Explanation Provided' else ($dictionary//Label[@ID=$Title2S]/PopupText[upper-case(@lang)=$Lang])" />&lt;br/><xsl:if test="count($dictionary//Label[@ID=$Title2S]/LabelText[upper-case(@lang)=$Lang])>1">&lt;br/>&lt;b>Warning : Multiple DataDic Entry in RepDic (Correction Required)&lt;/b>&lt;br/></xsl:if>"+DeBugText, {background: "#f8fbb6", target: false, tipJoint: "bottom left"});
						</script>
					</xsl:when>
					<!-- Trapping -->
					<xsl:otherwise>
						<span id="DDToBeChanged">
							<i>Error</i>
							<img src="/{$vHtDocsConfig}/CPN/img/Alert32.png" width="15px"/>
						</span>
						<script>
							var unIdDD= uniqueid();
							$('#DDToBeChanged').attr('id',unIdDD);
							new Opentip("#"+unIdDD, "&lt;b>&lt;u>&lt;i>Error in Data Dic&lt;/i>&lt;/u>&lt;/b>&lt;br/>Label and Pop-Up defined in RepDic (.xml) BUT Bad Data Dic Congiguration Type (only C/CP/IP/CIB are allowed).&lt;br/>&lt;br/>&lt;i>&lt;small>Source (DD2B) : RepDic with Lang Param '<xsl:value-of select='$Lang'/>'.&lt;br/>Original Field Name : '<xsl:value-of select='$Title2S'/>'.&lt;/i>&lt;/small>", {style: "alert", target: false, tipJoint: "bottom left"});
						</script>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- In RepDic ... Show It -->
			<xsl:otherwise>
				<xsl:choose>
					<!-- Caption - NO Icon - Popup (Normal Rule) -->
					<!-- Caption - No Icon - No Popup (Field Title) -->
					<xsl:when test="$tDDConfig='C'">
						<i><xsl:value-of select="$Title2S"/></i>
					</xsl:when>
					<!-- Caption - (Icon) - Popup -->
					<xsl:when test="$tDDConfig='CIP' or $tDDConfig='CP' or $tDDConfig='IP'">
						<span id="DDToBeChanged">
							<xsl:if test="$tDDConfig!='IP'">
								<span><i><xsl:value-of select="$Title2S"/></i></span>
							</xsl:if>
							<xsl:if test="$tDDConfig='CIP' or $tDDConfig='IP'">
								<xsl:text> </xsl:text>
								<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
							</xsl:if>
						</span>
						<script>
							var unIdDD= uniqueid();
							var NodeSetArr =JSON.parse(localStorage.getItem('<xsl:value-of select="$vNodeConfig"/>_Settings'));
							if (NodeSetArr.DebugMode.substring(0,1) === 'Y') { 
								var DeBugText="&lt;br/>&lt;br/>&lt;i>&lt;small>Source (DD1A) : No DBWeb DD And No RepDic with Lang Param '<xsl:value-of select='$Lang'/>'.&lt;br/>Original Field Name : '<xsl:value-of select='$Title2S'/>'.&lt;/i>&lt;/small>";
								} else {
								var DeBugText="";
							 };
							$('#DDToBeChanged').attr('id',unIdDD);
							new Opentip("#"+unIdDD, "No Label and Pop-Up defined in Report Dictionary. Help Us to define it."+DeBugText, {background: "#fcadc1", target: false, tipJoint: "bottom left"});
						</script>
					</xsl:when>
					<!-- Trapping -->
					<xsl:otherwise>
						<span id="DDToBeChanged">
							<i>Error</i>
							<img src="/{$vHtDocsConfig}/CPN/img/Alert32.png" width="15px"/>
						</span>
						<!-- Red -->
						<script>
							var unIdDD= uniqueid();
							$('#DDToBeChanged').attr('id',unIdDD);
							new Opentip("#"+unIdDD, "&lt;b>&lt;u>&lt;i>Error in Data Dic&lt;/i>&lt;/u>&lt;/b>&lt;br/>No Label and Pop-Up defined in Data Dictionary (DBWeb) and in RepDic (.xml) AND Bad Data Dic Congiguration Type (only C/CP/IP/CIB are allowed).&lt;br/>&lt;br/>&lt;i>&lt;small>Source (DD01B) : No DBWeb DD And No RepDic with Lang Param '<xsl:value-of select='$Lang'/>'.&lt;br/>Original Field Name : '<xsl:value-of select='$Title2S'/>'.&lt;/i>&lt;/small>", {style: "alert",target: false, tipJoint: "bottom left"});
						</script>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>	
	<xsl:template name="TNotif">                  	<!-- Notification (Pop-Up) -->
	   <xsl:param name="tMsg" select="'No Message Defined'"/>
	   <xsl:param name="tTitle" select="'No Title'"/>
	   <xsl:param name="tType" select="1"/>      		<!-- Type of Message 1=Info,2=Sucess,3=warning,4=error, -->
	   <xsl:param name="tAppear" select="1000"/>   		<!-- Appearance of Notification in miliseconds (Default 1000=1sec) -->
	   <xsl:param name="tDuration" select="5000"/>   	<!-- Duration of Notification in miliseconds (Default 1000=1sec) -->
	   <xsl:param name="tAddDebug" select="'Y'"/>   	<!-- Add this info To Local Storage Debug Info (Default=Y) -->
	   <xsl:param name="tSilence" select="'N'"/>   		<!-- Silence means no Toastr visible but Debug Info stored (Default=Y) -->
		    <xsl:if test="$tSilence='N'">
		    	<!-- Documentation on http://localhost/CPN/MRN_Prod/extras/toastr/demo.html -->
				    <!-- Notification Settings -->
				      <!-- Notification TimeOut Default -->
				      <script type="text/javascript">
				         var opts = {
				               "closeButton": true,
				               "debug": false,
				               <xsl:choose>
				                  <xsl:when test="$tType=2">"positionClass": "toast-bottom-left",</xsl:when>
				                  <xsl:when test="$tType=3">"positionClass": "toast-bottom-left",</xsl:when>
				                  <xsl:when test="$tType=3">"positionClass": "toast-top-full-width",</xsl:when>
				                  <xsl:otherwise>"positionClass": "toast-bottom-left toast-default",</xsl:otherwise>
				               </xsl:choose>  
				               "newestOnTop": true,
				  			   "progressBar": true,
				  			   "preventDuplicates": true,
							   "onclick": null,
				               "showDuration": "100",
				               "hideDuration": "1000",
				               "timeOut": "<xsl:value-of select="$tDuration"/>",
				               "extendedTimeOut": "1000",
				               "showEasing": "swing",
				               "hideEasing": "linear",
				               "showMethod": "fadeIn",
				               "hideMethod": "fadeOut"
				            };

				         // Notifications
				            setTimeout(function()
				               <xsl:choose>
				                  <xsl:when test="$tType=2">{if(NodeSetArr.DebugMode.substring(2,3) === 'Y'){toastr.success("<xsl:value-of select="$tMsg"/>", <xsl:choose><xsl:when test="$tTitle='None'">null</xsl:when><xsl:otherwise>"<xsl:value-of select="$tTitle"/>"</xsl:otherwise></xsl:choose>, opts);}}, <xsl:value-of select="$tAppear"/></xsl:when>
				                  <xsl:when test="$tType=3">{if(NodeSetArr.DebugMode.substring(3,4) === 'Y'){toastr.warning("<xsl:value-of select="$tMsg"/>", <xsl:choose><xsl:when test="$tTitle='None'">null</xsl:when><xsl:otherwise>"<xsl:value-of select="$tTitle"/>"</xsl:otherwise></xsl:choose>, opts);}}, <xsl:value-of select="$tAppear"/></xsl:when>
				                  <xsl:when test="$tType=4">{if(NodeSetArr.DebugMode.substring(4,5) === 'Y'){toastr.error("<xsl:value-of select="$tMsg"/>", <xsl:choose><xsl:when test="$tTitle='None'">null</xsl:when><xsl:otherwise>"<xsl:value-of select="$tTitle"/>"</xsl:otherwise></xsl:choose>, opts);}}, <xsl:value-of select="$tAppear"/></xsl:when>
				                  <xsl:otherwise>{if(NodeSetArr.DebugMode.substring(1,2) === 'Y'){toastr.info("<xsl:value-of select="$tMsg"/>", <xsl:choose><xsl:when test="$tTitle='No Title'">null</xsl:when><xsl:otherwise>"<xsl:value-of select="$tTitle"/>"</xsl:otherwise></xsl:choose>, opts);}}, <xsl:value-of select="$tAppear"/></xsl:otherwise>
				               </xsl:choose>); 
				      </script>	
				    <!-- Notification Settings End -->         	
		    </xsl:if>
		    <!-- Add Info to Debug Local Storage Variable -->
			<xsl:if test="$tAddDebug='Y'">
				<script>
					localStorage['NodeDebug'] = localStorage['NodeDebug']+'<br/><xsl:choose><xsl:when test="$tTitle='None'"></xsl:when><xsl:otherwise>- <em><b><u><xsl:value-of select="$tTitle"/></u></b></em> : </xsl:otherwise></xsl:choose><xsl:value-of select="$tMsg"/>';	
				</script>
			</xsl:if>
	</xsl:template>
	<xsl:template name="TMpopup">                  	<!-- Show Messages (Agressive Modal) -->
	   <xsl:param name="tMsg" select="'No Message Defined'"/> 	<!-- PopUp Message no Html Insisde -->
	   <xsl:param name="tTitle" select="'No Title'"/> 			<!-- Pop-Up Title if no Html inside -->
	   <xsl:param name="tPopUpId" select="MRNPopUp"/>      		<!-- Pop-Up Div Id -->
	   <xsl:param name="tTimer" select="0"/> 					<!-- Add a Timer (Duration in Seconds) a the Bottom of the PopUp -->
	   <xsl:param name="tRedir" select="None"/> 				<!-- Pop-Up generate a Redirection on close and/or Timer is greater than 0 --> 

		<!-- Example
			=========
			<div id="MRNPopUp" class="white-popup mfp-hide">
			  <h1>Title Magnific</h1>
			  Content Magnific ... ohoh
			</div>
			<xsl:call-template name="TMpopup">
				<xsl:with-param name="tTitle" select="'No Title'"/> 			
			   	<xsl:with-param name="tMsg" select="'No Message Defined'"/>
			   	<xsl:with-param name="tPopUpId" select="'MRNPopUp'"/>
			   	<xsl:with-param name="tTimer" select="7"/>	
			   	<xsl:with-param name="tRedir" select="'http://google.be'"/>
			</xsl:call-template>
		End Example -->
	    
	    <!-- Documentation on Web search Magnific PopUp -->
	    <!-- Pop-UP Settings -->
	      <!-- Magnific Popup core CSS file -->
	    <script>
			function MRNPopUp() {
				$.magnificPopup.open({
					items: {
				    	  src: '<div class="white-popup">'+$("#<xsl:value-of select="$tPopUpId"/>").html()+'<div align="center" id="mTimer"></div></div>',
				      	  type: 'inline'
					  },
					closeBtnInside: true,
					closeOnContentClick : false,
					closeOnBgClick : modal,
					false : false,
					callbacks: {
					    open: function() {
						      // Will fire when popup is closed
							  $().html(TimerPopUp(<xsl:value-of select="$tTimer"/>,"<xsl:value-of select="$tRedir"/>","mTimer");
						    },
					    close: function() {
						      // Will fire when popup is closed
						      window.location="<xsl:value-of select="$tRedir"/>";
						    }
					    // e.t.c.
					  	},
						});
				}
			MRNPopUp();
		</script>
	</xsl:template>
	<xsl:template name="Decode_FDC_MultipleValue"> 	<!-- Decoding of MultipleValue in 1 Field (SPE and FDC) -->
	    <xsl:param name="tText" select="'aa,bb,cc'"/>
	    <xsl:param name="tDelim" select="','" />
		<xsl:param name="tStart" select="1"/> 		<!-- Use 1 -->
	    <xsl:param name="tPos" select="1"/>
	    <xsl:param name="tLength" select="3"/>
		<xsl:choose>
			<xsl:when test="$tPos > $tLength ">
		    	ERROR
		    </xsl:when>
			<xsl:when test="$tStart = $tPos and $tLength != $tPos">
		    	<xsl:value-of select="substring-before($tText,$tDelim)" />
		    </xsl:when>
		    <xsl:when test="$tStart = $tPos and $tLength = $tPos">
		    	<xsl:value-of select="$tText"/>
		    </xsl:when>
		    <xsl:when test="$tPos > $tStart">
		    	<xsl:call-template name="Decode_FDC_MultipleValue">
		            <xsl:with-param name="tStart" select="$tStart + 1" />
		            <xsl:with-param name="tPos" select="$tPos" />
		            <xsl:with-param name="tDelim" select="$tDelim" />
		            <xsl:with-param name="tLength" select="$tLength" />
		            <xsl:with-param name="tText" select="substring-after($tText,$tDelim)" />
		        </xsl:call-template>
		    </xsl:when>
		    <xsl:otherwise>
		    </xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Accuracy_Indic">			<!-- Report Quality-Accuracy Markers -->
		<xsl:param name="tType" select="'Report'"/>
		<xsl:param name="tEOK" select="'0'"/>
		<xsl:param name="tDOK" select="'OK'"/>
		<xsl:param name="tLanguage" select="'EN'"/>
		
		<xsl:variable name="vGenRepDic" select="document('IL_MR_RepDic.xml')" />
		<th>
			<xsl:call-template name="FromDic2Rep">
				<xsl:with-param name="Title2S" select="'HRI_REPORT_ACC01'"/>
				<xsl:with-param name="Lang" select="$tLanguage"/>
				<xsl:with-param name="dictionary" select="$vGenRepDic"/>
				<xsl:with-param name="tDDKey" select="303"/>
			</xsl:call-template>  
			<xsl:choose>
				<!-- Extraction OK and SQL OK -->
				<xsl:when test="$tEOK = '0' and $tDOK = 'OK' ">
					<span class="status green">
						<xsl:attribute name='onmouseover'>return showPopup('/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_POPUP2/DBN_POPUP_Rep_Status_Extrac.xml?pKPI=<xsl:value-of select="$vKPI"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;XXX='+Math.floor(Math.random()*1001),500);</xsl:attribute>
						<xsl:attribute name='onmouseout'>return nd();</xsl:attribute>
					</span>
					- SQL <a href="#" data-toggle="modal" data-target="#CPN_Report_DBWebDescriptor" role="button"><span class="status green"></span></a> 
				</xsl:when>
				<!-- Extraction NOK and SQL OK -->
				<xsl:when test="$tEOK = '0' and $tDOK != 'OK' ">
					<span class="status red">
						<xsl:attribute name='onmouseover'>return showPopup('/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_POPUP2/DBN_POPUP_Rep_Status_Extrac.xml?pKPI=<xsl:value-of select="$vKPI"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;XXX='+Math.floor(Math.random()*1001),500);</xsl:attribute>
						<xsl:attribute name='onmouseout'>return nd();</xsl:attribute>
					</span>
					- SQL <a href="#" data-toggle="modal" data-target="#CPN_Report_DBWebDescriptor" role="button"><span class="status green"></span></a>
				</xsl:when>
				<!-- Extraction OK and SQL NOK -->
				<xsl:when test="$tEOK != '0' and $tDOK = 'OK' ">
					<span class="status green">
						<xsl:attribute name='onmouseover'>return showPopup('/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_POPUP2/DBN_POPUP_Rep_Status_Extrac.xml?pKPI=<xsl:value-of select="$vKPI"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;XXX='+Math.floor(Math.random()*1001),500);</xsl:attribute>
						<xsl:attribute name='onmouseout'>return nd();</xsl:attribute>
					</span>
					- SQL <a href="#" data-toggle="modal" data-target="#CPN_Report_DBWebDescriptor" role="button"><span class="status red"></span></a> 
				</xsl:when>
				<!-- Extraction NOK and SQL NOK -->
				<xsl:otherwise>
					<span class="status red">
						<xsl:attribute name='onmouseover'>return showPopup('/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_POPUP2/DBN_POPUP_Rep_Status_Extrac.xml?pKPI=<xsl:value-of select="$vKPI"/>&amp;pRID=<xsl:value-of select="$vRID"/>&amp;XXX='+Math.floor(Math.random()*1001),500);</xsl:attribute>
						<xsl:attribute name='onmouseout'>return nd();</xsl:attribute>
					</span>
					- SQL <a href="#" data-toggle="modal" data-target="#CPN_Report_DBWebDescriptor" role="button"><span class="status red"></span></a>
				</xsl:otherwise>
			</xsl:choose>
		</th>
	</xsl:template>
	<xsl:template name="DBWeb_Decryptor"> 			<!-- DBWEB Decriptor (Show Queries Mechanism) -->
		<xsl:param name="tUQD" select="'UQD_NONE'"/>
		<xsl:param name="tType" select="'Main'"/>
		<xsl:param name="tLanguage" select="'EN'"/>
		<!-- Generate Notification for ALL DBWebs in Error -->
		<xsl:for-each select = "//dbquery/error">
			<xsl:variable name="ErrorMsg">Querystring <xsl:value-of select="../@id"/> is in error &lt;b>(Error Bloc will appear in Red)&lt;/b></xsl:variable>
			<xsl:call-template name="TNotif">
				<xsl:with-param name="tMsg" select="$ErrorMsg"/>
				<xsl:with-param name="tTitle" select="'T04 - Error in the DBWeb Query'"/> 
				<xsl:with-param name="tType" select="4"/> 	
				<xsl:with-param name="tAppear" select="1000"/>	
			</xsl:call-template>
		</xsl:for-each>
		<!-- Duery Used Modal Window -->
		<div id="CPN_Report_DBWebDescriptor" class="modal fade" role="dialog">
	        <div class="modal-dialog modal-lg">
	            <!-- Modal content-->
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal">X</button>
	                    <h4 class="modal-title">Queries used for Report : '<xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_name"/>'</h4>
	                </div>
	                <div class="modal-body">
	                    <xsl:variable name="NBR_DBWEB_DECRYPT"><xsl:value-of select="count(//dbquery/descriptor/querystring)"/></xsl:variable>
	                    <xsl:variable name="SHOW_DBWEB_DECRYPT">
							<xsl:choose>
								<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_dbweb='Y'">YES</xsl:when>
								<xsl:when test="$vShowDBWeb='N' and //dbquery[@id='Report_Info']/rows/row/@dbn_rep_dbweb=''">NO</xsl:when>
								<xsl:when test="$vShowDBWeb='Y' and //dbquery[@id='Report_Info']/rows/row/@dbn_rep_dbweb=''">YES</xsl:when>
								<!-- For KPI Always Hidden for readibility -->
								<xsl:when test="//dbquery[@id='Report_Info']/descriptor/parameters/param[@name='pKPI']/@value!=''">NO</xsl:when>
								<xsl:otherwise>NO</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<div id="ALLQueryString" class="panel-group context">
							<!-- Metadata -->
							<div>
								<xsl:if test="count(//ws-query[@id='METADATA']/ws-rows/dbquery/error)=0">
									<xsl:attribute name="class">panel panel-default</xsl:attribute>
								</xsl:if>
								<xsl:if test="count(//ws-query[@id='METADATA']/ws-rows/dbquery/error)!=0">
									<xsl:attribute name="class">panel panel-danger</xsl:attribute>
								</xsl:if>
								<div class="panel-heading">
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#ALLQueryString" href="#MetaData">
											Metadata : <b><xsl:value-of select = "count(//ws-query[@id='METADATA']/ws-rows/dbquery)"/></b> Queries
										</a> 
										<xsl:text> </xsl:text>
										<xsl:if test="count(//ws-query[@id='METADATA']/ws-rows/dbquery/error)!=0">
											<span class="label label-danger">
												<xsl:value-of select = "count(//ws-query[@id='METADATA']/ws-rows/dbquery/error)"/> in Error
											</span>
										</xsl:if>
										<xsl:if test="contains($vINFO,'X') and ($vPROFILE='Node_Admin' or $vNodeConfig='Local')">
											<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
											<span class="label label-info">										Data Generated
											</span>
										</xsl:if>
									</h4>
								</div>
								<div id="MetaData" class="panel-collapse collapse">
									<div class="panel-body">
										<!-- All MetaDataQueries -->
						                <dl class="dl-horizontal">
				                        	<dt><b>Original URL :</b></dt>
											<dd><xsl:value-of select = "//ws-query[@id='METADATA']/descriptor/originalurl"/></dd>
											<dt><b>XPath :</b></dt>
											<dd><xsl:value-of select = "//ws-query[@id='METADATA']/descriptor/xpath"/></dd>
											<dt><b>Parameters :</b></dt>
											<xsl:for-each select = "//ws-query[@id='METADATA']/descriptor/parameters/parameter">
						                    	<dd><b><i><xsl:value-of select = "@name"/></i></b> : <xsl:value-of select = "."/></dd>
						                    </xsl:for-each>
											<dt><b>URL :</b></dt>
											<dd><xsl:value-of select = "//ws-query[@id='METADATA']/descriptor/url"/></dd>
										</dl>
						                <div id="MetaDataQueries" class="panel-group">    
						                    <xsl:for-each select = "//ws-query[@id='METADATA']/ws-rows/dbquery">
						                    	<div>
						                    		<xsl:if test="count(error)=0">
														<xsl:attribute name="class">panel panel-default</xsl:attribute>
													</xsl:if>
													<xsl:if test="count(error)!=0">
														<xsl:attribute name="class">panel panel-danger</xsl:attribute>
													</xsl:if>
													<div class="panel-heading">
														<h4 class="panel-title">
															<a data-toggle="collapse" data-parent="#MetaDataQueries" href="#{@id}">
																<b><xsl:value-of select='@id'/></b> 
																<xsl:text> </xsl:text>
																<small>(Database : <b><xsl:value-of select='descriptor/database'/></b>)</small>
																<xsl:text> </xsl:text>
																<small>(Records : <b><xsl:value-of select='count(rows/row)'/></b>)</small>

															</a>
															<xsl:text> </xsl:text>
															<span>
																<xsl:choose>
																	<xsl:when test="count(error)!=0">
																		<xsl:attribute name="class">label label-danger</xsl:attribute>
																		<b>Error in Query</b>
																	</xsl:when>
																	<xsl:when test="count(rows/row)=0">
																		<xsl:attribute name="class">label label-warning</xsl:attribute>
																		<b>No</b> Records
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:attribute name="class">label label-success</xsl:attribute>
																		<b><xsl:value-of select='count(rows/row)'/></b> Records
																	</xsl:otherwise>
																</xsl:choose>
															</span>
														</h4>
													</div>
													<div id="{@id}" class="panel-collapse collapse in">
														<div class="panel-body">
															<p>
																<dl class="dl-horizontal">
										                        	<dt><b>Query :</b></dt>
																	<dd><code class="sql"><xsl:value-of select = "descriptor/querystring"/></code></dd>
																	<xsl:if test="(count(rows/row)!=0 and contains($vINFO,'X')) and ($vPROFILE='Node_Admin' or $vNodeConfig='Local')">
																		<dt><b>Result :</b></dt>
																		<dd>
																			<small><ul>
																				<xsl:for-each select = "rows/row">
					        														<li>[
																	        		<xsl:for-each select="@*">
																						<b>'<xsl:value-of select="local-name()"/>'</b> : '<i><xsl:value-of select="."/></i>',
																	        		 </xsl:for-each>
																		        	],</li>
																		        </xsl:for-each>
																		    </ul></small>
																		</dd>
																	</xsl:if>
																</dl>
															</p>
														</div>
													</div>
												</div>
						                    </xsl:for-each>
						                </div>
									</div>
								</div>
							</div>
							<!-- Report Queries -->
							<div>
								<xsl:if test="count(//dbqueries/dbquery/error)=0">
									<xsl:attribute name="class">panel panel-default</xsl:attribute>
								</xsl:if>
								<xsl:if test="count(//dbqueries/dbquery/error)!=0">
									<xsl:attribute name="class">panel panel-danger</xsl:attribute>
								</xsl:if>
								<div class="panel-heading">
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#ALLQueryString" href="#ReportQueries">
											SQL : <b><xsl:value-of select = "count(//dbqueries/dbquery)"/></b> Queries
										</a>
										<xsl:text> </xsl:text>
										<xsl:if test="count(//dbqueries/dbquery/error)!=0">
											<span class="label label-danger">
												<xsl:value-of select = "count(//dbqueries/dbquery/error)"/> in Error
											</span>
										</xsl:if>
										<xsl:if test="contains($vINFO,'X') and ($vPROFILE='Node_Admin' or $vNodeConfig='Local')">
											<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
											<span class="label label-info">										Data Generated
											</span>
										</xsl:if>
									</h4>
								</div>
								<div id="ReportQueries" class="panel-collapse collapse">
									<div class="panel-body">
										<!-- All ReportQueries -->
					                    <div id="ReportQueries" class="panel-group">
					                        <xsl:for-each select = "//dbqueries/dbquery">
						                    	<div>
						                    		<xsl:if test="count(error)=0">
														<xsl:attribute name="class">panel panel-default</xsl:attribute>
													</xsl:if>
													<xsl:if test="count(error)!=0">
														<xsl:attribute name="class">panel panel-danger</xsl:attribute>
													</xsl:if>
													
													<div class="panel-heading">
														<h4 class="panel-title">
															<a data-toggle="collapse" data-parent="#ReportQueries" href="#{@id}">
																<b><xsl:value-of select='@id'/></b> 
																<xsl:text> </xsl:text>
																<span>
																	<xsl:choose>
																		<xsl:when test="descriptor/database='dbnode'">
																			<xsl:attribute name="class">label label-default</xsl:attribute>
																			Database : <b>Datamart</b>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:attribute name="class">label label-primary</xsl:attribute>
																			Database : <b><xsl:value-of select='descriptor/database'/></b>
																		</xsl:otherwise>
																	</xsl:choose>
																</span>
															</a>	
															<xsl:text> </xsl:text>
															<span>
																<xsl:choose>
																	<xsl:when test="count(error)!=0">
																		<xsl:attribute name="class">label label-danger</xsl:attribute>
																		<b>Error in Query</b>
																	</xsl:when>
																	<xsl:when test="count(rows/row)=0">
																		<xsl:attribute name="class">label label-warning</xsl:attribute>
																		<b>No</b> Records
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:attribute name="class">label label-success</xsl:attribute>
																		<b><xsl:value-of select='count(rows/row)'/></b> Records
																	</xsl:otherwise>
																</xsl:choose>
															</span>
														</h4>
													</div>
													<div id="{@id}" class="panel-collapse collapse in">
														<div class="panel-body">
															<p>
																<dl class="dl-horizontal">
										                        	<dt><b>Original Query :</b></dt>
																	<dd><code class="sql"><xsl:value-of select = "descriptor/originalquery"/></code></dd>
																	<dt><b>Query :</b></dt>
																	<dd><code class="sql"><xsl:value-of select = "descriptor/querystring"/></code></dd>
																	<xsl:if test="count(error)!=0">
																		<dt><b>Error :</b></dt>
																		<dd><xsl:value-of select = "substring(error,0,350)"/>...</dd>
																	</xsl:if>
																	<xsl:if test="(count(rows/row)!=0 and contains($vINFO,'X')) and ($vPROFILE='Node_Admin' or $vNodeConfig='Local')">
																		<dt><b>Result :</b></dt>
																		<dd>
																			<small><ul>
																				<xsl:for-each select = "rows/row">
					        														<li>[
																	        		<xsl:for-each select="@*">
																						<b>'<xsl:value-of select="local-name()"/>'</b> : '<i><xsl:value-of select="."/></i>',
																	        		 </xsl:for-each>
																		        	],</li>
																		        </xsl:for-each>
																		    </ul></small>
																		</dd>
																	</xsl:if>
																</dl>
															</p>
														</div>
													</div>
												</div>
						                    </xsl:for-each>
						                </div>
									</div>
								</div>
							</div>
							<!-- Parameters -->
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#ALLQueryString" href="#ReportParam">Parameters : <b><xsl:value-of select = "count(//dbqueries/dbquery[1]/descriptor/parameters/param)"/></b> Parameters</a>
									</h4>
								</div>
								<div id="ReportParam" class="panel-collapse collapse">
									<div class="panel-body">
										<!-- All Parameters -->
				                        <dl class="dl-horizontal">
					                        <xsl:for-each select = "//dbqueries/dbquery[1]/descriptor/parameters/param">
						                    	<dt><xsl:value-of select = "@name"/> :</dt>
												<dd><xsl:value-of select = "@value"/></dd>
						                    </xsl:for-each>
										</dl>
					                </div>
								</div>
							</div>
						</div>
						<!-- Activate Highlight -->
						<script>
							$(document).ready(function() {
							  $('code').each(function(i, block) {
							    hljs.highlightBlock(block);
							  });
							});
						</script>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	
<!-- 
	 *****************************************************
	 ***   			DEPREACATED DO NOT USE 				**
	 ***   			WILL BE REMOVE SOON 				**
	 ***   	FOR MRNode FW2 Backward Compatibity 		**
	 *****************************************************
	-->

	<xsl:template name="RepObjective_InfoBox"> 		<!-- Generation of Report Objective InfoBox based on Local RepDic -->
		<xsl:param name="Title2S"/> 
		<xsl:param name="dictionary"/>
		<xsl:param name="Lang" select="'EN'"/>
		
		<xsl:variable name="RepObj" select="$dictionary//Label[@ID=$Title2S]/ObjectiveText[upper-case(@lang)=$Lang]"/>
		<xsl:choose>
			<xsl:when test="$RepObj='' or not($RepObj)">
				Do Nothing because no Objective Defined
			</xsl:when>
			<xsl:otherwise>
				<div id="Explain">
					<br/><b><u><em>Objectif</em></u></b> :  
					<span onclick="$('#Explain').hide()" style="Cursor:pointer"><font color="red">(Cacher)</font></span>
					<xsl:copy-of select="$RepObj" />
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Recurse_Image"> 				<!-- FW2 : Recurse Image -->
	    <xsl:param name="num" />
	    <xsl:param name="text" />
	    <xsl:variable name="vAlphabet" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	    <xsl:if test="not($num = 27)">
	       <xsl:variable name="vSearch" select="substring($vAlphabet,$num,1)"/>
	       <xsl:if test="contains($text,$vSearch)">	
	       		<xsl:element name='img'>
					<xsl:attribute name='src'>/<xsl:value-of select='$vHtDocsConfig'/>/CPN/img/alphabet/Rep<xsl:value-of select="$vSearch"/>.png</xsl:attribute>
					<xsl:attribute name='width'>17px</xsl:attribute>
					<xsl:attribute name='onerror'>this.src='/<xsl:value-of select='$vHtDocsConfig'/>/CPN/img/alphabet/RepUNK.png'</xsl:attribute>
					<xsl:attribute name='style'>vertical-align:middle</xsl:attribute>
				</xsl:element>
				<font size="1" color="white"><xsl:value-of select="$vSearch"/></font>
			</xsl:if>
	        <xsl:call-template name="Recurse_Image">
	            <xsl:with-param name="num" select="$num + 1" />
	            <xsl:with-param name="text" select="$text" />
	        </xsl:call-template>
	    </xsl:if> 			  
	</xsl:template>
	<xsl:template name="Recurse_Line"> 					<!-- FW2 : Recurse Line -->
	    <xsl:param name="start"/>
	    <xsl:param name="end"/>
	    <xsl:param name="text" />
	    <xsl:if test="not($start = $end)">
	    	<xsl:if test="substring($text,$start,1)='1'">
	    		<img src="/{$vHtDocsConfig}/CPN/img/LREP_OK.png" height="17px" style="vertical-align:middle"/>
			</xsl:if>
			<xsl:if test="substring($text,$start,1)='0'">
				<img src="/{$vHtDocsConfig}/CPN/img/LREP_NOK.png" height="17px" style="vertical-align:middle"/>
			</xsl:if>
			<xsl:if test="substring($text,$start,1)='9'">
				<img src="/{$vHtDocsConfig}/CPN/img/LREP_UNK.png" height="17px" style="vertical-align:middle"/>
			</xsl:if>
	        <xsl:call-template name="Recurse_Line">
	            <xsl:with-param name="start" select="$start + 1" />
	            <xsl:with-param name="end" select="$end" />
	            <xsl:with-param name="text" select="$text" />
	        </xsl:call-template>
	    </xsl:if>
	</xsl:template>
	<xsl:template name="Header">     					<!-- FW2 : Global Report Header (without EXPLORER Page) -->
		<xsl:param name="tLocal" select="'NO'"/> 	
		<xsl:param name="tRepDic" select="'NO'"/>
		<xsl:param name="tLanguage" select="'EN'"/>
		<!-- Is This is a Local Report -->
		<!-- Variable declaration -->
		<xsl:variable name="vGenRepDic" select="document('IL_MR_RepDic.xml')" />
		<xsl:if test="$tLocal='YES'">
			<center>
				<font color="red">
					<h2>
						<xsl:call-template name="FromDic2Rep">
							<xsl:with-param name="Title2S" select="'LOCAL_REPORT'"/>
							<xsl:with-param name="Lang" select="$tLanguage"/>
							<xsl:with-param name="dictionary" select="$vGenRepDic"/>
							<xsl:with-param name="tDDKey" select="303"/>
						</xsl:call-template>
					</h2>
				</font>
			</center>
		</xsl:if>
		<div id="Header" style="display:block">
			<table border="0" align="center" width="100%" >		
				<tbody valign='Top'>
					<tr>
						<td width='50%' align='left'>
							<!-- Call Report Infos -->
							<xsl:call-template name="Report_Infos">
								<xsl:with-param name="tLocal" select="$tLocal"/>
								<xsl:with-param name="tRepDic" select="$tRepDic"/>
								<xsl:with-param name="tLanguage" select="$tLanguage"/>
							</xsl:call-template>
						</td>
						<td width='50%' align='right'>
							<!-- Call Report Prompt -->
							<xsl:call-template name="Report_Prompts">
								<xsl:with-param name="tLocal" select="$tLocal"/>
								<xsl:with-param name="tRepDic" select="'NO'"/>
								<xsl:with-param name="tLanguage" select="$tLanguage"/>
							</xsl:call-template>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</xsl:template>
	<xsl:template name="Report_Infos">     				<!-- FW2 : Report Info Header (Top-Left) without EXPLORER Page -->
		<xsl:param name="tLocal" select="'NO'"/>
		<xsl:param name="tRepDic" select="'NO'"/>
		<xsl:param name="tLanguage" select="'EN'"/>
		<!-- Variable declaration -->
		<xsl:variable name="vGenRepDic" select="document('IL_MR_RepDic.xml')" />
		<xsl:choose>
				<!-- Report without Report Infos based on PRID -->
				<xsl:when test="count(//dbquery[@id='Report_Info']/rows/row)=0">
					<h2>
						<xsl:call-template name="FromDic2Rep">
							<xsl:with-param name="Title2S" select="'Rep_INFO_0'"/>
							<xsl:with-param name="Lang" select="$tLanguage"/>
							<xsl:with-param name="dictionary" select="$vGenRepDic"/>
							<xsl:with-param name="tDDKey" select="303"/>
						</xsl:call-template>
					</h2>
				</xsl:when>
				<!-- Infos found based on pRID value -->
				<xsl:otherwise>
					<table align="left"  width="70%" class="MRHead">
						<thead class="MRHead">
							<th align="left"  width="5%" style='padding:3px 1px 0px 1px'>
								<xsl:element name="a">
									<xsl:attribute name="onclick">
										if(REPORT_H.style.display=='none'){REPORT_H.style.display='block';imgREPORT_H.src="/<xsl:value-of select='$vHtDocsConfig'/>/CPN/img/down-bl.png"} else {REPORT_H.style.display='none';imgREPORT_H.src="/<xsl:value-of select='$vHtDocsConfig'/>/CPN/img/up-bl.png"};
									</xsl:attribute>
									<xsl:attribute name="style">cursor:pointer</xsl:attribute>
									<img id="imgREPORT_H" style="cursor:pointer;margin-left:5px;margin-right:5px" src="/{$vHtDocsConfig}/CPN/img/up-bl.png"/>
								</xsl:element>
							</th>
							<xsl:variable name="DOK"><xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/attribute::Extr_Status"/></xsl:variable>
							<xsl:variable name="EOK"><xsl:value-of select="count(//dbquery/error)"/></xsl:variable>
							<!-- Call template for flag generation -->
							<xsl:call-template name="Accuracy_Indic">
								<xsl:with-param name="tType" select="'Report'"/>
								<xsl:with-param name="tDOK" select="$DOK"/>
								<xsl:with-param name="tEOK" select="$EOK"/>
								<xsl:with-param name="tLanguage" select="$tLanguage"/>		
							</xsl:call-template>
						</thead>
					</table>
					<center>
						<div>
							<xsl:attribute name="id">REPORT_H</xsl:attribute>
							<xsl:attribute name="style">display:none</xsl:attribute>
							<table align="left" width="70%" class="MRHead">
								<tbody>
									<tr>
										<xsl:for-each select = "//dbquery[@id='Report_Info']/rows/row">
											<tr>
												<td width="30%" align="left">
													<b>
														<xsl:call-template name="FromDic2Rep">
															<xsl:with-param name="Title2S" select="'HRI_REPORT_NAME'"/>
															<xsl:with-param name="Lang" select="$tLanguage"/>
															<xsl:with-param name="dictionary" select="$vGenRepDic"/>
															<xsl:with-param name="tDDKey" select="303"/>
														</xsl:call-template>
													</b>
												</td>
												<td align="left">
													<a style="cursor:help;border-bottom: 1px dotted #000;color:black" data-ot-background="#7f8c8d" data-ot-borderColor="#8BA790" data-ot-style="dark">
														<xsl:attribute name="data-ot">
															<xsl:choose>
																<xsl:when test="$tLanguage = 'NL'">
																	&lt;big>Information (<xsl:value-of select='$tLanguage'/>)&lt;/big>&lt;br/>&lt;br/>
																	&lt;u>Gedetaillerde Beschrijving&lt;/u> : <xsl:value-of select="@dbn_rep_long_desc_nl"/>&lt;br/>
																	&lt;u>Opmerking(en)&lt;/u> : <xsl:value-of select="@dbn_rep_remarks_nl"/>&lt;br/>
																	&lt;u>Report Id (pRID Key)&lt;/u> : <xsl:value-of select="@dbn_rep_id"/>
																</xsl:when>
																<xsl:when test="$tLanguage = 'FR'">
																	&lt;big>Information (<xsl:value-of select='$tLanguage'/>)&lt;/big>&lt;br/>&lt;br/>
																	&lt;u>Description Détaillée&lt;/u> : <xsl:value-of select="@dbn_rep_long_desc_fr"/>&lt;br/>
																	&lt;u>Remarques&lt;/u> : <xsl:value-of select="@dbn_rep_remarks_fr"/>&lt;br/>
																	&lt;u>Id du Rapport (pRID Key)&lt;/u> : <xsl:value-of select="@dbn_rep_id"/>
																</xsl:when>
																<xsl:when test="$tLanguage = 'EN'">
																	&lt;big>Information (<xsl:value-of select='$tLanguage'/>)&lt;/big>&lt;br/>&lt;br/>
																	&lt;u>Detailled Description&lt;/u> : <xsl:value-of select="@dbn_rep_long_desc_en"/>&lt;br/>
																	&lt;u>Remark(s)&lt;/u> : <xsl:value-of select="@dbn_rep_remarks_en"/>&lt;br/>
																	&lt;u>Report Id (pRID Key)&lt;/u> : <xsl:value-of select="@dbn_rep_id"/>
																</xsl:when>
																<xsl:otherwise>
																	&lt;u>Unknown Language Code :&lt;/u>&lt;em><xsl:value-of select='$tLanguage'/>&lt;/em> 
																</xsl:otherwise>
															</xsl:choose>
														</xsl:attribute>
														<xsl:value-of select='@dbn_rep_name'/>
													</a>
												</td>
											</tr>
											<tr>
												<td align="left">
													<b>
														<xsl:call-template name="FromDic2Rep">
															<xsl:with-param name="Title2S" select="'HRI_REPORT_STATE'"/>
															<xsl:with-param name="Lang" select="$tLanguage"/>
															<xsl:with-param name="dictionary" select="$vGenRepDic"/>
															<xsl:with-param name="tDDKey" select="303"/>
														</xsl:call-template>
													</b>
												</td>
												<td align="left">
													<a style="cursor:help;border-bottom: 1px dotted #000;color:black" data-ot-background="#7f8c8d" data-ot-borderColor="#8BA790" data-ot-style="dark">
														<xsl:attribute name="data-ot">
															<xsl:choose>
																<xsl:when test="$tLanguage = 'NL'">
																	&lt;big>Information (<xsl:value-of select='$tLanguage'/>)&lt;/big>&lt;br/>&lt;br/>
																	&lt;u>Gebruikte Extracties/tables&lt;/u> : <xsl:value-of select='@Views_Used'/>
																</xsl:when>
																<xsl:when test="$tLanguage = 'FR'">
																	&lt;big>Information (<xsl:value-of select='$tLanguage'/>)&lt;/big>&lt;br/>&lt;br/>
																	&lt;u>Extractions/Tables utilisée(s)&lt;/u> : <xsl:value-of select='@Views_Used'/>
																</xsl:when>
																<xsl:when test="$tLanguage = 'EN'">
																	&lt;big>Information (<xsl:value-of select='$tLanguage'/>)&lt;/big>&lt;br/>&lt;br/>
																	&lt;u>Extractions/Tables used&lt;/u> : <xsl:value-of select='@Views_Used'/>
																</xsl:when>
																<xsl:otherwise>
																	&lt;u>Unknown Language Code :&lt;/u>&lt;em><xsl:value-of select='$tLanguage'/>&lt;/em> 
																</xsl:otherwise>
															</xsl:choose>
														</xsl:attribute>
														<xsl:value-of select='@Extr_Status'/> on <b><xsl:value-of select='@dbn_rep_node'/> Node </b> (<xsl:value-of select='@dbn_rep_type'/>)
													</a>
												</td>
											</tr>
											<tr>
												<td align="left">
													<b>	
														<xsl:call-template name="FromDic2Rep">
															<xsl:with-param name="Title2S" select="'HRI_REPORT_STATUS'"/>
															<xsl:with-param name="Lang" select="$tLanguage"/>
															<xsl:with-param name="dictionary" select="$vGenRepDic"/>
															<xsl:with-param name="tDDKey" select="303"/>
														</xsl:call-template>
													</b>
												</td>
												<td align="left">
													<a style="cursor:help;border-bottom: 1px dotted #000;color:black" data-ot-background="#7f8c8d" data-ot-borderColor="#8BA790" data-ot-style="dark">
														<xsl:attribute name="data-ot">
															<xsl:choose>
																<xsl:when test="$tLanguage = 'NL'">
																	&lt;big>Information (<xsl:value-of select='$tLanguage'/>)&lt;/big>&lt;br/>&lt;br/>
																	&lt;u>POC&lt;/u> : <xsl:value-of select='@dbn_rep_poc'/>&lt;br/>
																	&lt;u>EMAIL POC&lt;/u> : <xsl:value-of select='@dbn_rep_email'/>
																</xsl:when>
																<xsl:when test="$tLanguage = 'FR'">
																	&lt;big>Information (<xsl:value-of select='$tLanguage'/>)&lt;/big>&lt;br/>&lt;br/>
																	&lt;u>POC&lt;/u> : <xsl:value-of select='@dbn_rep_poc'/>&lt;br/>
																	&lt;u>EMAIL POC&lt;/u> : <xsl:value-of select='@dbn_rep_email'/>
																</xsl:when>
																<xsl:when test="$tLanguage = 'EN'">
																	&lt;big>Information (<xsl:value-of select='$tLanguage'/>)&lt;/big>&lt;br/>&lt;br/>
																	&lt;u>POC&lt;/u> : <xsl:value-of select='@dbn_rep_poc'/>&lt;br/>
																	&lt;u>EMAIL POC&lt;/u> : <xsl:value-of select='@dbn_rep_email'/>
																</xsl:when>
																<xsl:otherwise>
																	&lt;u>Unknown Language Code :&lt;/u>&lt;em><xsl:value-of select='$tLanguage'/>&lt;/em> 
																</xsl:otherwise>
															</xsl:choose>
														</xsl:attribute>
														<xsl:value-of select='@dbn_rep_status'/> (Version <xsl:value-of select='@dbn_rep_version'/>)
													</a>
												</td>
											</tr>
											<tr>
												<td align="left">
													<b>
														<xsl:call-template name="FromDic2Rep">
															<xsl:with-param name="Title2S" select="'HRI_REPORT_DD'"/>
															<xsl:with-param name="Lang" select="$tLanguage"/>
															<xsl:with-param name="dictionary" select="$vGenRepDic"/>
															<xsl:with-param name="tDDKey" select="303"/>
														</xsl:call-template>
													</b>
												</td>
												<td align="left">
													<table width="90%">
														<td width="25%">
															<b>
																<xsl:call-template name="FromDic2Rep">
																	<xsl:with-param name="Title2S" select="'HRI_REPORT_DD_LOCAL'"/>
																	<xsl:with-param name="Lang" select="$tLanguage"/>
																	<xsl:with-param name="dictionary" select="$vGenRepDic"/>
																	<xsl:with-param name="tDDKey" select="303"/>
																</xsl:call-template> 
															</b>
															<xsl:choose>
																<xsl:when test="vRepDic='NO'">
																	<img src="/{$vHtDocsConfig}/CPN/img/No.png" width="15px"/>
																</xsl:when>
																<xsl:otherwise>
																	<img src="/{$vHtDocsConfig}/CPN/img/Yes.png" width="15px"/>
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<td width="30%">
															<b>
																<xsl:call-template name="FromDic2Rep">
																	<xsl:with-param name="Title2S" select="'HRI_REPORT_DD_ILIAS'"/>
																	<xsl:with-param name="Lang" select="$tLanguage"/>
																	<xsl:with-param name="dictionary" select="$vGenRepDic"/>
																	<xsl:with-param name="tDDKey" select="303"/>
																</xsl:call-template> 
															</b>
															<xsl:choose>
																<xsl:when test="count(//dbquery[@id='DATA_DICTIONARY'])=1">
																	<a target="_blank" href="/LRF/XMLWeb/ProcessDescriptor/descriptor/MRN_UAUT/MRN_REDIR/REDIR.xml?pRID=1061&amp;pVRID={$vRID}&amp;pLANG={$vLANG}"><img border="0px" src="/{$vHtDocsConfig}/CPN/img/Yes.png" width="15px"/></a>
																</xsl:when>
																<xsl:otherwise>
																	<img src="/{$vHtDocsConfig}/CPN/img/No.png" width="15px"/>
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<script>
															
														</script>
														<td width="30%">
															<b>
																<xsl:call-template name="FromDic2Rep">
																	<xsl:with-param name="Title2S" select="'HRI_REPORT_DEBUG'"/>
																	<xsl:with-param name="Lang" select="$tLanguage"/>
																	<xsl:with-param name="dictionary" select="$vGenRepDic"/>
																	<xsl:with-param name="tDDKey" select="303"/>
																</xsl:call-template> 
															</b>
															<img src="/{$vHtDocsConfig}/CPN/img/Flat/info-icon.png" style='cursor:pointer' width="15px" onclick="var mMsg=localStorage['MRNDebug'];MagPopUp(mMsg);"/>
														</td>
													</table>
												</td>
											</tr>
											<tr>
												<td colspan="10">
													<xsl:variable name="href2"><xsl:value-of select='@dbn_rep_id'/></xsl:variable>
													<table width="100%">
														<thead class="MRHead">	
															<td width="50%" align="center">
																<xsl:choose>
																	<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@DayModif = '' ">
																		<xsl:choose>
																			<xsl:when test="$tLanguage = 'NL'">
																				Geen Modificatie
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'FR'">
																				Pas de Modification
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'EN'">
																				No Modification
																			</xsl:when>
																			<xsl:otherwise>
																				<u>Unknown Language Code :</u><em><xsl:value-of select='$tLanguage'/></em> 
																			</xsl:otherwise>
																		</xsl:choose>
																	</xsl:when>
																	<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_version = '1.0' ">
																		<xsl:choose>
																			<xsl:when test="$tLanguage = 'FR'">
																				Nouveau rapport
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'NL'">
																				Nieuwe Rapport
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'EN'">
																				This is a new Report
																			</xsl:when>
																			<xsl:otherwise>
																				<u>Unknown Language Code :</u><em><xsl:value-of select='$tLanguage'/></em> 
																			</xsl:otherwise>
																		</xsl:choose>																
																		<xsl:text>   </xsl:text><img src="/{$vHtDocsConfig}/CPN/img/Flat/new-icon.png" width="30px" style="vertical-align:Top"/>
																	</xsl:when>
																	<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@DayModif = '0' ">
																		<xsl:choose>
																			<xsl:when test="$tLanguage = 'FR'">
																				Ce rapport a été modifié aujourd'hui (
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'NL'">
																				Dit Rapport was aangepast vandag (
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'EN'">
																				This report has been modified Today (
																			</xsl:when>
																			<xsl:otherwise>
																				<u>Unknown Language Code :</u><em><xsl:value-of select='$tLanguage'/> (</em> 
																			</xsl:otherwise>
																		</xsl:choose>
																		<xsl:element name='a'>
																			<xsl:attribute name='href'>javascript:void(0);</xsl:attribute>
																			<xsl:attribute name='onmouseover'>return showPopup('/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_POPUP2/DBN_POPUP_Rep_Logging.xml?repid=<xsl:value-of select="$vRID"/>',800);</xsl:attribute>
																			<xsl:attribute name='onmouseout'>return nd();</xsl:attribute>
																			Infos
																		</xsl:element>)
																		<xsl:text>   </xsl:text><img src="/{$vHtDocsConfig}/CPN/img/Flat/msg-2-icon.png" width="20px" style="vertical-align:center"/>
																	</xsl:when>
																	<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@DayModif = '1' ">
																		<xsl:choose>
																			<xsl:when test="$tLanguage = 'FR'">
																				Ce rapport a été modifié hier (
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'NL'">
																				Dit Rapport was aangepast gisteren (
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'EN'">
																				This report has been modified Yesterday (
																			</xsl:when>
																			<xsl:otherwise>
																				<u>Unknown Language Code :</u><em><xsl:value-of select='$tLanguage'/> (</em> 
																			</xsl:otherwise>
																		</xsl:choose>
																		<xsl:element name='a'>
																			<xsl:attribute name='href'>javascript:void(0);</xsl:attribute>
																			<xsl:attribute name='onmouseover'>return showPopup('/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_POPUP2/DBN_POPUP_Rep_Logging.xml?repid=<xsl:value-of select="$vRID"/>',800);</xsl:attribute>
																			<xsl:attribute name='onmouseout'>return nd();</xsl:attribute>
																			Infos
																		</xsl:element>)
																		<xsl:text>   </xsl:text><img src="/{$vHtDocsConfig}/CPN/img/Flat/msg-2-icon.png" width="20px" style="vertical-align:center"/>
																	</xsl:when>
																	<xsl:when test="//dbquery[@id='Report_Info']/rows/row/@DayModif &lt; 8 ">
																		<xsl:choose>
																			<xsl:when test="$tLanguage = 'FR'">
																				Ce rapport a été modifié récemment (<xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@DayModif"/> jours) (
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'NL'">
																				Dit Rapport was onlangs (<xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@DayModif"/> dagen) aangepast (
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'EN'">
																				This report has been recently (<xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@DayModif"/> days) modified (
																			</xsl:when>
																			<xsl:otherwise>
																				<u>Unknown Language Code :</u><em><xsl:value-of select='$tLanguage'/> (</em> 
																			</xsl:otherwise>
																		</xsl:choose>
																		<xsl:element name='a'>
																			<xsl:attribute name='href'>javascript:void(0);</xsl:attribute>
																			<xsl:attribute name='onmouseover'>return showPopup('/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_POPUP2/DBN_POPUP_Rep_Logging.xml?repid=<xsl:value-of select="$vRID"/>',800);</xsl:attribute>
																			<xsl:attribute name='onmouseout'>return nd();</xsl:attribute>
																			Infos
																		</xsl:element>)
																		<xsl:text>   </xsl:text><img src="/{$vHtDocsConfig}/CPN/img/Flat/msg-2-icon.png" width="20px" style="vertical-align:center"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:choose>
																			<xsl:when test="$tLanguage = 'NL'">
																				Laatste modificatie <xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@DayModif"/> dag geleden (
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'FR'">
																				Dernière modification, il y a <xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@DayModif"/> jours (
																			</xsl:when>
																			<xsl:when test="$tLanguage = 'EN'">
																				Last modification <xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@DayModif"/> days ago (
																			</xsl:when>
																			<xsl:otherwise>
																				<u>Unknown Language Code :</u><em><xsl:value-of select='$tLanguage'/></em> 
																			</xsl:otherwise>
																		</xsl:choose>
																		<xsl:element name='a'>
																			<xsl:attribute name='href'>javascript:void(0);</xsl:attribute>
																			<xsl:attribute name='onmouseover'>return showPopup('/LRF/XMLWeb/ProcessDescriptor/descriptor/LRF2/IL_MR_POPUP2/DBN_POPUP_Rep_Logging.xml?repid=<xsl:value-of select="$vRID"/>',800);</xsl:attribute>
																			<xsl:attribute name='onmouseout'>return nd();</xsl:attribute>
																			Infos
																		</xsl:element>)
																		<xsl:text>   </xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</td>
															<td width="50%" align="center">
																<xsl:choose>
																	<xsl:when test="$tLanguage = 'NL'">
																		<a target="_blank" href="/LRF/XMLWeb/ProcessDescriptor/descriptor/MRN/MRN_REPORT/MRN_REP_LIST.xml?pLANG=NL&amp;pMODE=Drill-Down2&amp;pIDRID={$href2}">Rapport Identiteitskaart</a>
																	</xsl:when>
																	<xsl:when test="$tLanguage = 'FR'">
																		<a target="_blank" href="/LRF/XMLWeb/ProcessDescriptor/descriptor/MRN/MRN_REPORT/MRN_REP_LIST.xml?pLANG=FR&amp;pMODE=Drill-Down2&amp;pIDRID={$href2}">Carte d'identité de ce Rapport</a>
																	</xsl:when>
																	<xsl:when test="$tLanguage = 'EN'">
																		<a target="_blank" href="/LRF/XMLWeb/ProcessDescriptor/descriptor/MRN/MRN_REPORT/MRN_REP_LIST.xml?pLANG=EN&amp;pMODE=Drill-Down2&amp;pIDRID={$href2}">Report Id Card</a>
																	</xsl:when>
																	<xsl:otherwise>
																		<u>Unknown Language Code :</u><em><xsl:value-of select='$tLanguage'/></em> 
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</thead>
													</table>
												</td>
											</tr>
										</xsl:for-each>
									</tr>
								</tbody>				
							</table>
						</div>
					</center>
				</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="Report_Prompts">     			<!-- FW2 : Report Prompts (Top-Right) without EXPLORER Page -->
		<xsl:param name="tLocal" select="'NO'"/>
		<xsl:param name="tRepDic" select="'NO'"/>
		<xsl:param name="tLanguage" select="'EN'"/>
		<!-- Variable declaration -->
		<xsl:variable name="vGenRepDic" select="document('IL_MR_RepDic.xml')" />
		<!-- Prompts -->
		<div id="REPORT_SP"  style="display:block">
			<xsl:choose>
				<!-- Config autre que MRN. A utiliser pour un rapport local -->
				<xsl:when test="$tLocal='YES'">
					<table align="right"  width="70%" class="MRPrompt">
						<thead class="MRPrompt">
							<th align="left"  width="5%" style='padding:3px 1px 0px 1px'>
								<xsl:element name="a">
									<xsl:attribute name="onclick">if(REPORT_P.style.display=='none'){REPORT_P.style.display='block';imgHP.src="/<xsl:value-of select='$vHtDocsConfig'/>/CPN/img/down-bl.png"} else {REPORT_P.style.display='none';imgHP.src="/<xsl:value-of select='$vHtDocsConfig'/>/CPN/img/up-bl.png"};</xsl:attribute>
									<xsl:attribute name="style"> style="cursor:pointer;</xsl:attribute>
									<img id="imgHP" style="cursor:pointer;margin-left:5px;margin-right:5px" src="/{$vHtDocsConfig}/CPN/img/up-bl.png"/>     
								</xsl:element>
							</th>
							<th  colspan="2">
								<!-- Script qui permet de verifier qu'un rapport local est appelé en dehors du Localhost -->
								<script>
									var url = window.location.href;
									if (url.indexOf("mrnode")==-1) {
										if (url.indexOf("localhost")==-1) {
										<xsl:choose>
											<xsl:when test="$tLanguage = 'NL'">
												document.write('<a class="tooltip" href="#"><font color="red">Opgelet</font><span class="custom info"><img src="/{$vHtDocsConfig}/CPN/img/Flat/bulb-icon.png" alt="Information" height="48" width="48" />U bent bezig om een lokake rapport te consulteren. Dit gebruikt de volgende paremeters in de DBWeb</span></a> : <xsl:value-of select="count(//dbquery[1]/descriptor/parameters/param[@name!='pRID'])"/> Lokale Opzoeking Parameters');
											</xsl:when>
											<xsl:when test="$tLanguage = 'FR'">
												document.write('<a class="tooltip" href="#"><font color="red">Attention</font><span class="custom info"><img src="/{$vHtDocsConfig}/CPN/img/Flat/bulb-icon.png" alt="Information" height="48" width="48" />Vous consultez un rapport local qui utilise les paramètres suivants dans son DBWeb</span></a> : <xsl:value-of select="count(//dbquery[1]/descriptor/parameters/param[@name!='pRID'])"/> Paramètres locaux de recherche');
											</xsl:when>
											<xsl:when test="$tLanguage = 'EN'">
												document.write('<a class="tooltip" href="#"><font color="red">Warning</font><span class="custom info"><img src="/{$vHtDocsConfig}/CPN/img/Flat/bulb-icon.png" alt="Information" height="48" width="48" />You are consulting a local report. It uses some parameters in de DBWeb</span></a> : <xsl:value-of select="count(//dbquery[1]/descriptor/parameters/param[@name!='pRID'])"/> Local Reports Parameters(s)');
											</xsl:when>
											<xsl:otherwise>
												document.write('<u>Unknown Language Code :</u><em><xsl:value-of select="$tLanguage"/></em>') 
											</xsl:otherwise>
										</xsl:choose>
										} 
										else {
										<xsl:choose>
											<xsl:when test="$tLanguage = 'NL'">
												document.write('<xsl:value-of select="count(//dbquery[1]/descriptor/parameters/param[@name!='pRID'])"/> Lokale Opzoeking Parameters');
											</xsl:when>
											<xsl:when test="$tLanguage = 'FR'">
												document.write('<xsl:value-of select="count(//dbquery[1]/descriptor/parameters/param[@name!='pRID'])"/> Paramètres locaux de recherche');
											</xsl:when>
											<xsl:when test="$tLanguage = 'EN'">
												document.write('<xsl:value-of select="count(//dbquery[1]/descriptor/parameters/param[@name!='pRID'])"/> Local Reports Parameters(s)');
											</xsl:when>
											<xsl:otherwise>
												document.write('<u>Unknown Language Code :</u><em><xsl:value-of select="$tLanguage"/></em>') 
											</xsl:otherwise>
										</xsl:choose>
										};
									} else {document.write('(?code001?) <xsl:value-of select="count(//dbquery[1]/descriptor/parameters/param[@name!='pRID'])"/> Local Reports Parameters(s)')};
								</script>
							</th>
						</thead>
					</table>
					<div align="right">
						<xsl:attribute name="id">REPORT_P</xsl:attribute>
						<xsl:attribute name="style">display:none</xsl:attribute>					
						<table width="70%" class="MRHead">
							<form width="100%" style='margin-bottom:0px;' method='get' action="" >
								<tr>
									<td colspan="2">									
										<xsl:element name='input'>
											<xsl:attribute name='type'>hidden</xsl:attribute>
											<xsl:attribute name='name'>pRID</xsl:attribute>
											<xsl:attribute name='value'><xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name='pRID']/@value"/></xsl:attribute>
										</xsl:element>
									</td>
									<td align="center">
										<xsl:attribute name='rowspan'>
											<xsl:value-of select="count(//dbquery[1]/descriptor/parameters/param)+2"/>
										</xsl:attribute>
										<input type='submit' value='Search'/>
									</td>
								</tr>
								<xsl:for-each select = "//dbquery[1]/descriptor/parameters/param[@name!='pRID']">
									<xsl:variable name="vparam"><xsl:value-of select="@name"/></xsl:variable>
									<tr>
										<td align="left">
											<label style='width:60%' align="left"><a class="tooltip" href="#">
												<xsl:value-of select="substring($vparam,2,100)"/>
												<span class="custom info">
													<img src="/{$vHtDocsConfig}/CPN/img/Flat/bulb-icon.png" alt="Information" height="48" width="48" />
													<u>Parameter defined in DBWEB</u> : <xsl:value-of select='$vparam'/>
												</span></a> : 
											</label><br/>
										</td>
										<td align="left">
											<xsl:element name='input'>
												<xsl:attribute name='name'><xsl:value-of select="$vparam"/></xsl:attribute>
												<xsl:attribute name='id'>id<xsl:value-of select="$vparam"/></xsl:attribute>
												<xsl:attribute name='value'><xsl:value-of select="//dbquery[@id='Report_Info']/descriptor/parameters/param[@name=$vparam]/attribute::value"/></xsl:attribute>
											</xsl:element>					
										</td>
									</tr>
								</xsl:for-each>
							</form>	
						</table>		
					</div>
				</xsl:when>
				<!-- Pour MR Node mais pas de Prompts trouvés : Notification -->
				<xsl:when test="$tLocal='NO' and count(//dbquery[@id='Report_Prompt']/rows/row)=0">
					<!-- Generate Notification -->
					<xsl:call-template name="TNotif">
						<xsl:with-param name="tMsg" select="'There is &lt;b>No&lt;/b> Prompts defined for this Report'"/>
						<xsl:with-param name="tTitle" select="'T05 - Report Prompt(s)'"/> 
						<xsl:with-param name="tType" select="1"/> 	
						<xsl:with-param name="tAppear" select="1000"/>
						<xsl:with-param name="tSilence" select="'Y'"/>	
					</xsl:call-template>
				</xsl:when>
				<!-- Pour MR Node AVEC Prompts trouvés -->
				<xsl:when test="$tLocal='NO' and count(//dbquery[@id='Report_Prompt']/rows/row)!=0">
	 				<table align="right"  width="70%" class="MRPrompt">
						<thead class="MRPrompt">
							<th align="left"  width="5%" style='padding:3px 1px 0px 1px'>
								<xsl:element name="a">
									<xsl:attribute name="onclick">if(REPORT_P.style.display=='none'){REPORT_P.style.display='block';imgHP.src="/<xsl:value-of select='$vHtDocsConfig'/>/CPN/img/down-bl.png"} else {REPORT_P.style.display='none';imgHP.src="/<xsl:value-of select='$vHtDocsConfig'/>/CPN/img/up-bl.png"};</xsl:attribute>
									<xsl:attribute name="style"> style="cursor:pointer;</xsl:attribute>
									<img id="imgHP" style="cursor:pointer;margin-left:5px;margin-right:5px" src="/{$vHtDocsConfig}/CPN/img/up-bl.png"/>     
								</xsl:element>
							</th>
							<th colspan="2">
								<xsl:value-of select="count(//dbquery[@id='Report_Prompt']/rows/row)"/> 
								<xsl:choose>
									<xsl:when test="$tLanguage = 'NL'">
										Opzoeking Parameters
									</xsl:when>
									<xsl:when test="$tLanguage = 'FR'">
										Paramètres de recherche
									</xsl:when>
									<xsl:when test="$tLanguage = 'EN'">
										Reports Parameters(s)
									</xsl:when>
									<xsl:otherwise>
										<u>Unknown Language Code :</u><em><xsl:value-of select='$tLanguage'/></em> 
									</xsl:otherwise>
								</xsl:choose>
							</th>
						</thead>
					</table>	
					<div id="REPORT_P" style="display:none">
						<!-- Call generation fo Prompts -->
						<xsl:call-template name="List_Of_Prompts">
							<xsl:with-param name="tLanguage" select="$tLanguage"/>
						</xsl:call-template> 
					</div>
				</xsl:when>
				<xsl:otherwise>
					Trap Prompting Otherwise (config=<xsl:value-of select='$tLocal'/>)
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<xsl:template name="List_Of_Prompts">				<!-- FW2 : List Of Prompts (called in All Reports) -->
		<xsl:param name="DBWeb" select="'Report_Prompt'"/>
		<xsl:param name="Action" select="''"/>
		<xsl:param name="tLanguage" select="'EN'"/>
		<!-- Variable declaration -->
		<xsl:variable name="vGenRepDic" select="document('IL_MR_RepDic.xml')" />
		<table border="0" width="70%" class="MRHead">
			<form width="100%" style='margin-bottom:0px;' method='get' action="" >
				<xsl:attribute name="action"><xsl:value-of select="$Action"/></xsl:attribute>
				<tr>
					<td colspan="2">									
						<!-- Add pRID always but hidden @remark : kan dit niet veel compacter geschreven worden -->
						<xsl:element name='input'>
							<xsl:attribute name='type'>hidden</xsl:attribute>
							<xsl:attribute name='name'>pRID</xsl:attribute>
							<xsl:attribute name='value'><xsl:value-of select="//dbquery[@id=$DBWeb]/rows/row[1]/@dbn_repp_parid"/></xsl:attribute>
						</xsl:element>
						<!-- Add KPI Classical Prompts hidden -->
						<xsl:if test="//dbquery[@id='Report_Info']/rows/row[1]/@dbn_rep_kpi!=''">
							<xsl:element name='input'>
								<xsl:attribute name='type'>hidden</xsl:attribute>
								<xsl:attribute name='name'>pKPI</xsl:attribute>
								<xsl:attribute name='value'><xsl:value-of select="$vKPI"/></xsl:attribute>
							</xsl:element>
							<xsl:element name='input'>
								<xsl:attribute name='type'>hidden</xsl:attribute>
								<xsl:attribute name='name'>pEXPLORE</xsl:attribute>
								<xsl:attribute name='value'>YES</xsl:attribute>
							</xsl:element>
						</xsl:if>
					</td>
					<td align="center">
						<xsl:attribute name='rowspan'>
							<xsl:value-of select="count(//dbquery[@id=$DBWeb]/rows/row)+2"/>
						</xsl:attribute>
						<input type='submit' value='Search'/>
					</td>
				</tr>
					<xsl:for-each select = "//dbquery[@id=$DBWeb]/rows/row">
						<xsl:sort select="@dbn_repp_param_order"/>
						<xsl:variable name="vPARAMNAME">
							<xsl:choose>
								<xsl:when test="$tLanguage = 'NL'"><xsl:value-of select="if(@dbn_repp_param_name_nl='') then concat(@dbn_repp_param_name,' (En)') else @dbn_repp_param_name_nl"/></xsl:when>
								<xsl:when test="$tLanguage = 'FR'"><xsl:value-of select="if(@dbn_repp_param_name_fr='') then concat(@dbn_repp_param_name,' (En)') else @dbn_repp_param_name_fr"/></xsl:when>
								<xsl:when test="$tLanguage = 'EN'"><xsl:value-of select="@dbn_repp_param_name"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="@dbn_repp_param_name"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="vPARAMREMARK">							
							<xsl:choose>
								<xsl:when test="$tLanguage = 'NL'"><xsl:value-of select="if(@dbn_repp_param_remark_nl='') then concat(@dbn_repp_param_remark,' (En)') else @dbn_repp_param_remark_nl"/></xsl:when>
								<xsl:when test="$tLanguage = 'FR'"><xsl:value-of select="if(@dbn_repp_param_remark_fr='') then concat(@dbn_repp_param_remark,' (En)') else @dbn_repp_param_remark_fr"/></xsl:when>
								<xsl:when test="$tLanguage = 'EN'"><xsl:value-of select="@dbn_repp_param_remark"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="@dbn_repp_param_remark"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>					
						<xsl:variable name="vparam" select="@dbn_repp_param"/>
						<tr>
							<td align="left">
								<label style='width:60%' align="left">
									<a style="cursor:help;border-bottom: 1px dotted #000;color:black" data-ot-background="#7f8c8d" data-ot-borderColor="#8BA790" data-ot-style="dark">
										<xsl:attribute name="data-ot">
											&lt;big>
												Infos on Prompt :&lt;br/>&lt;b><xsl:value-of select='$vPARAMNAME'/>
											&lt;/b>&lt;/big>&lt;br/>&lt;br/>
											&lt;u>Format&lt;/u> : <xsl:value-of select='@dbn_repp_param_format'/>&lt;br/>
											&lt;u>Type&lt;/u> : <xsl:value-of select='@dbn_repp_param_type'/>&lt;br/>
											&lt;u>Remarks&lt;/u> : 
												<xsl:value-of select='$vPARAMREMARK'/>
											&lt;br/>
											&lt;u>Coded Para in URL&lt;/u> : <xsl:value-of select='@dbn_repp_param'/>
										</xsl:attribute>
										<b>
											<xsl:value-of select='$vPARAMNAME'/>
										</b>
									</a> : 
								</label><br/>
							</td>
							<td align="left">
								<xsl:choose>
									<xsl:when test="@dbn_repp_param_type='Drop-Down'">
										<xsl:element name='select'>
											<xsl:attribute name='name'><xsl:value-of select="$vparam"/></xsl:attribute>	
											<xsl:variable name='LOVVal'><xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name=$vparam]/attribute::value"/></xsl:variable>
											<script type="text/javascript">
												 var DDContent = [<xsl:value-of select='@dbn_repp_param_type_detail'/>]
												 MRN_ComboBox(DDContent,'<xsl:value-of select='$LOVVal'/>');
											</script>
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										<xsl:element name='input'>
											<xsl:attribute name='name'><xsl:value-of select="$vparam"/></xsl:attribute>
											<xsl:attribute name='id'>id<xsl:value-of select="$vparam"/></xsl:attribute>
											<xsl:attribute name='value'><xsl:value-of select="//dbquery[1]/descriptor/parameters/param[@name=$vparam]/attribute::value"/></xsl:attribute>
										</xsl:element>					
									 </xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>
					<!-- Add KPI Classical Prompts Not Hidden -->
					<xsl:if test="//dbquery[@id='Report_Info']/rows/row[1]/@dbn_rep_kpi!=''">
						<!-- Add Historical Parameter -->
						<tr>
							<td align="left">
								<label style='width:60%' align="left">
									<a style="cursor:help;border-bottom: 1px dotted #000;color:black" data-ot-background="#7f8c8d" data-ot-borderColor="#8BA790" data-ot-style="dark">
										<xsl:attribute name="data-ot">
											&lt;big>
												Infos on Prompt (Std) :&lt;br/>&lt;b>
												Historical
											&lt;/b>&lt;/big>&lt;br/>&lt;br/>
											&lt;u>Format&lt;/u> : Text&lt;br/>
											&lt;u>Type&lt;/u> : Drill-Down&lt;br/>
											&lt;u>Remarks&lt;/u> : Yes to Show Historical KPI
											&lt;u>Coded Para in URL&lt;/u> : pHIST
										</xsl:attribute>
										<b>
											<xsl:choose>
												<xsl:when test="$tLanguage = 'NL'">
													Toon Historiek
												</xsl:when>
												<xsl:when test="$tLanguage = 'FR'">
													Montrer Historique
												</xsl:when>
												<xsl:when test="$tLanguage = 'EN'">
													Show Historical
												</xsl:when>
												<xsl:otherwise>
													<u>Unknown Language Code :</u><em><xsl:value-of select='$tLanguage'/></em> 
												</xsl:otherwise>
											</xsl:choose>
										</b>
									</a> :
								</label><br/>
							</td>
							<td align="left">
								<xsl:element name='select'>
									<xsl:attribute name='name'>pHIST</xsl:attribute>	
									<xsl:variable name='LOVVal' select="//dbquery[1]/descriptor/parameters/param[@name='pHIST']/@value"/>
									<script type="text/javascript">
										 var DDContentH = ['YES','Yes (Show Historical)','NO','No (Historical not Shown)']
										 MRN_ComboBox(DDContentH,'<xsl:value-of select='$LOVVal'/>');
									</script>
								</xsl:element>
							</td>
						</tr>
						
					</xsl:if>
					<!-- Add pLANG Parameter -->
					<tr>
						<td align="left">
							<label style='width:60%' align="left">
								<a style="cursor:help;border-bottom: 1px dotted #000;color:black" data-ot-background="#7f8c8d" data-ot-borderColor="#8BA790" data-ot-style="dark">
									<xsl:attribute name="data-ot">
										&lt;big>
											Infos on Prompt (Std) :&lt;br/>&lt;b>
											Language
										&lt;/b>&lt;/big>&lt;br/>&lt;br/>
										&lt;u>Format&lt;/u> : Text&lt;br/>
										&lt;u>Type&lt;/u> : Drill-Down&lt;br/>
										&lt;u>Coded Para in URL&lt;/u> : pLANG
									</xsl:attribute>
									<b>
										<xsl:choose>
											<xsl:when test="$tLanguage = 'NL'">
												Taal
											</xsl:when>
											<xsl:when test="$tLanguage = 'FR'">
												Langue
											</xsl:when>
											<xsl:when test="$tLanguage = 'EN'">
												Language
											</xsl:when>
											<xsl:otherwise>
												<u>Unknown Language Code :</u><em><xsl:value-of select='$tLanguage'/></em> 
											</xsl:otherwise>
										</xsl:choose>
									</b>
								</a> : 
							</label><br/>
						</td>
						<td align="left">
							<xsl:element name='select'>
								<xsl:attribute name='name'>pLANG</xsl:attribute>
								<!-- Use of Substring and Distinct to isolate double parameters created by usage of WS MRN_METADATA -->	
								<xsl:variable name='LOVVal' select="substring(distinct-values(//dbquery[1]/descriptor/parameters/param[@name='pLANG']/@value),1,2)"/>
								<script type="text/javascript">
									var DDContentL = ['EN','English','FR','Français','NL','Nederlands']
									MRN_ComboBox(DDContentL,'<xsl:value-of select='$LOVVal'/>');
								</script>
							</xsl:element>
						</td>
					</tr>

			</form>	
			<tr>
				<xsl:variable name="vReportIdforKPI" select="//dbquery[@id='Report_Info']/rows/row[1]/@dbn_rep_id"/>
				<td colspan="10" align="center">
					<a target="_blank" href="/LRF/XMLWeb/ProcessDescriptor/descriptor/MRN_UAUT/MRN_REDIR/WS.xml?pRID={$vRID}&amp;pLANG={$vLANG}">Define Default values for this Report</a>
					<xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
					<a target="_blank" href="/LRF/XMLWeb/ProcessDescriptor/descriptor/MRN_UAUT/MRN_REDIR/REDIR.xml?pRID=1064&amp;pVRID={$vReportIdforKPI}&amp;pLANG={$vLANG}">Leave Us a Feedback</a>
				</td>
			</tr>
		</table>	
	</xsl:template>

	<xsl:template name="Report2Improve"> 				<!-- FW2 : Bloc Improve Report (in Report Bottom) - Depreacated Do Not USE -->
		<xsl:param name="tRepDic" select="'NO'"/> 		<!-- Dictionary ? Type relative Path or No (Default) -->
		<xsl:param name="tLocal" select="'NO'"/> 		<!-- Yes for Local and NO (Default) for MR Node -->
		<xsl:param name="tLanguage" select="'EN'"/>
		
		<xsl:variable name="vGenRepDic" select="document('IL_MR_RepDic.xml')" />
		
		<div id="IMPROVE_S" style="display:block">
			<table border="0" align="center" width="60%" class="MRFoot">
				<thead  class="MRFoot">
					<th align="center"  width="5%" style='padding:3px 1px 0px 1px'>
						<xsl:element name="a">
							<xsl:attribute name="onclick">
								if(IMPROVE.style.display=='none'){IMPROVE.style.display='block';imgRF.src='/<xsl:value-of select='$vHtDocsConfig'/>/CPN/img/down-bl.png'} else {IMPROVE.style.display='none';imgRF.src='/<xsl:value-of select='$vHtDocsConfig'/>/CPN/img/up-bl.png'};
							</xsl:attribute>
							<xsl:attribute name="style"> style="cursor:pointer;</xsl:attribute>
							<img id="imgRF" style="cursor:pointer;margin-left:5px;margin-right:5px" src="/{$vHtDocsConfig}/CPN/img/up-bl.png"/>
						</xsl:element>
					</th>
					<TH colspan="4"  class="MRFoot">
						<xsl:call-template name="FromDic2Rep">
							<xsl:with-param name="Title2S" select="'HFI_REPORT_IMPROVE'"/>
							<xsl:with-param name="Lang" select="$tLanguage"/>
							<xsl:with-param name="dictionary" select="$vGenRepDic"/>
							<xsl:with-param name="tDDKey" select="303"/>
						</xsl:call-template><xsl:text> </xsl:text>
					</TH>
				</thead>
			</table>
			<div id="IMPROVE" style="display:none">
				<table width="60%" align="center" class="MRFoot">
					<tbody>
						<tr>
							<th width="10%" align="center" style='padding:1px 1px 1px 15px'><big>Fr</big></th><td colspan="8" align="left">Si vous avez des remarques et améliorations à nous proposer, envoyez un mail au <a href="mailto:crescencio.ibanez@mil.be">Cdt IBANEZ C</a> . Soyez le plus complet possible.</td>
						</tr>
						<tr>
							<th width="10%" align="center" style='padding:1px 1px 1px 15px'><big>Nl</big></th><td colspan="8" align="left">Indien u opmerkingen of verbeteringen heeft, stuur een Email naar <a href="mailto:renzo.dubus@mil.be">Adjt Dubus R</a> . Wees zo volledig mogelijk.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</xsl:template>
	<xsl:template name="DataDic_Decryptor"> 			<!-- FW2 : Data Dictionary decriptor -->
		<xsl:param name="tUDDD" select="'UDDD_NONE'"/>
		<xsl:param name="tLanguage" select="'EN'"/>
		
		<div style="display:none">
			<xsl:attribute name="id">D_<xsl:value-of select="$tUDDD"/></xsl:attribute>

			<xsl:variable name="TNameDD">ILIAS_DD_<xsl:value-of select="$tUDDD"/></xsl:variable>
			<xsl:variable name="vColDDVis">
				<xsl:choose>
					<xsl:when test="$tLanguage='FR'">0,2,7,10,11</xsl:when>
					<xsl:when test="$tLanguage='NL'">0,2,7,9,11</xsl:when>
					<xsl:otherwise>0,2,7</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:call-template name="Generic_Table_DBWEB">
				<xsl:with-param name="DBWEB_Name" select="'DATA_DICTIONARY'"/>
				<xsl:with-param name="UdTN" select="$tUDDD"/>
				<xsl:with-param name="Show_Empty" select="'Y'"/> 
				<xsl:with-param name="Node_Conf" select="$vNodeConfig"/>
				<xsl:with-param name="dT_Type" select="$vNodedT"/>
				<xsl:with-param name="Lang" select="$tLanguage"/>
				<xsl:with-param name="RepDic" select="'Y'"/> 
				<xsl:with-param name="dictionary" select="document('../COMMON/IL_MR_RepDic.xml')"/>
				<xsl:with-param name="Col_Hidden" select="$vColDDVis"/>
				<xsl:with-param name="MaxRecords" select="9999"/>
				<xsl:with-param name="Frame" select="'YC'"/>
				<xsl:with-param name="TableWidth" select="'60%'"/>
				<xsl:with-param name="Detail_Data" select="'Generic'"/> 
			</xsl:call-template>
		</div>
	</xsl:template>
	
<!-- 
	 *********************************************
	 ***   			   DO NOT USE 				**
	 ***   			ONLY FOR MR NODE 	 		**
	 ***   				FOR KPI 				**
	 ***   			WILL BE REMOVE SOON 		**
	 *********************************************
-->

	<xsl:template name="KPI_Toolbar"> 					<!-- Template For KPI Version 2 (without EXPLORER Page) -->
		<xsl:param name="tDebug" select="'YES'"/> 				<!-- Do Not Use - Depreacated -->
		<xsl:param name="tEXPLORE" select="'EXPLORE_UNK'"/> 	
		<xsl:param name="tKPI" select="'KPI_UNK'"/>
		<xsl:param name="tVKEYD" select="'VKEYD_UNK'"/>
		<xsl:param name="tLanguage" select="$vLANG"/>
		
		<!-- BootStrap Navigation Block -->
		<center>
			<div style="width:98%">
				<nav role="navigation" class="navbar-BRMRN-KPI">
					<div class="container-fluid">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
						</div>

						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse">
							<xsl:attribute name="id">D_KPI<xsl:value-of select='$vKPI'/>_<xsl:value-of select='$tVKEYD'/></xsl:attribute>
							<ul class="nav navbar-nav">
								<li class="active">
									<a href="#!">
										<xsl:attribute name="onclick">if(KPIDETREP<xsl:value-of select='$tKPI'/>_<xsl:value-of select='$tVKEYD'/>.style.display=='none'){$('#KPIDETREP<xsl:value-of select='$tKPI'/>_<xsl:value-of select='$tVKEYD'/>').slideDown('1000');$("#SKPIDETREP<xsl:value-of select='$tKPI'/>_<xsl:value-of select='$tVKEYD'/>").attr('class', 'glyphicon glyphicon-triangle-top');} else {$('#KPIDETREP<xsl:value-of select='$tKPI'/>_<xsl:value-of select='$tVKEYD'/>').slideUp('1000');$("#SKPIDETREP<xsl:value-of select='$tKPI'/>_<xsl:value-of select='$tVKEYD'/>").attr('class', 'glyphicon glyphicon-triangle-bottom');}</xsl:attribute>
										<span id="SKPIDETREP{$tKPI}_{$tVKEYD}" class="glyphicon glyphicon-triangle-top" aria-hidden="true"></span>
									</a>
								</li>
							</ul>
							<p class="navbar-text">
								<b>
								<xsl:choose>
									<xsl:when test="$vLANG = 'NL'">
										<xsl:value-of select="//dbquery[@id='KPI']/rows/row[1]/@kpid_denom_nl"/> (KPI<xsl:value-of select="$tKPI"/>) voor <xsl:value-of select="$vVKEYD"/>
									</xsl:when>
									<xsl:when test="$vLANG = 'FR'">
										<xsl:value-of select="//dbquery[@id='KPI']/rows/row[1]/@kpid_denom_fr"/> (KPI<xsl:value-of select="$tKPI"/>) pour <xsl:value-of select="$vVKEYD"/>
									</xsl:when>
									<xsl:when test="$vLANG = 'EN'">
										<xsl:value-of select="//dbquery[@id='KPI']/rows/row[1]/@kpid_denom_en"/> (KPI<xsl:value-of select="$tKPI"/>) for <xsl:value-of select="$vVKEYD"/>
									</xsl:when>
									<xsl:otherwise>
										Unknown Language Code :<em><xsl:value-of select="$vLANG"/></em>
									</xsl:otherwise>
								</xsl:choose>
								</b>
							</p> 
							<p class="navbar-text">
								<!-- Id des Blocs de decryptage des DBWEB lié à un Drill-Down -->
								<xsl:variable name="UQDDD_BL">D_UQDDD_<xsl:value-of select="$tVKEYD"/>_<xsl:value-of select="$tKPI"/></xsl:variable>
								<!-- Id des Blocs de decryptage des DBWEB -->
								<xsl:variable name="UQD_BL">D_UQD_<xsl:value-of select="$tVKEYD"/>_<xsl:value-of select="$tKPI"/></xsl:variable>		
								<!-- Id des Blocs de decryptage du DD ILIAS -->
								<xsl:variable name="UDDD_BL">D_UDDD_<xsl:value-of select="$tVKEYD"/>_<xsl:value-of select="$tKPI"/></xsl:variable>
								<xsl:choose>
									<xsl:when test="$vLANG = 'NL'">
										<span style="cursor:pointer" onclick="$('#{$UQD_BL}').show();$('#{$UQDDD_BL}').show();$('#{$UDDD_BL}').show();" >(Show</span>/<span style="cursor:pointer" onclick="$('#{$UQD_BL}').hide();$('#{$UQDDD_BL}').hide();$('#{$UDDD_BL}').hide();">Hide</span> Queries)
									</xsl:when>
									<xsl:when test="$vLANG = 'FR'">
										<span style="cursor:pointer" onclick="$('#{$UQD_BL}').show();$('#{$UQDDD_BL}').show();$('#{$UDDD_BL}').show();" >(Montrer</span>/<span style="cursor:pointer" onclick="$('#{$UQD_BL}').hide();$('#{$UQDDD_BL}').hide();$('#{$UDDD_BL}').hide();">Cacher</span> Requêtes)
									</xsl:when>
									<xsl:when test="$vLANG = 'EN'">
										<span style="cursor:pointer" onclick="$('#{$UQD_BL}').show();$('#{$UQDDD_BL}').show();$('#{$UDDD_BL}').show();" >(Show</span>/<span style="cursor:pointer" onclick="$('#{$UQD_BL}').hide();$('#{$UQDDD_BL}').hide();$('#{$UDDD_BL}').hide();">Hide</span> Queries)
									</xsl:when>
									<xsl:otherwise>
										Unknown Language Code :<em><xsl:value-of select="$vLANG"/></em>
									</xsl:otherwise>
								</xsl:choose>
							</p>
							<xsl:variable name="PRID4KPI"><xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@dbn_rep_id"/></xsl:variable>
				            <ul class="nav navbar-nav navbar-right">
								<p class="navbar-text">
									<!-- Start KPI Report Summary Flags -->
									<!-- If OK : Green -->
									<xsl:variable name="DOK"><xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@Extr_Status"/></xsl:variable>
									<!-- If 0 : Green -->
									<xsl:variable name="EOK"><xsl:value-of select="count(//dbquery/error)"/></xsl:variable>
									<!-- Call template for flag generation -->
									<xsl:call-template name="Accuracy_Indic">
										<xsl:with-param name="tType" select="'KPI'"/>
										<xsl:with-param name="tDOK" select="$DOK"/>
										<xsl:with-param name="tEOK" select="$EOK"/>
										<xsl:with-param name="tLanguage" select="$tLanguage"/>	
									</xsl:call-template>
								</p> 
								<li class="dropdown">
						          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Help <span class="caret"></span></a>
						          <ul class="dropdown-menu">
						            <li>
						            	<a href="http://icp.idcn.mil.intra/bedef{lower-case($vLANG)}/index.php/Report_KPI{$tKPI}" target="_blank" role="button">
											Wiki Documentation
										</a> 
									</li>
						            <li>
						            	<a href="#" data-toggle="modal" data-target="#Modal_KPI_{$tKPI}_{$tVKEYD}" role="button">
											KPI Info
										</a> 
									</li>
									<!-- Not Used ... For Future if needed 
						            <li>
						            	<a href="#" data-toggle="modal" data-target="#CPN_BReport_Infos_KPIDETREP{$tKPI}_{$tVKEYD}" role="button">
											Bloc Infos
										</a> 
									</li>
						            <li role="separator" class="divider"></li>
						            <li><a href="#" data-toggle="modal" data-target="#CPN_BReport_Toolbox_KPIDETREP{$tKPI}_{$tVKEYD}" role="button"><span class="glyphicon glyphicon-briefcase" aria-hidden="true"></span> ToolBox </a></li>
						        	-->
						          </ul>
						        </li>
						        <!-- Explore KPI Hyperlink -->
						        <xsl:if test="$vEXPLORE='NO'">
						        	<p class="navbar-text">
										<b><a href="IL_MR_KPI{$vKPI}.xml?pRID={$PRID4KPI}&amp;pVKEYD={$vVKEYD}&amp;pKPI={$vKPI}&amp;pLANG={$tLanguage}&amp;pHIST=YES&amp;pEXPLORE=YES" target="_blank" role="button"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> Explore</a></b>
									</p>
								</xsl:if>
						      </ul>
						</div><!-- /.navbar-collapse -->
					</div><!-- /.container-fluid -->
				</nav>
			</div>
		</center>
		<!-- Modal HTML Generic -->
	    <div id="Modal_{$tKPI}_{$tVKEYD}" class="modal fade">
	        <div class="modal-dialog modal-lg">
	            <div class="modal-content">
	            	<!-- Loading Url -->
	            </div>
	        </div>
	    </div>
	    <!-- Modal HTML KPI -->
	    <div id="Modal_KPI_{$tKPI}_{$tVKEYD}" class="modal fade">
	        <div class="modal-dialog modal-lg">
            	<!-- Modal content-->
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="close" data-dismiss="modal">X</button>
	                    <h4 class="modal-title">KPI Information : '<xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_code"/> - 
									<xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_denom_en"/>'</h4>
	                </div>
	                <div class="modal-body">
	                    <div class="row">
	                        <div class="col-md-12">
	                            <p style="font-style:italic">This page summarize all <b>General</b> information about this Report. More info on <a href="http://mrnode.mil.intra/LRF/XMLWeb/ProcessDescriptor/descriptor/KPI/IL_MR_KPI/IL_MR_KPI_LIST.xml?pIDKPI={//dbquery[@id='KPI']/rows/row/@kpid_id}&amp;pLANG={$vLANG}&amp;pMODE=Drill-Down2" target="_blank">MR Node</a></p>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-5">
	                            <h4>General Data</h4>
	                            <p><b>Description : </b> <xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_code"/> - 
									<xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_denom_en"/></p>
	                            <ul>
	                                <li>
	                                	<b>Code : </b><xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_desc_en"/>
	                                </li>
	                                <li>
	                                	<b>Status : </b><xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_status"/>
	                                </li>
	                                <li>
	                                	<b>POC : </b>
	                                	<ul>
	                                		<li><xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_poc_name"/></li>
	                                		<li>Tel : <xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_poc_tel"/> </li>
	                                		<li>Email : <xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_poc_email"/></li>
	                                	</ul>
	                                </li>
	                                <li>...</li>
	                            </ul>
	                        </div>
	                        <div class="col-md-7">
	                            <h4>SQL Calculation</h4> 	
	                            	<p>
		                                <xsl:value-of select="//dbquery[@id='KPI']/rows/row/@kpid_sql"/>
	                                </p>
	                            <hr/>
                            	<h4>Accuracy</h4> 	
                            	<p>
	                                This Report has build using 
                                	<b><xsl:value-of select="//dbquery[@id='Report_Info']/rows/row/@Views_Used"/> View(s) or Table(s)</b> (Moves mouse cursor on Report Menu Acc Flag to visualize detailed information)
                                </p>
                                <hr/>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-md-12">
	                            <p style="font-style:italic">This report has been build with <b>Report CPN (Common Pilar Node Framework)</b></p>
	                        </div>
	                    </div>
	                    
	                </div>
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                </div>
	            </div>
           	</div>
	    </div>
	</xsl:template>
	<xsl:template name="Generic_Tab"> 					<!-- Template For Generic Tab -->
		<xsl:param name="tTAB_UnId" select="concat('Tab_Gen_',$vRID)"/> 		<!-- Unique String for Id generation -->
		<xsl:param name="tDD_UnId" select="'DD_KPIDETREP'"/> 					<!-- Unique String for Id generation -->
		<xsl:param name="tRowId" select="'a#b'"/>
		<xsl:param name="tTabNbr" select="2"/>
		<xsl:param name="tSeparator" select="'#'"/>
		<xsl:param name="tTabType" select="concat($vTabDefault,'s')"/> 		<!-- Tabulation type in Bootstrap tabs/pills -->
		<xsl:param name="tWidth" select="10"/> 				<!-- Width For Tab Bloc in Bootstrap 0-12 -->
		<xsl:param name="tOffset" select="1"/> 				<!-- Offset For Tab Bloc in Bootstrap 0-12 -->
		
		<div id="{$tTAB_UnId}">		<!-- This Div allows to Hide the complete Report in KPI Dashboard -->
			<br/>
			<div class="row">
				<!-- Generate Tab Header -->
				<ul class="nav nav-{$tTabType} col-md-{$tWidth} col-md-offset-{$tOffset}">
				  	<xsl:call-template name="Gen_Tab_Header">
			            <xsl:with-param name="tTAB_UnId" select="$tTAB_UnId" />
			            <xsl:with-param name="tLoop" select="$tTabNbr" />
			            <xsl:with-param name="tText" select="$tRowId" />
			            <xsl:with-param name="tSeparator" select="$tSeparator"/>
			        </xsl:call-template>
				</ul>
			</div>
			<!--Generate Content -->
			<div class="tab-content">
				<xsl:call-template name="Gen_Tab_Content">
		            <xsl:with-param name="tTAB_UnId" select="$tTAB_UnId" />
		            <xsl:with-param name="tDD_UnId" select="'DD_KPIDETREP'" />
		            <xsl:with-param name="tLoop" select="$tTabNbr" />
		            <xsl:with-param name="tText" select="$tRowId" />
		            <xsl:with-param name="tSeparator" select="$tSeparator"/>
		        </xsl:call-template>
			</div>
			<!-- Generate Div For Drill-Down -->
			<div class="row col-md-12">
				<!--<div id="DD_{$tTAB_UnId}">DD(DD_<xsl:value-of select="$vKPI"/>_<xsl:value-of select="$vVKEYD"/></div>-->
				<!--div id="{tDD_UnId}"></div-->
				<div id="DD_{$vKPI}_{$vVKEYD}"></div>
			</div>
		</div>
	</xsl:template>	
	<xsl:template name="Gen_Tab_Header"> 				<!-- Template For Generic Tab Header -->
		<xsl:param name="tTAB_UnId" select="'KPIDETREP'"/> 			<!-- Unique String for Id generation -->
		<xsl:param name="tStart" select="1" />
	    <xsl:param name="tLoop" select="1" />
	    <xsl:param name="tText" select="'a'"/>
	    <xsl:param name="tSeparator" select="'#'"/>

	    <xsl:if test="not($tStart = $tLoop+1)">
			
			<xsl:variable name="vTabName">
				<xsl:call-template name="Decode_FDC_MultipleValue"> 	<!-- v2 - Allow Decoding of MultipleValue in 1 Field (SPE and FDC) -->
				    <xsl:with-param name="tText" select="$tText"/>
				    <xsl:with-param name="tDelim" select="$tSeparator" />
					<xsl:with-param name="tPos" select="$tStart"/>
				    <xsl:with-param name="tLength" select="$tLoop"/>
				</xsl:call-template>
			</xsl:variable>
			<li>
				<xsl:if test="$tStart=1">
	  				<xsl:attribute name="class">active</xsl:attribute>
	  			</xsl:if>
		  		<a data-toggle="{$vTabDefault}" href="#TAB_{$tStart}_{$tTAB_UnId}">
		  			<xsl:call-template name="FromDic2Rep">
						<xsl:with-param name="Title2S" select="$vTabName"/>
						<xsl:with-param name="Lang" select="$vLANG"/>
					</xsl:call-template>
		  		</a>
		  	</li>
			<!-- Loop -->
	        <xsl:call-template name="Gen_Tab_Header">
	            <xsl:with-param name="tStart" select="$tStart + 1" />
	            <xsl:with-param name="tLoop" select="$tLoop" />
	            <xsl:with-param name="tText" select="$tText" />
	            <xsl:with-param name="tSeparator" select="$tSeparator"/>
	        </xsl:call-template>
	    </xsl:if>
	</xsl:template>
	<xsl:template name="Gen_Tab_Content"> 				<!-- Template For Generic Tab Content -->
		<xsl:param name="tTAB_UnId" select="'KPIDETREP'"/> 			<!-- Unique String for Id generation -->
		<xsl:param name="tDD_UnId" select="'DD_KPIDETREP'"/> 			<!-- Unique String for Id generation -->
		<xsl:param name="tStart" select="1" />
	    <xsl:param name="tLoop" select="1" />
	    <xsl:param name="tText" select="'a'"/>
	    <xsl:param name="tSeparator" select="'#'"/>

	   	<xsl:if test="not($tStart = $tLoop+1)">
	        
			<xsl:variable name="vRowId">
				<xsl:call-template name="Decode_FDC_MultipleValue"> 	<!-- v2 - Allow Decoding of MultipleValue in 1 Field (SPE and FDC) -->
				    <xsl:with-param name="tText" select="$tText"/>
				    <xsl:with-param name="tDelim" select="$tSeparator" />
					<xsl:with-param name="tPos" select="$tStart"/>
				    <xsl:with-param name="tLength" select="$tLoop"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="$vRowId!='COLLAPSE'">
				<div id="TAB_{$tStart}_{$tTAB_UnId}">
				    <xsl:if test="$tStart=1">
		  				<xsl:attribute name="class">tab-pane fade in active nav nav-tabs col-md-10 col-md-offset-1</xsl:attribute>
		  			</xsl:if>
		  			<xsl:if test="$tStart!=1">
		  				<xsl:attribute name="class">tab-pane fade col-md-10 col-md-offset-1</xsl:attribute>
		  			</xsl:if>
				    <p>
				    	<xsl:call-template name="Generic_Table_DBWEB">
							<xsl:with-param name="DBWEB_Name" select="$vRowId"/>
							<xsl:with-param name="UdTN" select="concat('TAB_',$tStart,'_',$tTAB_UnId,'_Cont')"/>
							<xsl:with-param name="Show_Empty" select="'Y'"/> 
							<xsl:with-param name="Lang" select="$vLANG"/>
							<xsl:with-param name="RepDic" select="'Y'"/> 
							<xsl:with-param name="MaxRecords" select="-1"/>
							<xsl:with-param name="Frame" select="'YO'"/> 
							<xsl:with-param name="TableWidth" select="'100%'"/>
							<xsl:with-param name="Detail_Data" select="$vRowId"/> 
						</xsl:call-template>
		                	
				    </p>
				</div>
			</xsl:if>
			<xsl:if test="$vRowId='COLLAPSE'">
				<div id="TAB_{$tStart}_{$tTAB_UnId}" class="tab-pane fade col-md-10 col-md-offset-1"/>
			</xsl:if>
	        <!-- Loop -->
	        <xsl:call-template name="Gen_Tab_Content">
	            <xsl:with-param name="tStart" select="$tStart + 1" />
	            <xsl:with-param name="tLoop" select="$tLoop" />
	            <xsl:with-param name="tText" select="$tText" />
	            <xsl:with-param name="tSeparator" select="$tSeparator"/>
	        </xsl:call-template>
	    </xsl:if>
	</xsl:template>

</xsl:stylesheet>