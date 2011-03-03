@echo off

rem à surcharger à chaque fois
set LOT_REASS=LotX.Y
set VERSION_COURT=XYZZ

rem Envrionnement par défaut
set TYPE_ENV=Recette
set TYPE_ENV_COURT=REC
set REGIE=UEM

set ENVIR=RECDali2DegasRenoir

rem version ex : X_Y_ZZ
set VERSION_LONG=%VERSION_COURT:~0,1%_%VERSION_COURT:~1,1%_%VERSION_COURT:~2,2%

rem version ex : X.Y.ZZ
set VERSION=%VERSION_COURT:~0,1%.%VERSION_COURT:~1,1%.%VERSION_COURT:~2,2%

rem definitions utilisees par les cmd
set TAG_REASS=LIV_%VERSION_LONG%

rem C2
set LOT_C2=6.0
set TAG_C2=LIV_%VERSION_LONG%
set VERSION_C2=%VERSION%


rem Tablespaces et schémas
set TBLSPACE=LIV_%VERSION_LONG%
set PREFIXE_SCHEMA=%TYPE_ENV_COURT%

rem préfixes des applications
set APPLICATION_PREFIXE=
set PREFIXE_EFLUID=hermes
set PREFIXE_EFLUIDNETSERVER=eFluidNetServer
set PREFIXE_EFLUIDPUB=efluidPub
set PREFIXE_EFLUIDWeb=efluid

set SCRIPTS=scripts
call %SCRIPTS%\commun\setCheminAbsolu.cmd ".\scripts"
set VERSION_HOME=%CHEMIN_ABSOLU%
set XML_HOME=%CHEMIN_ABSOLU%%SCRIPTS%

call .\commun\setEnv.cmd


cls
set CHOICE=
set CHOICELIST=
set TITLE=%TYPE_ENV% %REGIE% v.%VERSION%

title %TITLE%

:menu
if not '%CHOICELIST%'=='' (
 	set CHOICE=%CHOICELIST:~0,3%
	set CHOICELIST=%CHOICELIST:~4,500%
) else (
	set CHOICE=
)

if '%CHOICE%'=='' goto menuderoulant 
if not '%CHOICE%'=='' goto menuchoix

