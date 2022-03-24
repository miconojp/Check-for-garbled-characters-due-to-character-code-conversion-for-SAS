options fullstimer=1;
/*
+-------------------------------------+
|試験・目的     :|日本語（2byte文字）がSASファイルに
　　　　　　　　:|落とした時に文字化けしていないかチェックする
+-------------------------------------+

+-------------------------------------+
文字コードがUTF-8のデータを、
SASファイルに落とした場合、S-JISに変換されます。
まれに変換時に文字化けを起こす場合がありますので、
このプログラムで文字化けを探してください。
*/
*/
*実行環境ROOT
*適宜変更;
%let RT_PATH=C:\Users\xxxx\Desktop;

*チェックするSASファイルの場所;
%let Raw	= &RT_PATH.\test ;
%let OUT	= &RT_PATH.\test ;

*Library設定;
libname RAW "&Raw." access=readonly;
libname OUT "&OUT.";


data temp_CM;
	set raw.CM;
	keep  project SUBJECT DataPageName RecordPosition S_CMTRT ;
run;

data CM_Check;
	set temp_CM;
	*文字化けを起こすと必ず"?"になるので"?"を探す;
	check = find(S_CMTRT,"?");
run;

data Byte2Check_result;
	set CM_Check;
	*該当レコードを抽出;
	if check > 0 then output;
run;

/*データエクスポート*/
PROC EXPORT DATA= WORK.Byte2check_result 
            OUTFILE= "&OUT.\Byte2Check_result.xls" 
            DBMS=EXCEL REPLACE;
     SHEET="Sheet"; 
RUN;
