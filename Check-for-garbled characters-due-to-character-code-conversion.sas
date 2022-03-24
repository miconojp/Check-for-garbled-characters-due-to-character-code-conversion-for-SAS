options fullstimer=1;
/*
+-------------------------------------+
|�����E�ړI     :|���{��i2byte�����j��SAS�t�@�C����
�@�@�@�@�@�@�@�@:|���Ƃ������ɕ����������Ă��Ȃ����`�F�b�N����
+-------------------------------------+

+-------------------------------------+
�����R�[�h��UTF-8�̃f�[�^���A
SAS�t�@�C���ɗ��Ƃ����ꍇ�AS-JIS�ɕϊ�����܂��B
�܂�ɕϊ����ɕ����������N�����ꍇ������܂��̂ŁA
���̃v���O�����ŕ���������T���Ă��������B
*/
*/
*���s��ROOT
*�K�X�ύX;
%let RT_PATH=C:\Users\xxxx\Desktop;

*�`�F�b�N����SAS�t�@�C���̏ꏊ;
%let Raw	= &RT_PATH.\test ;
%let OUT	= &RT_PATH.\test ;

*Library�ݒ�;
libname RAW "&Raw." access=readonly;
libname OUT "&OUT.";


data temp_CM;
	set raw.CM;
	keep  project SUBJECT DataPageName RecordPosition S_CMTRT ;
run;

data CM_Check;
	set temp_CM;
	*�����������N�����ƕK��"?"�ɂȂ�̂�"?"��T��;
	check = find(S_CMTRT,"?");
run;

data Byte2Check_result;
	set CM_Check;
	*�Y�����R�[�h�𒊏o;
	if check > 0 then output;
run;

/*�f�[�^�G�N�X�|�[�g*/
PROC EXPORT DATA= WORK.Byte2check_result 
            OUTFILE= "&OUT.\Byte2Check_result.xls" 
            DBMS=EXCEL REPLACE;
     SHEET="Sheet"; 
RUN;
