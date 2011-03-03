@echo off

if not '%PATCHS_ASS%'=='' set TAG_ASS=%TAG_ASS_SANS_PATCH%+%PATCHS_ASS%
if '%PATCHS_ASS%'=='' set TAG_ASS=%TAG_ASS_SANS_PATCH%

set SCRIPTS=scripts
call %SCRIPTS%\commun\setCheminAbsolu.cmd ".\scripts"
set VERSION_HOME=%CHEMIN_ABSOLU%
set XML_HOME=%CHEMIN_ABSOLU%%SCRIPTS%

rem JDK 1.5 par défaut
call .\commun\setEnv.cmd

cls
set CHOICE=
set CHOICELIST=

title Assemblage v.%TAG_ASS%

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
echo     º Assemblage de la version %TAG_ASS_SANS_PATCH%                º
echo     ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
echo     º                                                              º
echo     º 101. tagger le code                                          º
echo     º 102. tagger bdd                                              º
echo     º 103. tagger un patch ou un regroupement de patchs            º
echo     º ------------------------------------------------------------ º
echo     º 201. MAJ Evenements suivefluid                               º
echo     º ------------------------------------------------------------ º
echo     º 210. Differences entre versions n et n-1                     º
echo     º ------------------------------------------------------------ º
echo     º 301. DCT                                                     º
echo     º ------------------------------------------------------------ º
echo     º 311. DocExploitationBatchs                                   º
echo     º ------------------------------------------------------------ º
echo     º Assemblage des applications en 1.4                           º
echo     º ------------------------------------------------------------ º
echo     º 400. Assemblage J2EE complet (401 a 412)                     º
echo     º 401. application efluid J2EE                                 º
echo     º 402. batchs efluid                                           º
echo     º 403. batchs ANT efluid                                       º
echo     º 404. injecteurs                                              º
echo     º 405. extracteurs                                             º
echo     º 406. archiveur                                               º
echo     º                                                              º
echo     º 407. application eFluidNet                                   º
echo     º 408. batchs efluidNet                                        º
echo     º 409. application eFluidPub                                   º
echo     º                                                              º
echo     º 410. application eldap                                       º
echo     º 411. batchs eldap                                            º
echo     º                                                              º
echo     º 412. application AEL                                         º
echo     º                                                              º
echo     º 413. application efluidProxy (en test)                       º
echo     º ------------------------------------------------------------ º
echo     º Assemblage des applications en 1.5                           º
echo     º ------------------------------------------------------------ º
echo     º 430. Assemblage J2EE 1.5 complet (431 a 442)                 º
echo     º 431. Assemblage efluid 1.5                                   º
echo     º 432. batchs efluid 1.5                                       º
echo     º 433. batchs ANT efluid 1.5                                   º
echo     º 434. injecteurs 1.5                                          º
echo     º 435. extracteurs  1.5                                        º
echo     º 436. archiveur 1.5                                           º
echo     º                                                              º
echo     º 437. application eFluidNet 1.5                               º
echo     º 438. batchs efluidNet 1.5                                    º
echo     º 439. application eFluidPub 1.5                               º
echo     º                                                              º
echo     º 440. application eldap 1.5                                   º
echo     º 441. batchs eldap 1.5                                        º
echo     º                                                              º
echo     º 442. application AEL 1.5                                     º
echo     º ------------------------------------------------------------ º
echo     º 500. Assemblage oracle complet (502 a 530)                   º
echo     º 501. Jeux d'essai (obsolete)                                 º
echo     º 502. structure de la base                                    º
echo     º                                                              º
echo     º 510. structure efluidNet                                     º
echo     º                                                              º
echo     º 520. structure eldap                                         º
echo     º                                                              º
echo     º 530. structure AEL                                           º
echo     º ------------------------------------------------------------ º
echo     º 601. Assemblage StreamServe                                  º
echo     º 602. Assemblage StreamServe Clients                          º
echo     º ------------------------------------------------------------ º
echo     º 010. Commit                                                  º
echo     º ------------------------------------------------------------ º
echo     º 020. Programmation complete (sans commit)                    º
echo     º 021. Programmation sans BDD (sans commit)                    º
echo     º 022. Programmation sans MAJ Evenements (sans commit)         º
echo     º 023. Programmation tagger bdd (prg+102)                      º
echo     º 024. Programmation patch code simple sans bdd                º
echo     º ------------------------------------------------------------ º
echo     º 098. choix compilation avec JDK 1.5 (setEnv par defaut)      º
echo     º 099. choix compilation avec JDK 1.4 (setEnv14)               º
echo     º ------------------------------------------------------------ º
echo     º Programmation (ex : prg+401)                                 º
echo     º Multi-selection (ex : 401+402+403)                           º
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
if '%CHOICE%'=='101' goto taggercode
if '%CHOICE%'=='102' goto taggerbdd
if '%CHOICE%'=='103' goto taggerpatch
if '%CHOICE%'=='201' goto statutevenement
if '%CHOICE%'=='210' goto diff
if '%CHOICE%'=='301' goto dct
if '%CHOICE%'=='311' goto docExploitationsBatchs
if '%CHOICE%'=='400' set CHOICELIST=401+402+403+404+405+406+407+408+409+410+411+412
if '%CHOICE%'=='401' goto applicationJ2EE
if '%CHOICE%'=='402' goto batchs
if '%CHOICE%'=='403' goto batchsANT
if '%CHOICE%'=='404' goto injecteurs
if '%CHOICE%'=='405' goto extracteurs
if '%CHOICE%'=='406' goto archiveur
if '%CHOICE%'=='407' goto efluidNet
if '%CHOICE%'=='408' goto batchsefluidNet
if '%CHOICE%'=='409' goto efluidPub
if '%CHOICE%'=='410' goto applicationeldapJ2EE
if '%CHOICE%'=='411' goto batchseldap
if '%CHOICE%'=='412' goto AEL
if '%CHOICE%'=='413' goto efluidProxy
if '%CHOICE%'=='430' set CHOICELIST=431+432+433+434+435+436+437+438+439+440+441+442
if '%CHOICE%'=='431' goto applicationJ2EE15
if '%CHOICE%'=='432' goto batchs15
if '%CHOICE%'=='433' goto batchsANT15
if '%CHOICE%'=='434' goto injecteurs15
if '%CHOICE%'=='435' goto extracteurs15
if '%CHOICE%'=='436' goto archiveur15
if '%CHOICE%'=='437' goto efluidNet15
if '%CHOICE%'=='438' goto batchsefluidNet15
if '%CHOICE%'=='439' goto efluidPub15
if '%CHOICE%'=='440' goto applicationeldapJ2EE15
if '%CHOICE%'=='441' goto batchseldap15
if '%CHOICE%'=='442' goto AEL15
if '%CHOICE%'=='500' set CHOICELIST=502+503+510+520+530
if '%CHOICE%'=='501' goto je
if '%CHOICE%'=='502' goto structureefluid
if '%CHOICE%'=='510' goto structureefluidNet
if '%CHOICE%'=='520' goto structureeldap
if '%CHOICE%'=='530' goto structureAEL
if '%CHOICE%'=='601' goto streamserve
if '%CHOICE%'=='602' goto streamserveClient
if '%CHOICE%'=='010' goto commit
if '%CHOICE%'=='098' goto jdk15
if '%CHOICE%'=='099' goto jdk14
  

