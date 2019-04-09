; -- Components.iss --
; Demonstrates a components-based installation.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!


#define MyAppName "Sistema de Votação para CIPA"
#define MyAppVersion "2015"
#define MyAppPublisher "My Company, Inc."
#define MyAppURL "http://www.example.com/"
#define MyAppExeName "Instalador_cipa_completo_2015"

#define AdministradorExeName "cipa.exe"
#define gerenteExeName "cipa_gerente.exe"
#define VotacaoExeName "cipa_cliente.exe"
#define LiberacaoExeName "cipa_liberacao.exe"


[Setup]
AppId={{4F80D573-FD61-449A-BFCA-7F1FBC032514}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
DefaultDirName=C:\CIPA
DefaultGroupName=CIPA 

;AppPublisher={#MyAppPublisher}
;AppPublisherURL={#MyAppURL}
;AppSupportURL={#MyAppURL}
;AppUpdatesURL={#MyAppURL}
;DefaultDirName=C:\CIPA
DisableDirPage=yes
;DisableProgramGroupPage=yes
OutputBaseFilename={#MyAppExeName}
Password=whirlpool
Compression=lzma
SolidCompression=yes


[Types]
Name: "administrador"; Description: "Módulo do Administrador"
Name: "gerente"; Description: "Módulo Gerencial"
Name: "votacao"; Description: "Módulo de Votação"
Name: "liberacao"; Description: "Módulo de Liberação das Cabines de Votação"
Name: "servidor"; Description: "Somente Servidor do Banco de Dados"
;Name: "custom"; Description: "Instalação Personalizada"; Flags: iscustom

[Components]
Name: "administrador"; Description: "Módulo Administrador"; Types: administrador ; 
Name: "gerente";       Description: "Módulo Gerencial"; Types: gerente ; 
Name: "votacao";       Description: "Módulo Votação"; Types: votacao ; 
Name: "liberacao";     Description: "Módulo Liberação de Cabine"; Types: liberacao ; 
Name: "servidor";      Description: "Servidor do banco de Dados"; Types: servidor ; 


[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\CIPA\CIPA.FDB"; DestDir: "{app}"; Components: servidor;
Source: "C:\CIPA2\*"; DestDir: "{app}"; Components: administrador gerente votacao liberacao;
Source: "C:\Program Files (x86)\Borland\Delphi7\Projects\cipa\cipa.exe";  DestDir: "{app}"; Components: administrador
Source: "C:\Program Files (x86)\Borland\Delphi7\Projects\cipa_cliente\cipa_cliente.exe";  DestDir: "{app}"; Components: votacao
Source: "C:\Program Files (x86)\Borland\Delphi7\Projects\cipa_gerente\cipa_gerente.exe";  DestDir: "{app}"; Components: gerente
Source: "C:\Program Files (x86)\Borland\Delphi7\Projects\cipa_liberacao\cipa_liberacao.exe";  DestDir: "{app}"; Components: liberacao
Source: "C:\Users\Mauricio\Downloads\Firebird-2.5.3.26780_0_Win32.exe"; DestDir: {tmp};  Components: administrador gerente votacao liberacao; Flags: ignoreversion
Source: "C:\Users\Mauricio\Downloads\Firebird-2.5.3.26780_0_Win32.exe"; DestDir: {app};  Components: servidor; Flags: deleteafterinstall ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#AdministradorExeName}"; Tasks: desktopicon; Flags: createonlyiffileexists;
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#gerenteExeName}"; Tasks: desktopicon; Flags: createonlyiffileexists;
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#VotacaoExeName}"; Tasks: desktopicon; Flags: createonlyiffileexists;
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#LiberacaoExeName}"; Tasks: desktopicon; Flags: createonlyiffileexists;


[Run]
Filename: {tmp}\Firebird-2.5.3.26780_0_Win32.exe; WorkingDir: {app}; Parameters: "/VERYSILENT /NOICONS /COMPONENTS=""ClientComponent"" /FORCE /COPYFBCLIENT";StatusMsg: Instalando o cliente do Banco de Dados… Aguarde;  Flags:  skipifdoesntexist;
Filename: {app}\Firebird-2.5.3.26780_0_Win32.exe; WorkingDir: {app}; Parameters: "/VERYSILENT /NOICONS /COMPONENTS=""SuperServerComponent, ServerComponent, DevAdminComponent, ClientComponent"" /FORCE /COPYFBCLIENT";StatusMsg: Instalando o Servidor do Banco de Dados… Aguarde; Flags:  skipifdoesntexist;
;Filename: "{app}\{#AdministradorExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent skipifdoesntexist;
;Filename: "{app}\{#gerenteExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent skipifdoesntexist;
;Filename: "{app}\{#VotacaoExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent skipifdoesntexist;
;Filename: "{app}\{#LiberacaoExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent skipifdoesntexist;





