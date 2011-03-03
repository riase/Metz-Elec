@echo off

set SCRIPTS=scripts
call %SCRIPTS%\commun\setCheminAbsolu.cmd ".\scripts"
set VERSION_HOME=%CHEMIN_ABSOLU%
set XML_HOME=%CHEMIN_ABSOLU%%SCRIPTS%

call .\commun\setEnv.cmd

cls
set CHOICE=
set CHOICELIST=

title Creation branche de maintenance %VERSION_COURT%

:menu
if not "%CHOICELIST%"=="" (
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
echo     º         Branche de maintenance de la version %VERSION_COURT%         º
echo     ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo     º                                                              º
echo     º 100. creer branche sur la projet complet (101 à 105)         º
echo     º                                                              º
echo     º 101. creer branche sur l'archi                               º
echo     º 102. creer branche sur l'EDK                                 º
echo     º 103. creer branche sur le developpement                      º
echo     º 104. creer branche sur le specifique clients                 º
echo     º 105. creer branche sur la doc des batchs                     º
echo     º ------------------------------------------------------------ º
echo     º 201. creer zip du developpement                              º
echo     º 202. creer zip specifique clients                            º
echo     º 203. creer zip des docs des batchs                           º
echo     º ------------------------------------------------------------ º
echo     º Multi-selection (ex : 103+201)                               º
echo     º                                                              º
echo     º 0. Quitter                                                   º
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
rem ******************************************** logs de la console
echo %DATE%-%TIME% - Action %CHOICE% >> %VERSION_HOME%\actionsAssemblage%VERSION_COURT%.log
rem ******************************************** Multi-sélection
if '%CHOICE:~3,1%'=='+' (
	set CHOICELIST=%CHOICE%
	goto menu
)
rem ******************************************** Programmation
if '%CHOICE:~0,3%'=='prg' goto time
rem ****************************************** actions
if '%CHOICE%'=='101' goto brancheArchi
if '%CHOICE%'=='102' goto brancheEDK
if '%CHOICE%'=='103' goto brancheDev
if '%CHOICE%'=='104' goto brancheClients
if '%CHOICE%'=='105' goto brancheDoc
if '%CHOICE%'=='100' set CHOICELIST=101+102+103+104+105
if '%CHOICE%'=='201' goto creerZipDev
if '%CHOICE%'=='202' goto creerZipClients
if '%CHOICE%'=='203' goto creerZipDoc


rem ******************************************** Navigation
if not '%CHOICELIST%'=='' goto menu
if '%CHOICE%'=='0' goto end
if '%EXIT%'=='1' goto exit
goto menu
rem ******************************************** Fin

:exit
rem l'étape sélectionnée ne correspond pas à une étape valide de la console
echo.
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Etape non valide !        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo   ==^> Merci de choisir une etape du menu !!
echo.
goto menu

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
if '%SELECTED_TIME:~0,2%%SELECTED_TIME:~3,2%' LSS '%TIME:~0,2%%TIME:~3,2%' (
	echo      !!! Attention : l'heure choisie doit etre superieure a l'heure actuelle !!!
	set SELECTED_TIME=
	goto time
)
if not '%TIME:~0,5%'=='%SELECTED_TIME%' (
	sleep 15
	goto time
)
if '%TIME:~0,5%'=='%SELECTED_TIME%' (
	set TRAITE=true
	set CHOICELIST=%CHOICE:~4,500%
	goto menu
)


rem ******************************************** Tâches créer Branches

:brancheArchi
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ branche de l'Archi ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creerBranche.xml -Dproperty.file=branche_hermesArchi.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:brancheEDK
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ branche de l'EDK ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creerBranche.xml -Dproperty.file=branche_efluidEDK.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:brancheDev
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ branche du Dev    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creerBranche.xml -Dproperty.file=branche_Dev.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..\..
goto menu

:brancheClients
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ branche du spec. client ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creerBranche.xml -Dproperty.file=branche_clients.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:brancheDoc
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ branche de la doc ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creerBranche.xml -Dproperty.file=branche_Doc.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

rem ******************************************** Tâches créer Zip

:creerZipDev
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Creer zip Dev.    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creationZipEnv.xml -Dproperty.file=zip_Dev.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:creerZipClients
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Creer zip Clients ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creationZipEnv.xml -Dproperty.file=zip_Clients.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:creerZipDoc
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Creer zip Doc     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creationZipEnv.xml -Dproperty.file=zip_Doc.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:end
