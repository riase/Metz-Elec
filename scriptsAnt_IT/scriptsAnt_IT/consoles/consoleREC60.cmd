@echo off

rem � surcharger � chaque fois
set LOT_REASS=LotX.Y
set VERSION_COURT=XYZZ

rem Envrionnement par d�faut
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


rem Tablespaces et sch�mas
set TBLSPACE=LIV_%VERSION_LONG%
set PREFIXE_SCHEMA=%TYPE_ENV_COURT%

rem pr�fixes des applications
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
echo     ��������������������������������������������������������������ͻ
echo     � %TYPE_ENV% %REGIE% de la version %TAG_REASS%                         �
echo     ��������������������������������������������������������������͹
echo     �                                                              � 
echo     �                                                              �
echo     � 110. creation des tablespaces MA_BDD                         � 
echo     � 120. drop des tablespaces MA_BDD                             �
echo     �                                                              �
echo     � 130. Aide en ligne efluid                                    �
rem echo     � 131. Aide en ligne eldap                                     �
rem echo     � 132. Aide en ligne ael                                       �
echo     � ------------------------------------------------------------ �
echo     � 2--.TST, 3--.PRO, 4--.LDP, 5--.DEC, 6--.NET, 7--.AEL         �
echo     �                                                              �
echo     �       ------------------------------------------------------- �
echo     �       -20. reAssemblage - all (21+22+23)                      �
echo     �         -21. reAssemblage - application (EAR)                �
echo     �         -22. reAssemblage - batchs                            �
echo     �         -23. reAssemblage - eFluidNetServer                   �
echo     �         -24. reAssemblage - efluid.Pub                        �
echo     �         -26. reAssemblage - batchs Echange                   �
echo     �                                                               �
echo     �       -25. reAssemblage - application Web                     �
echo     �       ------------------------------------------------------- �
echo     �       -30. copie - all (31+32)                                �
echo     �         -31. copie - efluid (EAR,eFluidNetServer,eFluid.Pub)  �
echo     �         -32. copie - WAR                                      �
echo     �         -33. copie - Batchs                                   �
echo     �         -34. copie - Batchs Echanges                         �
echo     �       ------------------------------------------------------- �
echo     �       -40. weblogic - all                                     �
echo     �         -41. weblogic - delete Application (EAR ou WAR)       �
echo     �         -42. weblogic - delete eFluidNetServer                �
echo     �       -43. weblogic - delete eFluid.Pub                       �
echo     �       -44. weblogic - delete JDBC                             �
echo     �                                                               �
echo     �       -45. weblogic - configure JDBC                          �
echo     �       -46. weblogic - deploy Application (EAR)                �
echo     �       -47. weblogic - deploy Application Web (WAR)            �
echo     �       -48. weblogic - deploy eFluidNetServer                  �
echo     �       -49. weblogic - deploy eFluid.Pub                       �
echo     �       ------------------------------------------------------- �
echo     �       -50. oracle - (51+53+54...59)                           �
echo     �         -51. oracle - schema                                  �
echo     �         -52. oracle - migration                               �
echo     �         -53. oracle - structure                               �
echo     �       -54. oracle - JE                                        �
echo     �       -55. oracle - patchs                                    �
echo     �       -56. oracle - visu                                      �
echo     �       -57. oracle - maj confidentialite                       �
echo     �       -58. oracle - stats                                     �
echo     �       -59. oracle - index                                     �
echo     �       ------------------------------------------------------- �
echo     �       -61. tests - application                                �
echo     �       -62. tests - eFluidNetServer                            �
echo     �       -63. tests - eFluidPub                                  �
echo     �       -64. tests - AEL                                        �
echo     �       -65. tests - eFluidNet                                  �
echo     �       ------------------------------------------------------- �
echo     �       -71. menage - weblogic n-1                              �
echo     �       -72. menage - drop user et visu                         �
echo     �       -73. menage - drop role visu                            �
echo     �       ------------------------------------------------------- �
echo     �       -80. migration - all                                    �
echo     �       -81. migration - reAssemblage Transformateurs           �
echo     �       -82. migration - reAssemblage Injecteurs                �
echo     �       -83. migration - reAssemblage Complements injecteurs    �
echo     �       -84. migration - reAssemblage Extracteurs               �
echo     �       -85. migration - copie                                  �
echo     �       ------------------------------------------------------- �
echo     �                                                               �
echo     � 150. StreamServe - reAssemblage                               �
echo     � 151. StreamServe - copie                                      �
echo     �                                                               �
echo     � 160. Decisionnel - lancement de la console                    �
echo     �                                                               �
echo     � 180. C2                                                       �
echo     � 181. MAJTVersion                                              �
echo     �                                                               �
echo     � 190. Commit                                                   �
echo     �                                                               �
echo     � Programmation possible (ex : prg+221+222+223)                 �
echo     � Multi-selection possible (ex : 221+222+223)                   �
echo     �                                                               �
echo     � 0. Quitter                                                    �
echo     ��������������������������������������������������������������ͼ
echo.
set CHOICE=
set /p CHOICE=Selectionnez l'etape souhaitee : 
set CHOICELIST=
set TRAITE=false
set SELECTED_TIME=


