


# Mysql 

INSERT INTO  databases_mysql values   ('LAP','clstsgslx4262','WWY','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','')

select concat( "INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','",db,"','8.0','31','PRD','ORA','S','S','N','N','','','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');"  ) Inventario from mysql.db;


select distinct concat( "INSERT INTO  databases_mysql values ('LAP','zbgrdblx01','",SCHEMA_NAME,"','8.0','31','PRD','ORA','S','S','N','N','','','Projeto SHADOWN','NET','10.88.4.142',sysdate,'N',0,'','N','','');"  ) Inventario from  information_schema.SCHEMATA;


 
--------------------------------------------------------
--  DDL for Table DATABASES_MYSQL
--------------------------------------------------------

  CREATE TABLE "DBMON"."DATABASES_MYSQL" 
   (	
    "SITE" VARCHAR2(3 BYTE), 
	"HOST" VARCHAR2(60 BYTE), 
	"DB_NAME" VARCHAR2(45 BYTE), 
	"VERSAO" VARCHAR2(17 BYTE), 
	"RELEASE" VARCHAR2(17 BYTE), 
	"TIPO" VARCHAR2(3 BYTE), 
	"ADMINISTRACAO" VARCHAR2(3 BYTE), 
	"24/7" VARCHAR2(1 BYTE) DEFAULT 'S', 
	"NO_AR" VARCHAR2(1 BYTE), 
	"EM_MANUTENCAO" VARCHAR2(1 BYTE), 
	"LEGADO" VARCHAR2(1 BYTE), 
	"SCRIPT_PATH" VARCHAR2(2000 BYTE), 
	"SISTEMA" VARCHAR2(90 BYTE), 
	"PRODUCAO" VARCHAR2(200 BYTE), 
	"ORIGEM" VARCHAR2(3 BYTE), 
	"IP_ADDRESS" VARCHAR2(17 BYTE), 
	"CREATION_DATE" DATE, 
	"CRITICO" VARCHAR2(1 BYTE), 
	"PLATFORM_ID" NUMBER, 
	"PLATFORM_NAME" VARCHAR2(101 BYTE), 
	"LGPD" VARCHAR2(1 BYTE) DEFAULT 'N', 
	"CONNECT_STRING" VARCHAR2(100 BYTE), 
	"SOCKET" VARCHAR2(100 BYTE)
   ) 
 

INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','bd_pmo','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_adm_cat_mdu','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_admin_75','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_admin_cat_ged','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_admin_cat_teste','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_admin_mdu','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_caixas_fibra','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_cat_ged','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_g5','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_mdu','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','portal_danos','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','controle_mdu','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','contatos_dth','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','cop_preso','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','copc_adm_cfg','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','copc_bot_bragi','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_config','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_config_dmt','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_extract','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_ferr_dmt','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_log','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','bd_cop_info','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','hc','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','ws_cop_info','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','bd_cx_log','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','bd_fca_empresarial','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','bd_gerproj','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_admin_infratel','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_infra_am','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','NETHP','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','ext_toa','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_admin','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_controlemapas','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_sgat','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','bd_frota_spo','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_reconline','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_sisnet','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','copc_ferr_agtec','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','performance_schema','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','sys','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_celula','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','copc\\_adm\\_cfg','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','copc\\_ferr\\_agtec','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','calendar','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_admin_expense','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_infra_am_expense','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_planorc','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_admin_kronus','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_infra_am_kronus','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_kronus','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','net_hp','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','0800_banco','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','abastecimentos','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','ativos_bd','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','banco_acesso','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','banco_manut','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','controle_clm','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','controle_materiais','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','controle_sla','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','controle_smp','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','epis','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','ferramenta_spd','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','ferramentas','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','good_card','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','km','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','materiais_ferramentas','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','multas_java','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','outros','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','portal_spd','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','projetojava','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','sinistros_banco_java','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','telefonia','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','uniformes','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','zona_azul_banco','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','extractions_db_toa','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','extractions_db_dwh','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','copc_sharepoint','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','bd_admin_scm','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_admin_scm','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_par','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','net002prdlnx849','db_scm','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','NET','10.29.3.89',sysdate,'N',0,'','N','','');


INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_app','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_cockpit','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_form','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_integracao','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_integracao_rep','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_relatorio','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_sgp','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_sgp_rel','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_sgp_rep','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_rel','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','db_rep','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','performance_schema','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clstsgslx4262','sys','8.0','31','PRD','ORA','S','S','N','N','','SGP','Projeto SHADOWN','CLA','10.88.132.214',sysdate,'N',0,'','N','','');




INSERT INTO  databases_mysql values ('LAP','clsgelx4859','db_sge','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','CLA','10.88.132.98',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clsgelx4859','calendar','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','CLA','10.88.132.98',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clsgelx4859','db_admin_expense','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','CLA','10.88.132.98',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clsgelx4859','db_planorc','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','CLA','10.88.132.98',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clsgelx4859','db_admin_kronus','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','CLA','10.88.132.98',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clsgelx4859','db_infra_am_kronus','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','CLA','10.88.132.98',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clsgelx4859','db_kronus','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','CLA','10.88.132.98',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clsgelx4859','performance_schema','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','CLA','10.88.132.98',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','clsgelx4859','sys','8.0','31','PRD','ORA','S','S','N','N','',' ','Projeto SHADOWN','CLA','10.88.132.98',sysdate,'N',0,'','N','','');


INSERT INTO  databases_mysql values ('LAP','zbgrdblx01','zabbix','8.0','31','PRD','ORA','S','S','N','N','','','Projeto Zabbix 2.0','NET','10.88.4.142',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','zbgrdblx01','zabbix','8.0','31','PRD','ORA','S','S','N','N','','','Projeto Zabbix 2.0','NET','10.88.4.142',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','zbgrdblx01','performance_schema','8.0','31','PRD','ORA','S','S','N','N','','','Projeto Zabbix 2.0','NET','10.88.4.142',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','zbgrdblx01','sys','8.0','31','PRD','ORA','S','S','N','N','','','Projeto Zabbix 2.0','NET','10.88.4.142',sysdate,'N',0,'','N','','');
INSERT INTO  databases_mysql values ('LAP','zbgrdblx01','zabbix','8.0','31','PRD','ORA','S','S','N','N','','','Projeto Zabbix 2.0','NET','10.88.4.142',sysdate,'N',0,'','N','','');