:menuderoulant
echo.
echo     ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo     º %TYPE_ENV% %REGIE% de la version %TAG_REASS%                         º
echo     ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo     º                                                              º 
echo     º                                                              º
echo     º 110. creation des tablespaces MA_BDD                         º 
echo     º 120. drop des tablespaces MA_BDD                             º
echo     º                                                              º
echo     º 130. Aide en ligne efluid                                    º
rem echo     º 131. Aide en ligne eldap                                     º
rem echo     º 132. Aide en ligne ael                                       º
echo     º ------------------------------------------------------------ º
echo     º 2--.TST, 3--.PRO, 4--.LDP, 5--.DEC, 6--.NET, 7--.AEL         º
echo     º                                                              º
echo     º       ------------------------------------------------------- º
echo     º       -20. reAssemblage - all (21+22+23)                      º
echo     º         -21. reAssemblage - application (EAR)                º
echo     º         -22. reAssemblage - batchs                            º
echo     º         -23. reAssemblage - eFluidNetServer                   º
echo     º         -24. reAssemblage - efluid.Pub                        º
echo     º         -26. reAssemblage - batchs Echange                   º
echo     º                                                               º
echo     º       -25. reAssemblage - application Web                     º
echo     º       ------------------------------------------------------- º
echo     º       -30. copie - all (31+32)                                º
echo     º         -31. copie - efluid (EAR,eFluidNetServer,eFluid.Pub)  º
echo     º         -32. copie - WAR                                      º
echo     º         -33. copie - Batchs                                   º
echo     º         -34. copie - Batchs Echanges                         º
echo     º       ------------------------------------------------------- º
echo     º       -40. weblogic - all                                     º
echo     º         -41. weblogic - delete Application (EAR ou WAR)       º
echo     º         -42. weblogic - delete eFluidNetServer                º
echo     º       -43. weblogic - delete eFluid.Pub                       º
echo     º       -44. weblogic - delete JDBC                             º
echo     º                                                               º
echo     º       -45. weblogic - configure JDBC                          º
echo     º       -46. weblogic - deploy Application (EAR)                º
echo     º       -47. weblogic - deploy Application Web (WAR)            º
echo     º       -48. weblogic - deploy eFluidNetServer                  º
echo     º       -49. weblogic - deploy eFluid.Pub                       º
echo     º       ------------------------------------------------------- º
echo     º       -50. oracle - (51+53+54...59)                           º
echo     º         -51. oracle - schema                                  º
echo     º         -52. oracle - migration                               º
echo     º         -53. oracle - structure                               º
echo     º       -54. oracle - JE                                        º
echo     º       -55. oracle - patchs                                    º
echo     º       -56. oracle - visu                                      º
echo     º       -57. oracle - maj confidentialite                       º
echo     º       -58. oracle - stats                                     º
echo     º       -59. oracle - index                                     º
echo     º       ------------------------------------------------------- º
echo     º       -61. tests - application                                º
echo     º       -62. tests - eFluidNetServer                            º
echo     º       -63. tests - eFluidPub                                  º
echo     º       -64. tests - AEL                                        º
echo     º       -65. tests - eFluidNet                                  º
echo     º       ------------------------------------------------------- º
echo     º       -71. menage - weblogic n-1                              º
echo     º       -72. menage - drop user et visu                         º
echo     º       -73. menage - drop role visu                            º
echo     º       ------------------------------------------------------- º
echo     º       -80. migration - all                                    º
echo     º       -81. migration - reAssemblage Transformateurs           º
echo     º       -82. migration - reAssemblage Injecteurs                º
echo     º       -83. migration - reAssemblage Complements injecteurs    º
echo     º       -84. migration - reAssemblage Extracteurs               º
echo     º       -85. migration - copie                                  º
echo     º       ------------------------------------------------------- º
echo     º                                                               º
echo     º 150. StreamServe - reAssemblage                               º
echo     º 151. StreamServe - copie                                      º
echo     º                                                               º
echo     º 160. Decisionnel - lancement de la console                    º
echo     º                                                               º
echo     º 180. C2                                                       º
echo     º 181. MAJTVersion                                              º
echo     º                                                               º
echo     º 190. Commit                                                   º
echo     º                                                               º
echo     º Programmation possible (ex : prg+221+222+223)                 º
echo     º Multi-selection possible (ex : 221+222+223)                   º
echo     º                                                               º
echo     º 0. Quitter                                                    º
echo     ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
set CHOICE=
set /p CHOICE=Selectionnez l'etape souhaitee : 
set CHOICELIST=
set TRAITE=false
set SELECTED_TIME=


:menuchoix
rem ******************************************** Début
set EXIT=1
if '%CHOICE%'=='' goto menu
set ENV_CODE=%CHOICE:~0,1%
set ACT_CODE=%CHOICE:~1,2%

rem ******************************************** logs de la console
echo %DATE%-%TIME% - Action %CHOICE% >> %VERSION_HOME%\actions%TYPE_ENV%%VERSION_COURT%.log
rem ******************************************** Multi-sélection
if '%CHOICE:~3,1%'=='+' (
	set CHOICELIST=%CHOICE%
	goto menu
)
if not '%CHOICE:~3,1%'=='' goto exit
rem ******************************************** Programmation
if '%CHOICE%'=='prg' goto time
rem ******************************************** Environnements .Sites et Servers
if '%ENV_CODE%'=='2' set ENV=TST
if '%ENV_CODE%'=='3' set ENV=PRO
if '%ENV_CODE%'=='4' set ENV=LDP
if '%ENV_CODE%'=='5' set ENV=MCU
if '%ENV_CODE%'=='6' set ENV=DEC
if '%ENV_CODE%'=='7' set ENV=NET
if '%ENV_CODE%'=='8' set ENV=PUB

rem ICI spécialisation de ENVIR/SITE si besoin
rem exemple :
rem if '%ENV_CODE%'=='7' set ENVIR=RECMiroDegasRenoir
if '%ENV_CODE%'=='7' set PREFIXE_EFLUID=efluid
if '%ENV_CODE%'=='7' set APPLICATION_PREFIXE=efluid
rem if '%ENV_CODE%'=='8' set ENVIR=RECMiroDegasRenoir
if '%ENV_CODE%'=='8' set PREFIXE_EFLUID=efluid
if '%ENV_CODE%'=='8' set APPLICATION_PREFIXE=efluid

rem Configuration JDBC
set PREFIXE_JDBC=%ENV%
set SCHEMA=%PREFIXE_SCHEMA%_%ENV%_%VERSION_LONG%

