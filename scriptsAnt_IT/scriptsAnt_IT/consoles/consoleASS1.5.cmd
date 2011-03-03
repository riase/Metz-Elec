@echo off

if not '%PATCHS_ASS%'=='' set TAG_ASS=%TAG_ASS_SANS_PATCH%+%PATCHS_ASS%
if '%PATCHS_ASS%'=='' set TAG_ASS=%TAG_ASS_SANS_PATCH%

set SCRIPTS=scripts
call %SCRIPTS%\commun\setCheminAbsolu.cmd ".\scripts"
set VERSION_HOME=%CHEMIN_ABSOLU%
set XML_HOME=%CHEMIN_ABSOLU%%SCRIPTS%

rem JDK 1.5
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
echo     º 201. MAJ Evenements Corriges suivefluid                      º
echo     º 202. MAJ Evenements Parametrage suivefluid                   º
echo     º ------------------------------------------------------------ º
echo     º 210. Differences entre versions n et n-1                     º
echo     º ------------------------------------------------------------ º
echo     º 301. DCT                                                     º
echo     º ------------------------------------------------------------ º
echo     º 311. DocExploitationBatchs                                   º
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
echo     º 412. application AEL                                         º
echo     º 416. ressources AEL Clients                                  º
echo     º 417. ressources AEL Produit                                  º
echo     º                                                              º
echo     º 413. application efluidProxy                                 º
echo     º                                                              º
echo     º 414. EJB Statefull					                                  º
echo     º 415. EJB Stateless					                                  º
echo     º ------------------------------------------------------------ º
echo     º 500. Assemblage oracle complet (502 a 530)                   º
echo     º 501. Jeux d'essai (obsolete)                                 º
echo     º 502. structure de la base                                    º
echo     º                                                              º
echo     º 510. structure efluidNet                                     º
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
if '%CHOICE%'=='201' goto statutevenementcorrige
if '%CHOICE%'=='202' goto statutevenementparametrage
if '%CHOICE%'=='210' goto diff
if '%CHOICE%'=='301' goto dct
if '%CHOICE%'=='311' goto docExploitationBatchs
if '%CHOICE%'=='400' set CHOICELIST=401+402+403+404+405+406+407+408+409+412+413+416+417
if '%CHOICE%'=='401' goto applicationJ2EE
if '%CHOICE%'=='402' goto batchs
if '%CHOICE%'=='403' goto batchsANT
if '%CHOICE%'=='404' goto injecteurs
if '%CHOICE%'=='405' goto extracteurs
if '%CHOICE%'=='406' goto archiveur
if '%CHOICE%'=='407' goto efluidNet
if '%CHOICE%'=='408' goto batchsefluidNet
if '%CHOICE%'=='409' goto efluidPub
if '%CHOICE%'=='412' goto AEL
if '%CHOICE%'=='413' goto efluidProxy
if '%CHOICE%'=='414' goto ejbstatefull
if '%CHOICE%'=='415' goto ejbstateless
if '%CHOICE%'=='416' goto RessourcesAELClients
if '%CHOICE%'=='417' goto RessourcesAELProduit
if '%CHOICE%'=='500' set CHOICELIST=502+503+510+530
if '%CHOICE%'=='501' goto je
if '%CHOICE%'=='502' goto structureefluid
if '%CHOICE%'=='510' goto structureefluidNet
if '%CHOICE%'=='530' goto structureAEL
if '%CHOICE%'=='601' goto streamserve
if '%CHOICE%'=='602' goto streamserveClient
if '%CHOICE%'=='010' goto commit
  