rem etape statutC2DEC et JE desactivees sur toutes les programmations
if '%CHOICE%'=='020' (
rem set CHOICE=prg+101+102+201+210+301+401+402+403+404+405+406+407+408+409+410+411+412+431+432+433+434+435+436+437+438+439+440+441+442+502+510+520+530+601+602
	set CHOICE=prg+101+102+201+210+301+311+431+432+433+434+435+436+437+438+439+440+441+442+099+401+402+403+404+405+406+407+408+409+410+411+412+502+510+520+530+601+602
	goto time
)
if '%CHOICE%'=='021' (
	set CHOICE=prg+101+201+210+301+311+099+401+402+403+404+405+406+407+408+409+410+411+412+098+431+432+433+434+435+436+437+438+439+440+441+442+502+510+520+530+601+602
	goto time
)
if '%CHOICE%'=='022' (
	set CHOICE=prg+101+102+210+301+311+099+401+402+403+404+405+406+407+408+409+410+411+412+098+431+432+433+434+435+436+437+438+439+440+441+442+502+510+520+530+601+602
	goto time
)
if '%CHOICE%'=='023' (
	set CHOICE=prg+102
	goto time
)
if '%CHOICE%'=='024' (
	set CHOICE=prg+103+201+210+099+401+402+403+404+405+406+407+408+409+410+411+412+098+431+432+433+434+435+436+437+438+439+440+441+442+601+602
	goto time
)

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