rem mise à jour des variables d'environnement spécifique à chaque ENV
call .\commun\setEnv_%ENVIR%.cmd



rem ******************************************** Actions génériques
if '%CHOICE%'=='110' set SERVER_BDD=MA_BDD
if '%CHOICE%'=='110' goto tblspce
if '%CHOICE%'=='120' set SERVER_BDD=MA_BDD
if '%CHOICE%'=='120' goto dropTBS
if '%CHOICE%'=='130' goto helpefluid
if '%CHOICE%'=='131' goto helpeldap
if '%CHOICE%'=='132' goto helpael
if '%CHOICE%'=='150' goto streamserve
if '%CHOICE%'=='151' goto copieStreamServe
if '%CHOICE%'=='160' goto decisionnel
if '%CHOICE%'=='170' goto phpldapadmin
if '%CHOICE%'=='180' goto c2
if '%CHOICE%'=='181' goto MAJTVersion
if '%CHOICE%'=='190' goto commit
rem ******************************************** Cas spécifiques
rem if '%CHOICE%'=='354' goto migrationProd
rem if '%CHOICE%'=='355' goto jeProd
rem if '%CHOICE%'=='554' goto migrationProd
rem if '%CHOICE%'=='555' goto jeProd
rem ******************************************** Actions sur environnements
rem ******************************************** Actions sur environnements
if '%ACT_CODE%'=='20' set CHOICELIST=%ENV_CODE%21+%ENV_CODE%22+%ENV_CODE%23
if '%ACT_CODE%'=='21' goto applicationsJ2EE
if '%ACT_CODE%'=='22' goto batchs
if '%ACT_CODE%'=='23' goto efluidnetserver
if '%ACT_CODE%'=='24' goto efluidPub
if '%ACT_CODE%'=='25' goto applicationWeb
if '%ACT_CODE%'=='26' goto batchsEchange
if '%ACT_CODE%'=='30' set CHOICELIST=%ENV_CODE%31+%ENV_CODE%32
if '%ACT_CODE%'=='31' goto copieEAR
if '%ACT_CODE%'=='32' goto copieWAR
if '%ACT_CODE%'=='33' goto copieBatchs
if '%ACT_CODE%'=='34' goto copieBatchsEchange
if '%ACT_CODE%'=='40' set CHOICELIST=%ENV_CODE%41+%ENV_CODE%42+%ENV_CODE%43+%ENV_CODE%44+%ENV_CODE%45
if '%ACT_CODE%'=='41' goto undeployAppli
if '%ACT_CODE%'=='42' goto undeployNetServer
if '%ACT_CODE%'=='43' goto undeployPub
if '%ACT_CODE%'=='44' goto deleteJDBC
if '%ACT_CODE%'=='45' goto configureJDBC
if '%ACT_CODE%'=='46' goto deployAppli
if '%ACT_CODE%'=='47' goto deployAppliWeb
if '%ACT_CODE%'=='48' goto deployEFluidNetServer
if '%ACT_CODE%'=='49' goto deployEFluidPub
if '%ACT_CODE%'=='50' set CHOICELIST=%ENV_CODE%51+%ENV_CODE%53+%ENV_CODE%54+%ENV_CODE%55+%ENV_CODE%56+%ENV_CODE%57+%ENV_CODE%58+%ENV_CODE%59
if '%ACT_CODE%'=='51' goto schema
if '%ACT_CODE%'=='52' goto migration
if '%ACT_CODE%'=='53' goto structure
if '%ACT_CODE%'=='54' goto je
if '%ACT_CODE%'=='55' goto patch
if '%ACT_CODE%'=='56' goto visu
if '%ACT_CODE%'=='57' goto majconfidentialite
if '%ACT_CODE%'=='58' goto stats
if '%ACT_CODE%'=='59' goto index
if '%ACT_CODE%'=='61' goto testAppli
if '%ACT_CODE%'=='62' goto testNetServer
if '%ACT_CODE%'=='63' goto testPub
if '%ACT_CODE%'=='64' goto testAel
if '%ACT_CODE%'=='65' goto testNet
if '%ACT_CODE%'=='71' goto weblogicOld
if '%ACT_CODE%'=='72' goto dropUsers
if '%ACT_CODE%'=='73' goto dropRoles
if '%ACT_CODE%'=='80' set CHOICELIST=%ENV_CODE%81+%ENV_CODE%82+%ENV_CODE%83+%ENV_CODE%84+%ENV_CODE%85
if '%ACT_CODE%'=='81' goto transformateurs
if '%ACT_CODE%'=='82' goto injecteurs
if '%ACT_CODE%'=='83' goto complementsInjecteurs
if '%ACT_CODE%'=='84' goto extracteurs
if '%ACT_CODE%'=='85' goto copieMigration
rem ******************************************** Navigation
if not '%CHOICELIST%'=='' goto menu
if '%CHOICE%'=='0' goto end
if '%EXIT%'=='1' goto exit
rem ******************************************** Fin


