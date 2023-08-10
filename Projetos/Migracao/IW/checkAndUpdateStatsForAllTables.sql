CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckAndUpdateStatsForAllTables2`(IN dbName VARCHAR(255))
BEGIN
    DECLARE tableName VARCHAR(255);
    DECLARE needUpdate INT DEFAULT 0;
    DECLARE sqlCmd VARCHAR(1000);


    DECLARE tableCursor CURSOR FOR
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = dbName;


    OPEN tableCursor;


    tableLoop: LOOP
        FETCH tableCursor INTO tableName;
        IF tableName IS NULL THEN
            LEAVE tableLoop;
        END IF;


        SELECT COUNT(*) INTO needUpdate
        FROM information_schema.statistics
        WHERE table_schema = dbName
          AND table_name = tableName
          AND non_unique = 1;


        IF needUpdate > 0 THEN
            SET sqlCmd = CONCAT('ANALYZE TABLE ', dbName, '.', tableName);

            -- SELECT CONCAT('Comando que seria executado para tabela ', dbName, '.', tableName, ': ', sqlCmd) AS result;
                SELECT sqlCmd;
                

        END IF;

    END LOOP;


    CLOSE tableCursor;

END
