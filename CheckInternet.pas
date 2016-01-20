unit CheckInternet;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient;

type
  TCheckInternet = class(TIdTCPClient)
    IdTCPClient: TIdTCPClient;
  private
    function CheckInternet: boolean;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    phost: string;
    pport: integer;
  published
    { Published declarations }

    property status: boolean read CheckInternet;
  end;

  TCustomNetworkState = class(TObject)
    function GetSSID: String; virtual; abstract;
    function IsConnected: boolean; virtual; abstract;
    function IsWifiConnected: boolean; virtual; abstract;
    function IsMobileConnected: boolean; virtual; abstract;
  end;

procedure Register;

implementation

function TCheckInternet.CheckInternet: boolean;
begin
  try
    self.ReadTimeout := 2000;
    self.ConnectTimeout := 2000;
    self.port := self.pport;
    self.host := self.phost;
    self.Connect;
    if self.Connected then
      result := true
    else
      result := false;
    self.Disconnect;
  except
    result := false;
  end;
end;

procedure Register;
begin
  RegisterComponents('internet', [TCheckInternet]);
end;

end.