:confirm
rem demande à l'utilisateur de confirmer sa demande
echo.
set CONFIRM=
set /p CONFIRM=Merci de confirmer votre demande ('y' pour confirmer) ? : 
if '%CONFIRM%'=='y' (
	if '%CHOICE%'=='120' goto dropTBS
	if '%CHOICE%'=='121' goto dropTBS
	if '%CHOICE%'=='122' goto dropTBS
	if '%ACT_CODE%'=='72' goto dropUsers
	if '%ACT_CODE%'=='73' goto dropRoles
) else (
	echo. =^> la demande n'a pas ete confirmee !
	goto menu
)


:time
if '%SELECTED_TIME%'=='' (
	set /p SELECTED_TIME=Saisir l'heure de lancement ^(hh24^:mi^) : 
)
if '%SELECTED_TIME%'=='' (
	if '%TRAITE%'=='false' (
		echo      !!! Attention : vous devez saisir une heure !!!
		goto time
	)
)
if not '%SELECTED_TIME:~2,1%' == ':' (
	echo      !!! Attention : le format de la date doit etre ^(hh24^:mi^) !!!
	set SELECTED_TIME=
	goto time
)
rem if '%SELECTED_TIME:~0,2%%SELECTED_TIME:~3,2%' LSS '%TIME:~0,2%%TIME:~3,2%' (
rem 	echo      !!! Attention : l'heure choisie doit etre superieure a l'heure actuelle !!!
rem 	set SELECTED_TIME=
rem 	goto time
rem )
if not '%TIME:~0,5%'=='%SELECTED_TIME%' (
	sleep 15
	goto time
)
if '%TIME:~0,5%'=='%SELECTED_TIME%' (
	set TRAITE=true
	goto menu
)



:exit
rem l'étape sélectionnée ne correspond pas à une étape valide de la console
echo.
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Etape non valide !        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo   ==^> Merci de choisir une etape du menu !!
echo.
goto menu


:tblspce
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ tblspce %TYPE_ENV_COURT% %SERVER_BDD%  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call creerTablespaceParamFichier.cmd %LOT_REASS% %TBLSPACE% tablespace_%TYPE_ENV_COURT%_%SERVER_BDD%.properties
cd ..\..
goto menu




:dropTBS
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ dropTBS %TYPE_ENV_COURT% %SERVER_BDD% ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
if not '%CONFIRM%'=='y' goto confirm
set CONFIRM=n
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call creerTablespaceParamFichier.cmd %LOT_REASS% %TBLSPACE% dropTablespace_%TYPE_ENV_COURT%_%SERVER_BDD%.properties
cd ..\..
goto menu


:helpefluid
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Aide en ligne efluid³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\commun\DeploiementZip.xml -Ddest.dir=%DEPLOYHELP_HOME%\\efluid%VERSION_COURT%\\help -Dfile=hermesJ2EEHelp -Dcvs.lot=%LOT_REASS% -Dcvs.tag=%TAG_REASS% -Dcvs.context=j2ee\application\hermesJ2EE -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -Dproperty.file=help_efluid.properties -Dproperty.file.dir=cmd\parametres
cd ..\..
goto menu

:helpeldap
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Aide en ligne eldap³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\commun\DeploiementZip.xml -Ddest.dir=%DEPLOYHELP_HOME%\\eldap%VERSION_COURT%\\help -Dfile=hermesLdapJ2EEHelp -Dcvs.lot=%LOT_REASS% -Dcvs.tag=%TAG_REASS% -Dcvs.context=j2ee\application\hermesLdapJ2EE -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -Dproperty.file=help_eldap.properties -Dproperty.file.dir=cmd\parametres
cd ..\..
goto menu

