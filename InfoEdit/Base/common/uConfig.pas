{========================================================
   读取配置的单元, 封装配置文件类
   @ zhiguo.wu
   2014-06-12 21:00
========================================================}

unit uConfig;

interface
uses Classes, Windows, SysUtils, AES, IniFiles, Dialogs;

type
  TDBConfig = class(TObject)
    FConfigName: string;
    FStrConn: string;
    FUserName: string;
    FPassWord: string;
    FDBName: string;
    FServerIP: string;

  private

  public
    constructor Create(aFileName: string); virtual;
    destructor Destroy; override;


    property ConfigName: string read FConfigName write FConfigName;
    property StrConn: string read FStrConn write FStrConn;
    property UserName: string read FUserName write FUserName;
    property PassWord: string read FPassWord write FPassWord;
    property DBName: string read FDBName write FDBName;
    property ServerIP: string read FServerIP write FServerIP;
  end;


implementation

{ TDBConfig }

constructor TDBConfig.Create(aFileName: string);  // 构建配置文件类
var
  inifile: TIniFile;
  filePath: string;
begin
  if Trim(aFileName) = '' then Exit;

  filePath := ExtractFilePath(ParamStr(0)) + aFileName;
  if not FileExists(filePath) then
  begin
    ShowMessage('配置文件 : ' + filePath + '不存在');
    Exit;
  end;

//  inherited;

  inifile := TIniFile.Create(filePath);    // 读取配置文件
  try
    with inifile do
    begin
      FConfigName := ReadString('Param', 'ConfigName', 'DBConn.ini');
      FStrConn := ReadString('Param', 'StrConn', '');
      FUserName := ReadString('Param', 'UserName', '');
      FPassWord := ReadString('Param', 'PassWord', '');
      FDBName := ReadString('Param', 'DBName', '');
      FServerIP := ReadString('Param', 'ServerIP', '');
    end;
  finally
    FreeAndNil(inifile);
  end;

end;

destructor TDBConfig.Destroy;
begin
  inherited;

  FConfigName := '';
  FStrConn := '';
  FUserName := '';
  FPassWord := '';
  FDBName := '';
  FServerIP := '';
end;

end.
