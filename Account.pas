unit Account;

interface

uses Windows, Classes, Dialogs, SysUtils, RegExpr, lib;

type
  TAccount = class
    public
      Balance, id : Integer;
			Login, Password : String;
			Token : String;
			function signIn() : Boolean;
			function getInfo (): String;
			function JsToStr_dll(s : string):string;
      constructor Create(Login, Password, Token:String; id:integer); virtual;
      destructor Destroy(); virtual;
  end;
const
	host = 'https://darktraffic.pro/';
	api = 'qapi/';
  UA = 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:30.0) Gecko/20100101 Firefox/30.0';

implementation

{ TAccount }

function TAccount.signIn(): Boolean;
var
	response:string;
begin
	if (Login <> EmptyStr) and (Password <> EmptyStr) then begin
		response := send('GET', host+api+'auth.signIn?username=Winexcel2&password=password','');
		if pos('access_token', response)<>0 then begin
			Token:=copy(response, pos('":"', response)+3, Length(response));
			Token:=copy(Token, 0, pos('"}', Token)-1);
			ShowMessage(Token);
		end;

	end;
end;

function TAccount.getInfo (): String;
begin

end;

constructor TAccount.Create(Login, Password, Token:String; id:integer);
begin
  Self.id:=id;
  Balance := 0;
  Self.Login := Login;
  Self.Password := Password;
  Self.Token := Token;
end;

destructor TAccount.Destroy;
begin
  inherited;
end;

// dll code :
{ Account_WebSurf }

function TAccount.JsToStr_dll(s : string):string;
var b:string;
begin
  while pos('\u',s)>0 do begin
    b:=Copy(s,pos('\u',s)+2,4);
    Delete(s, pos('\u',s), 6);
    Insert(WideChar(StrToInt('$'+b)), s, pos('\u',s));
  end;
  result:=s;
end;


end.