:helpael
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Aide en ligne ael³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\commun\DeploiementZip.xml -Ddest.dir=%DEPLOYHELP_HOME%\\ael%VERSION_COURT%\\help -Dfile=aelHelp  -Dcvs.lot=%LOT_REASS% -Dcvs.tag=%TAG_REASS% -Dcvs.context=j2ee\application\ael -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -Dcvs.server=hermescvs -Dproperty.file=help_ael.properties -Dproperty.file.dir=cmd\parametres
cd ..\..
goto menu


:applicationsJ2EE
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Application %ENV%     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageAppliParamFichierJ2EE.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% %PREFIXE_EFLUID%%ENV%.properties
cd ..\..
goto menu


:batchs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs %ENV%        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageBatchParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% batch%ENV%.properties
cd ..\..
goto menu

:batchsEchange
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs Echange %ENV%      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageBatchEchangeParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%Echange%ENV%%VERSION_COURT% batchEchange%ENV%.properties
cd ..\..
goto menu


:efluidnetserver
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ eFluidNetServer %ENV%    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageEfluidNetServerParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUIDNETSERVER%%ENV%%VERSION_COURT% %PREFIXE_EFLUIDNETSERVER%%ENV%.properties
cd ..\..
goto menu

:efluidpub
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ efluidPub %ENV%        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageAppliWebParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUIDPUB%%ENV%%VERSION_COURT% %PREFIXE_EFLUIDPUB%%ENV%.properties
cd ..\..
goto menu


:applicationWeb
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Application Web     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
rem demande à l'utilisateur l'environnement pour réassembler les applications Web efluidNet et efluidAel
rem (on fait peu de contrôle : troncature 3 caractères à gauche)
rem set SUFFIXE_Web=
rem ajouter les autres environnements ICI (par ex. INT, MIG, etc.)
rem set /p SUFFIXE_Web=Selectionnez l'environnement souhaite parmi TST PRO : 
rem set SUFFIXE_Web=%SUFFIXE_Web:~0,3%
rem echo Environnement choisi : %suffixe_web%
rem echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
rem call reAssemblageAppliWebParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUIDWeb%%SUFFIXE_Web%%VERSION_COURT% %PREFIXE_EFLUIDWeb%%SUFFIXE_Web%.properties
call reAssemblageAppliWebParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUIDWeb%%ENV%%VERSION_COURT% %PREFIXE_EFLUIDWeb%%ENV%.properties
cd ..\..
goto menu


:copieEAR
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Copier les Applications efluid et eFluidNetServer %ENV%     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call copieApplications.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUID%%ENV%%VERSION_COURT%
call copieApplications.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUIDNETSERVER%%ENV%%VERSION_COURT%
call copieApplicationWeb.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUIDPUB%%ENV%%VERSION_COURT%
cd ..\..
goto menu


:copieWAR
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Copier l'application Web %ENV%     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
rem demande à l'utilisateur l'environnement pour réassembler les applications Web efluidNet et efluidAel
rem (on fait peu de contrôle : troncature 3 caractères à gauche)
rem set SUFFIXE_Web=
rem ajouter les autres environnements ICI (par ex. INT, MIG, etc.)
rem set /p SUFFIXE_Web=Selectionnez l'environnement souhaite parmi TST PRO : 
rem set SUFFIXE_Web=%SUFFIXE_Web:~0,3%
rem echo Environnement choisi : %suffixe_web%
rem echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
rem call copieApplicationWeb.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUIDWeb%%SUFFIXE_Web%%VERSION_COURT%
call copieApplicationWeb.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUIDWeb%%ENV%%VERSION_COURT%
cd ..\..
goto menu


:copieBatchs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Copier les batchs      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd commun
call setExecDir.cmd
call copieArchives.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUID% %ENV% %VERSION_COURT%
cd ..
goto menu

:copieBatchsEchange
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Copier les batchs Echange   ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd commun
call setExecDir.cmd
set DEPLOYBATCH_HOME=\\%SERVER_BATCH%\batchsefluidEchange\%REGIE%
call copieArchives.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUID%Echange %ENV% %VERSION_COURT%
cd ..
goto menu

:weblogicOld
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ weblogic Old      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\deleteJDBC.cmd %PREFIXE_JDBC%6005 %ENVIR%
call %XML_HOME%\weblogic\undeploy.cmd %PREFIXE_EFLUID%%ENV%6005 %SERVER_NAME% 
call %XML_HOME%\weblogic\undeploy.cmd %PREFIXE_EFLUIDNETSERVER%%ENV%6005 %SERVER_NAME% 
call %XML_HOME%\weblogic\undeploy.cmd %PREFIXE_EFLUIDPUB%%ENV%6005 %SERVER_NAME% 
cd ..\..
goto menu

