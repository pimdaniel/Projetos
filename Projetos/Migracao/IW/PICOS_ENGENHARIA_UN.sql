CREATE DEFINER=`root`@`localhost` PROCEDURE `PICOS_ENGENHARIA_UN`()
    SQL SECURITY INVOKER
BEGIN
	# FAZ O JOIN NA TABELA DE CAPACIDADE DE REDE POR UN
	SET @type_look := '';
	SET @num  := 1;
	SELECT *
	FROM (
		SELECT t1.*, 
		   @num := IF(@type_look = t1.tipo, @num + 1, 1) AS row_number,
		   @type_look := t1.tipo AS dummy
		FROM (
			SELECT
			   IF(v.COD_UNNEGOCIO IN (4,5), 'SP', a.NOM_EXIBIR) AS tipo,
			   '' AS HORA, 
			   DATE_FORMAT(v.DAT_MOVIMENTO, '%d/%m') AS DAT_MOVIMENTO,
			   ROUND(SUM(CONVERT(v.QTD_TRAFEGO_PICO, UNSIGNED)) / 1000) AS abc,
			   a.QTD_CAPACIDADE
			FROM iwprd_vnd.itv_trafego_capacidade_un a
			LEFT JOIN iwprd_vnd.itv_trafego_engenharia v USING(COD_UNNEGOCIO)
			GROUP BY tipo, v.DAT_MOVIMENTO
			ORDER BY a.NUM_ORDEM, tipo, abc DESC
		) t1
	) t2
	HAVING t2.row_number < 3;
    END