rem etape statutC2DEC et JE desactivees sur toutes les programmations
if '%CHOICE%'=='020' (
	set CHOICE=prg+101+102+201+210+301+311+401+402+403+404+405+406+407+408+409+412+413+414+415+416+417+502+510+530+601+602
	goto time
)
if '%CHOICE%'=='021' (
	set CHOICE=prg+101+201+210+301+311+099+401+402+403+404+405+406+407+408+409+412+413+414+415+416+417+502+510+530+601+602
	goto time
)
if '%CHOICE%'=='022' (
	set CHOICE=prg+101+102+210+301+311+401+402+403+404+405+406+407+408+409+412+413+414+415+416+417+502+510+530+601+602
	goto time
)
if '%CHOICE%'=='023' (
	set CHOICE=prg+102
	goto time
)
if '%CHOICE%'=='024' (
	set CHOICE=prg+103+201+210+401+402+403+404+405+406+407+408+409+412+413+414+415+601+602
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

:statutevenementcorrige
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Statut Evenements Corriges ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd c2\cmd
call %XML_HOME%\commun\setCheminAbsolu.cmd ".\scripts"
java -jar %XML_HOME%/evenement/assemblerVersion.jar http://suivefluid.uem.lan/suivefluid_UEM/services2/ServiceLivraison %LOT_SVF_PREV% CORRIGE %DATE_HEURE_SVF% INTEGRE EFL efluid %VERSION_SVF% %TRIGRAMME% %CHEMIN_ABSOLU%ServiceAssemblage%VERSION_SVF%.log
cd ..\..
goto menu

:statutevenementparametrage
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Statut Evenements Parametrage ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd c2\cmd
call %XML_HOME%\commun\setCheminAbsolu.cmd ".\scripts"
java -jar %XML_HOME%/evenement/assemblerVersion.jar http://suivefluid.uem.lan/suivefluid_UEM/services2/ServiceLivraison %LOT_SVF_PREV% LIVRE_PARAM %DATE_HEURE_SVF_PARAM% INTEGRE EFL efluid %VERSION_SVF% %TRIGRAMME% %CHEMIN_ABSOLU%ServiceAssemblage%VERSION_SVF%.log
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
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_hermes.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_streamserve.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_clients.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_dexbatch.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
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

:docExploitationBatchs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ DocExploitationBatchs  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageDexBatch.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=docExploitationBatchs.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\j2ee
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
call ant -f %XML_HOME%\j2ee\assemblageEAR.xml -Dcvs.tag=%TAG_ASS% -Djava.home=%JAVA_HOME% -Dcontext=hermesJ2EE1.5 -Dproperty.file=appliJ2EE1.5.properties -Dapplication=efluid -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs (CMD) ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=batch1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:batchsANT
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs (ANT) ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatchANT15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=batchANT1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu



:efluidNet
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ efluidNet        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageWAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=eFluidNet1.5 -Dproperty.file=eFluidNet1.5.properties -Dapplication=efluid.net -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchsefluidNet
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Batchs efluidNet  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch2-1.5.xml -Dcvs.tag=%TAG_ASS% -Dcontext=efluidNet1.5 -Dproperty.file=efluidNetBatch1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:efluidPub
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ efluidPub        ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageWAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=eFluidPub1.5 -Dproperty.file=eFluidPub1.5.properties -Dapplication=eFluidPub -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:efluidProxy
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ efluidProxy       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageEjbProxy.xml -Dcvs.tag=%TAG_ASS% -Dcontext=efluidProxy -Dproperty.file=efluidProxy.properties -Dapplication=efluidProxy -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:AEL
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ AEL                 ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageWar.xml -Dcvs.tag=%TAG_ASS% -Dcontext=AEL1.5 -Dproperty.file=AEL1.5.properties -Dapplication=AgenceEnLigne -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:RessourcesAELClients
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Ressources AEL Clients ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\commun\zipListe.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=ressourcesAELClients.properties -Dproperty.file.dir=cmd\parametres -DxmlCommunDir=%XML_HOME%\commun -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:RessourcesAELProduit
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Ressources AEL Clients ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\commun\zipListe.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=ressourcesAELProduit.properties -Dproperty.file.dir=cmd\parametres -DxmlCommunDir=%XML_HOME%\commun -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:injecteurs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ Injecteurs      ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageInjecteurs15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=injecteurs1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:extracteurs
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ extracteurs    ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageExtracteurs15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=extracteurs1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:archiveur
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ archiveur       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageJAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=archiveur -Dapplication.name=hermes1.5 -Dproperty.file=archiveur.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:ejbstatefull
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ EJB Statefull       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageJAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=EJBStatefull -Dapplication.name=hermes1.5 -Dproperty.file=EJBStatefull.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:ejbstateless
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³ EJB Stateless       ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageJAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=EJBStateless -Dapplication.name=hermes1.5 -Dproperty.file=EJBStateless.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
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