:undeployAppli
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ undeployAppli %ENV%     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\undeploy.cmd %PREFIXE_EFLUID%%ENV%%VERSION_COURT% %SERVER_NAME% 
cd ..\..
goto menu

:undeployNetServer
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ undeployNetServer %ENV%  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\undeploy.cmd %PREFIXE_EFLUIDNETSERVER%%ENV%%VERSION_COURT% %SERVER_NAME% 
cd ..\..
goto menu

:undeployPub
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ undeployPub %ENV%       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\undeploy.cmd %PREFIXE_EFLUIDPUB%%ENV%%VERSION_COURT% %SERVER_NAME% 
cd ..\..
goto menu

:deleteJDBC
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ deleteJDBC %ENV%      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\supprimerJDBC.cmd %PREFIXE_JDBC%%VERSION_COURT% %ENVIR%
cd ..\..
goto menu

:configureJDBC
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ configureJDBC %ENV%      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\creerJDBC.cmd %PREFIXE_JDBC%%VERSION_COURT% %SCHEMA% %SERVER_NAME% %ENVIR%
cd ..\..
goto menu

:deployAppli
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ deployAppli %ENV%      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\deploy.cmd %PREFIXE_EFLUID%%ENV%%VERSION_COURT% ear %SERVER_NAME% 
cd ..\..
goto menu

:deployAppliWeb
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ deployAppliWeb %ENV%       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\deploy.cmd %PREFIXE_EFLUID%%ENV%%VERSION_COURT% war %SERVER_NAME% 
cd ..\..
goto menu

:deployEFluidNetServer
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ deployEFluidNetServer %ENV%      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\deploy.cmd %PREFIXE_EFLUIDNETSERVER%%ENV%%VERSION_COURT% ear %SERVER_NAME% 
cd ..\..
goto menu

:deployEfluidPub
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ deployEfluidPub %ENV%       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\deploy.cmd %PREFIXE_EFLUIDPUB%%ENV%%VERSION_COURT% war %SERVER_NAME% 
cd ..\..
goto menu


:schema
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ schema %SERVER_BDD% %ENV%    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call creerUserParamFichier.cmd %LOT_REASS% %TBLSPACE% user_%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu


:export
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ export %SERVER_BDD% %ENV% ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call exporterSchemaParamFichier.cmd %LOT_REASS% %TAG_REASS% exportSchema_%ENV%_%SERVER_BDD%.properties
grep -r -H -i erreur ..\tmpEXP\*
cd ..\..
goto menu


:import
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ import %SERVER_BDD% %ENV%    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call importerDMPParamFichier.cmd %LOT_REASS% %TAG_REASS% importDMP_%ENV%_%SERVER_BDD%.properties
grep -r -H -i erreur ..\tmpDMP\*
cd ..\..
goto menu


:migration
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ migration %SERVER_BDD% %ENV%  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call reassemblageListePatchSQLParamFichier.cmd %LOT_REASS% %TAG_REASS% %TBLSPACE% reassemblerListePatchSQL_migration_n-1_n_%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu


:je
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ je %SERVER_BDD% %ENV%      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageJEParametrageParamFichier.cmd %LOT_REASS% %TAG_REASS% JEParam_%ENV%_%SERVER_BDD%.properties
grep -r -H -i erreur ..\tmpJEParam\*
cd ..\..
goto menu


:patch
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ patch %SERVER_BDD% %ENV%      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call reassemblageListePatchSQLParamFichier.cmd %LOT_REASS% %TAG_REASS% %TBLSPACE% reassemblerListePatchSQL_patch%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu

:majconfidentialite
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ majConf %ENV%     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd scripts\oracle
echo Log consigne dans ..\scripts\oracle\modificationConfidentialite_%ENV%.log
%SystemRoot%\system32\attrib.exe -r modificationConfidentialite_%ENV%.log
%SystemRoot%\system32\attrib.exe -r UpdateConfidentialite.sql
call modificationConfidentialite.cmd %SCHEMA% UEM %REGIE% %ORACLE_SID% > modificationConfidentialite_%ENV%.log
cd ..\..
goto menu