rem ******************************************** Tâches TAGGER

:taggercode
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ tag du code java  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd tagger\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\tagger\tagger.xml -Dcvs.tag=%TAG_ASS_SANS_PATCH% -Dproperty.file=tagger.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu


:taggerbdd
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ tag des scripts BDD       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd tagger\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\tagger\taggerListeFichiers.xml -Dcvs.listeFichier=listeFichiers_BDD.txt -Dproperty.file=taggerBDD.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\tagger
cd ..\..
goto menu


:taggerpatch
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ tag de patch      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd tagger\cmd
call ..\..\commun\setExecDir.cmd
echo.
set PATCH=
set /p PATCH=Entrez le N° du patch ou regroupement de patch (valeurs possibles = '06', 'A_33', 'M', etc...) : 
if '%PATCH%'=='' (
	echo. =^> aucun patch saisi, rien ne sera fait !
) else (
  call ant -f %XML_HOME%\tagger\taggerListeFichiers.xml -Dcvs.listeFichier=listeFichiers_%PATCH%.txt -Dproperty.file=taggerListeFichiersVersion.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\tagger
)
cd ..\..
goto menu



rem ******************************************** Tâches suivefluid

:statutevenement
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Statut Evenements ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd c2\cmd
call %XML_HOME%\commun\setCheminAbsolu.cmd ".\scripts"
java -jar %XML_HOME%/evenement/assemblerVersion.jar http://suivefluid.uem.lan/suivefluid_UEM/services2/ServiceLivraison %LOT_SVF_PREV% CORRIGE %DATE_HEURE_SVF% INTEGRE EFL efluid %VERSION_SVF% %TRIGRAMME% %CHEMIN_ABSOLU%ServiceAssemblage%VERSION_SVF%.log
java -jar %XML_HOME%/evenement/assemblerVersion.jar http://suivefluid.uem.lan/suivefluid_UEM/services2/ServiceLivraison %LOT_SVF_PREV% LIVRE_PARAM %DATE_HEURE_SVF% INTEGRE EFL efluid %VERSION_SVF% %TRIGRAMME% %CHEMIN_ABSOLU%ServiceAssemblageParametrage%VERSION_SVF%.log
cd ..\..
goto menu



rem ******************************************** Tâches DIFF

:diff
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Differences entre versions n et n-1       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd diff\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_ael.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_efluidnet.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_efluidpub.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_eldap.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_hermes.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_streamserve.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_clients.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
cd ..\..
goto menu



rem ******************************************** Tâches DCT

:dct
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ DCT               ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd dct\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\documentation\assemblageDCT.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=dct.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu



rem ******************************************** Tâches DOCEXPLOITATIONBATCHS

:docExploitationsBatchs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ DocExploitationBatchs  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageDEXBTCH.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=docExploitationBatchs.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\j2ee
cd ..\..
goto menu



rem ******************************************** Tâches J2EE

:applicationJ2EE
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ applicationJ2EE    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageAppliJ2EE.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermesJ2EE -Dproperty.file=appliJ2EE.properties -Dapplication=efluid -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:applicationJ2EE15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ applicationJ2EE 1.5    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageEAR.xml -Dcvs.tag=%TAG_ASS% -Djava.home=%JAVA_HOME% -Dcontext=hermesJ2EE1.5 -Dproperty.file=appliJ2EE1.5.properties -Dapplication=efluid -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs (CMD)  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes -Dproperty.file=batch.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchsANT
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs (ANT)  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatchANT.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes -Dproperty.file=batchANT.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:batchs15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs (CMD) 1.5 ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=batch1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:batchsANT15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs (ANT) 1.5 ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatchANT15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=batchANT1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu



:efluidNet
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ efluidNet         ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageAppliWeb.xml -Dcvs.tag=%TAG_ASS% -Dcontext=eFluidNet -Dproperty.file=eFluidNet.properties -Dapplication=efluid.net -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:efluidNet15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ efluidNet  1.5       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageWAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=eFluidNet1.5 -Dproperty.file=eFluidNet1.5.properties -Dapplication=efluid.net -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchsefluidNet
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs efluidNet   ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch2.xml -Dcvs.tag=%TAG_ASS% -Dcontext=efluidNet -Dproperty.file=efluidNetBatch.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchsefluidNet15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs efluidNet 1.5  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch2-1.5.xml -Dcvs.tag=%TAG_ASS% -Dcontext=efluidNet1.5 -Dproperty.file=efluidNetBatch1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:efluidPub
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ efluidPub         ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageAppliWeb.xml -Dcvs.tag=%TAG_ASS% -Dcontext=eFluidPub -Dproperty.file=eFluidPub.properties -Dapplication=eFluidPub -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:efluidPub15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ efluidPub 1.5        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageWAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=eFluidPub1.5 -Dproperty.file=eFluidPub1.5.properties -Dapplication=eFluidPub -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:AEL
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ AEL                    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageAppliWeb.xml -Dcvs.tag=%TAG_ASS% -Dcontext=AEL -Dproperty.file=AEL.properties -Dapplication=AgenceEnLigne -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:AEL15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ AEL    1.5             ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageWar.xml -Dcvs.tag=%TAG_ASS% -Dcontext=AEL1.5 -Dproperty.file=AEL1.5.properties -Dapplication=AgenceEnLigne -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:efluidProxy
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ efluidProxy            ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageEAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=efluidProxy -Dproperty.file=efluidProxy.properties -Dapplication=efluidProxy -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:applicationeldapJ2EE
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ application eldap  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageAppliJ2EE.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermesLdapJ2EE -Dproperty.file=appliLdap.properties -Dapplication=eldap -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:applicationeldapJ2EE15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ application eldap 1.5  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageEAR.xml -Dcvs.tag=%TAG_ASS% -Djava.home=%JAVA_HOME% -Dcontext=hermesLdapJ2EE1.5 -Dproperty.file=appliLdap1.5.properties -Dapplication=eldap -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchseldap
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs eldap       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch2.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermesLdap -Dproperty.file=hermesLdapBatch.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchseldap15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs eldap   1.5    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch2-1.5.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermesLdap1.5 -Dproperty.file=hermesLdapBatch1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:injecteurs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Injecteurs        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageInjecteurs.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes -Dproperty.file=injecteurs.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:injecteurs15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Injecteurs 1.5     ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageInjecteurs15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=injecteurs1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:extracteurs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ extracteurs       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageExtracteurs.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes -Dproperty.file=extracteurs.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:extracteurs15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ extracteurs 1.5   ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageExtracteurs15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=extracteurs1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:archiveur
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ archiveur         ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageJAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=archiveur -Dapplication.name=hermes -Dproperty.file=archiveur.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:archiveur15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ archiveur    1.5   ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageJAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=archiveur -Dapplication.name=hermes1.5 -Dproperty.file=archiveur.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:javadoc
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ JavaDoc           ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageJavaDoc.xml -Dcvs.module=Developpement_dev/Hermes -DexecDir=%EXEC_DIR%
cd ..\..
goto menu



rem ******************************************** Tâches ORACLE

:je
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ JE               ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\assemblageJE.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=assemblerJE.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlDir=%XML_HOME%\oracle -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu


:structureefluid
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Structure eFluid  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\assemblageStructureSchema.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=assemblerStructureefluid.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlDir=%XML_HOME%\oracle -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu


:structureeldap
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Structure eldap       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\assemblageStructureSchema.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=assemblerStructureeLdap.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlDir=%XML_HOME%\oracle -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu

:structureefluidNet
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Structure efluidNet   ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\assemblageStructureSchema.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=assemblerstructureefluidNet.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlDir=%XML_HOME%\oracle -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu


:structureAEL
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Structure AEL         ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\assemblageStructureSchema.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=assemblerstructureAEL.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlDir=%XML_HOME%\oracle -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu



rem ******************************************** Tâches STREAMSERVE

:streamserve
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ StreamServe            ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd streamserve\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\streamserve\assemblageStrS.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=streamserve.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\streamserve
cd ..\..
goto menu


:streamserveClient
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ StreamServe            ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd streamserve\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\streamserve\assemblageStrS.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=streamserveClient.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\streamserve
cd ..\..
goto menu



rem ******************************************** Tâches JDK

:jdk15
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Choix JDK 1.5          ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
call .\commun\setEnv.cmd
set
goto menu


:jdk14
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Choix JDK 1.4          ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
call .\commun\setEnv14.cmd
set
goto menu



rem ******************************************** Tâches COMMIT

:commit
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Commit %LOT_ASS%\%TAG_ASS%                ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd ..\..
call CommitCVS_assemblage.cmd %LOT_ASS%\%TAG_ASS% 1
cd %LOT_ASS%\%TAG_ASS%
goto menu

:help
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Help                                      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 


:end