:menuchoix
rem ******************************************** D�but
set EXIT=1
if '%CHOICE%'=='' goto menu
set ENV_CODE=%CHOICE:~0,1%
set ACT_CODE=%CHOICE:~1,2%

rem ******************************************** logs de la console
echo %DATE%-%TIME% - Action %CHOICE% >> %VERSION_HOME%\actions%TYPE_ENV%%VERSION_COURT%.log
rem ******************************************** Multi-s�lection
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

rem ICI sp�cialisation de ENVIR/SITE si besoin
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

rem mise � jour des variables d'environnement sp�cifique � chaque ENV
call .\commun\setEnv_%ENVIR%.cmd



rem ******************************************** Actions g�n�riques
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
rem ******************************************** Cas sp�cifiques
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
rem demande � l'utilisateur de confirmer sa demande
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
rem l'�tape s�lectionn�e ne correspond pas � une �tape valide de la console
echo.
echo ���������������������������Ŀ
echo � Etape non valide !        �
echo �����������������������������
echo   ==^> Merci de choisir une etape du menu !!
echo.
goto menu


:tblspce
echo �������������������Ŀ
echo � tblspce %TYPE_ENV_COURT% %SERVER_BDD%  �
echo ���������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call creerTablespaceParamFichier.cmd %LOT_REASS% %TBLSPACE% tablespace_%TYPE_ENV_COURT%_%SERVER_BDD%.properties
cd ..\..
goto menu




:dropTBS
echo �������������������Ŀ
echo � dropTBS %TYPE_ENV_COURT% %SERVER_BDD% �
echo ���������������������
echo. 
if not '%CONFIRM%'=='y' goto confirm
set CONFIRM=n
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call creerTablespaceParamFichier.cmd %LOT_REASS% %TBLSPACE% dropTablespace_%TYPE_ENV_COURT%_%SERVER_BDD%.properties
cd ..\..
goto menu


:helpefluid
echo ���������������������Ŀ
echo � Aide en ligne efluid�
echo �����������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\commun\DeploiementZip.xml -Ddest.dir=%DEPLOYHELP_HOME%\\efluid%VERSION_COURT%\\help -Dfile=hermesJ2EEHelp -Dcvs.lot=%LOT_REASS% -Dcvs.tag=%TAG_REASS% -Dcvs.context=j2ee\application\hermesJ2EE -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -Dproperty.file=help_efluid.properties -Dproperty.file.dir=cmd\parametres
cd ..\..
goto menu

:helpeldap
echo ���������������������Ŀ
echo � Aide en ligne eldap�
echo �����������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\commun\DeploiementZip.xml -Ddest.dir=%DEPLOYHELP_HOME%\\eldap%VERSION_COURT%\\help -Dfile=hermesLdapJ2EEHelp -Dcvs.lot=%LOT_REASS% -Dcvs.tag=%TAG_REASS% -Dcvs.context=j2ee\application\hermesLdapJ2EE -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -Dproperty.file=help_eldap.properties -Dproperty.file.dir=cmd\parametres
cd ..\..
goto menu