:index
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ index %SERVER_BDD% %ENV%       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageRebuildIndexParamFichier.cmd %LOT_REASS% %TAG_REASS% rebuildIndex_%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu

:stats
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ stats %SERVER_BDD% %ENV%     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call calculerStats.cmd %SCHEMA% %TAG_REASS%
cd ..\..
goto menu


:structure
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ struct %SERVER_BDD% %ENV%    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageStructureSchemaParamFichier.cmd %LOT_REASS% %TAG_REASS% reassemblerStructure_%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu


:visu
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ visu %SERVER_BDD% %ENV%     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call creerUserVisu.cmd %SCHEMA% %TBLSPACE%_DATA
cd ..\..
goto menu


:testAppli
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Test Application %ENV%        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
call IEXPLORE http://%ALIAS_DNS%/%PREFIXE_EFLUID%%ENV%%VERSION_COURT%/jsp/arc/commun/index.jsp
goto menu


:testNetServer
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Test eFluidNetServer %ENV%         ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
call IEXPLORE "http://%ALIAS_DNS%/%PREFIXE_EFLUIDNETSERVER%%ENV%%VERSION_COURT%/VerifInstallation?user=B-G-%REGIE%&mdp=B-G-%REGIE%"
goto menu


:testPub
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Test EfluidPub %ENV%        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
call IEXPLORE "http://%ALIAS_DNS%/%PREFIXE_EFLUIDPUB%%ENV%%VERSION_COURT%/VerifInstallation?user=B-G-%REGIE%&mdp=B-G-%REGIE%"
goto menu


:testAel
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Test EfluidAEL              ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
call IEXPLORE "http://ragenceenligne.uem.lan/%PREFIXE_EFLUIDWeb%%ENV%%VERSION_COURT%/jsp/arc/habilitation/login.jsp"
goto menu


:testNet
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Test EfluidNET              ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
call IEXPLORE "http://refluidnet.uem.lan/%PREFIXE_EFLUIDWeb%%ENV%%VERSION_COURT%"
goto menu


:dropUsers
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ drop User Oracle %ENV% + user visu      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
echo. 
if not '%CONFIRM%'=='y' goto confirm
set CONFIRM=n
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call creerUserParamFichier.cmd %LOT_REASS% %TBLSPACE% dropUser_%ENV%_%SERVER_BDD%.properties
call creerUserParamFichier.cmd %LOT_REASS% %TBLSPACE% dropUser_%ENV%_Visu_%SERVER_BDD%.properties
cd ..\..
goto menu

:dropRoles
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ drop Role visu %ENV%               ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
echo. 
if not '%CONFIRM%'=='y' goto confirm
set CONFIRM=n
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call dropRoleVisuParamFichier.cmd %LOT_REASS% %TBLSPACE% dropRoleVisu_%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu


:streamserve
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ StreamServe            ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd streamserve\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageStreamServeParamFichier.cmd %LOT_REASS% %TAG_REASS% streamserve.properties
cd ..\..
goto menu


:copieStreamServe
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Copier StreamServe       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd commun
call setExecDir.cmd
call copieArchives.cmd %ENVIR% %TYPE_ENV_COURT% StreamServe "" %VERSION_COURT%
cd ..
goto menu

:transformateurs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Transformateurs %ENV%    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd migration\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageTransformateursParamFichier.cmd %LOT_REASS% %TAG_REASS% TCBT%ENV%%VERSION_COURT% transformateursTCBT.properties
call reAssemblageTransformateursParamFichier.cmd %LOT_REASS% %TAG_REASS% FonctionClient%ENV%%VERSION_COURT% transformateursFonctionClient.properties
cd ..\..
goto menu

:injecteurs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Injecteurs %ENV%  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageInjecteursParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% injecteurs.properties
cd ..\..
goto menu

:complementsInjecteurs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Complements Injecteurs %ENV%    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd migration\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageComplementsInjecteursParamFichier.cmd %LOT_REASS% %TAG_REASS% TCBT%ENV%%VERSION_COURT% injecteursTCBT.properties
call reAssemblageComplementsInjecteursParamFichier.cmd %LOT_REASS% %TAG_REASS% FonctionClient%ENV%%VERSION_COURT% injecteursFonctionClient.properties
cd ..\..
goto menu

:extracteurs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Extracteurs %ENV% ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageExtracteursParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% extracteurs.properties
cd ..\..
goto menu

