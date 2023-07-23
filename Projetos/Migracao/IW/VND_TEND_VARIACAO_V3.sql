CREATE DEFINER=`iwprd`@`%` PROCEDURE `VND_TEND_VARIACAO_V3`(
			IN DAT_MOVIMENTO DATE, 
			IN QTD_LAST_DAY INT(11), 
			IN QTD_DAY INT(11), 
			IN QTD_PERC_DOWN DOUBLE(15,6), 
			IN QTD_PERC_UP DECIMAL(15,6), 
			OUT retorno DECIMAL(15,6), 
			OUT retorno_diff DECIMAL(15,6), 
			OUT retorno_tmp DECIMAL(15,6)
		)
BEGIN
	# ###################################################################
	# CALCULO DE VARIA??O VARIA??O
	DECLARE QTD_DIFF DECIMAL(15,6);
	DECLARE QTD_PERC_TMP DECIMAL(15,6);
	DECLARE QTD_PERC DECIMAL(15,6);
	DECLARE QTD_A DECIMAL(15,6);
	DECLARE QTD_B DECIMAL(15,6);
	DECLARE QTD_C DECIMAL(15,6);
	DECLARE QTD_1 DECIMAL(15,6);
	SET QTD_1 = 1.00;
	# #########	
	IF QTD_LAST_DAY = NULL THEN 
	# #########	
		SET QTD_PERC = QTD_1;
		SET QTD_DIFF = 0;
		SET QTD_PERC_TMP = QTD_1;
	# #########	
	ELSEIF QTD_LAST_DAY = 0 THEN 
	# #########	
		SET QTD_PERC = QTD_1;
		SET QTD_DIFF = 0;
		SET QTD_PERC_TMP = QTD_1;
	# #########	
	ELSE 
	# ###################################################################
		# #########	
		SET QTD_DIFF = (QTD_DAY / QTD_LAST_DAY) - QTD_1;
		# #########	
		# #########	
		#SELECT 'PROCEDURE - TESTE 1', QTD_DAY, QTD_LAST_DAY, QTD_DIFF;
		# #########	
		# #########	
		IF QTD_DIFF < 0 THEN 
			IF QTD_DIFF < QTD_PERC_DOWN THEN 
				SET QTD_PERC_TMP = QTD_PERC_DOWN + QTD_1;
			ELSE 
				SET QTD_PERC_TMP = QTD_1;
			END IF;
		ELSE 
			IF QTD_DIFF > QTD_PERC_UP THEN 
				SET QTD_PERC_TMP = QTD_PERC_UP + QTD_1;
				#SELECT 'PROCEDURE - TESTE 1B', QTD_PERC_UP, QTD_1, QTD_PERC_UP + QTD_1, QTD_PERC_TMP;
			ELSE 
				SET QTD_PERC_TMP = QTD_1;
			END IF;
		END IF;
		# #########	
		# #########	
		IF QTD_PERC_TMP < 0 THEN 
			SET QTD_A = QTD_LAST_DAY * (QTD_PERC_TMP * -1);
		ELSE 
			SET QTD_A = ( QTD_LAST_DAY * (QTD_PERC_TMP) );
		END IF;
		SET QTD_B = ((QTD_DAY - QTD_A) / QTD_DAY );
		# #########	
		# #########	
		#SELECT 'PROCEDURE - TESTE 2', QTD_A, QTD_B, QTD_PERC, QTD_DIFF, QTD_PERC_TMP;
		# #########	
		# #########	
		SET QTD_PERC = QTD_1 - QTD_B;
		# #########	
		# #########	
		SET QTD_C = ( QTD_PERC * QTD_LAST_DAY );
		# #########	
		# #########	
		#SELECT 'PROCEDURE - TESTE 3', QTD_PERC, QTD_DIFF, QTD_PERC_TMP;
		# #########	
		# #########	
		# SE FOR DIA PRIMEIRO, QTD_PERC = 1
		IF (DATE_FORMAT(DAT_MOVIMENTO, '%d')+0) <= QTD_1 THEN 
			SET QTD_PERC = QTD_1;
		ELSE 
			SET QTD_PERC = QTD_PERC;
		END IF;
		# #########	
		# #########	
		# SE FOR DIA PRIMEIRO, QTD_PERC = 1
		IF QTD_PERC_TMP = QTD_1 THEN 
			SET QTD_PERC = QTD_PERC_TMP;
		END IF;
		# #########	
		# #########	
		#SELECT 'PROCEDURE - TESTE 4', QTD_PERC, QTD_DIFF, QTD_PERC_TMP;
		# #########	
	# ###################################################################
	END IF;
	# #########	
	# #########	
	SELECT QTD_PERC, QTD_DIFF, QTD_PERC_TMP INTO retorno, retorno_diff, retorno_tmp;
	# ###################################################################
END