:helpael
echo ���������������������Ŀ
echo � Aide en ligne ael�
echo �����������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\commun\DeploiementZip.xml -Ddest.dir=%DEPLOYHELP_HOME%\\ael%VERSION_COURT%\\help -Dfile=aelHelp  -Dcvs.lot=%LOT_REASS% -Dcvs.tag=%TAG_REASS% -Dcvs.context=j2ee\application\ael -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -Dcvs.server=hermescvs -Dproperty.file=help_ael.properties -Dproperty.file.dir=cmd\parametres
cd ..\..
goto menu


:applicationsJ2EE
echo ���������������������Ŀ
echo � Application %ENV%     �
echo �����������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageAppliParamFichierJ2EE.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% %PREFIXE_EFLUID%%ENV%.properties
cd ..\..
goto menu


:batchs
echo �������������������Ŀ
echo � Batchs %ENV%        �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageBatchParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% batch%ENV%.properties
cd ..\..
goto menu

:batchsEchange
echo ���������������������������Ŀ
echo � Batchs Echange %ENV%      �
echo �����������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageBatchEchangeParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%Echange%ENV%%VERSION_COURT% batchEchange%ENV%.properties
cd ..\..
goto menu


:efluidnetserver
echo ������������������������Ŀ
echo � eFluidNetServer %ENV%    �
echo ��������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageEfluidNetServerParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUIDNETSERVER%%ENV%%VERSION_COURT% %PREFIXE_EFLUIDNETSERVER%%ENV%.properties
cd ..\..
goto menu

:efluidpub
echo ������������������������Ŀ
echo � efluidPub %ENV%        �
echo ��������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageAppliWebParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUIDPUB%%ENV%%VERSION_COURT% %PREFIXE_EFLUIDPUB%%ENV%.properties
cd ..\..
goto menu


:applicationWeb
echo ���������������������Ŀ
echo � Application Web     �
echo �����������������������
echo. 
rem demande � l'utilisateur l'environnement pour r�assembler les applications Web efluidNet et efluidAel
rem (on fait peu de contr�le : troncature 3 caract�res � gauche)
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
echo ��������������������������������������������������������������Ŀ
echo � Copier les Applications efluid et eFluidNetServer %ENV%     �
echo ����������������������������������������������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call copieApplications.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUID%%ENV%%VERSION_COURT%
call copieApplications.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUIDNETSERVER%%ENV%%VERSION_COURT%
call copieApplicationWeb.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUIDPUB%%ENV%%VERSION_COURT%
cd ..\..
goto menu


:copieWAR
echo ������������������������������������Ŀ
echo � Copier l'application Web %ENV%     �
echo ��������������������������������������
echo. 
rem demande � l'utilisateur l'environnement pour r�assembler les applications Web efluidNet et efluidAel
rem (on fait peu de contr�le : troncature 3 caract�res � gauche)
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
echo ������������������������Ŀ
echo � Copier les batchs      �
echo ��������������������������
echo. 
cd commun
call setExecDir.cmd
call copieArchives.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUID% %ENV% %VERSION_COURT%
cd ..
goto menu

:copieBatchsEchange
echo �����������������������������Ŀ
echo � Copier les batchs Echange   �
echo �������������������������������
echo. 
cd commun
call setExecDir.cmd
set DEPLOYBATCH_HOME=\\%SERVER_BATCH%\batchsefluidEchange\%REGIE%
call copieArchives.cmd %ENVIR% %TYPE_ENV_COURT% %PREFIXE_EFLUID%Echange %ENV% %VERSION_COURT%
cd ..
goto menu

:weblogicOld
echo �������������������Ŀ
echo � weblogic Old      �
echo ���������������������
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
echo �������������������������Ŀ
echo � undeployAppli %ENV%     �
echo ���������������������������
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\undeploy.cmd %PREFIXE_EFLUID%%ENV%%VERSION_COURT% %SERVER_NAME% 
cd ..\..
goto menu

:undeployNetServer
echo �������������������������Ŀ
echo � undeployNetServer %ENV%  �
echo ���������������������������
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\undeploy.cmd %PREFIXE_EFLUIDNETSERVER%%ENV%%VERSION_COURT% %SERVER_NAME% 
cd ..\..
goto menu