:copieMigration
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Copier les transformateurs, injecteurs et complements %ENV%    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd migration\cmd
call ..\..\commun\setExecDir.cmd
echo * Copier les transformateurs TCBT *
call copieMigration.cmd %ENVIR% %TYPE_ENV_COURT% transformateurs TCBT %ENV% %VERSION_COURT%
echo. 
echo * Copier les transformateurs FonctionClient *
call copieMigration.cmd %ENVIR% %TYPE_ENV_COURT% transformateurs FonctionClient %ENV% %VERSION_COURT%
echo. 
echo * Copier les injecteurs *
call copieMigration.cmd %ENVIR% %TYPE_ENV_COURT% injecteurs "" %ENV% %VERSION_COURT%
echo. 
echo * Copier les compléments des injecteurs TCBT *
call copieMigration.cmd %ENVIR% %TYPE_ENV_COURT% complements TCBT %ENV% %VERSION_COURT%
echo. 
echo * Copier les compléments des injecteurs FonctionClient *
call copieMigration.cmd %ENVIR% %TYPE_ENV_COURT% complements FonctionClient %ENV% %VERSION_COURT%
echo. 
echo * Copier les extracteurs *
call copieMigration.cmd %ENVIR% %TYPE_ENV_COURT% extracteurs "" %ENV% %VERSION_COURT%
cd ..\..
goto menu


:ldapapplication
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Application %ENV%     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd ldap\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageLdapAppliParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% %PREFIXE_EFLUID%%ENV%.properties
cd ..\..
goto menu


:ldapbatchs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs %ENV%        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd ldap\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageLdapBatchParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% batch%ENV%.properties
cd ..\..
goto menu




:decisionnel
cd decisionnel\cmd
call consoleDecisionnel.cmd
title %TITLE%
cd ..\..
goto menu

:c2
echo ÚÄÄÄÄÄÄÄÄÄÄ¿
echo ³ C2       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd c2\cmd
call majC2Statut.cmd %LOT_C2% %TAG_C2% lot ass2rec
call listeC2PourStatut.cmd %VERSION_C2% Livr__recette
cd ..\..
goto menu


:MAJTVersion
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Mise à jour de la table TVersion                                    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
set /p ORANET= Merci de taper le oracle.net.DB du schema destination :
set /p NOMUSER= Merci de taper le user du schema destination :
set /p PWDUSER= Merci de taper le mot de passe du schema destination :
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\MAJTVersion.xml -Dcvs.lot=%LOT_REASS% -Dcvs.tag=%TAG_REASS% -DprefixeTbs=%TBLSPACE% -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\oracle -Dsqlplus.home=%SQLPLUS_HOME% -Dputty.home=%PUTTY_HOME% -Doracle.netDB=%ORANET% -DuserDB.name=%NOMUSER% -DuserDB.pwd=%PWDUSER% -Dversion=%VERSION_C2% -Dlot=%LOT_C2%
cd ..\..
goto menu


:commit
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Commit                                    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd ..
call CommitCVS_UEM.cmd %TAG_REASS% 1
cd %TAG_REASS%
goto menu


:aide
echo les codes des actions sont sur 3 chiffres (au lieu de 2) : 
echo 		le 1er chiffre est le code environnement ('2' pour MOA, '3' pour TST, ...) 
echo 		les 2 chiffres suivants sont le code de l'action ('21' pour reassembler l'appli, ...) 
echo 		=> '221' permet de reassembler l'appli MOA
echo.
echo le reassemblage de la migration a été ajoute 
echo 		reassemblage des transformateurs 
echo 		reassemblage des injecteurs 
echo 		reassemblage des complements aux injecteurs (donnees specifiques à une application existante) 
echo 		deploiement sur le serveur d'execution (renoir) 
echo 				ajout de la super console qui permet de lancer toute la chaine de migration (de la transformation à l'injection)
echo.
echo suppression des schemas, roles et tablespaces oracle 
echo 		modification des scripts xml de creation
echo.
echo tests 
echo 		verification de la connexion à eFluidNetServer 
echo 		lancement de l'appli pour tests manuels
echo.
echo programmation des actions 
echo 		on tape 'prg+<code_action> 
echo 		au prompt, on saisit l'heure a laquelle on veut lancer l'<action> 
echo 		l'<action> (ou la chaîne d'action) est lancee à l'heure voulue


:end
