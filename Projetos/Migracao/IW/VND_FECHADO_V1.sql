CREATE DEFINER=`iwprd`@`%` PROCEDURE `VND_FECHADO_V1`(IN IN_DAT_ANOMES INT(11), IN ID CHAR(2))
BEGIN
	# ###################################################################
    DECLARE i int(11);
    SET i = 1;
	# ###################################################################
	# ###################################################################
	# INCLUIR PROCEDURE QUE CRIA A NOVA LINHA DO DAT_ANOMES EM FECHADO
	# NECESS?RIO PARA RODAR AS LINHAS ABAIXO
		SET @DAT_ANOMES = IN_DAT_ANOMES;
		SET @DAT_ANOMES_FECHADO = 0;
		SELECT @DAT_ANOMES_FECHADO:=( DAT_ANOMES ) FROM iwprd_vnd.fechado WHERE DAT_ANOMES = @DAT_ANOMES;
		IF @DAT_ANOMES_FECHADO = 0 THEN 
			INSERT INTO iwprd_vnd.fechado 
				SET 
					COD_FECHADO = @DAT_ANOMES, 
					COD_STATUS = 0, 
					DAT_FECHADO = NOW(), 
					DAT_ANOMES = @DAT_ANOMES, 
					DAT_ULTIMODIA = NULL, 
					DAT_ULTIMODIA_CV = NULL, 
					DAT_ULTIMODIA_CD = NULL, 
					DAT_ULTIMODIA_OD = NULL;
		END IF;
	# ###################################################################
	# ###################################################################
	# CRIA REGRAS DE TRATAMENTO PARA O CICLO DE VIDA - CV
	# ###################################################################
		IF ID = 'CV' THEN 
			# ###########################################################
			# PEGA O ULTIMO MOVIMENTO
			SET @DAT_ULTIMODIA_CV = NOW();
			# SELECT @DAT_ULTIMODIA_CV:=( MAX(DAT_MOVIMENTO) ) FROM iwprd_vnd.bi_ciclodiario WHERE DAT_ANOMES = @DAT_ANOMES;
			
			SELECT @DAT_ULTIMODIA_CV:=( MAX(DAT_MOVIMENTO) )
			FROM 
				(SELECT
					DAT_MOVIMENTO
				FROM
					iwprd_vnd.bi_ciclodiario
				WHERE DAT_ANOMES = @DAT_ANOMES
				GROUP BY 1
				HAVING SUM(QTD_GROSS_BRUTO) > 0) t;			
			
			# iwprd_vnd.fechado = COD_FECHADO, COD_STATUS, DAT_FECHADO, DAT_ANOMES, DAT_ULTIMODIA, DAT_ULTIMODIA_CV, DAT_ULTIMODIA_CD, DAT_ULTIMODIA_OD
			# ATUALIZA A TABELA COM O ULTIMO MOVIMENTO
			UPDATE iwprd_vnd.fechado 
				   SET DAT_ULTIMODIA_CV = @DAT_ULTIMODIA_CV, DAT_FECHADO = NOW() 
				   WHERE DAT_ANOMES = @DAT_ANOMES;
			# ###########################################################
		END IF;
	# ###################################################################
	# ###################################################################
	# CRIA REGRAS DE TRATAMENTO PARA O CICLO DE VIDA - CV
	# ###################################################################
		IF ID = 'CD' THEN 
			# ###########################################################
			# PEGA O ULTIMO MOVIMENTO
			SET @DAT_ULTIMODIA_CD = NOW();
			SELECT @DAT_ULTIMODIA_CD:=( MAX(DAT_MOVIMENTO) ) FROM iwprd_vnd.ciclo_detalhe_diario WHERE DAT_ANOMES = @DAT_ANOMES;
			# iwprd_vnd.fechado = COD_FECHADO, COD_STATUS, DAT_FECHADO, DAT_ANOMES, DAT_ULTIMODIA, DAT_ULTIMODIA_CV, DAT_ULTIMODIA_CD, DAT_ULTIMODIA_OD
			# ATUALIZA A TABELA COM O ULTIMO MOVIMENTO
			UPDATE iwprd_vnd.fechado 
				   SET DAT_ULTIMODIA_CD = @DAT_ULTIMODIA_CD, DAT_FECHADO = NOW() 
				   WHERE DAT_ANOMES = @DAT_ANOMES;
			# ###########################################################
		END IF;
	# ###################################################################
	# ###################################################################
	# CRIA REGRAS DE TRATAMENTO PARA O CICLO DE VIDA - CV
	# ###################################################################
		IF ID = 'OD' THEN 
			# ###########################################################
			# PEGA O ULTIMO MOVIMENTO
			SET @DAT_ULTIMODIA_OD = NOW();
			SELECT @DAT_ULTIMODIA_OD:=( MAX(DAT_MOVIMENTO) ) FROM iwprd_vnd.dados_resumo_offer WHERE DAT_ANOMES = @DAT_ANOMES;
			# iwprd_vnd.fechado = COD_FECHADO, COD_STATUS, DAT_FECHADO, DAT_ANOMES, DAT_ULTIMODIA, DAT_ULTIMODIA_CV, DAT_ULTIMODIA_CD, DAT_ULTIMODIA_OD
			# ATUALIZA A TABELA COM O ULTIMO MOVIMENTO
			UPDATE iwprd_vnd.fechado 
				   SET DAT_ULTIMODIA_OD = @DAT_ULTIMODIA_OD, DAT_FECHADO = NOW() 
				   WHERE DAT_ANOMES = @DAT_ANOMES;
			# ###########################################################
		END IF;
	# ###################################################################
	# ###################################################################
	# MUDA O STATUS DO ANO/MES PARA "EM FECHAMENTO" NO ULTIMO DIA DO M?S
	SET @DAT_ULTIMODIA = CURRENT_DATE;
	SET @COD_STATUS = 0;
	SELECT @DAT_ULTIMODIA:=( DAT_ULTIMODIA_CV ), @COD_STATUS:=(COD_STATUS) FROM iwprd_vnd.fechado WHERE DAT_ANOMES = @DAT_ANOMES;
		IF ID = 'CV' AND @DAT_ULTIMODIA = LAST_DAY(@DAT_ULTIMODIA) AND @COD_STATUS < 2 THEN 
			# ###########################################################
			# ATIVA O BLOQUEIO DO DAT_ANOMES EM FECHAMENTO
			UPDATE iwprd_sys.controle SET COD_STATUS = 1 WHERE COD_CONTROLE IN(11, 12);
			# ATIVA A MENSAGEM DE VALIDA??O MENSAL
			UPDATE iwprd_sys.controle SET COD_STATUS = 1 WHERE COD_CONTROLE IN(2);
			# DESATIVA O ENVIO DE E-MAIL AUTOM?TICO
			UPDATE iwprd_sys.controle SET COD_STATUS = 0 WHERE COD_CONTROLE IN(3, 18);
			# ###########################################################
			# COLOCA EM FECHAMENTO
			UPDATE iwprd_vnd.fechado 
				SET COD_STATUS = 2 
				WHERE DAT_ANOMES = @DAT_ANOMES AND DAT_ULTIMODIA_CV = LAST_DAY(DAT_ULTIMODIA_CV); 
			# ###########################################################
		END IF;
	
	# ###################################################################
END