:undeployPub
echo �������������������������Ŀ
echo � undeployPub %ENV%       �
echo ���������������������������
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\undeploy.cmd %PREFIXE_EFLUIDPUB%%ENV%%VERSION_COURT% %SERVER_NAME% 
cd ..\..
goto menu

:deleteJDBC
echo ���������������������Ŀ
echo � deleteJDBC %ENV%      �
echo �����������������������
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\supprimerJDBC.cmd %PREFIXE_JDBC%%VERSION_COURT% %ENVIR%
cd ..\..
goto menu

:configureJDBC
echo ������������������������Ŀ
echo � configureJDBC %ENV%      �
echo ��������������������������
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\creerJDBC.cmd %PREFIXE_JDBC%%VERSION_COURT% %SCHEMA% %SERVER_NAME% %ENVIR%
cd ..\..
goto menu

:deployAppli
echo ����������������������Ŀ
echo � deployAppli %ENV%      �
echo ������������������������
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\deploy.cmd %PREFIXE_EFLUID%%ENV%%VERSION_COURT% ear %SERVER_NAME% 
cd ..\..
goto menu

:deployAppliWeb
echo ����������������������������Ŀ
echo � deployAppliWeb %ENV%       �
echo ������������������������������
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\deploy.cmd %PREFIXE_EFLUID%%ENV%%VERSION_COURT% war %SERVER_NAME% 
cd ..\..
goto menu

:deployEFluidNetServer
echo ��������������������������������Ŀ
echo � deployEFluidNetServer %ENV%      �
echo ����������������������������������
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\deploy.cmd %PREFIXE_EFLUIDNETSERVER%%ENV%%VERSION_COURT% ear %SERVER_NAME% 
cd ..\..
goto menu

:deployEfluidPub
echo ����������������������������Ŀ
echo � deployEfluidPub %ENV%       �
echo ������������������������������
echo. 
cd weblogic\cmd
call ..\..\commun\setExecDir.cmd
call %XML_HOME%\weblogic\deploy.cmd %PREFIXE_EFLUIDPUB%%ENV%%VERSION_COURT% war %SERVER_NAME% 
cd ..\..
goto menu


:schema
echo ��������������������Ŀ
echo � schema %SERVER_BDD% %ENV%    �
echo ����������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call creerUserParamFichier.cmd %LOT_REASS% %TBLSPACE% user_%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu


:export
echo �����������������Ŀ
echo � export %SERVER_BDD% %ENV% �
echo �������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call exporterSchemaParamFichier.cmd %LOT_REASS% %TAG_REASS% exportSchema_%ENV%_%SERVER_BDD%.properties
grep -r -H -i erreur ..\tmpEXP\*
cd ..\..
goto menu


:import
echo ��������������������Ŀ
echo � import %SERVER_BDD% %ENV%    �
echo ����������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call importerDMPParamFichier.cmd %LOT_REASS% %TAG_REASS% importDMP_%ENV%_%SERVER_BDD%.properties
grep -r -H -i erreur ..\tmpDMP\*
cd ..\..
goto menu


:migration
echo ���������������������Ŀ
echo � migration %SERVER_BDD% %ENV%  �
echo �����������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call reassemblageListePatchSQLParamFichier.cmd %LOT_REASS% %TAG_REASS% %TBLSPACE% reassemblerListePatchSQL_migration_n-1_n_%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu


:je
echo ������������������Ŀ
echo � je %SERVER_BDD% %ENV%      �
echo ��������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageJEParametrageParamFichier.cmd %LOT_REASS% %TAG_REASS% JEParam_%ENV%_%SERVER_BDD%.properties
grep -r -H -i erreur ..\tmpJEParam\*
cd ..\..
goto menu


:patch
echo ���������������������Ŀ
echo � patch %SERVER_BDD% %ENV%      �
echo �����������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call reassemblageListePatchSQLParamFichier.cmd %LOT_REASS% %TAG_REASS% %TBLSPACE% reassemblerListePatchSQL_patch%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu

:majconfidentialite
echo �������������������Ŀ
echo � majConf %ENV%     �
echo ���������������������
echo. 
cd scripts\oracle
echo Log consigne dans ..\scripts\oracle\modificationConfidentialite_%ENV%.log
%SystemRoot%\system32\attrib.exe -r modificationConfidentialite_%ENV%.log
%SystemRoot%\system32\attrib.exe -r UpdateConfidentialite.sql
call modificationConfidentialite.cmd %SCHEMA% UEM %REGIE% %ORACLE_SID% > modificationConfidentialite_%ENV%.log
cd ..\..
goto menu

:index
echo ����������������������Ŀ
echo � index %SERVER_BDD% %ENV%       �
echo ������������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageRebuildIndexParamFichier.cmd %LOT_REASS% %TAG_REASS% rebuildIndex_%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu

:stats
echo ��������������������Ŀ
echo � stats %SERVER_BDD% %ENV%     �
echo ����������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call calculerStats.cmd %SCHEMA% %TAG_REASS%
cd ..\..
goto menu


:structure
echo ��������������������Ŀ
echo � struct %SERVER_BDD% %ENV%    �
echo ����������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageStructureSchemaParamFichier.cmd %LOT_REASS% %TAG_REASS% reassemblerStructure_%ENV%_%SERVER_BDD%.properties
cd ..\..
goto menu


:visu
echo �������������������Ŀ
echo � visu %SERVER_BDD% %ENV%     �
echo ���������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call creerUserVisu.cmd %SCHEMA% %TBLSPACE%_DATA
cd ..\..
goto menu


:testAppli
echo �����������������������������Ŀ
echo � Test Application %ENV%        �
echo �������������������������������
echo. 
call IEXPLORE http://%ALIAS_DNS%/%PREFIXE_EFLUID%%ENV%%VERSION_COURT%/jsp/arc/commun/index.jsp
goto menu


:testNetServer
echo ����������������������������������Ŀ
echo � Test eFluidNetServer %ENV%         �
echo ������������������������������������
echo. 
call IEXPLORE "http://%ALIAS_DNS%/%PREFIXE_EFLUIDNETSERVER%%ENV%%VERSION_COURT%/VerifInstallation?user=B-G-%REGIE%&mdp=B-G-%REGIE%"
goto menu


:testPub
echo �����������������������������Ŀ
echo � Test EfluidPub %ENV%        �
echo �������������������������������
echo. 
call IEXPLORE "http://%ALIAS_DNS%/%PREFIXE_EFLUIDPUB%%ENV%%VERSION_COURT%/VerifInstallation?user=B-G-%REGIE%&mdp=B-G-%REGIE%"
goto menu


:testAel
echo �����������������������������Ŀ
echo � Test EfluidAEL              �
echo �������������������������������
echo. 
call IEXPLORE "http://ragenceenligne.uem.lan/%PREFIXE_EFLUIDWeb%%ENV%%VERSION_COURT%/jsp/arc/habilitation/login.jsp"
goto menu


:testNet
echo �����������������������������Ŀ
echo � Test EfluidNET              �
echo �������������������������������
echo. 
call IEXPLORE "http://refluidnet.uem.lan/%PREFIXE_EFLUIDWeb%%ENV%%VERSION_COURT%"
goto menu


:dropUsers
echo ���������������������������������������Ŀ
echo � drop User Oracle %ENV% + user visu      �
echo �����������������������������������������
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
echo ����������������������������������Ŀ
echo � drop Role visu %ENV%               �
echo ������������������������������������
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
echo ������������������������Ŀ
echo � StreamServe            �
echo ��������������������������
echo. 
cd streamserve\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageStreamServeParamFichier.cmd %LOT_REASS% %TAG_REASS% streamserve.properties
cd ..\..
goto menu


:copieStreamServe
echo ��������������������������Ŀ
echo � Copier StreamServe       �
echo ����������������������������
echo. 
cd commun
call setExecDir.cmd
call copieArchives.cmd %ENVIR% %TYPE_ENV_COURT% StreamServe "" %VERSION_COURT%
cd ..
goto menu

:transformateurs
echo ������������������������Ŀ
echo � Transformateurs %ENV%    �
echo ��������������������������
echo. 
cd migration\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageTransformateursParamFichier.cmd %LOT_REASS% %TAG_REASS% TCBT%ENV%%VERSION_COURT% transformateursTCBT.properties
call reAssemblageTransformateursParamFichier.cmd %LOT_REASS% %TAG_REASS% FonctionClient%ENV%%VERSION_COURT% transformateursFonctionClient.properties
cd ..\..
goto menu

:injecteurs
echo �������������������Ŀ
echo � Injecteurs %ENV%  �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageInjecteursParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% injecteurs.properties
cd ..\..
goto menu

:complementsInjecteurs
echo �������������������������������Ŀ
echo � Complements Injecteurs %ENV%    �
echo ���������������������������������
echo. 
cd migration\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageComplementsInjecteursParamFichier.cmd %LOT_REASS% %TAG_REASS% TCBT%ENV%%VERSION_COURT% injecteursTCBT.properties
call reAssemblageComplementsInjecteursParamFichier.cmd %LOT_REASS% %TAG_REASS% FonctionClient%ENV%%VERSION_COURT% injecteursFonctionClient.properties
cd ..\..
goto menu

:extracteurs
echo �������������������Ŀ
echo � Extracteurs %ENV% �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageExtracteursParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% extracteurs.properties
cd ..\..
goto menu

:copieMigration
echo ��������������������������������������������������������������Ŀ
echo � Copier les transformateurs, injecteurs et complements %ENV%    �
echo ����������������������������������������������������������������
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
echo * Copier les compl�ments des injecteurs TCBT *
call copieMigration.cmd %ENVIR% %TYPE_ENV_COURT% complements TCBT %ENV% %VERSION_COURT%
echo. 
echo * Copier les compl�ments des injecteurs FonctionClient *
call copieMigration.cmd %ENVIR% %TYPE_ENV_COURT% complements FonctionClient %ENV% %VERSION_COURT%
echo. 
echo * Copier les extracteurs *
call copieMigration.cmd %ENVIR% %TYPE_ENV_COURT% extracteurs "" %ENV% %VERSION_COURT%
cd ..\..
goto menu


:ldapapplication
echo ���������������������Ŀ
echo � Application %ENV%     �
echo �����������������������
echo. 
cd ldap\cmd
call ..\..\commun\setExecDir.cmd
call reAssemblageLdapAppliParamFichier.cmd %LOT_REASS% %TAG_REASS% %PREFIXE_EFLUID%%ENV%%VERSION_COURT% %PREFIXE_EFLUID%%ENV%.properties
cd ..\..
goto menu


:ldapbatchs
echo �������������������Ŀ
echo � Batchs %ENV%        �
echo ���������������������
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
echo ����������Ŀ
echo � C2       �
echo ������������
echo. 
cd c2\cmd
call majC2Statut.cmd %LOT_C2% %TAG_C2% lot ass2rec
call listeC2PourStatut.cmd %VERSION_C2% Livr__recette
cd ..\..
goto menu


:MAJTVersion
echo �������������������������������������������Ŀ
echo � Mise � jour de la table TVersion                                    �
echo ���������������������������������������������
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
echo �������������������������������������������Ŀ
echo � Commit                                    �
echo ���������������������������������������������
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
echo le reassemblage de la migration a �t� ajoute 
echo 		reassemblage des transformateurs 
echo 		reassemblage des injecteurs 
echo 		reassemblage des complements aux injecteurs (donnees specifiques � une application existante) 
echo 		deploiement sur le serveur d'execution (renoir) 
echo 				ajout de la super console qui permet de lancer toute la chaine de migration (de la transformation � l'injection)
echo.
echo suppression des schemas, roles et tablespaces oracle 
echo 		modification des scripts xml de creation
echo.
echo tests 
echo 		verification de la connexion � eFluidNetServer 
echo 		lancement de l'appli pour tests manuels
echo.
echo programmation des actions 
echo 		on tape 'prg+<code_action> 
echo 		au prompt, on saisit l'heure a laquelle on veut lancer l'<action> 
echo 		l'<action> (ou la cha�ne d'action) est lancee � l'heure voulue


:end
